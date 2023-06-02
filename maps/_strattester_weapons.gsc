#include common_scripts\utility; 
#include maps\_utility;
#include maps\_strattester_presets;

/*
	Dvars are generated as follows 'st_<ent_number>_<wpn_number>'
	Where ent number is internal ID of the player (0 to 3) and wpn_numbers are wpn1, wpn2 and wpn3. Those can be set directly in the config file
	Example, to give blue player bow and bknives, following entires would be added to config file
	st_1_wpn1 "knife_ballistic_upgraded_zm"
	st_1_wpn2 "crossbow_explosive_upgraded_zm"
*/

give_player_weapons()
{
    level endon("end_game");
    self endon("disconnect");

	level waittill("fade_introblack");
    initial_give = true;

    while (true)
    {
        while (getDvar("st_give_weapons") == "0")
            wait 0.05;

        if (getDvar("st_award_melee") == "1")
            self award_melee_weapon();
        if (getDvar("st_award_mines") == "1")
            self award_mines();

        if (initial_give)
            self takeWeapon("m1911_zm");
        else
        {
            player_weapons = self GetWeaponsListPrimaries();
            for (i = 0; i < player_weapons.size; i++)
            {
                self takeWeapon(player_weapons[i]);
                wait 0.05;
            }
        }

        self strattester_give_weapon(self.strattester.weapon1);
        self strattester_give_weapon(self.strattester.weapon2);
        if (self hasperk("specialty_additionalprimaryweapon"))
            self strattester_give_weapon(self.strattester.weapon3);

        if (getDvar("st_award_tacticals") == "1")
            self thread strattester_give_tacticals(self.strattester.tactical);

        self switchToWeapon(self.strattester.weapon1);

        /*
        all_weapons = self getWeaponsList();
        for (i = 0; i < all_weapons.size; i++)
            maps\_strattester::debug_print(all_weapons[i]);
        */

        // Initialize that dvar to 1 in gsc
        if (getDvar("st_award_hacker") == "1" && level.script == "zombie_moon")
            self award_hacker();

        level waittill("st_weapon_preset_changed");
        initial_give = false;
        self update_weapons();
    }
}

get_weapon_settings(wpn_array)
{
    if (!isDefined(wpn_array))
        wpn_array = array("wpn1", "wpn2", "wpn3");

    weapon_settings = array();

    for (i = 0; i < wpn_array.size; i++)
    {
        weapon = "";

        /* Pull weapon from the config */
        if (getDvar("st_use_cfg_weapons") == "1")
        {
            dvar = "st_" + self.entity_num + "_" + wpn_array[i];
            weapon = getDvar(dvar);
        }

        /* Pull default weapons */
        if (weapon == "" || (!isDefined(level.zombie_weapons[weapon]) && !maps\_zombiemode_weapons::is_weapon_upgraded(weapon)))
            weapon = get_weapon_default(i, self.entity_num);

        /* bipod check is necessary, cause paped name for bipod weapons is an empty string */
        if (is_in_array(array("zombie_cod5_prototype", "zombie_cod5_asylum", "zombie_cod5_sumpf"), level.script) && !isSubStr(weapon, "bipod"))
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

get_weapon_default(array_index, index)
{
    if (!isDefined(index))
        index = 0;

    weapon_preset = getDvar("st_weapon_preset");
    p = get_players().size;
    // maps\_strattester::debug_print("weapon_preset: " + weapon_preset + " index: " + index);

    /*
        Presets:
        - Instas
        - No Power
        - 30sr
        - Strat dependent hr
    */

    switch (level.script)
    {
        case "zombie_cod5_prototype":
            a = weapon_preset_nacht(index, p, weapon_preset);
            break;
        case "zombie_cod5_asylum":
            a = weapon_preset_verruckt(index, p, weapon_preset);
            break;
        case "zombie_cod5_sumpf":
            a = weapon_preset_shino(index, p, weapon_preset);
            break;
        case "zombie_cod5_factory":
            a = weapon_preset_der(index, p, weapon_preset);
            break;
        case "zombie_theater":
            a = weapon_preset_kino(index, p, weapon_preset);
            break;
        case "zombie_pentagon":
            a = weapon_preset_five(index, p, weapon_preset);
            break;
        case "zombie_cosmodrome":
            a = weapon_preset_ascension(index, p, weapon_preset);
            break;
        case "zombie_coast":
            a = weapon_preset_cotd(index, p, weapon_preset);
            break;
        case "zombie_temple":
            a = weapon_preset_shang(index, p, weapon_preset);
            break;
        case "zombie_moon":
            a = weapon_preset_moon(index, p, weapon_preset);
            break;
        default:
            a = array("cz75dw_zm", "ray_gun_zm", "", "0");
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
        return false;
    }

    // maps\_strattester::debug_print("weapon: " + weapon);
    if (isSubStr(weapon, "upgraded"))
        self giveWeapon(weapon, 0, self maps\_zombiemode_weapons::get_pack_a_punch_weapon_options(weapon));
    else
        self giveWeapon(weapon);

    if (weapon == "microwavegundw_upgraded_zm")
        self GiveMaxAmmo("microwavegun_upgraded_zm");
    else if (weapon == "microwavegundw_zm")
        self GiveMaxAmmo("microwavegun_zm");
    else if (weapon == "m16_gl_upgraded_zm")
        self GiveMaxAmmo("gl_m16_upgraded_zm");

    self giveMaxAmmo(weapon);
    return true;
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

award_mines()
{
    switch (level.script)
    {
        case "zombie_cod5_asylum":
        case "zombie_cod5_sumpf":
        case "zombie_cod5_factory":
            trigger = "betty_purchase";
            break;
        case "zombie_temple":
            trigger = "spikemore_purchase";
            break;
        case "zombie_cod5_prototype":
            return;
        default:
            trigger = "claymore_purchase";
    }

    trigs = getentarray(trigger,"targetname");
    trigs[0] notify("trigger", self);
}

update_weapons()
{
    new_weapons = get_weapon_settings();

    tactical_id = self maps\_strattester_weapons::get_tactical_setting();

    self.strattester.weapon1 = new_weapons["wpn1"];
    self.strattester.weapon2 = new_weapons["wpn2"];
    self.strattester.weapon3 = new_weapons["wpn3"];
    self.strattester.tactical = maps\_strattester_weapons::get_tactical_pointer(tactical_id);
}

award_hacker()
{
    hacker = GetEntArray("zombie_equipment_upgrade", "targetname"); 
    for (i = 0; i < hacker.size; i++) 
    { 
        if(isDefined(hacker[i].zombie_equipment_upgrade) && hacker[i].zombie_equipment_upgrade == "equip_hacker_zm") 
            hacker[i] notify("trigger", self); 
    }
}

get_wonderweapon()
{
    switch (level.script)
    {
        case "zombie_theater":
        case "zombie_cosmodrome":
        case "zombie_cod5_prototype":
            return "thundergun_zm";
        case "zombie_pentagon":
        case "zombie_cod5_asylum":
            return "ray_gun_zm";
        case "zombie_coast":
            return "humangun_zm";
        case "zombie_temple":
            return "shrink_ray_zm";
        case "zombie_moon":
            return "microwavegundw_zm";
        case "zombie_cod5_sumpf":
        case "zombie_cod5_factory":
            return "tesla_gun_zm";
    }
}

refill_ammo()
{
    level endon("end_game");
    self endon("disconnect");

    while (true)
    {
        if (getDvar("st_ammo_refill") == "1" && !is_true(maps\_laststand::player_is_in_laststand()))
        {    
            guns = self GetWeaponsList();

            self notify("zmb_max_ammo");
            self notify("zmb_lost_knife");
            self notify("zmb_disable_claymore_prompt");
            self notify("zmb_disable_spikemore_prompt");

            for (i = 0; i < guns.size; i++)
                self giveMaxAmmo(guns[i]);
        }

        wait 0.4;
    }
}