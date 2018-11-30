Thundersword
		name = "Thunderswords"
		worn = 0
		icon='kiba.dmi'
		var/form = "Twin"
		verb
			Wear()
				if(worn)
					worn = 0
					usr.overlays-=src.icon
					usr << "You remove the [name]."
					suffix = ""
					usr.weapon=0
					usr.Thundersword = 0
					usr.Swordsmen = 0
					usr.weapon2="[name]"

				else
					worn = 1
					usr.overlays+=src.icon
					usr << "You wear the [name]."
					suffix = "Equipped"
					usr.weapon=1.50
					usr.Thundersword = 1
					usr.Swordsmen = 1
					usr.weapon2="[name]"
			Get()
				set src in oview(1)
				if(usr.Org == "Seven Swordsmen of Mist")
					loc = usr
					//Executioner_Owner = usr
					usr<<"You picked up the [src]"
					hasSSMsword = 1
					Thundersword_Owner = "[src]"
				else
					usr<<"You pick up the [src], but they shock you and you drop them instantly."
			FormSwitch()
				set category = "Taijutsu"
				switch(form)
					if("Twin")
						form ="Double-Blade"
					else if("Double-Blade")
						form = "Twin"
				usr << "Your [src] are now set to [src.form] sword."
			Thunder_Gate()
				set name= "Lightning Release: Thunder Gate"
				set category = "Ninjutsu"
				if(usr.Thundersword)
					usr <<"Heh it's time to end this..."
					usr.Frozen=1
					Ticks(20)
					view(usr)<<"Lightning Release: Thunder Gate!"
					for(var/i=1 to 6)
						for(var/mob/A in oview(i,usr))
							if(A.client)
								spawn(0)
									A.Flash()
							if(get_dist(A,usr)==i)
								A.tdmg(round(usr.nin * (9/i),1),usr)
								oview(5,A) << "[A] was damaged by the lightning for [usr.nin * (9/i)]"
					usr.Frozen=0



			Slash()
				set category = "Taijutsu"
				var/tmp/damage
				if(form == "Twin")
					for(var/mob/M in view(1,usr))
						if(usr.Target)
							usr.dir = get_dir(usr,usr.Target)
						if(usr.dir == get_dir(usr,M))
							damage = round(usr.nin/1.5)
							M.health -= damage
							oview(M) << "<font size=1>[usr] sliced [M] for [damage]!"
							M.Death(usr)
							Ticks(1)
							.
						else
							continue
						//if(usr.element
					if(usr.ChakraType!="Lightning")
						usr.chakra -= 1000
					var/obj/lightning_ball/Z = new
					Z.LocationSpawn(usr)
					Z.nin=usr.nin;Z.Move_Delay=JUTSUSPEEDFAST;Z.dir = usr.dir;Z.name="[usr]";Z.Gowner=usr;walk(Z,usr.dir)
					Ticks(50)
				else
					for(var/mob/M in view(1,usr))
						if(usr.Target)
							usr.dir = get_dir(usr,usr.Target)
						if(usr.dir == get_dir(usr,M))
							damage = round(usr.nin)
							M.health -= damage
							oview(M) << "<font size=1>[usr] sliced [M] for [damage]!"
					Ticks(3)
obj
	proc
		LocationSpawn(var/mob/M)
			switch(M.dir)
				if(NORTH)
					src.loc = locate(M.x,M.y+1,M.z)
				if(SOUTH)
					src.loc = locate(M.x,M.y-1,M.z)
				if(WEST)
					src.loc = locate(M.x-1,M.y,M.z)
				if(EAST)
					src.loc = locate(M.x+1,M.y,M.z)
				if(NORTHEAST)
					src.loc = locate(M.x+1,M.y+1,M.z)
				if(NORTHWEST)
					src.loc = locate(M.x-1,M.y+1,M.z)
				if(SOUTHEAST)
					src.loc = locate(M.x+1,M.y-1,M.z)
				if(SOUTHWEST)
					src.loc = locate(M.x-1,M.y-1,M.z)
mob/proc
	Blowback(var/atom/M,var/times=1)
		var/tmp/J = M.dir
		src.dir = get_dir(src.loc,M.loc)
		for(var/i=1 to times)
			switch(J)
				if(NORTH)
					src.loc = locate(src.x,src.y+1,src.z)
				if(SOUTH)
					src.loc = locate(src.x,src.y-1,src.z)
				if(WEST)
					src.loc = locate(src.x-1,src.y,src.z)
				if(EAST)
					src.loc = locate(src.x+1,src.y,src.z)
				if(NORTHEAST)
					src.loc = locate(src.x+1,src.y+1,src.z)
				if(NORTHWEST)
					src.loc = locate(src.x-1,src.y+1,src.z)
				if(SOUTHEAST)
					src.loc = locate(src.x+1,src.y-1,src.z)
				if(SOUTHWEST)
					src.loc = locate(src.x-1,src.y-1,src.z)
			if(M)
				del(M)
			Ticks(5)
		del(M)
obj/lightning_ball
	density=1
	icon = 'rai.dmi'
	Bump(mob/A)
		if(ismob(A))
			var/mob/M = A
			var/mob/O = Gowner
			if(M.sphere)return
			if(M.Kaiten)del(src)
			if(M.SharkCounter(1000)==1)del(src)
			var/damage = round(nin*3.5)
			if(damage >= 1)
				M.health -= damage
				view(M) << "[M] was hit by Raikyu for [damage] damage!"
				for(var/mob/S in players)
					if(S.isviewing==O&&S.viewcombat)
						S<<"<font size=1><font face='verdana'>(Combat Spy)[M] was hit by Raikyu for [damage] damage."
				M.Blowback(src,2)
				M.Death(O)
			if(src)
				del(src)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj/))
			del(src)
		Ticks(30)
		del(src)


datum/var
	hasSSMsword = 0
	//Executioner Sword Vars
	Executioner = 0
	Executioner_Owner = ""
	Combo_Breaker = 3
	Combo_Check = 0
	Count= 0
	Zfire = 0
	Multi = 0
	Swordsmen
	timerr = 0
	//Shark Skin Sword Vars
	Sharkskin = 0
	Sharkskin_Owner = ""
	Sharkskin_Chakra = 0
	//Helmet Splitter Sword Vars
	Helm_Splitter =0
	Helm_Shield
	//Thunder Sword Variables
	Thundersword = 0
	Thundersword_Owner=""




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
			var/tmp/maxtarget = length(usr.Targetoptions)
			usr.Target=null
			for(var/image/A in usr.Targetlist)
				del A
			usr.Targetlist = new
			if(usr.TargetNumber==0)
				usr << "You are not targeting anyone"
				usr.TargetNumber++
				return
			spawn(0.1)
				Target(Targetoptions[TargetNumber])
			Ticks(0.2)
			usr.TargetNumber++
			if(usr.TargetNumber>maxtarget)
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
				if(src)
					Targeting()

		Target(atom/P,var/flag=ENEMY)
			if(flag == ENEMY)
				if(src.Target||P in src.Target)
					src.Target=null
					del src.Targetlist
					src.Targetlist = new
				var/image/K=image('Target.dmi',P,pixel_x=-4)
				K.layer=7
				K.pixel_x=-4
				SET
				if(P in view(src))
					if(src.Targetlist.len == 0)
						//var/HUD/Target/T = new
						K.icon_state = "[flag]"
						//T.screen_loc = "[Screen_Locator(src,P)]"
						K.layer = MOB_LAYER
						K.pixel_x=-
						src<<K
						src.Targetlist+=K
						src.Target=P
						src << "You are now targeting [P]"
	/*				for(var/HUD/Target/G in src.Targetlist)
						G.screen_loc = "[Screen_Locator(src,P)]"*/
					spawn(0.1)
						goto SET
				else
					del K
					src.Targetlist = new
					src.Target=null
/*			if(flag == FRIENDLY)
				if(usr.Ally.len <=3)
					var/image/K=image('Target.dmi',P)
				SET
				if(P in Ally)
					del AllyList[Ally.Find(P,1)]
					Ally-=P*/


Objects
	parent_type = /obj
	Effects
		Footprints
			icon = 'Footprint.dmi'
mob
	proc
		Footprint(var/tmp/mob/P,_x,_y,_z,water=0)
			var/Objects/Effects/Footprints/F= new
			if(water)
				F.icon_state = "water"
				F.dir=P.dir
				F.loc=locate(_x,_y,_z)
				Ticks(5)
				animate(F,alpha=0,time=5)
				Ticks(5)
				del(F)
			else
				F.dir=P.dir
				F.loc=locate(_x,_y,_z)
				if(P.dir==EAST||P.dir==WEST)
					F.pixel_y= -20
				Ticks(20)
				animate(F,alpha=0,time=40)
				Ticks(40)
				del(F)



proc
	Screen_Locator(var/atom/A,var/atom/B)
		var/dis
		var/new_x
		var/new_y
		new_x=B.x-A.x
		new_y=B.y-A.y
		dis = "CENTER+[new_x],CENTER+[new_y]"
		return dis

mob
	var
		scent
	Move()
		..()
		spawn()
			var/obj/Marker/L = new(src.loc)
			L.owner = src
			Ticks(100)
			del(L)

obj
	Marker
		var
			marked=0
mob/inuzuka
	verb/Scent()
		var/tmp/Hunt
		set category= "Ninjutsu"
		if(usr.scent)
			usr<<"You are already tracking someone"
			return
		if(usr.Target==null)
			usr << "You need to target someone"
			return
		else
			usr.scent=1
			Hunt = usr.Target
			usr << "You gather [usr.Target]'s scent."
			spawn()
				while(usr.scent)
					if(!Hunt)
						usr << "His scent disappeared!"
						usr.scent=0
						return
					for(var/obj/Marker/L in view(usr))
						if(L.owner == Hunt&&!L.marked)
							L.marked=1
							var/image/I = image('Footprint.dmi',L)
							usr << I
							spawn(100)
								del(I)
					Ticks(0.3)
		while(Hunt)
			Ticks(500)
			usr << "You lost [Hunt]'s trail.."
			usr.scent=0
			return