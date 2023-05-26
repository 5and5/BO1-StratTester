strattester_init()
{
	level.strattester_tactical_black_hole = maps\_zombiemode_weap_black_hole_bomb::player_give_black_hole_bomb;
	level.strattester_tactical_qed = maps\_zombiemode_weap_quantum_bomb::player_give_quantum_bomb;
	level.strattester_tactical_fallback = level.strattester_tactical_black_hole;
}