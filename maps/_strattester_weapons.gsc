#include common_scripts\utility; 
#include maps\_utility;

/*
	Dvars are generated as follows 'st_<ent_number>_<wpn_number>'
	Where ent number is internal ID of the player (0 to 3) and wpn_numbers are wpn1, wpn2 and wpn3. Those can be set directly in the config file
	Example, to give blue player bow and bknives, following entires would be added to config file
	st_1_wpn1 "knife_ballistic_upgraded_zm"
	st_1_wpn2 "crossbow_explosive_upgraded_zm"
*/

give_player_weapons()
{
	level waittill("fade_introblack");

	if (getDvar("give_weapons") == "0")
		return;

	if (getDvar("st_award_melee") == "1")
		self award_melee_weapon();
	if (getDvar("st_award_mines") == "1")
	{
		if (!isDefined(level.strattester_mine_pointer))
			level.strattester_mine_pointer = maps\_zombiemode_claymore::claymore_setup;
		self thread [[level.strattester_mine_pointer]]();
	}

	self takeWeapon("m1911_zm");
	self strattester_give_weapon(self.strattester.weapon1);
	self strattester_give_weapon(self.strattester.weapon2);
	if (self hasperk("specialty_additionalprimaryweapon"))
		self strattester_give_weapon(self.strattester.weapon3);

	if (getDvar("st_award_tacticals") == "1")
		self thread strattester_give_tacticals(self.strattester.tactical);

    self switchToWeapon(self.strattester.weapon1);
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
        if (weapon == "" || (!isDefined(level.zombie_weapons[weapon]) && !maps\_zombiemode_weapons::is_weapon_upgraded(weapon)))
            weapon = get_weapon_default(i);

        if (is_in_array(array("zombie_cod5_prototype", "zombie_cod5_asylum", "zombie_cod5_sumpf"), level.script))
            weapon = get_base_name_of_weapon(weapon);

        /* Save weapon */
        weapon_settings[wpn_array[i]] = weapon;
    }

    return weapon_settings;
}

get_tactical_setting()
{
    dvar = "st_" + self.entity_num + "_tact";
    if (is_in_array(array("0", "1", "2", "3", "4"), getDvar(dvar)))
        tactical_id = getDvar(dvar);
    else
        tactical_id = get_weapon_default(3);

    return int(tactical_id);
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
    }

    if (isDefined(array_index) && isDefined(a[array_index]))
        return a[array_index];
    return "";
}

get_tactical_pointer(tactical_id)
{
    /* IDS:
        1 - Monkeys
        2 - Gersh
        3 - Dolls
        4 - QED
    */

    // maps\_strattester::debug_print("tactical pointer of id " + tactical_id + " isint=" + !isString(tactical_id));

    if (tactical_id == 0)
        return maps\_strattester::stub;
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
        // maps\_strattester::debug_print("Can't find weapon: " + weapon);
        return;
    }

    maps\_strattester::debug_print("weapon: " + weapon);
    if (isSubStr(weapon, "upgraded"))
        self giveWeapon(weapon, 0, self maps\_zombiemode_weapons::get_pack_a_punch_weapon_options(weapon));
    else
        self giveWeapon(weapon);

    self giveMaxAmmo(weapon);
}

strattester_give_tacticals(func)
{
    level endon("end_game");
    self endon("disconnect");

    level waittill("start_of_round");
    // maps\_strattester::debug_print("awarding tacticals");
    self [[func]]();
}

get_base_name_of_weapon(upgraded_weapon)
{
    keys = getArrayKeys(level.zombie_weapons);
    for (i = 0; i < keys.size; i++)
    {
        if (isDefined(level.zombie_weapons[keys[i]].upgrade_name) && (level.zombie_weapons[keys[i]].upgrade_name == upgraded_weapon))
            return level.zombie_weapons[keys[i]].weapon_name;
    }

    return upgraded_weapon;
}