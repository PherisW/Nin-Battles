Suiton
	parent_type=/Projectile
Hud/Skill
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

Player/proc
	Gunshot(_nin,cooldowns,var/triggered=0,_level=1,power=0)
		var/_loc = NumToAngle2(src.dir)
		_message(view(src),"[src]","Water Style: Gunshot Jutsu!","cyan",,"blue")
		if(Target)
			_loc = GetAngleStep(Target)
		x_projectile(src,_loc,/Projectile/Suiton/Gunshot,50*src.ninjutsu,1)

		/*var/Projectile/Suiton/Gunshot/K = new(loc = Jutsu_Spawn(src),stat_dam = _nin)
		K.dir = src.dir
		src.dir=src.AimAssist(K)
		K.owner = src
		K.stat_dam = _nin
		walk(K,src.AimAssist(K),1)
		spawn(30)
			del(K)*/
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

Projectile
	Suiton
		Gunshot
			icon = 'Gunshot.dmi'
			New()
				var/icon/I = new(src.icon)
				//I.Turn(90)
				src.icon = I
				..()