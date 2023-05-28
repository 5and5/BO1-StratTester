#include clientscripts\_utility;


main_start()
{
    players = GetLocalPlayers();
	for(i = 0; i < players.size; i++)
	{	
		players[i] thread set_fov();
		players[i] thread set_fovScale();
	}

	registerSystem("client_systems", ::client_systems_message_handler);
	register_client_system("hud_anim_handler", ::hud_message_handler);
}

register_client_system(name, func)
{
	if(!isdefined(level.client_systems))
		level.client_systems = [];
	if(isdefined(func))
		level.client_systems[name] = func;
}

client_systems_message_handler(clientnum, state, oldState)
{
	tokens = StrTok(state, ":");

	name = tokens[0];
	message = tokens[1];

	if(isdefined(level.client_systems) && isdefined(level.client_systems[name]))
		level thread [[level.client_systems[name]]](clientnum, message);
}

set_fov()
{
	self endon("disconnect");

	while(1)
	{	
		if(GetDvarInt("cg_fov_enable") == 1)
		{
			fov = GetDvarFloat("cg_fov_settings");
			if(fov == GetDvarFloat("cg_fov"))
			{
				wait .05;
				continue;
			}

			SetClientDvar("cg_fov", fov);
		}
		wait .05;
	}
}

set_fovScale()
{
	self endon("disconnect");

	while(1)
	{	
		if(GetDvarInt("cg_fov_enable") == 1)
		{
			fovScale = GetDvarFloat("cg_fovScale_settings");
			if(fovScale == GetDvarFloat("cg_fovScale"))
			{
				wait .05;
				continue;
			}

			SetClientDvar("cg_fovScale", fovScale);
		}
		wait .05;
	}
}
main_end()
{
}

hud_message_handler(clientnum, state)
{
	// MUST MATCH MENU FILE DEFINES
	menu_name = "";
	item_name = "";
	fade_type = "";
	fade_time = 0;

	if(state == "hud_zone_name_in")
	{
		menu_name = "zone_name";
		item_name = "zone_name_text";
		fade_type = "fadein";
		fade_time = 250;
	}
	else if(state == "hud_zone_name_out")
	{
		menu_name = "zone_name";
		item_name = "zone_name_text";
		fade_type = "fadeout";
		fade_time = 250;
	}

	AnimateUI(clientnum, menu_name, item_name, fade_type, fade_time);
}

