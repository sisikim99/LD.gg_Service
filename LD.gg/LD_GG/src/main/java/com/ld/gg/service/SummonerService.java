package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.Summoner_dao;
import com.ld.gg.dto.summoner.BuildDto;
import com.ld.gg.dto.summoner.ChampRecordDto;
import com.ld.gg.dto.summoner.DashBoardDto;
import com.ld.gg.dto.summoner.MatchUpPlayerDto;
import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.RecordInfoDto;
import com.ld.gg.dto.summoner.RecordRankingDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.dto.summoner.SummonerRankDto;
import com.ld.gg.dto.summoner.TeamRankingDataDto;

@Service
public class SummonerService {
	
	@Autowired
	private Summoner_dao SD;

	public List<SummonerRankDto> getRankSoloData() {
		List<SummonerRankDto> sd = SD.getRankSoloData();
		return sd;
	}

	public List<SummonerRankDto> getRankFlexData() {
		List<SummonerRankDto> sd = SD.getRankFlexData();
		return sd;
	}

	public List<SummonerRankDto> getRankLevelData() {
		List<SummonerRankDto> sd = SD.getRankLevelData();
		return sd;
	}

	public SummonerDto get_summoner_info(String summoner_name) {
		SummonerDto sd = SD.get_summoner_info(summoner_name);
		return sd;
	}

	public List<RecordDto> get_summoner_record(String summoner_name, int offset) {
		List<RecordDto> sr = SD.get_summoner_record(summoner_name, offset);
		return sr;
	}

	public List<SummonerDto> get_renewal_info(String summoner_name) {
		List<SummonerDto> sd = SD.get_renewal_info(summoner_name); 
		return sd;
	}

	public List<SummonerDto> get_champ_position_filter(String summoner_name) {
		List<SummonerDto> sd = SD.get_champ_position_filter(summoner_name);
		return sd;
	}

	public List<ChampRecordDto> get_champ_record(String summoner_name, int offset) {
		List<ChampRecordDto> crd = SD.get_champ_record(summoner_name, offset);
		return crd;
	}

	public List<ChampRecordDto> get_20games_summary(String summoner_name) {
		List<ChampRecordDto> crd = SD.get_20games_summary(summoner_name);
		return crd;
	}

	public List<RecordInfoDto> get_record_detail(String match_id) {
		List<RecordInfoDto> rd = SD.get_record_detail(match_id);
		return rd;
	}

	public List<SummonerRankDto> getRankLoadingData() {
		List<SummonerRankDto> srd = SD.getRankLoadingData();
		return srd;
	}

	public List<ChampRecordDto> getChampSolo(String summoner_name) {
		List<ChampRecordDto> crd = SD.getChampSolo(summoner_name);
		return crd;
	}

	public List<ChampRecordDto> getChampFlex(String summoner_name) {
		List<ChampRecordDto> crd = SD.getChampFlex(summoner_name);
		return crd;
	}

	public List<ChampRecordDto> getChampClassic(String summoner_name) {
		List<ChampRecordDto> crd = SD.getChampClassic(summoner_name);
		return crd;
	}

	public BuildDto getBuild(String match_id, String summoner_name) {
		BuildDto bd = SD.getBuild(match_id, summoner_name);
		return bd;
	}

	public RecordRankingDto getRanking(String match_id, String summoner_name) {
		RecordRankingDto rrd = SD.getRanking(match_id, summoner_name);
		return rrd;
	}

	public SummonerDto getSummoner(String lol_account) {
		SummonerDto sd = SD.getSummoner(lol_account);
		return sd;
	}

	public DashBoardDto getDashBoardKDA(String summoner_name) {
		DashBoardDto dbd = SD.getDashBoardKDA(summoner_name);
		return dbd;
	}

	public List<MatchUpPlayerDto> getMatchUpPlayer(String match_id) {
		List<MatchUpPlayerDto> mpd = SD.getMatchUpPlayer(match_id);
		return mpd;
	}

	public List<TeamRankingDataDto> getTeamData(String match_id, String summoner_name) {
		List<TeamRankingDataDto> TRDD = SD.getTeamData(match_id, summoner_name);
		return TRDD;
	}

	public List<ChampRecordDto> getChampRecordLane(String summoner_name, String paramLane, int offset) {
		List<ChampRecordDto> crd = SD.getChampRecordLane(summoner_name, paramLane, offset);
		return crd;
	}

	public List<DashBoardDto> getDashBoardMatchUp(String summoner_name) {
		List<DashBoardDto> dbd = SD.getDashBoardMatchUp(summoner_name);
		return dbd;
	}

	public List<DashBoardDto> getDashBoardRecent(String summoner_name) {
		List<DashBoardDto> dbd = SD.getDashBoardRecent(summoner_name);
		return dbd;
	}

	public List<DashBoardDto> getDashBoardPlayer(String match_id, String summoner_name) {
		List<DashBoardDto> dbd = SD.getDashBoardPlayer(match_id, summoner_name);
		return dbd;
	}

	public DashBoardDto getDashBoardProfile(String summoner_name) {
		DashBoardDto dbd = SD.getDashBoardProfile(summoner_name);
		return dbd;
	}

	public List<BuildDto> getMainMaking(String main) {
		return SD.getMainMaking(main);
	}

	public List<BuildDto> getSubMaking(String sub) {
		return SD.getSubMaking(sub);
	}

	public SummonerDto searchSummoner(String summoner_name) {
		return SD.searchSummoner(summoner_name);
	}

}
