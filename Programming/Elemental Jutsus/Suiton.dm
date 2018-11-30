Suiton
	parent_type=/Projectile


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