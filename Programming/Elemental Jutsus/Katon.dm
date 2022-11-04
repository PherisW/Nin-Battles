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
//D Rank


Player/proc
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