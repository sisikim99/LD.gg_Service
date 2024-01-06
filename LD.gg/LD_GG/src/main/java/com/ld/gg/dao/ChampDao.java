package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_info;
import com.ld.gg.dto.champ.Champ_item_info;
import com.ld.gg.dto.champ.Champ_match_up_default;
import com.ld.gg.dto.champ.Champ_match_up_item;
import com.ld.gg.dto.champ.Champ_match_up_rune;
import com.ld.gg.dto.champ.Champ_match_up_skill;
import com.ld.gg.dto.champ.Champ_match_up_spell;
import com.ld.gg.dto.champ.Champ_recomm_info;

public interface ChampDao {

	List<Champ_analytics> champ_rank(@Param("lane")String lane, @Param("tier")Integer tier);

	List<Champ_match_up_default> champ_match_up(Integer left_champion);

	List<Champ_match_up_default> champ_match_up_both(@Param("left_champion")Integer left_champion,
			@Param("right_champion")Integer right_champion);

	Champ_info champ_search(String champion_name);

	String champ_search_eng(String champion_en_name);

	List<Champ_match_up_default> champ_recom(@Param("lane")String lane,
			@Param("tag")String tag, @Param("right_champion")String right_champion);

	List<Champ_match_up_spell> build_recom_spell(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion,
			@Param("team_position")String team_position);

	List<Champ_match_up_item> build_recom_item(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion,
			@Param("team_position")String team_position);

	List<Champ_match_up_rune> build_recom_rune(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion,
			@Param("team_position")String team_position);

	List<Champ_match_up_skill> build_recom_skill(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion,
			@Param("team_position")String team_position);


  List<Champ_default> get_champ_list();

	Champ_info getChampionInfo(int champion_id);

	List<Champ_recomm_info> getChampionLaneData(int champion_id);

	List<Champ_recomm_info> getChampionRuneData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getChampionItemData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getChampionMythicItemData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getChampionItemBuildData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getChampionShoesData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getChampionSpellData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getChampionSkillBuildData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getChampionAccessoriesData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);
	
	List<Champ_recomm_info> getChampionTierData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getEasyChampData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getHardChampData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_match_up_default> get_champion_match_up(Integer champion_id);

	List<Champ_match_up_default> get_enemy_champion_match_up(@Param("champion_id")Integer champion_id, @Param("team_position")String team_position);

	List<Champ_match_up_rune> getRuneInfo(String main_key);

	List<Champ_match_up_rune> getSubRuneInfo(String sub_key);

	List<Champ_match_up_spell> getSpellInfo(@Param("first_spell")int first_spell, @Param("second_spell")int second_spell);

	List<Champ_match_up_default> get_champion_match_up_chart(@Param("champion_id")Integer champion_id, @Param("team_position")String team_position);

	List<Champ_recomm_info> getStartItemData(@Param("champion_id")int champion_id, @Param("team_position")String team_position);

	List<Champ_item_info> getItemInfo(int item_id);
  
}
