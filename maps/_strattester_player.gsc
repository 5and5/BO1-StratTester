#include common_scripts\utility; 
#include maps\_utility;
#include maps\_strattester_func;

spawn_strattester_player()
{
    self.strattester = spawnStruct();

    /* Logic for weapons given on spawn */
    wpn_array = array("wpn1", "wpn2", "wpn3", "tact");
    self initialize_weapon_dvars_for_player(wpn_array);
    weapons_array = self get_weapon_settings(wpn_array);

    if (isDefined(level.zombie_weapons[weapons_array["wpn1"]]) || maps\_zombiemode_weapons::is_weapon_upgraded(weapons_array["wpn1"]))
        self.strattester.weapon1 = weapons_array["wpn1"];
    else
        self.strattester.weapon1 = get_weapon_default(0);

    if (isDefined(level.zombie_weapons[weapons_array["wpn2"]]) || maps\_zombiemode_weapons::is_weapon_upgraded(weapons_array["wpn2"]))
        self.strattester.weapon2 = weapons_array["wpn2"];
    else
        self.strattester.weapon2 = get_weapon_default(1);

    if (isDefined(level.zombie_weapons[weapons_array["wpn3"]]) || maps\_zombiemode_weapons::is_weapon_upgraded(weapons_array["wpn3"]))
        self.strattester.weapon3 = weapons_array["wpn3"];
    else
        self.strattester.weapon3 = get_weapon_default(2);

    self thread set_tacticals(weapons_array["tact"]);
}

