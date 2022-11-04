var/const
	HIGH_STATUS = 50
	MED_STATUS = 33
	LOW_STATUS = 10

Player
	var
		list
			Skills[5][7] //name,Style,Stat_Usage,cooldown,in_cooldown,jutsu uses count, seals needed
		kaiten
		WaterReplace=0

atom
	proc
		Trap(tar,traploc,type)
			var/Player/Prey = tar
			if(type=="WaterClone"&&Prey in view(2,traploc))
				//for(var/Player/A in view(2,locs))
				_message(Prey,"Info","you are frozen")
				var/Visuals/WaterP = new
				WaterP.icon= 'WaterPrison.dmi'
				Prey.overlays+= WaterP
				Prey._Movement_locked=1
				spawn(40)
					Prey._Movement_locked=0
					Prey.overlays-= WaterP
					_message(Prey,"Info","you have been released")

Clone
	parent_type = /mob
	health = 100
	var/bomb
	var/explode=0
	var/canhit=1
	icon = 'Shinobi.dmi'
	New(var/Player/_cloneof=(null),var/Clonetype="Normal")
		if(_cloneof)
			src.appearance=_cloneof
			src.village=_cloneof.village
			/*src.icon = _cloneof.icon
			src.icon_state = _cloneof.icon_state
			src.overlays = _cloneof.overlays*/
		if(Clonetype=="Trap")
			health = 1
			bomb=1
			..()
		if(Clonetype=="Normal")
			health = 1
			src.alpha=200
			src.underlays-=_cloneof.shadows
	proc
		Bomb()
			if(bomb==1&&!explode)
				//src.health = 1
				alpha=0
				density = 0
				spawn(5)
					DeathChance()
				return 1
			else
				density=0
				alpha=0
				canhit=0
				var/Visuals/Smoke = new
				Smoke.icon = 'Shinobi.dmi'
				Smoke.icon_state = "smoke"
				Smoke.alpha=255
				Smoke.loc=src.loc
				spawn(3)
					del(Smoke)
					DeathChance()
				return 0

Hud/Skill
//S Rank
//A Rank
//B Rank
//C Rank
//D Rank

Player/proc
	Taigan(_nin,cooldowns,var/triggered=0,_level=1,power=0)
		if(triggered==1)
			if("Taigan" in src.activeskills)
				src.activeskills-=("Taigan")
				_message(src,"Battle Info","Your eyes return to normal.","white",,"white")
				for(var/Hud/Effects/Black_Screen/B in src.client.screen)
					B.color= rgb(0,0,0)
				src.see_invisible = 0
				src.see_infrared = 0
				src.ninjutsu -= 100
				return
			else
				src.activeskills+=("Taigan")
				for(var/Hud/Effects/Black_Screen/B in src.client.screen)
					B.color +=rgb(0,0,255)
				_message(view(src),"[src]","Taigan!","red",,"grey")
				src.see_invisible = 2
				src.see_infrared=40
				src.ninjutsu += 100
				return


	//Bunshin(_gen)
		//src << "BUNSHIN"
	Rotation(_nin,cooldowns,var/triggered=0,_level=1,power=0)
		_message(view(src),"[src]","Rotation!","white",,"white")
		src.kaiten=1
		src._in_barrier=1
		var/SpinSpeed=1
		var/Projectile/Hyuuga/Kaiten/K = new(loc = src.loc)
		K.SetCenter(src)
		var/matrix/M = matrix()
		M.Scale(_level*2,_level)
		K.transform=M
		GenerateShadowMob(K,EAST)
		src.Movement=1
		spawn()
			for(var/i=1 to 100)
				src.dir = turn(src.dir,90)
				if(i<=10||i>=190)
					Ticks(SpinSpeed)
				else if(i< 80)
					Ticks(SpinSpeed/2)
					src.dir = turn(src.dir,90)
					Ticks(SpinSpeed/2)

		spawn()
			Ticks(2)
			animate(K,alpha=200,time=11)
		Ticks(20)
		SpinSpeed=0.5

		Ticks(100)
		SpinSpeed=1
		animate(K,alpha=0,time=14)
		Ticks(15)
		src.Movement=0
		src.kaiten=0
		src._in_barrier=0
		del(K)


Projectile
	Hyuuga
		Kaiten
			icon = 'hakkeshou.dmi'
			alpha = 0
			density=0
			Enter(atom/A)
				if(isobj(A))
					walk(A,Jutsu_Spawn(A,"west"))

