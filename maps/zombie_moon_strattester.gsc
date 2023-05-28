strattester_init()
{
	level.strattester_tactical_black_hole = maps\_zombiemode_weap_black_hole_bomb::player_give_black_hole_bomb;
	level.strattester_tactical_qed = maps\_zombiemode_weap_quantum_bomb::player_give_quantum_bomb;
	level.strattester_tactical_fallback = level.strattester_tactical_black_hole;
}

/* map specific dvars */
init_strattester_moon_dvars()
{
	maps\_strattester::init_dvar("st_astro_active", "0");
	level thread maps\_strattester::watch_dvar("st_astro_active");
}

astro_watcher()
{
	level endon("end_game");
	level endon("disconnect");
	
	if (getDvar("st_astro_active") == "1")
	{
		level.max_astro_zombies = 1;
		spawner = getent( "astronaut_zombie", "targetname" );
		while (getDvar("st_astro_active") == "1" && level.on_the_moon == true)
		{
			astro = spawner maps\_zombiemode_ai_astro::astro_zombie_spawn();
			if ( !maps\_utility::spawn_failed( astro ) )
			{
				break;
			}
			maps\_utility::wait_network_frame();
		}
	}
	else if (getDvar("st_astro_active") == "0")
	{
		// lveez - this stops the astro spawning
		level.max_astro_zombies = 0;
		// lveez - kill astro if currently on map
		astro = getent("astronaut_zombie_ai", "targetname");
		if (isDefined(astro))
			astro dodamage(astro.health + 1, astro.origin);
	}

	level waittill("st_astro_active_changed");

	thread astro_watcher();
}