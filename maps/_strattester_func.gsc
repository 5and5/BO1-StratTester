#include common_scripts\utility; 
#include maps\_utility;

stub()
{
    return;
}

debug_print(content)
{
    debug_mode = true;
    iPrintLn("DEBUG: " + content);
}

initialize_weapon_dvars_for_player(wpn_array)
{
    for (i = 0; i < wpn_array.size; i++)
    {
        dvar = "st_" + self.entity_num + "_" + wpn_array[i];
        if (getDvar(dvar) == "")
            setDvar(dvar, "");
    }
}

get_weapon_settings(wpn_array)
{
    weapon_settings = array();

    for (i = 0; i < wpn_array.size; i++)
    {
        weapon = "";

        /* Pull weapon from the config */
        dvar = "st_" + self.entity_num + "_" + wpn_array[i];
        weapon = getDvar(dvar);

        /* Pull weapon from settings */

        /* Pull default weapons */
        if (weapon == "")
            weapon = get_weapon_default(i);

        /* Save weapon */
        weapon_settings[wpn_array[i]] = weapon;
    }

    debug_print("tact: " + weapon_settings["tact"]);

    /* Handle tactical weapons separately */
    if (isDefined(weapon_settings["tact"]))
    {
        options = array("0", "1", "2", "3", "4");
        if (!is_in_array(options, weapon_settings["tact"]))
            weapon_settings["tact"] = "666";
        weapon_settings["tact"] = int(weapon_settings["tact"]);
        weapon_settings["tact"] = get_tactical_pointer(weapon_settings["tact"]);
    }
    else
        weapon_settings["tact"] = get_tactical_pointer(666);

    return weapon_settings;
}

get_weapon_default(array_index)
{
    switch (level.script)
    {
        case "zombie_cod5_prototype":
            a = array("thundergun_zm", "ray_gun_zm", "", "1");
            break;
        case "zombie_cod5_asylum":
            a = array("cz75dw_zm", "ray_gun_zm", "", "1");
            break;
        case "zombie_cod5_sumpf":
            a = array("tesla_gun_zm", "cz75dw_zm", "", "1");
            break;
        case "zombie_cod5_factory":
            a = array("tesla_gun_upgraded_zm", "ray_gun_upgraded_zm", "", "1");
            break;
        case "zombie_theater":
            a = array("thundergun_zm", "ray_gun_zm", "", "1");
            break;
        case "zombie_pentagon":
            a = array("crossbow_explosive_upgraded_zm", "ray_gun_upgraded_zm", "", "1");
            break;
        case "zombie_cosmodrome":
            a = array("thundergun_upgraded_zm", "ray_gun_upgraded_zm", "", "2");
            break;
        case "zombie_coast":
            a = array("sniper_explosive_upgraded_zm", "humangun_upgraded_zm", "", "3");
            break;
        case "zombie_temple":
            a = array("shrink_ray_upgraded_zm", "m1911_upgraded_zm", "", "1");
            break;
        case "zombie_moon":
            a = array("microwavegun_upgraded_zm", "m1911_upgraded_zm", "", "2");
            break;
        default:
            a = array("", "", "", "0");

        if (isDefined(array_index) && isDefined(a[array_index]))
            return a[array_index];
        return "";
    }
}

get_tactical_pointer(tactical_id)
{
    /* IDS:
        1 - Monkeys
        2 - Gersh
        3 - Dolls
        4 - QED
    */
    debug_print("tactical pointer of id " + tactical_id);
    if (tactical_id == 0)
        return ::stub;
    if (isDefined(level.strattester_tactical_black_hole) && tactical_id == 2)
        return level.strattester_tactical_black_hole;
    if (isDefined(level.strattester_tactical_dolls) && tactical_id == 3)
        return level.strattester_tactical_dolls;
    if (isDefined(level.strattester_tactical_qed) && tactical_id == 4)
        return level.strattester_tactical_qed;
    /* This will trigger in case wrong ID is used but map has no monkeys */
    if (isDefined(level.strattester_tactical_fallback))
        return level.strattester_tactical_fallback;
    return maps\_zombiemode_weap_cymbal_monkey::player_give_cymbal_monkey;
}

award_melee_weapon()
{
    switch (level.script)
    {
        case "zombie_theater":
        case "zombie_pentagon":
        case "zombie_temple":
        case "zombie_moon":
        case "zombie_cod5_factory":
            self giveWeapon("bowie_knife_zm");
            break;
        case "zombie_cosmodrome":
        case "zombie_coast":
            self giveWeapon("sickle_knife_zm");
            break;
    }
}

strattester_give_weapon(weapon)
{
    if (!isDefined(level.zombie_weapons[weapon]) && !maps\_zombiemode_weapons::is_weapon_upgraded(weapon))
    {
        iPrintLn("Can't find weapon: " + weapon);
        return;
    }

    if (isSubStr(weapon, "upgraded"))
        self giveWeapon(weapon, 0, self maps\_zombiemode_weapons::get_pack_a_punch_weapon_options(weapon));
    else
        self giveWeapon(weapon);

    self giveMaxAmmo(weapon);
}