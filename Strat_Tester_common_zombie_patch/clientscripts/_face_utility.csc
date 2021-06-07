#include clientscripts\_utility;

setFaceRoot( root )
{
	if( !IsDefined( level.faceStates ) )
	{
		level.faceStates = [];
	}
	
	if( !IsDefined( level.faceStates ) )
	{
		level.faceStates = [];
	}
	
	level.faceStates["face_root"] = root;
}

buildFaceState( face_state, looping, timer, priority, statetype, animation )
{
	if( !IsDefined( level.faceStates ) )
	{
		level.faceStates = [];
	}
		
	if( !IsDefined( level.faceStates ) )
	{
		level.faceStates = [];
	}
	
	level.faceStates[face_state][ "looping" ] = looping;
	level.faceStates[face_state][ "timer" ] = timer;
	level.faceStates[face_state][ "priority" ] = priority;
	level.faceStates[face_state][ "statetype" ] = statetype;
	level.faceStates[face_state][ "animation" ] = [];
	level.faceStates[face_state][ "animation" ][0] = animation;
}

addAnimToFaceState( face_state, animation ) 
{
	Assert( IsDefined( level.faceStates[face_state] ) );
	Assert( IsDefined( level.faceStates[face_state]["animation"] ) );
	
	curr_size = level.faceStates[face_state][ "animation" ].size;
	level.faceStates[face_state][ "animation" ][curr_size] = animation;
}

isHigherPriority( new_state, old_state )
{
	if ( GetDvarInt( #"cg_debugFace" ) != 0 )
	{
		PrintLn( "newstate "+new_state+" oldstate "+old_state );
		if ( !isdefined( new_state ) )
			PrintLn( "new_state undefined\n" );
		if ( !isdefined( level.faceStates ) )
			PrintLn( "level.faceStates undefined\n" );			
		if ( !isdefined( level.faceStates ) )
			PrintLn( "level.faceStates undefined\n" );
		if ( !isdefined( level.faceStates[new_state] ) )
			PrintLn( "level.faceStates[new_state] undefined\n" );

		if ( !isdefined( level.faceStates[new_state] ) )
		{
			
			faceStatesArray = getArrayKeys( level.faceStates );
			PrintLn( new_state + " undefined\n" );

			for( i = 0; i < faceStatesArray.size; i++ )
			{
				println( i + ":" );
				PrintLn( faceStatesArray[i] + "\n" );
			}
		}
	}
	if( level.faceStates[new_state]["priority"] >= level.faceStates[old_state]["priority"] )
	{
		if ( GetDvarInt( #"cg_debugFace" ) != 0 )
		{
			PrintLn( "FaceState "+new_state+" is higher priority than "+old_state );
		}
		return true;
	}
	if ( GetDvarInt( #"cg_debugFace" ) != 0 )
	{
		PrintLn( "FaceState "+new_state+" is not higher priority than "+old_state );
	}
	return false;
}

waitForAnyPriorityReturn( prevState )
{
	level endon( "demo_jump" );
	self endon( "entityshutdown" );
	self endon( "stop_facial_anims" );
	self endon( "new_face_processor" );
	
	if ( GetDvarInt( #"cg_debugFace" ) != 0 )
	{
		PrintLn( "Waiting for priority return for "+prevState );
	}
	
	while( true )
	{
		self waittill( "face", newState );
		if( isdefined( newState ) && newState != prevState && isHigherPriority( newState, prevState ) )
		{
			break;
		}
	}
		
	return newState;
}

waitForFaceEventRepeat( base_time )
{
	level endon( "demo_jump" );
	self endon( "entityshutdown" );
	self endon( "stop_face_anims" );
	self endon( "new_face_event" );
	self endon( "face_timer_expired" );
		
	state = self.face_curr_event;
	
	while( true )
	{
		self waittill( "face", newState );
		if( newState == state )
		{
			self.face_timer = base_time;
		}
	}
}

waitForFaceEventComplete(localClientNum)
{
	level endon( "demo_jump" );
	self endon( "entityshutdown" );
	self endon( "stop_face_anims" );
	self endon( "new_face_event" );
		
	if ( GetDvarInt( #"cg_debugFace" ) != 0 )
	{
		PrintLn( "Trying to get animation for state "+self.face_curr_event+" # "+self.face_curr_event_idx );
	}
	
	Assert( IsDefined( level.faceStates[self.face_curr_event]["animation"][self.face_curr_event_idx] ) );
	
	self waittillmatch( self.face_curr_event, "end" );
	
	self.face_curr_event = undefined;
	self.face_curr_event_idx = undefined;
	
	if ( GetDvarInt( #"cg_debugFace" ) != 0 )
	{
		println("setAnimKnob Back To base");
	}
	if ( !isdefined ( self ) )
		return;
	self SetAnimKnob( level.faceStates[self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0 );
	self notify( "face", "face_advance" );
}

processFaceEvents( localClientNum )
{
	self notify( "new_face_processor" );
	level endon( "demo_jump" );
	self endon( "entityshutdown" );
	self endon( "new_face_processor" );
		
	// Start the entity in face_alert
	state = "face_alert";
	self.face_curr_base = "face_alert";
	numAnims = level.faceStates[state]["animation"].size;
	self.face_curr_base_idx = RandomInt( numAnims );

	if ( GetDvarInt( #"cg_debugFace" ) != 0 )
	{
		println("setAnimKnobProcessFaceEvents");
	}
	if ( !isdefined ( self ) )
		return;
	self SetAnimKnob( level.faceStates[self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.0, 1.0 ); 
	
	// Unless we already have preset them as disabled or dead
	if ( isdefined( self.face_disable ) && self.face_disable )
		state = "face_disable";
	else if ( isdefined( self.face_death ) && self.face_death )
		state = "face_death";

	if ( !isdefined(self) )
		return;
	
	self.face_state = state;
	self thread showState();
	self thread watchfor_death();
	
	while ( true )
	{
		if ( GetDvarInt( #"cg_debugFace" ) != 0 )
		{
			if ( !isdefined( state ) )
				PrintLn( "state undefined\n" );
			if ( !isdefined( level.faceStates ) )
				PrintLn( "level.faceStates undefined\n" );			
			if ( !isdefined( level.faceStates ) )
				PrintLn( "level.faceStates undefined\n" );
			if ( !isdefined( level.faceStates[state] ) )
				PrintLn( "level.faceStates[state] undefined\n" );

			if ( !isdefined( level.faceStates[state] ) )
			{
				
				faceStatesArray = getArrayKeys( level.faceStates );
				PrintLn( state + " undefined\n" );

				for( i = 0; i < faceStatesArray.size; i++ )
				{
					println( i + ":" );
					PrintLn( faceStatesArray[i] + "\n" );
				}
			}
		}

		numAnims = level.faceStates[state]["animation"].size;
		
		if ( GetDvarInt( #"cg_debugFace" ) != 0 )
		{
			PrintLn( "Found "+numAnims+" anims for state "+state );
		}
		
		// If we have set face_disable on this entity, clear anims and wait for it to unset
		if( IsDefined( self.face_disable ) && self.face_disable == true )
		{
			if ( GetDvarInt( #"cg_debugFace" ) != 0 )
			{
				PrintLn( "Disabling face anims" );
			}
			setFaceState( "face_disabled" );
			self ClearAnim( level.faceStates[ "face_root" ], 0 );
			self notify( "stop_face_anims" );
			
			while( self.face_disable )
			{
				wait( 0.05 );
			}
		}
		
		if ( GetDvarInt( #"cg_debugFace" ) != 0 )
		{
			if ( !isdefined( state ) )
				PrintLn( "state undefined\n" );
			if ( !isdefined( level.faceStates ) )
				PrintLn( "level.faceStates undefined\n" );			
			if ( !isdefined( level.faceStates ) )
				PrintLn( "level.faceStates undefined\n" );
			if ( !isdefined( level.faceStates[state] ) )
				PrintLn( "level.faceStates[state] undefined\n" );

			if ( !isdefined( level.faceStates[state] ) )
			{
				
				faceStatesArray = getArrayKeys( level.faceStates );
				PrintLn( state + " undefined\n" );

				for( i = 0; i < faceStatesArray.size; i++ )
				{
					println( i + ":" );
					PrintLn( faceStatesArray[i] + "\n" );
				}
			}
		}

		setFaceState( state );
		
		// If our current state is an exit state, nothing will supercede this animation so we should return
		if( level.faceStates[state]["statetype"] == "exitstate" )
		{
			if ( GetDvarInt( #"cg_debugFace" ) != 0 )
			{
				PrintLn( "Exitstate found, returning, anim tree:" + level.face_anim_tree );
			}
			if ( !isdefined ( self ) )
				return;
			if ( GetDvarInt( #"cg_debugFace" ) != 0 )
			{
				println("setAnimKnob286");
			}
			self SetAnimKnob( level.faceStates[state]["animation"][RandomInt(numAnims)], 1.0, 0.1, 1.0 );
			self notify( "stop_face_anims" );
			self.curr_face_base = undefined;
			self.curr_face_event = undefined;
			return; // All done!
		}
		else if( level.faceStates[state]["statetype"] == "basestate" )
		{
			if( !IsDefined( self.face_curr_base ) || self.face_curr_base != state )
			{
				self.face_curr_base = state;
				self.face_curr_base_idx = RandomInt( numAnims );
				if ( GetDvarInt( #"cg_debugFace" ) != 0 )
				{
					PrintLn( "New base face anim state "+self.face_curr_base+" anim # "+self.face_curr_base_idx );
				}
				if( !IsDefined( self.face_curr_event ) )
				{
					if ( GetDvarInt( #"cg_debugFace" ) != 0 )
					{
						PrintLn( "trying to play animation for state "+self.face_curr_base+" w/ index "+self.face_curr_base_idx );
					}
					if ( GetDvarInt( #"cg_debugFace" ) != 0 )
					{
						println("setAnimKnob310");
					}
					if ( !isdefined ( self ) )
						return;
					self SetAnimKnob( level.faceStates[self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0 );
				}
			}
		}
		else if( level.faceStates[state]["statetype"] == "eventstate" )
		{
			if( !IsDefined( self.face_curr_event ) || !level.faceStates[self.face_curr_event]["looping"] || self.face_curr_event != state )
			{
				self.face_curr_event= state;
				self.face_curr_event_idx = RandomInt( numAnims );
				if ( GetDvarInt( #"cg_debugFace" ) != 0 )
				{
					PrintLn( "New face anim event "+self.face_curr_event+" anim # "+self.face_curr_event_idx );
				}
				if ( !isdefined ( self ) )
					return;
				self SetFlaggedAnimKnobRestart( self.face_curr_event, level.faceStates[self.face_curr_event]["animation"][self.face_curr_event_idx], 1.0, 0.1, 1.0 );
				self thread waitForFaceEventComplete(localClientNum);
			}
		}
		
		if( IsDefined( self.face_curr_event ) )
		{
			state = self waitForAnyPriorityReturn( self.face_curr_event );
		}
		else
		{
			state = self waitForAnyPriorityReturn( self.face_curr_base );
		}
	}
}

showState( state )
{
/#
	level endon( "demo_jump" );
	self endon( "entityshutdown" );
	
	while ( true )
	{
		if ( GetDvarInt( #"cg_debugFace" ) != 0 )
		{
			if ( isdefined( self.face_state ) && isdefined( self.origin ) )
			{
				entNum = self getentitynumber();
				if ( !isdefined( entNum ) )
					entNum = "?";

				if ( isdefined( self.face_disable ) && self.face_disable )
					disableChar = "-";
				else
					disableChar = "+";

				if ( isdefined( self.face_death ) && self.face_death )
					deathChar = "D";
				else
					deathChar = "A";

				Print3d( self.origin + ( 0, 0, 72 ), disableChar + deathChar + "["+ entNum +"]" + self.face_state, (1,1,1), 1, 0.25 );
			}
		}
		
		wait( 0.01667 );
	}
#/
}

setFaceState( state )
{
	self.face_state = state;
}

watchfor_death()
{
	level endon( "demo_jump" );
	self endon( "entityshutdown" );
	self endon( "new_face_processor" );
	
	if ( !isdefined( self.face_death ) )
	{
		self waittillmatch( "face", "face_death" );
		self.face_death = true;
	}
}

