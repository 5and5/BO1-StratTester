#include common_scripts\utility; 
#include maps\_utility;
#include maps\_zombiemode_net;
#include maps\_zombiemode_audio;

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

    self.st_grenades_thrown = 0;

    self throwaway_grenade_hud();
    self thread watch_grenade_pull();

    // debug_print("weapon1: " + self.strattester.weapon1);
    // debug_print("weapon2: " + self.strattester.weapon2);
    // debug_print("weapon3: " + self.strattester.weapon3);
}

init_levelvars()
{
    level.st_version = "2.4-z2";
    level.st_grenades_thrown = 0;
    if (level.script == "zombie_cod5_asylum")
    {
        level.st_grenades_damage_tracking = [];
    }
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
    init_dvar("st_grenade_hud", "0");

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
        players[i] setClientDvar("st_version", level.st_version);
        players[i] init_client_dvar("st_hud_enemy_counter_value", "0");
        players[i] init_client_dvar("st_hud_sph", "0");
        players[i] init_client_dvar("st_hud_kills_per_shot", "0");
        players[i] init_client_dvar("st_hud_zone_name", "");
        players[i] init_client_dvar("st_hud_health_bar_value", "100");
        players[i] init_client_dvar("st_hud_health_bar_width", "100");
        players[i] init_client_dvar("st_grenades_thrown", "0");
        players[i] init_client_dvar("st_global_grenades_thrown", "0");
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
                case "zombie_dog":
                case "thief_zombie":
                case "astro_zombie":
                    is_special = true;
                    break;
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

watch_grenade_pull()
{
    level endon("end_game");
    self endon("disconnect");

    while (true)
    {
        self waittill ("grenade_pullback", weaponName);

        // iPrintLn(weaponName);
        switch (weaponName)
        {
            case "claymore_zm":
            case "spikemore_zm":
            case "mine_bouncing_betty":
            case "zombie_cymbal_monkey":
            case "zombie_nesting_dolls":
            case "zombie_black_hole_bomb":
                break;
            default:
                increment_grenades_thrown();
        }
    }
}

increment_grenades_thrown()
{
    if (!isdefined(self.st_grenade_hud))
    {
        self throwaway_grenade_hud();
    }

    level.st_grenades_thrown++;
    self.st_grenades_thrown++;

    // For the future, if put into menus
    self setClientDvar("st_global_grenades_thrown", level.st_grenades_thrown);
    self setClientDvar("st_grenades_thrown", self.st_grenades_thrown);

    // Current throwaway GSC hud
    self.st_grenade_hud setValue(self.st_grenades_thrown);
    level.st_grenade_hud setValue(level.st_grenades_thrown);
}

throwaway_grenade_hud()
{
    if (!isdefined(level.st_grenade_hud))
    {
        level.st_grenade_hud = maps\_zombiemode_utility::create_simple_hud();
        level.st_grenade_hud.alignX = "left"; 
        level.st_grenade_hud.alignY = "top";
        level.st_grenade_hud.horzAlign = "user_left"; 
        level.st_grenade_hud.vertAlign = "user_top";
        level.st_grenade_hud.color = ( 1, 1, 1 );
        level.st_grenade_hud.fontscale = 1.2;
        level.st_grenade_hud.x = 0;
        level.st_grenade_hud.y = 85;
        level.st_grenade_hud.label = "Total nades:";
        level.st_grenade_hud.alpha = 1;

        level.st_grenade_hud setValue(level.st_grenades_thrown);
    }

    self.st_grenade_hud = maps\_zombiemode_utility::create_simple_hud(self);
    self.st_grenade_hud.alignX = "left"; 
    self.st_grenade_hud.alignY = "top";
    self.st_grenade_hud.horzAlign = "user_left"; 
    self.st_grenade_hud.vertAlign = "user_top";
    self.st_grenade_hud.color = ( 1, 1, 1 );
    self.st_grenade_hud.fontscale = 1.2;
    self.st_grenade_hud.x = 0;
    self.st_grenade_hud.y = 96;
    self.st_grenade_hud.label = "My nades:";
    self.st_grenade_hud.alpha = 1;

    self.st_grenade_hud setValue(self.st_grenades_thrown);

    thread throwaway_grenade_hud_control();
}

throwaway_grenade_hud_control()
{
    level notify("st_kill_throwaway_grenade_hud_control");
    level endon("st_kill_throwaway_grenade_hud_control");

    while (true)
    {
        players = getplayers();

        for (i = 0; i < players.size; i++)
        {
            if (isdefined(players[i].st_grenade_hud))
            {
                players[i].st_grenade_hud.alpha = getDvarInt("st_grenade_hud");
            }
        }

        if (isdefined(level.st_grenade_hud))
        {
            level.st_grenade_hud.alpha = getDvarInt("st_grenade_hud");
        }

        wait 0.1;
    }
}

st_zombie_damage(mod, hit_location, hit_origin, player, amount)
{
    if( maps\_zombiemode_utility::is_magic_bullet_shield_enabled( self ) )
    {
        return;
    }

    //ChrisP - 12/8 - no points for killing gassed zombies!
    player.use_weapon_type = mod;
    if(isDefined(self.marked_for_death))
    {
        return;
    }	

    if( !IsDefined( player ) )
    {
        return; 
    }

    if ( self maps\_zombiemode_spawner::check_zombie_damage_callbacks( mod, hit_location, hit_origin, player, amount ) )
    {
        return;
    }
    else if( self maps\_zombiemode_spawner::zombie_flame_damage( mod, player ) )
    {
        if( self maps\_zombiemode_spawner::zombie_give_flame_damage_points() )
        {
            player maps\_zombiemode_score::player_add_points( "damage", mod, hit_location, self.isdog );
        }
    }
    else if( self maps\_zombiemode_weap_tesla::is_tesla_damage( mod ) )
    {
        self maps\_zombiemode_weap_tesla::tesla_damage_init( hit_location, hit_origin, player );
        return;
    }
    else
    {
        if ( self maps\_zombiemode_weap_freezegun::is_freezegun_damage( self.damagemod ) )
        {
            self thread maps\_zombiemode_weap_freezegun::freezegun_damage_response( player, amount );
        }

        // no points awarded for damage or deaths dealt by the shatter result
        if ( !self maps\_zombiemode_weap_freezegun::is_freezegun_shatter_damage( self.damagemod ) )
        {
            if( maps\_zombiemode_spawner::player_using_hi_score_weapon( player ) )
            {
                damage_type = "damage";
            }
            else
            {
                damage_type = "damage_light";
            }

            if ( !is_true( self.no_damage_points ) )
            {
                player maps\_zombiemode_score::player_add_points( damage_type, mod, hit_location, self.isdog );
            }
        }
    }

    if ( IsDefined( self.zombie_damage_fx_func ) )
    {
        self [[ self.zombie_damage_fx_func ]]( mod, hit_location, hit_origin, player );
    }

    modName = maps\_zombiemode_utility::remove_mod_from_methodofdeath( mod );

    if ( self maps\_zombiemode_weap_freezegun::is_freezegun_damage( self.damagemod ) )
    {
        ; // no scaling damage for the freezegun
    }
    else if( maps\_zombiemode_utility::is_placeable_mine( self.damageweapon ) )
    {
        if ( IsDefined( self.zombie_damage_claymore_func ) )
        {
            self [[ self.zombie_damage_claymore_func ]]( mod, hit_location, hit_origin, player );
        }
        else if ( isdefined( player ) && isalive( player ) )
        {
            self DoDamage( level.round_number * randomintrange( 100, 200 ), self.origin, player);
        }
        else
        {
            self DoDamage( level.round_number * randomintrange( 100, 200 ), self.origin, undefined );
        }
    }
    else if ( mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" )
    {
        /* 
         * This damage is calculated directly in DoDamage call in the original, 
         * taking it out to keep the data
         */
        randomized = level.round_number + randomintrange(100, 200);
        if (isdefined(level.st_grenades_damage_tracking) && level.st_grenades_damage_tracking.size < 48)
        {
            level.st_grenades_damage_tracking[level.st_grenades_damage_tracking.size] = randomized;
        }

        if ( isdefined( player ) && isalive( player ) )
        {
            self DoDamage( randomized, self.origin, player, 0, modName, hit_location);
        }
        else
        {
            self DoDamage( randomized, self.origin, undefined, 0, modName, hit_location );
        }
    }
    else if( mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH" )
    {
        if ( isdefined( player ) && isalive( player ) )
        {
            self DoDamage( level.round_number * randomintrange( 0, 100 ), self.origin, player, 0, modName, hit_location);
        }
        else
        {
            self DoDamage( level.round_number * randomintrange( 0, 100 ), self.origin, undefined, 0, modName, hit_location );
        }
    }

    //AUDIO Plays a sound when Crawlers are created
    if( IsDefined( self.a.gib_ref ) && (self.a.gib_ref == "no_legs") && isalive( self ) )
    {
        if ( isdefined( player ) )
        {
            rand = randomintrange(0, 100);
            if(rand < 10)
            {
                player create_and_play_dialog( "general", "crawl_spawn" );
            }
        }
    }
    else if( IsDefined( self.a.gib_ref ) && ( (self.a.gib_ref == "right_arm") || (self.a.gib_ref == "left_arm") ) )
    {
        if( self.has_legs && isalive( self ) )
        {
            if ( isdefined( player ) )
            {
                rand = randomintrange(0, 100);
                if(rand < 7)
                {
                    player create_and_play_dialog( "general", "shoot_arm" );
                }
            }
        }
    }	
    self thread maps\_zombiemode_powerups::check_for_instakill( player, mod, hit_location );
}

grenade_damage_tracking_printer()
{
    level endon("end_game");

    while (true)
    {
        if (isdefined(level.st_grenades_damage_tracking) && level.st_grenades_damage_tracking.size)
        {
            table = level.st_grenades_damage_tracking;
            level.st_grenades_damage_tracking = [];

            line = "";
            for (i = 0; i < table.size; i++)
            {
                if (i && i % 6 == 0)
                {
                    iPrintLn(line);
                    line = "";
                }
                line += " " + table[i];
            }

            if (line != "")
            {
                iPrintLn(line);
            }
        }

        wait 0.2;
    }
}
