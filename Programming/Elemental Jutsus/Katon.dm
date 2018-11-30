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
	Katon
		Style="Katon"
//Katon Release//
//S Rank//
//A Rank//
//B Rank//
//C Rank//
		Phoenix_Flower
			Stat_Usage = "ninjutsu"
			Skill_Name = "Phoenix_Flower"
			Power=40
			icon_state = "Pheonix Flower"
			Description = "Shoot multiple small flame in any direction"
			Rank = "C"
			UsesNeeded = 50
			Copyable=1
			Drain = 100
			Cooldown = 12
			Seals_Needed=1
			//Chakra_Control_Trigger=1

//D Rank//
	Suiton
		Style="Suiton"
		Water_Clone
			Stat_Usage = "ninjutsu"
			Skill_Name = "Watera"
			icon_state = "Water Clone Tech"
			Description = "Use water infused clones to battle alongside you"
			Rank = "B"
			UsesNeeded = 50
			Copyable=1
			Drain = 400
			Cooldown = 6
			Seals_Needed=1
//Suiton Release//
//S
//A
//B Rank//

//C
//D

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
	Water_Clone(_nin,cooldowns,var/triggered=0,_level=1,power=0)
		_message(view(src),"[src]","Water Style: Water Clone Jutsu!","cyan",,"cyan")
		//var/Clone/C = new("Trap")
		var/Clone/C =new(Clonetype="Trap")
		C.alpha= 0
		C.loc= locate(src.x+1,src.y,src.z)
		spawn(10)
			C.alpha=255
			flick("mizu-summon",C)
			Ticks(100)


	WaterClone2(_nin,cooldowns,var/triggered=0,_level=1,power=0)
		//view(src) << "Water Clone Jutsu!"
		_message(view(src),"[src]","Water Style: Water Clone Jutsu!","cyan",,"cyan")
		var/Clone/C = new(loc= Jutsu_Spawn(usr),alpha=0)
		spawn(50)
			alpha=255
			flick("mizu-summon",C)
			Ticks(100)
	Waterc(_nin)
		src <<  "You have 10 seconds to select a water turf to hide in."
		src.WaterReplace=1
		Ticks(10)
		src.WaterReplace=0
	Phoenix_Flower(_nin,cooldowns,var/triggered=0)
		var/_loc = NumToAngle2(src.dir)
		_message(view(src),"[src]","Fire Style: Fireball Jutsu!","red",,"red")
		if(Target)
			_loc = GetAngleStep(Target)
		//x_spreadproj(src,_loc,/Projectile/Katon/Housenka,5,1)
		for(var/i=1 to 3)
			x_projectile(src,_loc,/Projectile/Katon/Housenka,50*src.ninjutsu,1)
			sleep(1)
		//view(src) << "Fireball Jutsu!"
		/*for(var/i=1 to 4)
			var/Projectile/Katon/Housenka/K = new(loc = Jutsu_Spawn(src),stat_dam = _nin)
			K.dir = src.dir
			src.dir=src.AimAssist(K)
			K.owner = src
			K.stat_dam = _nin
			walk(K,src.AimAssist(K),1)
			spawn(30)
				del(K)
			Ticks(5)*/
		//if(Timer(cooldowns)==1)
			//return
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
	Katon
		var
			Burn_Chance
		Housenka
			icon = 'housekna2.dmi'
			//icon_state = "1"
			//pixel_y=-16
			//pixel_x=-16
			/*Cross(atom/Player)
				if(ismob(Player,/Player))
					var/Player/P = Player
					if(P==src.owner)*/
/*			Bump(atom/A)
				if(istype(A,/Player))
					if(istype(A,/Player))
						var/Player/P = A
						if("[P]"==src.owner) return
						if(P.kaiten)
							walk(src,Deflect(P,src),1)
							return
					if(istype(A,/Non_Player))
						var/Non_Player/NPC=A
						if(NPC.village==src.owner.village)
							src.owner.Stat_Gain("ninjutsu",10)
					for(var/Player/Z in view(src,10))
						if(Z==src.owner)
							Z.Stat_Gain("ninjutsu",10)
					_message(view(A), "Battle Damage" , "[A] was hit for [stat_dam]!","red",,"red")
					if(istype(A,/Clone))
						var/Clone/S = A
						S.health -= stat_dam
						if(S.health <= 0)
					S.Bomb()
					//del(src)
				if(isobj(A))
					if(istype(A,/Projectile/Hyuuga/Kaiten))
						walk(src,Jutsu_Spawn(src,"east"))*/
	Suiton
		Gunshot
			icon = 'Gunshot.dmi'
			New()
				var/icon/I = new(src.icon)
				//I.Turn(90)
				src.icon = I
				..()
	Hyuuga
		Kaiten
			icon = 'hakkeshou.dmi'
			alpha = 0
			density=0
			Enter(atom/A)
				if(isobj(A))
					walk(A,Jutsu_Spawn(A,"west"))

