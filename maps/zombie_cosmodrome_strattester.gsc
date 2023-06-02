#include common_scripts\utility; 
#include maps\_utility;

strattester_init()
{
	level.strattester_tactical_black_hole = maps\_zombiemode_weap_black_hole_bomb::player_give_black_hole_bomb;
    level.strattester_tactical_dolls = maps\_zombiemode_weap_nesting_dolls::player_give_nesting_dolls;
	level.strattester_tactical_fallback = level.strattester_tactical_black_hole;
}

override_rocket_sequence()
{
	if (getDvar("st_start_rocket") == "1")
		return true;
	return false;
}