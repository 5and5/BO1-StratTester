#include common_scripts\utility; 
#include maps\_utility;

spawn_strattester_player()
{
    self.strattester = spawnStruct();

    /* Logic for weapons given on spawn */
    wpn_array = array("wpn1", "wpn2", "wpn3");
    self maps\_strattester_weapons::initialize_weapon_dvars_for_player(wpn_array);
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
