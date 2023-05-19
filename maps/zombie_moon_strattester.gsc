#include maps\_zombiemode_weap_quantum_bomb;
#include maps\_zombiemode_weap_black_hole_bomb;

strattester_init()
{
	level.strattester_tactical_black_hole = ::player_give_black_hole_bomb;
	level.strattester_tactical_qed = ::player_give_quantum_bomb;
	level.strattester_tactical_fallback = level.strattester_tactical_black_hole;
}