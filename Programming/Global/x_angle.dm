proc
	NumToAngle(num)
		if(isnum(num)) num=num2text(num)
		if(num=="4")		//East
			num=0
		else if(num=="5")	//Northeast
			num=45
		else if(num=="1")	//North
			num=90
		else if(num=="9")	//Northwest
			num=135
		else if(num=="8") 	//West
			num=180
		else if(num=="10") 	//Southwest
			num=225
		else if(num=="2") 	//South
			num=270
		else if(num=="6") 	//South east
			num=315
		if(istext(num)) num=text2num(num)
		return num
	NumToAngle2(num)
		if(isnum(num)) num=num2text(num)
		if(num=="4")		//East
			num=0
		else if(num=="5")	//Northeast
			num=315
		else if(num=="1")	//North
			num=270
		else if(num=="9")	//Northwest
			num=225
		else if(num=="8") 	//West
			num=180
		else if(num=="10") 	//Southwest
			num=135
		else if(num=="2") 	//South
			num=90
		else if(num=="6") 	//South east
			num=45
		if(istext(num)) num=text2num(num)
		return num
atom
	proc
		GetAngle(var/turf/t)
			if(istype(src,/atom/movable)&&istype(t,/atom/movable)) return src.GetAngleStep(t)
			else
				if(t==null) return
				var/sx=t.x-src.x
				var/sy=t.y-src.y
				var/sz=sqrt(sx*sx+sy*sy)
				if(sz==0)
					sz+=0.1
				var/degrees=arccos(sx/sz)
				if(t.y>src.y) degrees=(360-degrees)
				return round(degrees)
		GetAngleStep(var/mob/t)
			if(t==null) return
			if(istype(src,/atom/movable)&&istype(t,/atom/movable))
				var/sizex=(t:bound_height-32)/2
				var/sizey=(t:bound_width-32)/2
				var/sx=(t.x+(t.step_x+sizex)/32)-(src.x+src:step_x/32)
				var/sy=(t.y+(t.step_y+sizey)/32)-(src.y+src:step_y/32)
				var/sz=sqrt(sx*sx+sy*sy)
				if(sz==0)
					sz+=0.1
				var/degrees=arccos(sx/sz)
				if(t.y>src.y) degrees=(360-degrees)
				return round(degrees)
			else return src.GetAngle(t)
	movable
		var/movedelay=0
		proc
			MoveAngInstant(ang,pixels,walk=0,wait=1,target)
				set waitfor=FALSE
				MoveAng(ang,pixels,walk,wait,target)
			MoveAng(ang,pixels,walk=0,wait=1,target)
				var/a=step_x,var/b=step_y,var/r=pixels
				if(r<0)
					ang+=180
					r=abs(r)
				movedelay=0
				if(walk&&r>32)
					var/dcovering=r
					var/turf/begin=src.loc
					while(dcovering>0)
						r=dcovering
						if(dcovering>32) r=32
						dcovering-=32
						var/x=a+r*(cos(ang)); var/y=b-r*(sin(ang));
						var/movesx=round((x)/32);var/movesy=round((y)/32)
						x-=movesx*32; y-=movesy*32;
						if(begin)
							begin=locate(begin.x+movesx,begin.y+movesy,begin.z)
							var/returnvalue=src.Move(begin,,x,y,2)
							if(returnvalue==0) break
							if(wait) sleep(wait)
				else
					var/x=a+r*(cos(ang)); var/y=b-r*(sin(ang));
					var/movesx=round((x)/32);var/movesy=round((y)/32)
					x-=movesx*32; y-=movesy*32;
					var/turf/begin=locate(src.x+movesx,src.y+movesy,src.z)
					if(begin) src.Move(begin,,x,y)
atom/movable
	var
		sub_step_x = 0
		sub_step_y = 0
		angle
		target
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