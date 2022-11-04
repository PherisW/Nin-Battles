mob
	var
		list
			IMAGE= list()

Projectile
	Hyuuga
		Kaiten
			icon = 'hakkeshou.dmi'
			alpha = 0
			density=0
			Enter(atom/A)
				if(isobj(A))
					walk(A,Jutsu_Spawn(A,"west"))

Player/proc
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

