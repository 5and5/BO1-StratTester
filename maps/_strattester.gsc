#include common_scripts\utility; 
#include maps\_utility;

spawn_strattester_player()
{
    self.strattester = spawnStruct();

    /* Logic for weapons given on spawn */
    wpn_array = array("wpn1", "wpn2", "wpn3");
    weapons_array = self maps\_strattester_weapons::get_weapon_settings(wpn_array);
    tactical_id = self maps\_strattester_weapons::get_tactical_setting();

    self.strattester.weapon1 = weapons_array["wpn1"];
    self.strattester.weapon2 = weapons_array["wpn2"];
    self.strattester.weapon3 = weapons_array["wpn3"];
    self.strattester.tactical = maps\_strattester_weapons::get_tactical_pointer(tactical_id);

    // debug_print("weapon1: " + self.strattester.weapon1);
    // debug_print("weapon2: " + self.strattester.weapon2);
    // debug_print("weapon3: " + self.strattester.weapon3);
}

init_dvar(dvar, def, set_watcher)
{
    if (getDvar(dvar) == "")
        setDvar(dvar, def);

    if (is_true(set_watcher))
        level thread watch_dvar(dvar);
}

init_client_dvar(dvar, def)
{
    if (!isDefined(def))
        def = "0";

    if (getDvar(dvar) == "")
        self SetClientDvar(dvar, def);
    else
        self SetClientDvar(dvar, getDvar(dvar));
}

init_strattester_dvars()
{
    // 3arc dvars
    init_dvar("magic_chest_movable", "1", true);

    // Gameplay dvars
    init_dvar("st_round_number", "100");
    init_dvar("st_backspeed_fix", "1", true);
    init_dvar("st_turn_power_on", "1");
    init_dvar("st_open_doors", "1");
    init_dvar("st_open_windows", "1");
    init_dvar("st_round_insta", "normal", true);
    init_dvar("st_next_special_round", "0");
    init_dvar("st_round_start_delay", "3");
    init_dvar("st_disable_powerups", "1");
    init_dvar("st_zombies_per_horde", "24", true);

    init_dvar("st_finish_round", "0", true);  // With this doesn't matter what value, can be either 0 or 1, watcher is the most important

    // HUD dvars
    init_dvar("st_hud_command_print_offset", 0);
    init_dvar("st_hud_total_timer_on", "1");
    init_dvar("st_hud_round_timer_on", "1");
    init_dvar("st_hud_enemy_counter_on", "0");
    init_dvar("st_hud_sph_on", "0");
    init_dvar("st_hud_kills_per_shot_on", "0");
    init_dvar("st_hud_zone_health_bar", "none");
    init_dvar("st_hud_drawsprint", "0");

    // Weapon dvars
    init_dvar("st_weapon_preset", "highround", true);
    init_dvar("st_award_melee", "1");
    init_dvar("st_award_mines", "1");
    init_dvar("st_award_tacticals", "1");
    init_dvar("st_award_hacker", "1");
    init_dvar("st_use_cfg_weapons", "0");
    init_dvar("st_give_weapons", "1");
    init_dvar("st_weapon_to_give", "", true);
    init_dvar("st_ammo_refill", "0");

    // Perks & drops dvars
    init_dvar("st_set_perks", "all");
    init_dvar("st_disable_carpenter", "1");
    init_dvar("st_disable_firesale", "1");
    init_dvar("st_disable_death_machine", "1");

    // Box dvars
    init_dvar("st_perfect_trade", "0");

    // Map dvars
    init_dvar("st_zombie_pentagon_disabled_window1", "conference_ne");
    init_dvar("st_zombie_pentagon_disabled_window2", "hallway_e");
    init_dvar("st_director_active", "0");
    init_dvar("st_novas_active", "0");
    init_dvar("st_digger_t6", "0");
    init_dvar("st_digger_t11", "0");
    init_dvar("st_digger_bio", "0");
    init_dvar("st_shang_special_zombies", "0");
    init_dvar("st_astro_active", "0", true);
}

init_strattester_client_dvars()
{
    players = get_players();
    for (i = 0; i < players.size; i++)
    {
        players[i] init_client_dvar("st_hud_enemy_counter_value", "0");
        players[i] init_client_dvar("st_hud_sph", "0");
        players[i] init_client_dvar("st_hud_kills_per_shot", "0");
        players[i] init_client_dvar("st_hud_zone_name", "");
        players[i] init_client_dvar("st_hud_health_bar_value", "100");
        players[i] init_client_dvar("st_hud_health_bar_width", "100");
    }
}

watch_dvar(dvar)
{
    level endon("end_game");

    dvar_state = getDvar(dvar);
    while (true)
    {
        wait 0.05;

        if (dvar_state == getDvar(dvar))
            continue;

        level notify(dvar + "_changed");
        dvar_state = getDvar(dvar);
    }
}

stub()
{
    return;
}

debug_print(content)
{
    debug_mode = false;
    if (debug_mode)
        iPrintLn("DEBUG: " + content);
}

evaluate_backspeed()
{
    level endon("end_game");
    self endon("disconnect");

    if (getDvar("st_backspeed_fix") == "1")
        self setClientDvars("player_backSpeedScale", "1",
        "player_strafeSpeedScale", "1");
    else
        self setClientDvars("player_backSpeedScale", "0.7",
        "player_strafeSpeedScale", "0.8");

    level waittill("st_backspeed_fix_changed");
    self thread evaluate_backspeed();
}

finish_round()
{
    level endon("end_game");

    while (true)
    {
        level waittill("st_finish_round_changed");

        if (isDefined(level.round_end_forbidden_func) && [[level.round_end_forbidden_func]]())
            continue;

        level.zombie_total = 0;
        test_ent = undefined;

        on_the_map = GetAiSpeciesArray("axis");
        for (i = 0; i < on_the_map.size; i++)
        {
            if (!isDefined(on_the_map[i].animname))
                continue;

            switch (on_the_map[i].animname)
            {
                case "director_zombie":
                case "ape_zombie":
                case "monkey_zombie":
                case "thief_zombie":
                case "astro_zombie":
                    is_special = true;
                    break;
                case "zombie_dog":
                default:
                    is_special = false;
            }

            if (!is_true(is_special))
            {
                dmg = on_the_map[i].health + 666;
                if (dmg < 150 || dmg > 2147483647)
                    dmg = 2147483647;
                on_the_map[i] doDamage(dmg, on_the_map[i].origin);

                if (isAlive(on_the_map[i]))
                    test_ent = on_the_map[i];
            }
        }

        // if (isDefined(test_ent))
        //     debug_print("after dmg: " + test_ent.health);

        level waittill("start_of_round");
    }
}

instaround_toggle_watcher()
{
    level endon("end_game");

    while (true)
    {
        level waittill("st_round_insta_changed");
        level notify("st_finish_round_changed");
    }
}

zombies_per_horde()
{
	level endon("end_game");
	
	while (true) 
	{
        level waittill("st_zombies_per_horde_changed");
        level.zombie_ai_limit = getDvarInt("st_zombies_per_horde");
        SetAILimit(level.zombie_ai_limit);
	}
}
