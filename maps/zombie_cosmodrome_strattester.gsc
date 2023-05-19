#include maps\_zombiemode_weap_nesting_dolls;
#include maps\_zombiemode_weap_black_hole_bomb;

strattester_init()
{
	level.strattester_tactical_black_hole = ::player_give_black_hole_bomb;
    level.strattester_tactical_dolls = ::player_give_nesting_dolls;
	level.strattester_tactical_fallback = level.strattester_tactical_black_hole;
}