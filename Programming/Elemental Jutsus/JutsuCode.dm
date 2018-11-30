var/list/objtypersc=new
var/nullobjtypes[0]
proc
	FindObjType(obj)
		var/type=obj
		if(!ispath(obj))
			type=obj:type
		var/list/l=objtypersc[type]
		if(l&&l.len)
			var/obj/o=l[l.len]
			l.len--
			return o
		else
			var/obj/o=new type
			o.appearance=obj
			return o
atom/proc
	AfterImage(image,fade=0,time,colors)
		set waitfor=FALSE
		var/image/i
		if(isicon(image))
			i=FindImage(image)
		else
			i=FindImage(image)
			i.appearance=image:appearance
			if(istype(image,/atom/movable))
				i.pixel_x=image:step_x
				i.pixel_y=image:step_y
		if(colors) i.color=pick(colors)
		sleep(1)
		i.loc=src
		src.OverPut(i,time)
		RecycleImage(i,time)/*
		if(fade)
			sleep(fade-1)
			if(i.loc) i.loc=src
			src.overlays-=i
			i.appearance=image:appearance
			viewers()<<i
			animate(i,alpha=0,time=time-fade)*/
		if(fade)
			sleep(fade)
			src.overlays-=i
			i.loc=src
			viewers()<<i
			animate(i,alpha=0,time=time-fade)
	RecycleImage(image/img, time=0)
		set waitfor = 0
		sleep(time)
		if(!nullimage)
			var/image/I=new
			I.appearance_flags=RESET_COLOR
			nullimage = I.appearance
		img.appearance = nullimage
		img.loc = null
		imageresource += img
var/list/imageresource=new
//var/mutable_appearance/nullimage
var/nullimage
atom/proc
	FindImage(icon,icon_state)
		if(imageresource.len)
			var/image/img=imageresource[imageresource.len]
			img.icon=icon
			img.icon_state=icon_state
			imageresource.len--
			return img
		else return new/image(icon,,icon_state)
Projectile/proc
	Terminate()
		..()
		Dissapate(2,1)//Make them fade out
	Homing()
		if(!src.target||!(src.target in viewers(homingview,src)))//If there is no target or target is out of view we will just try to find a new one
			for(var/mob/M in viewers(homingview,src))
				src.target=M
				break
		if(target)//I have no idea what im doing here.. trying to calculate which direction will get the angle closer but the 0 and 360 degrees aspect of angles makes it act weird and confusing
			var/ang=angle
			var/gang=GetAngle(target)
			if(ang>=270&&gang<270)
				gang+=180
				ang-=180
			else
				if(ang<=90&&gang>270)
					ang+=180
					gang-=180
			if(ang<gang)
				angle+=homingang
			else
				angle-=homingang



proc
	x_spreadproj(from,towards,type,pellets,gapang,anim=0)
		var/ang=towards
		if(!isnum(towards)) ang=from:GetAngle(towards)
		for(var/num=0,num<pellets,num++)
			pellets--
			var/projang=ang
			if(num)
				switch(num%2)
					if(0) projang=ang+sqrt(num)*gapang
					else projang=ang-sqrt(num+1)*gapang
			x_projectile(from,projang,type,anim)
	x_projectile(var/Player/from,towards,type,base_damage=100,anim=0)
		set waitfor=FALSE
		var/Projectile/proj=new type
		var/ang
		proj.owner = from
		proj.stat_dam = base_damage
		var/icon/I = new(proj.icon)
		if(isnum(towards)) ang=towards
		else ang=from:GetAngle(towards)
		proj.transform=turn(proj.transform,ang)
		proj.angle=ang
		I.Turn(-90)
		proj.icon = I
		world.log << "[proj.dir]"
		var/transx=cos(ang)
		var/transy=-sin(ang)
		proj.SetCenter(from)
		proj.px = PixelMovement.tile_width * proj.x
		proj.py = PixelMovement.tile_height * proj.y
		while(proj&&proj.range>0)
			var/originalpx=proj.pixel_x
			var/originalpy=proj.pixel_y
			if(proj.angle!=ang)
				ang=proj.angle
				transx=cos(ang)
				transy=-sin(ang)
			if(anim) animate(proj,pixel_x=proj.pixel_x+transx,proj.pixel_y+transy,time=1)
			sleep(world.tick_lag)
			var/turf/startloc=proj.loc
			var/startx=proj.step_x
			var/starty=proj.step_y
			var/dist=proj.Translate(transx*proj.speed,transy*proj.speed)
			//proj.loc.AfterImage(proj,proj.trailfade,proj.trail)
			proj.range-=dist
			if(proj.beam)
				if(proj.speed>=16)
					for(var/i=16,i<dist,i+=16)
						var/obj/o=FindObjType(proj)
						o.appearance=proj.appearance
						o.loc=startloc
						o.Translate(transx*16,transy*16)
						proj.taillist+=o
				else
					if(proj.disttraveled>=16)
						proj.disttraveled-=16
						var/obj/o=FindObjType(proj)
						o.appearance=proj.appearance
						o.step_x=startx
						o.step_y=starty
						o.loc=startloc
						o.Translate(transx*16,transy*16)
						proj.taillist+=o
					proj.disttraveled+=dist
				//RecycleObjType(o,time)
			if(anim)
				proj.pixel_x=originalpx
				proj.pixel_y=originalpy
			if(!dist) break
		proj.Terminate()

proc
	Jutsu_Spawn(atom/m,_state = "linear")
		var/tmp/_new_loc = m.loc
		switch(_state)
			if("linear")
				_new_loc = get_step(m,m.dir)
			if("east")
				_new_loc = get_step(m,turn(m.dir,-90))
			if("west")
				_new_loc = get_step(m,turn(m.dir,90))
		return _new_loc
	Deflect(Player/P,Projectile/m,_state = "west")
		var/tmp/_new_dir = m.dir
		switch(_state)
			if("linear")
				_new_dir = (m.dir)
			if("east")
				_new_dir = turn(m.dir,-45)
			if("west")
				if(prob(33))
					_new_dir = turn(m.dir,45)
				else if(prob(50))
					_new_dir = turn(m.dir,90)
				else
					_new_dir = turn(m.dir,180)
		if(istype(m,/Projectile)&&P.kaiten)
			m.owner = P
		return _new_dir
HitBox
	parent_type = /obj
	density=1
Projectile
	parent_type = /obj
	density=1
	layer=MOB_LAYER+1
	var
		stat_dam
		owner
		_type="None"
		_Rank="E"
		style="General"
		disttraveled=0
		beam=0
		trail=4
		trailfade=1
		speed=7
		range=320
		//homing variables
		homing=0// can the projectile turn? and this variable will dictate how long till homing activates
		homingang=0//how fast can the homing proj turn
		homingview=5///the range the projectile can check for homing targets
		list/taillist
	Del()
		var/count=0
		for(var/atom/v in taillist)
			count++
			Dissapate(count,1)
		..()
	New()
		..()
		if(beam) taillist=new
	Bump(atom/A)
		if(src.owner)
			var/Player/Player = src.owner
			if(ismob(A))
				if(istype(A,/Player))
					var/Player/P = A
					world.log << "SAFE"
					if(P==src.owner) return 0
					if(P.kaiten)
						walk(src,Deflect(P,src),1)
						return
				if(istype(A,/Non_Player))
					var/Non_Player/NPC=A
					if(NPC.village==Player.village)
						Player.Stat_Gain("ninjutsu",10)
						world.log<<"FRIENDLY FIRE"
					else
						NPC.health -= stat_dam
						if(NPC.health <= 0)
							NPC.DeathChance()
				for(var/Player/Z in view(src,10))
					if(Z==Player)
						Z.Stat_Gain("ninjutsu",10)
				if(istype(A,/Clone))
					var/Clone/S = A
					S.health -= stat_dam
					if(S.health <= 0)
						if(S.Bomb())
							S.Trap(Player,S.loc,"WaterClone")
				_message(view(A), "Battle Damage" , "[A] was hit for [stat_dam]!","red",,"red")
				del(src)
			if(isobj(A))
				if(istype(A,/Projectile/Hyuuga/Kaiten))
					walk(src,Jutsu_Spawn(src,"east"))
				else
					del(src)