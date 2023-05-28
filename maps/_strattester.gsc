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

init_dvar(dvar, def)
{
    if (!isDefined(def))
        def = "0";

    if (getDvar(dvar) == "")
        setDvar(dvar, def);
}

init_strattester_dvars()
{
    init_dvar("st_round_number", "100");
    init_dvar("st_backspeed_fix", "1");
    init_dvar("st_weapon_preset", "highround");

    level thread watch_dvar("st_weapon_preset");
    level thread watch_dvar("st_backspeed_fix");
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