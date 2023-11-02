// self should be player
init()
{
    self thread hud_zombies_on_map();
}

// shows the current number of zombies spawned on the map
hud_zombies_on_map()
{
    while(1)
    {
        self SetClientDvar("st_hud_zombies_on_map", maps\_zombiemode_utility::get_enemy_count());
        wait 0.1;
    }
}
