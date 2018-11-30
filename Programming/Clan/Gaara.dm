Player
	proc
		/*First Skill: Sand Control
		It gives activate the sand in your gourd (MUST BE EQUIPPED) to protect you in battle
		+ 5/10/15/20% chance to autoblock
		+ also allows for the other skills to be used with 50% less chakra cost
		- drain of 50 chakra overtime

		*/
		Sand_Control(_nin,cooldowns,triggered=0,_level=1,power=0)
			world.log << triggered
			if(triggered==1)
				world.log <<"Triggered"
				var/SandVisuals/SandControlFX/Sand = new
				Sand.icon_state = "Ready"
				if("Sand Control" in src.activeskills)
					src.activeskills-=("Sand Control")
					_message(src,"Battle Info","You retract your Sand back into your gourd.")
					src.overlays-=Sand
					//for(var/SandVisuals/SandAuraFX/Aura in src.overlays)
					src.overlays-='SunanoTate.dmi'
					RemoveShadow(src)
					GenerateShadowMob(src,EAST)
				else
					src.activeskills+=("Sand Control")
					_message(src,"Battle Info","Sand flows out of [src]'s gourd, moving all around them.")
					//Sand.icon_state = "Ready"
					src.overlays.Add(Sand)
					src.overlays.Add('SunanoTate.dmi')
					RemoveShadow(src)
					GenerateShadowMob(src,EAST)
		/*
		Second Skill: Sand Dome
		Creates an ultimate sand shield to block attacks
		+ Sand health = 30/60/90% of chakra capacity
		-
		*/
		Sand_Dome(_nin,cooldowns,var/triggered=0,_level=1,power=0)
			if(triggered==1)
				var/SandVisuals/SandDome/Dome = new
				if("Sand Dome" in src.activeskills)
					src.activeskills-=("Sand Dome")
					src._Movement_locked=0
					src._in_barrier=0
					_message(src,"Battle Info","You remove the shield dome.")
					for(Dome in view(src,2))
						flick("unforming",Dome)
						sleep(10)
						del(Dome)
				else
					src.activeskills+=("Sand Dome")
					_message(src,"Battle Info","You control the sand to encase a sheild around yourself.")
					Dome.SetCenter(src)
					src._Movement_locked=1
					src._in_barrier=1
					src.MovementSpeed=1
					GenerateShadowMob(Dome,EAST,120)
					flick("forming",Dome)
					sleep(10)
					Dome.icon_state = ""

		Sand_Flight(_nin,cooldowns,var/triggered=0,_level=1,power=0)
			if(triggered==1)
				var/SandVisuals/SandMound/Mound = new
				var/SandVisuals/SandMound2/Mound2 = new
				if("Sand Flight" in src.activeskills)
					src.activeskills-=("Sand Flight")
					_message(src,"Battle Info","You float back onto the ground")
					src.underlays-=Mound2
					src.move_speed=5
					src.overlays-=Mound
					src.density=1
					src.icon_state=""
					src.flight=0
					RemoveShadow(src)
					GenerateShadowMob(src,EAST)
					src.camera.mode = camera.SLIDE
				else
					src.activeskills+=("Sand Flight")
					_message(src,"Battle Info","You use the sand in your gourd to create a mound to fly.")
					//var/check = usr.contents
					src.underlays.Add(Mound2)
					src.overlays.Add(Mound)
					src.camera.mode = camera.FOLLOW
					src.density=0
					src.flight=1
					src.move_speed=8
					//usr.layer+=3
					//src.overlays:layer+=3
					src.icon_state = "bird"
					world.log << "[src.icon_state]"
					RemoveShadow(src)
					GenerateShadowMob(src,EAST,,-64)
					START
					while(src.flight)
						animate(src,pixel_y=8,time=10)
						sleep(10)
						animate(src,pixel_y=0,time=10)
						sleep(10)
						goto START
					return

/*Sand
	parent_type=/Hud/Skill/Clans
	Sand_Control
		Stat_Usage = "ninjutsu"
		Skill_Name = "SandControl"
		icon_state = "SandControl"
		Description="Focus chakra into your sand for battle."
		Power=60
		Rank = "B"
		UsesNeeded = 50
		//Drain = 100
		Cooldown = 40
		Seals_Needed=0
		var
			incontrol
	Sand_Dome
		Stat_Usage = "ninjutsu"
		Skill_Name = "SandDome"
		icon_state = "Sand Dome"
		Description="Use your special sand to make extremely strong Barrier"
		Power=5
		Rank = "B"
		Seals_Needed=0
		Cooldown=20
	Sand_Flight
		Stat_Usage = "ninjutsu"
		Skill_Name = "Sand Flight"
		Description="Use your sand to move in the air."
		icon_state="SandMound"
		Rank = "A"
		Seals_Needed=0
		Cooldown=200*/
SandVisuals
	parent_type=/obj
	layer = MOB_LAYER+1
	SandControlFX
		icon = 'kyuu.dmi'
	SandAuraFX
		icon = 'SunanoTate.dmi'
	SandDome
		var
			health
		density=1
		icon = 'SunanoMuya.dmi'
		//New(var/Player/Player,var/Sand/Skill)
			//health = Player.chakra
	SandMound
		icon='DesertSuspension.dmi'
		icon_state = "overlay"
		appearance_flags = RESET_TRANSFORM
		New()
			pixel_y= -32

	SandMound2
		icon='DesertSuspension.dmi'
		icon_state = "underlay"


