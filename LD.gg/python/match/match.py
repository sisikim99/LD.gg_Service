import time
import pandas as pd
import requests
from tqdm import tqdm
import my_utils as mu
import json
import multiprocessing as mp
import numpy as np
import data_load
tqdm.pandas()
import private

riot_api_keys = private.riot_api_key_array

def summoner_tier(x):
    url = f'https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/{x.summonerId}?api_key={x.api_key}'
    res = requests.get(url).json()

    if isinstance(res, list) and len(res) > 0:
        ress = res[0]['tier']
        return ress
    else:
        if isinstance(res, list):
            print(f'Invalid response: {res} {x.summonerName}')
        elif res.get('status') is not None:
            print('status:', res['status'], x.api_key, x.summonerName)
            time.sleep(20)
            return summoner_tier(x)
        else:
            print('KeyError:', res)
        return 0


def insert(t, conn):
    sql = (
        f"insert ignore into match_solr_rank (api_key, match_id, gameDuration, gameVersion, summonerName, summonerId," 
        f"summonerTier, summonerLevel, participantId, championName, championId, ban_champion_id, champExperience, teamPosition,"
        f"teamId, win, kills, deaths, assists, towerDestroy, inhibitorDestroy, dealToObject, cs, kda, totalDamageDealtToChampions,"
        f"totalDamageTaken, timeCCingOthers, total_gold,"
        f"g_5, g_6, g_7, g_8, g_9, g_10, g_11, g_12, g_13, g_14, g_15, g_16, g_17, g_18, g_19, g_20, g_21, g_22,"
        f"g_23, g_24, g_25) "
        f"values ({repr(t.api_key)}, {repr(t.match_id)}, {t.gameDuration}, {repr(t.gameVersion)}, {repr(t.summonerName)},"
        f"{repr(t.summonerId)}, {repr(t.summonerTier)}, {t.summonerLevel}, {t.participantId}, {repr(t.championName)}, {t.championId},"
        f"{t.ban_champion_id}, {t.champExperience}, {repr(t.teamPosition)}, {repr(t.teamId)}, {repr(t.win)}, {t.kills},"
        f"{t.deaths}, {t.assists}, {t.towerDestroy}, {t.inhibitorDestroy}, {t.dealToObject}, {t.cs},"
        f"{t.kda}, {t.totalDamageDealtToChampions}, {t.totalDamageTaken}, {t.timeCCingOthers}, {t.total_gold}, "
        f"{t.g_5}, {t.g_6}, {t.g_7}, {t.g_8}, {t.g_9}, {t.g_10}, {t.g_11}, {t.g_12}, {t.g_13}, {t.g_14}, {t.g_15},"
        f"{t.g_16}, {t.g_17}, {t.g_18}, {t.g_19}, {t.g_20}, {t.g_21}, {t.g_22}, {t.g_23}, {t.g_24}, {t.g_25})"
    )
    mu.mysql_execute(sql, conn)


def insert_worker(chunks):
    print(f'chunk : {len(chunks)}')
    if len(chunks) == 0:
        return
    chunks['summonerTier'] = chunks.progress_apply(lambda x: summoner_tier(x), axis=1)
    return chunks

if __name__ == '__main__':
    print("시작!")
    conn = mu.connect_mysql()
    matchId_count = pd.DataFrame(mu.mysql_execute_dict(f"SELECT match_id_substr FROM match_raw_patch", conn))
    conn.close()
    print(f'매치아이디 갯수 : {len(matchId_count.match_id_substr.unique())}개')

    batch_size = 20000
    win_pick_lst_result = []
    ban_rate_lst_result = []
    meta_score_lst_result = []
    # len(matchId_count.match_id_substr.unique())
    for limit in tqdm(range(0, len(matchId_count.match_id_substr.unique()), batch_size)):
        conn = mu.connect_mysql()
        query = f"SELECT * FROM match_raw_patch LIMIT {limit}, {batch_size}"
        df = pd.DataFrame(mu.mysql_execute_dict(query, conn))
        conn.close()

        df['matches'] = df.progress_apply(lambda x: json.loads(x['matches']), axis=1)
        df['timeline'] = df.progress_apply(lambda x: json.loads(x['timeline']), axis=1)

        df_creater = []
        columns = [
            'api_key', 'match_id', 'gameDuration', 'gameVersion', 'summonerName', 'summonerId', 'summonerLevel',
            'participantId', 'championName',
            'championId', 'ban_champion_id', 'champExperience', 'teamPosition', 'teamId', 'win', 'kills', 'deaths',
            'assists', 'kda', 'towerDestroy', 'inhibitorDestroy',
            'dealToObject', 'cs', 'totalDamageDealtToChampions', 'totalDamageTaken',
            'timeCCingOthers', 'total_gold',
            'g_5', 'g_6', 'g_7', 'g_8', 'g_9', 'g_10', 'g_11', 'g_12', 'g_13', 'g_14', 'g_15', 'g_16',
            'g_17', 'g_18', 'g_19', 'g_20', 'g_21', 'g_22', 'g_23', 'g_24', 'g_25'
        ]

        for m_idx, m in tqdm(enumerate(df['matches'])):
            if m['gameDuration'] < 900:
                continue
            p_idx = 1
            tower_destroy = 0
            bans = 0
            p_id = 0
            for p_idx, p in enumerate(m['participants']):
                game_end = list(df.iloc[m_idx]['timeline'].keys())[-1]
                minions_killed = df.iloc[m_idx]['timeline'][game_end]['participantFrames'][p_idx]['minionsKilled']
                jungle_minions_killed = df.iloc[m_idx]['timeline'][game_end]['participantFrames'][p_idx][
                    'jungleMinionsKilled']
                total_gold = df.iloc[m_idx]['timeline'][game_end]['participantFrames'][p_idx]['totalGold']
                cs = minions_killed + jungle_minions_killed

                tmp_lst = list(map(lambda x: x['events'], df.iloc[m_idx]['timeline'].values()))
                event_lst = [element for array in tmp_lst for element in array]

                building_log = [i for i in event_lst if i['type'] == 'BUILDING_KILL']
                tower_log = [i for i in building_log if i['buildingType'] == 'TOWER_BUILDING']
                inhibitor_log = [i for i in building_log if i['buildingType'] == 'INHIBITOR_BUILDING']

                elite_monster_log = [i for i in event_lst if i['type'] == 'ELITE_MONSTER_KILL']
                dragon_log = [i for i in elite_monster_log if i['monsterType'] == 'DRAGON']
                baron_log = [i for i in elite_monster_log if i['monsterType'] == 'BARON_NASHOR']

                tower_destroy = 0
                for event in tower_log:
                    if p_idx == event['killerId']:
                        tower_destroy += 1

                inhibitor_destroy = 0
                for event in inhibitor_log:
                    if p_idx == event['killerId']:
                        inhibitor_destroy += 1

                if p['teamId'] == 100:
                    team = 0
                else:
                    team = 1

                if bans == 5:
                    bans = 0

                df.iloc[0]['matches']['participants'][0].keys()
                df_creater.append([
                    df['api_key'][m_idx],
                    df.iloc[m_idx]['match_id'],
                    m['gameDuration'],
                    m['gameVersion'],
                    p['summonerName'],
                    p['summonerId'],
                    p['summonerLevel'],
                    p['participantId'],
                    p['championName'],
                    p['championId'],
                    m['bans'][p_idx],
                    p['champExperience'],
                    p['teamPosition'],
                    p['teamId'],
                    p['win'],
                    p['kills'],
                    p['deaths'],
                    p['assists'],
                    p['kda'],
                    tower_destroy,
                    inhibitor_destroy,
                    p['damageDealtToObjectives'],
                    cs,
                    p['totalDamageDealtToChampions'],
                    p['totalDamageTaken'],
                    p['timeCCingOthers'],
                    total_gold,
                ])
                for t in range(5, 26):
                    try:
                        g_each = df.iloc[m_idx]['timeline'][str(f"{t}")]['participantFrames'][p_idx]['totalGold']
                        df_creater[-1].append(g_each)
                    except Exception as e:
                        df_creater[-1].append(0)
                p_idx += 1
                bans += 1
        sum_df = pd.DataFrame(df_creater, columns=columns)
        grouped_df = sum_df.groupby('api_key')
        df_list = [group for _, group in grouped_df]

        # 작은 DataFrame을 병렬로 처리
        summoner_tier_output = []
        with mp.Pool(processes=8) as pool:
            for res in (pool.map(insert_worker, df_list)):
                summoner_tier_output.append(res)

        merged_df = pd.concat(summoner_tier_output)
        print(f'merged_df = {len(merged_df)}')

        sql_conn = mu.connect_mysql()
        merged_df.progress_apply(lambda x: insert(x, sql_conn), axis=1)
        sql_conn.commit()
        sql_conn.close()