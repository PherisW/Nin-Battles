mob
	var/tmp
		list
			Targetlist[0]
			Ally[3]
			AllyList[0]
			Targetoptions
		Target
	var
		TargetNumber=1


/*proc/TimeLoop()
	hours=round(world.time/10/60/60)
	minutes=round(world.time/10/60-(60*hours))
	seconds=round(world.time/10-(60*minutes)-(60*hours*60))*/
mob
	verb
		TargetCycle()
			set hidden=1;set instant=1
			set background=1
			var/tmp/maxtarget = length(usr.Targetoptions)
			if(usr.TargetNumber==0)
				usr << "You are not targeting anyone"
				for(var/Hud/Data/Enemy_Hud/L in usr.client.screen)
					del(L)
				for(var/Hud/Data/Enemy_Text/T in src.client.screen)
					T.maptext="<center>"
					T.alpha=0
				for(var/Hud/Data/Enemy_Underlay/U in src.client.screen)
					U.alpha=0
				usr.TargetNumber++
			else if(!maxtarget)
				usr <<"There is no one to target!"
				for(var/Hud/Data/Enemy_Hud/L in usr.client.screen)
					del(L)
				for(var/Hud/Data/Enemy_Text/T in src.client.screen)
					T.maptext="<center>"
					T.alpha=0
				for(var/Hud/Data/Enemy_Underlay/U in src.client.screen)
					U.alpha=0
				//for(var/Hud/Data/Enemy_Text/T in src.client.screen)
					//del(T)
				usr.Target=null
				return
			usr.Target=null
			for(var/image/A in usr.Targetlist)
				del A
			usr.Targetlist = new
			spawn(0.1)
				Target(Targetoptions[TargetNumber])
				usr.TargetNumber++
			Ticks(0.2)
			//usr.TargetNumber++
			if(usr.TargetNumber>length(usr.Targetoptions))
				usr.TargetNumber=0
			return



HUD
	parent_type = /obj
	Target
		icon = 'Target.dmi'
		icon_state="Red"
mob
	proc
		Targeting()
			set background =1
			var/tmp/list/Test = list()
			for(var/mob/A in oview(client.view,src))
				Test+=A
			Targetoptions= Test
			Ticks(10)
			spawn()
				Targeting()

		Target(atom/P,var/flag=ENEMY)
			if(flag == ENEMY)
				if(src.Target||P in src.Target)
					src.Target=null
					del src.Targetlist
					src.Targetlist = new
				var/image/K=image('Target.dmi',P)
				if(P in view(src))
					if(length(src.Targetlist.len)==0)
						//var/HUD/Target/T = new
						//if(!K)
						for(var/Hud/Data/Enemy_Hud/L in src.client.screen)
							del(L)
						for(var/Hud/Data/Enemy_Text/T in src.client.screen)
							T.maptext="<center>"
							T.alpha=0
						for(var/Hud/Data/Enemy_Underlay/U in src.client.screen)
							U.alpha=0
						//for(var/Hud/Data/Enemy_Text/T in src.client.screen)
							//del(T)
						K =image('Target.dmi',P)
						K.icon_state = "[flag]"
						//T.screen_loc = "[Screen_Locator(src,P)]"
						K.plane = 6
						K.pixel_x=-2
						K.pixel_y=4
						src<<K
						src.Targetlist+=K
						src.Target=P
						src << "You are now targeting [P]"
						src.camera.mode = camera.SLIDE
						src.watch(P)
						spawn(30)
							src.watch(src)
						//var/Hud/Data/Enemy_Text/T = new
						var/Hud/Data/Enemy_Hud/H = new(src,,P)
						//src.client.screen+=T
						for(var/Hud/Data/Enemy_Text/T in src.client.screen)
							T.maptext="<center>[P]"
							T.alpha=255
						for(var/Hud/Data/Enemy_Underlay/U in src.client.screen)
							U.alpha=255
						src.client.screen+=H
	/*				for(var/HUD/Target/G in src.Targetlist)
						G.screen_loc = "[Screen_Locator(src,P)]"*/
					//spawn(0.1)
						//goto SET
				else
					del K
					src.Targetlist = new
					src.Target=null

		AimAssist()
			if(src.Target)
				var/tmp/_newdir = get_dir(src,src.Target)
				return _newdir
			else
				return src.dir