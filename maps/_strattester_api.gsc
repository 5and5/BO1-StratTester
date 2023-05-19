#include common_scripts\utility; 
#include maps\_utility;
#include maps\_strattester_func;

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
