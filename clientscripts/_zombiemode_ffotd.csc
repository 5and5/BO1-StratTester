#include clientscripts\_utility;


main_start()
{
    players = GetLocalPlayers();
	for(i = 0; i < players.size; i++)
	{	
		players[i] thread set_fov();
		players[i] thread set_fovScale();
	}
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

