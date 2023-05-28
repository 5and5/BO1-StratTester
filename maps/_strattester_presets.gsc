#include common_scripts\utility; 
#include maps\_utility;

weapon_preset_nacht(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            default:
                a = array("thundergun_zm", "ray_gun_zm", "zombie_thompson", "1");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "30sr":
                if (index == 0)
                    a = array("thundergun_zm", "ray_gun_zm", "hk21_zm", "1");
                else
                    a = array("ray_gun_zm", "m72_law_zm", "hk21_zm", "1");
                break;
            default:
                if (index == 0)
                    a = array("thundergun_zm", "ray_gun_zm", "zombie_thompson", "1");
                else if (index == 1)
                    a = array("knife_ballistic_zm", "ray_gun_zm", "zombie_thompson", "1");
                else if (index == 2)
                    a = array("crossbow_explosive_zm", "ray_gun_zm", "zombie_thompson", "1");
                else
                    a = array("cz75dw_zm", "ray_gun_zm", "zombie_thompson", "1");
        }
    }

    return a;
}

weapon_preset_verruckt(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "nopower":
                a = array("freezegun_zm", "ray_gun_zm", "nonexistinggun", "1");
                break;
            case "30sr":
                a = array("hk21_zm", "ray_gun_zm", "nonexistinggun", "1");
                break;
            default:
                a = array("cz75dw_zm", "zombie_thompson", "nonexistinggun", "1");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "nopower":
            case "30sr":
                if (index == 0)
                    a = array("freezegun_zm", "ray_gun_zm", "", "1");
                else
                    a = array("hk21_zm", "ray_gun_zm", "", "1");
                break;
            default:
                a = array("cz75dw_zm", "zombie_thompson", "", "1");
        }
    }

    return a;
}

weapon_preset_shino(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "instas":
                a = array("tesla_gun_zm", "zombie_stg44", "zombie_thompson", "1");
                break;
            case "30sr":
                a = array("tesla_gun_zm", "ray_gun_zm", "hk21_zm", "1");
                break;
            default:
                a = array("tesla_gun_zm", "cz75dw_zm", "zombie_thompson", "1");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "instas":
                if (index == 0)
                    a = array("tesla_gun_zm", "zombie_stg44", "zombie_thompson", "1");
                else
                    a = array("cz75dw_zm", "zombie_stg44", "zombie_thompson", "1");
                break;
            case "30sr":
                if (index == 0)
                    a = array("tesla_gun_zm", "ray_gun_zm", "hk21_zm", "1");
                else
                    a = array("hk21_zm", "ray_gun_zm", "commando_zm", "1");
                break;
            default:
                if (index == 0)
                    a = array("tesla_gun_zm", "cz75dw_zm", "zombie_thompson", "1");
                else
                    a = array("cz75dw_zm", "zombie_thompson", "", "1");
                break;
        }
    }

    return a;
}

weapon_preset_der(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "instas":
                a = array("tesla_gun_upgraded_zm", "zombie_thompson_upgraded", "ray_gun_upgraded_zm", "1");
                break;
            case "nopower":
                a = array("tesla_gun_zm", "ray_gun_zm", "", "1");
                break;
            case "30sr":
                a = array("m1911_upgraded_zm", "tesla_gun_upgraded_zm", "ray_gun_upgraded_zm", "1");
                break;
            default:
                a = array("tesla_gun_upgraded_zm", "ray_gun_upgraded_zm", "zombie_thompson", "1");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "instas":
                if (index == 0)
                    a = array("tesla_gun_upgraded_zm", "zombie_thompson_upgraded", "ray_gun_upgraded_zm", "1");
                else
                    a = array("ray_gun_upgraded_zm", "zombie_thompson_upgraded", "", "1");
                break;
            case "nopower":
                if (index == 0)
                    a = array("tesla_gun_zm", "ray_gun_zm", "", "1");
                else
                    a = array("ray_gun_zm", "hk21_zm", "", "1");
                break;
            case "30sr":
                if (index == 0)
                    a = array("m1911_upgraded_zm", "tesla_gun_upgraded_zm", "ray_gun_upgraded_zm", "1");
                else
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "hk21_upgraded_zm", "1");
                break;
            default:
                if (index == 0)
                    a = array("tesla_gun_upgraded_zm", "ray_gun_upgraded_zm", "zombie_thompson", "1");
                else if (index == 1)
                    a = array("ray_gun_upgraded_zm", "crossbow_explosive_upgraded_zm", "zombie_thompson", "1");
                else if (index == 2)
                    a = array("ray_gun_upgraded_zm", "knife_ballistic_upgraded_zm", "zombie_thompson", "1");
                else
                    a = array("ray_gun_upgraded_zm", "zombie_thompson", "", "1");
        }
    }

    return a;
}

weapon_preset_kino(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "nopower":
                a = array("thundergun_zm", "ray_gun_zm", "", "1");
                break;
            case "30sr":
                a = array("thundergun_upgraded_zm", "ray_gun_upgraded_zm", "mp40_zm", "1");
                break;
            case "novas":
                a = array("thundergun_upgraded_zm", "crossbow_explosive_upgraded_zm", "cz75dw_upgraded_zm", "1");
                break;
            default:
                a = array("thundergun_zm", "mpl_zm", "", "1");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "nopower":
                if (index == 0)
                    a = array("thundergun_zm", "ray_gun_zm", "", "1");
                else
                    a = array("ray_gun_zm", "m72_law_zm", "", "1");
                break;
            case "30sr":
                if (index == 0)
                    a = array("thundergun_upgraded_zm", "ray_gun_upgraded_zm", "mp40_zm", "1");
                else
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "hk21_upgraded_zm", "1");
                break;
            case "novas":
                if (index == 0)
                    a = array("thundergun_upgraded_zm", "crossbow_explosive_upgraded_zm", "cz75dw_upgraded_zm", "1");
                else if (index == 1)
                    a = array("crossbow_explosive_upgraded_zm", "ray_gun_upgraded_zm", "cz75dw_upgraded_zm", "1");
                else if (index == 2)
                    a = array("knife_ballistic_upgraded_zm", "ray_gun_upgraded_zm", "cz75dw_upgraded_zm", "1");
                else
                    a = array("ray_gun_upgraded_zm", "cz75dw_upgraded_zm", "", "1");
                break;
            default:
                if (index == 0)
                    a = array("thundergun_zm", "mpl_zm", "ray_gun_zm", "1");
                else
                    a = array("ray_gun_zm", "mpl_zm", "", "1");
        }
    }

    return a;
}

weapon_preset_five(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "instas":
                a = array("ithaca_zm", "crossbow_explosive_upgraded_zm", "", "1");
                break;
            case "nopower":
                a = array("freezegun_zm", "ray_gun_zm", "", "1");
                break;
            case "30sr":
                a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "crossbow_explosive_upgraded_zm", "1");
                break;
            default:
                a = array("ray_gun_upgraded_zm", "crossbow_explosive_upgraded_zm", "", "1");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "instas":
                if (index == 0)
                    a = array("ithaca_upgraded_zm", "knife_ballistic_upgraded_zm", "", "1");
                else if (index == 1)
                    a = array("ithaca_upgraded_zm", "crossbow_explosive_upgraded_zm", "", "1");
                else
                    a = array("ithaca_upgraded_zm", "mpl_zm", "", "1");
                break;
            case "nopower":
                if (index == 0)
                    a = array("freezegun_zm", "ray_gun_zm", "", "1");
                else
                    a = array("ray_gun_zm", "m72_law_zm", "", "1");
                break;
            case "30sr":
                if (index == 0)
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "crossbow_explosive_upgraded_zm", "1");
                else
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "1");
                break;
            default:
                if (index == 0)
                    a = array("crossbow_explosive_upgraded_zm", "ray_gun_upgraded_zm", "mpl_zm", "1");
                else if (index == 1)
                    a = array("knife_ballistic_upgraded_zm", "ray_gun_upgraded_zm", "mpl_zm", "1");
                else if (index == 2)
                    a = array("freezegun_upgraded_zm", "ray_gun_upgraded_zm", "mpl_zm", "1");
                else
                    a = array("ray_gun_upgraded_zm", "mpl_zm", "", "1");
                break;
        }
    }

    return a;
}

weapon_preset_ascension(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "instas":
                a = array("thundergun_upgraded_zm", "m16_gl_upgraded_zm", "crossbow_explosive_upgraded_zm", "2");
                break;
            case "nopower":
                a = array("thundergun_zm", "ray_gun_zm", "", "2");
                break;
            case "30sr":
                a = array("m1911_upgraded_zm", "thundergun_upgraded_zm", "ray_gun_upgraded_zm", "2");
                break;
            default:
                a = array("thundergun_upgraded_zm", "crossbow_explosive_upgraded_zm", "hk21_zm", "2");
        }
    }
    // 2p
    else if (p == 2)
    {
        switch (preset)
        {
            case "instas":
                if (index == 0)
                    a = array("thundergun_upgraded_zm", "m16_gl_upgraded_zm", "cz75dw_upgraded_zm", "2");
                else
                    a = array("crossbow_explosive_upgraded_zm", "m16_gl_upgraded_zm", "knife_ballistic_upgraded_zm", "2");
                break;
            case "nopower":
                if (index == 0)
                    a = array("thundergun_zm", "knife_ballistic_zm", "", "2");
                else if (index == 1)
                    a = array("cz75dw_zm", "crossbow_explosive_zm", "", "2");
                break;
            case "30sr":
                if (index == 0)
                    a = array("m1911_upgraded_zm", "thundergun_upgraded_zm", "ray_gun_upgraded_zm", "2");
                else
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "crossbow_explosive_upgraded_zm", "2");
                break;
            default:
                if (index == 0)
                    a = array("thundergun_upgraded_zm", "hk21_zm", "cz75dw_upgraded_zm", "2");
                else
                    a = array("knife_ballistic_upgraded_zm", "crossbow_explosive_upgraded_zm", "hk21_zm", "2");
        }
    }
    // 3p & 4p
    else
    {
        switch (preset)
        {
            case "instas":
                if (index == 0)
                    a = array("thundergun_upgraded_zm", "m16_gl_upgraded_zm", "", "2");
                else if (index == 1)
                    a = array("crossbow_explosive_upgraded_zm", "m16_gl_upgraded_zm", "", "2");
                else if (index == 2)
                    a = array("knife_ballistic_upgraded_zm", "m16_gl_upgraded_zm", "", "2");
                else
                    a = array("cz75dw_upgraded_zm", "m16_gl_upgraded_zm", "", "2");
                break;
            case "nopower":
                if (index == 0)
                    a = array("thundergun_zm", "knife_ballistic_zm", "", "2");
                else if (index == 1)
                    a = array("cz75dw_zm", "crossbow_explosive_zm", "", "2");
                else
                    a = array("cz75dw_zm", "mp5k_zm", "", "2");
                break;
            case "30sr":
                if (index == 0)
                    a = array("m1911_upgraded_zm", "thundergun_upgraded_zm", "ray_gun_upgraded_zm", "2");
                else if (index == 1)
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "crossbow_explosive_upgraded_zm", "2");
                else
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "hk21_upgraded_zm", "2");
                break;
            default:
                if (index == 0)
                    a = array("thundergun_upgraded_zm", "hk21_zm", "cz75dw_upgraded_zm", "2");
                else if (index == 1)
                    a = array("crossbow_explosive_upgraded_zm", "cz75dw_upgraded_zm", "", "2");
                else if (index == 2)
                    a = array("knife_ballistic_upgraded_zm", "hk21_zm", "", "2");
                else
                    a = array("cz75dw_upgraded_zm", "hk21_zm", "", "2");
        }
    }

    return a;
}

weapon_preset_cotd(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "nopower":
                a = array("sniper_explosive_zm", "ray_gun_zm", "m72_law_zm", "3");
                break;
            case "sr30":
                a = array("m1911_upgraded_zm", "sniper_explosive_upgraded_zm", "ray_gun_upgraded_zm", "3");
                break;
            default:
                a = array("humangun_upgraded_zm", "crossbow_explosive_upgraded_zm", "sniper_explosive_upgraded_zm", "3");
        }
    }
    // 2p
    else if (p == 2)
    {
        switch (preset)
        {
            case "nopower":
                if (index == 0)
                    a = array("sniper_explosive_zm", "ray_gun_zm", "m72_law_zm", "3");
                else
                    a = array("ray_gun_zm", "m72_law_zm", "ak74u_zm", "0");
                break;
            case "30sr":
                if (index == 0)
                    a = array("m1911_upgraded_zm", "sniper_explosive_upgraded_zm", "ray_gun_upgraded_zm", "3");
                else
                    a = array("m1911_upgraded_zm", "humangun_upgraded_zm", "ray_gun_upgraded_zm", "0");
                break;
            case "boat":
                if (index == 0)
                    a = array("humangun_upgraded_zm", "knife_ballistic_upgraded_zm", "ray_gun_upgraded_zm", "3");
                else
                    a = array("m16_gl_upgraded_zm", "crossbow_explosive_upgraded_zm", "sniper_explosive_upgraded_zm", "0");
                break;
            default:
                if (index == 0)
                    a = array("humangun_upgraded_zm", "knife_ballistic_upgraded_zm", "ak74u_upgraded_zm", "3");
                else
                    a = array("ak74u_upgraded_zm", "crossbow_explosive_upgraded_zm", "sniper_explosive_upgraded_zm", "0");
        }
    }
    // 3p & 4p
    else
    {
        switch (preset)
        {
            case "nopower":
                if (index == 0)
                    a = array("sniper_explosive_zm", "ray_gun_zm", "m72_law_zm", "3");
                else
                    a = array("ray_gun_zm", "m72_law_zm", "ak74u_zm", "0");
                break;
            case "30sr":
                if (index == 0)
                    a = array("m1911_upgraded_zm", "sniper_explosive_upgraded_zm", "ray_gun_upgraded_zm", "3");
                else if (index == 1)
                    a = array("m1911_upgraded_zm", "humangun_upgraded_zm", "ray_gun_upgraded_zm", "0");
                else
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "hk21_upgraded_zm", "0");
                break;
            case "boat":
                if (index == 0)
                    a = array("humangun_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "3");
                else if (index == 1)
                    a = array("m16_gl_upgraded_zm", "crossbow_explosive_upgraded_zm", "ray_gun_upgraded_zm", "0");
                else if (index == 2)
                    a = array("sniper_explosive_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "0");
                else
                    a = array("knife_ballistic_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "0");
                break;
            default:
                if (index == 0)
                    a = array("humangun_upgraded_zm", "ray_gun_upgraded_zm", "ak74u_upgraded_zm", "3");
                else if (index == 1)
                    a = array("ak74u_upgraded_zm", "crossbow_explosive_upgraded_zm", "ray_gun_upgraded_zm", "0");
                else if (index == 2)
                    a = array("sniper_explosive_upgraded_zm", "ray_gun_upgraded_zm", "ak74u_upgraded_zm", "0");
                else
                    a = array("knife_ballistic_upgraded_zm", "ray_gun_upgraded_zm", "ak74u_upgraded_zm", "0");
        }
    }

    return a;
}

weapon_preset_shang(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "nopower":
                a = array("shrink_ray_zm", "ray_gun_zm", "", "1");
                break;
            case "30sr":
                a = array("m1911_upgraded_zm", "shrink_ray_upgraded_zm", "ray_gun_upgraded_zm", "1");
            default:
                a = array("shrink_ray_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "1");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "nopower":
                if (index == 0)
                    a = array("shrink_ray_zm", "ray_gun_zm", "", "1");
                else if (index == 1)
                    a = array("knife_ballistic_zm", "crossbow_explosive_zm", "", "1");
                else
                    a = array("cz75dw_zm", "ak74u_zm", "", "1");
                break;
            case "30sr":
                if (index == 0)
                    a = array("m1911_upgraded_zm", "shrink_ray_upgraded_zm", "ray_gun_upgraded_zm", "1");
                else if (index == 1)
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "crossbow_explosive_upgraded_zm", "1");
                else
                    a = array("m1911_upgraded_zm", "ray_gun_upgraded_zm", "hk21_upgraded_zm", "1");
                break;
            default:
                if (index == 0)
                    a = array("shrink_ray_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "1");
                else if (index == 1)
                    a = array("crossbow_explosive_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "1");
                else if (index == 2)
                    a = array("knife_ballistic_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "1");
                else
                    a = array("m16_gl_upgraded_zm", "ray_gun_upgraded_zm", "", "1");
        }
    }

    return a;
}

weapon_preset_moon(index, p, preset)
{
    a = undefined;
    // Solo
    if (p == 1)
    {
        switch (preset)
        {
            case "30sr":
                a = array("microwavegundw_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "2");
                break;
            default:
                a = array("microwavegundw_upgraded_zm", "m16_gl_upgraded_zm", "", "2");
        }
    }
    // Coops
    else
    {
        switch (preset)
        {
            case "30sr":
                if (index == 0)
                    a = array("microwavegundw_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "2");
                else if (index == 1)
                    a = array("knife_ballistic_upgraded_zm", "ray_gun_upgraded_zm", "m16_gl_upgraded_zm", "2");
                else
                    a = array("m16_gl_upgraded_zm", "ray_gun_upgraded_zm", "", "2");
                break;
            default:
                if (index == 0)
                    a = array("microwavegundw_upgraded_zm", "m16_gl_upgraded_zm", "", "2");
                else if (index == 1)
                    a = array("knife_ballistic_upgraded_zm", "m16_gl_upgraded_zm", "", "2");
                else
                    a = array("m16_gl_upgraded_zm", "ray_gun_upgraded_zm", "", "2");
        }
    }

    return a;
}
