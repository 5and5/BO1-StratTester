strattester_init()
{
    level thread redisable_box_move();
}

redisable_box_move()
{
    level endon("end_game");

    level waittill("magic_chest_movable_changed");
    setDvar("magic_chest_movable", "0");
    level thread redisable_box_move();
}