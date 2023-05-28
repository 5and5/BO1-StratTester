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
    init_dvar("st_round_insta", "0");
    init_dvar("st_next_special_round", "0");
    init_dvar("st_round_start_delay", "3");
    init_dvar("st_disable_powerups", "1");
    init_dvar("st_zombies_per_horde", "24");

    // HUD dvars
    init_dvar("st_hud_timer", "1");
    init_dvar("st_drawsprint", "0");
    init_dvar("st_hud_zone_health_bar", "0");

    // Weapon dvars
    init_dvar("st_weapon_preset", "highround", true);
    init_dvar("st_award_melee", "1");
    init_dvar("st_award_mines", "1");
    init_dvar("st_award_tacticals", "1");
    init_dvar("st_award_hacker", "1");
    init_dvar("st_use_cfg_weapons", "0");
    init_dvar("st_give_weapons", "1");
    init_dvar("st_weapon_to_give", "");

    // Perks & drops dvars
    init_dvar("st_set_perks", "all");
    init_dvar("st_disable_carpenter", "1");
    init_dvar("st_disable_firesale", "1");
    init_dvar("st_disable_death_machine", "1");

    // Map dvars
    init_dvar("st_zombie_pentagon_disabled_window1", "conference_ne");
    init_dvar("st_zombie_pentagon_disabled_window2", "hallway_e");
    init_dvar("st_director_active", "0");
    init_dvar("st_novas_active", "0");
    init_dvar("st_digger_t6", "0");
    init_dvar("st_digger_t11", "0");
    init_dvar("st_digger_bio", "0");
    init_dvar("st_shang_special_zombies", "0");
}

init_strattester_client_dvars()
{
    players = get_players();
    for (i = 0; i < players.size; i++)
    {
        players[i] init_client_dvar("st_hud_enemy_counter_value", "0");
        players[i] init_client_dvar("st_hud_sph", "0");
        players[i] init_client_dvar("st_hud_tesla_kills", "0");
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
    debug_mode = true;
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