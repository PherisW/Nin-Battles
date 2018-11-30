/*
What all do we want this projectile system to do?
Fire at angles, Fire towards targets, Homing Options, Fire Spread
*/


Projectile//Kaiochaio Vector
	var
		sub_step_x = 0
		sub_step_y = 0
		angle
	proc
		TranslateFire(ang,dist,time,anim=0)
			set waitfor=FALSE
			var/transx=cos(ang)
			var/transy=-sin(ang)
			var/speed=dist/time
			var/originalpx=pixel_x,originalpy=pixel_y
			while(dist>0)
				if(anim) animate(src,pixel_x=src.pixel_x+transx,src.pixel_y+transy,time=1)
				sleep(world.tick_lag)
				dist-=Translate(transx*speed,transy*speed)
				if(anim)
					pixel_x=originalpx
					pixel_y=originalpy
				if(!dist||!loc) break
		TranslateAng(ang,dist,glidetime=0)
			var/x=dist*cos(ang)
			var/y=dist*sin(ang)
			Translate2(x,y,glidetime)
		Translate2(X,Y,GlideTime=0)
			var whole_x = 0, whole_y = 0
			var/osize=step_size
			if(X)
				sub_step_x += X
				whole_x = round(sub_step_x, 1)
				sub_step_x -= whole_x
			if(Y)
				sub_step_y += Y
				whole_y = round(sub_step_y, 1)
				sub_step_y -= whole_y
			step_size = max(abs(whole_x), abs(whole_y))
			var/shiftx=step_x + whole_x
			var/shifty=step_y + whole_y
			if(GlideTime)
				var original_pixel_x = pixel_y, original_pixel_y = pixel_y
				pixel_x = -whole_x
				pixel_y = -whole_y
				animate(src, time = GlideTime,
					pixel_x = original_pixel_x,
					pixel_y = original_pixel_y)
			var/move=Move(loc, dir,shiftx,shifty)
			step_size=osize
			return move
atom
	movable
		var
			atom/movable/target
obj
	var
		activetime=0
		damage=0
	hitbox
		density=1
	Projectiles
		appearance_flags=RESET_COLOR
		var
			disttraveled=0
			beam=0
			trail=3
			trailfade=1
			speed=10
			range=100
			//homing variables
			homing=0// can the projectile turn? and this variable will dictate how long till homing activates
			homingang=0//how fast can the homing proj turn
			homingview=5///the range the projectile can check for homing targets
			list/taillist
		Del()
			var/count=0
			for(var/atom/v in taillist)
				count++
				v:Dissapate(count,1)
			..()
		New()
			..()
			if(beam) taillist=new
		proc
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
			Terminate()
				..()
				Dissapate(2,1)//Make them fade out
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
	x_projectile(from,towards,type,anim=0)
		set waitfor=FALSE
		var/Projectile/proj=new type
		var/ang
		if(isnum(towards)) ang=towards
		else ang=from:GetAngle(towards)
		var/pick = rand(40,80)
		proj.transform=turn(proj.transform,ang)
		ang = pick(ang+pick,prob(50)ang-pick,prob(50)ang,prob(20))
		if(prob(50))
			ang+= pick
			ang-= pick
		proj.angle=ang
		var/transx=cos(ang)
		var/transy=-sin(ang)
		proj.set_pos(from.px,from.py,from.z)
		while(proj.range>0)
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
			proj.loc.AfterImage(proj,proj.trailfade,proj.trail)
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

proc/cast_ray(StartX, StartY, DirectionX, DirectionY, MaxDistance = 100, Z = 1, obj/hitbox/raycast/Ray = new)
	Ray.SetCenter(StartX, StartY, Z)
	Ray.Translate(DirectionX * MaxDistance, DirectionY * MaxDistance)
	Ray.moved_x = Ray.Cx() - StartX
	Ray.moved_y = Ray.Cy() - StartY
	return Ray

obj/hitbox/raycast
	var tmp
		moved_x
		moved_y