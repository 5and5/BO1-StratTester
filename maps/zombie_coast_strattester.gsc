#include maps\_zombiemode_weap_nesting_dolls;

strattester_init()
{
    level.strattester_tactical_dolls = ::player_give_nesting_dolls;
	level.strattester_tactical_fallback = level.strattester_tactical_dolls;
}