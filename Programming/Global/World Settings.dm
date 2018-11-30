/*
Season Wipe Idea;
there will be an automatic wipe every 3 months
*/

/*
	These are simple defaults for your project.
 */
#define BASE_SPEED 2

proc
	Ticks(num=1,var/second=0)
		set background =1
		do
			if(second)
				sleep(1)
			else
				sleep(1 * world.tick_lag)
			num--
		while(num>0)
		return 1
var
	world_connect=0
world
	fps = 40 // 25 frames per second
	icon_size = 32 // 32x32 icon size by default
	view = "32x22"
	//view = "16x11"
	mob = /Player
	//loop_checks=0
	//tick_lag = 0.25
	sleep_offline=0
	hub = "Heyblinx.ProjectNindo"
	hub_password = "qA2BeYKd1SphTJEU"
	//visibility =0
	New()
		..()
		//log = file("Crash log.txt")
		Ticks(2)
		for(var/mob/A in world) // For all mobs in world
			if(!A.client && A.shadow) // Theres a var called "shadow" you can set to 1 if you want your object to have a shadow.
				GenerateShadowMob(A,EAST)	// Give them a shadow!!!
		spawn(0.5)
			DayTimer(1,2)
			RebootTimer(144000)
		world.status = "[PHASE] Version [VERSION]"
	proc
		RebootTimer(var/time)
			spawn(time)
			world.log <<"Preparing for reboot"
			_message(world,"World","Preparing for Auto-Reboot!","red",,"red")
			sleep(50)
			world.Reboot(0)

// Make objects move 8 pixels per tick when walking
Player
	shadow = 1
	pwidth = 12
	pheight = 25
	bound_x=9
	//step_x=8
	//step_y=8
	verb
		Open_World()
			if(usr.key=="Heyblinx")
				if(world.visibility)
					world.visibility=0
					world_connect=0
					world.log << "Port is invisibile"
					_message(usr,"World","Port is now invisible","red",,"red")
				else
					world.visibility=1
					world_connect=1
					world.log << "Port is Visibile"
					_message(usr,"World","Port is now visible","red",,"green")

PixelMovement
	debug=1
	tile_width=32
	tile_height=32
Non_Player


Objects
	step_size = 8
