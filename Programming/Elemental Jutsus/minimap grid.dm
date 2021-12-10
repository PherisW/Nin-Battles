var/list/minimap=new
var/maprendering=0
Player
	Move()
		.=..()
		if(src.client&&.)
			if(worldmap)
				worldmap:ChangeIcon(src)
	Start()
		..()
		spawn(5)
		GiveMiniHud()

world
	New()
		..()
		spawn(30)
			TPixelGet1(0)
proc
	TPixelGet1(bypass=0)//Call at world New(), This a minimap of all maps
		set waitfor=FALSE
		set background=1
		sleep(10)
		if(bypass||!LoadMiniMap())//Checks if theres a previous minimap icon that can be loaded
			for(var/p in typesof(/turf))//This loop creates the miniture version of all turfs in game so can be used for
				var/turf/t=new p(locate(1,1,1),"MiniMap")
				var/icon/i=icon(t.icon,t.icon_state)
				if(t.icon==null||!i.GetPixel(i.Width()/2,i.Height()/2)||i==null)
					continue
				var/scalex=i.Width()/8
				var/scaley=i.Height()/8
				if(scalex<1) scalex=(1-scalex)*15
				if(scaley<1) scaley=(1-scaley)*15
				i.Scale(scalex,scaley)
				minimap[t.type]=i
			for(var/p in typesof(/Objects))//This loop creates the miniture version of all objs in game so can be used for
				var/Objects/t=new p
				if(p in list(/Items,/Hud,/MapTools/Interior/Shaders))
					del t
				else//Skip certain items
					if(!t._multi)
					//var/obj/t=new p
						if(t==null) continue
						var/icon/i=icon(t.icon,t.icon_state)
						var/scalex=i.Width()/8
						var/scaley=i.Height()/8
						if(scalex<1) scalex=(1-scalex)*15
						if(scaley<1) scaley=(1-scaley)*15
						i.Scale(scalex,scaley)
						minimap[t.type]=i
					else
						del t
			world.log << "Rendering World Map."
			//_message(world,"Map Log","Rendering World Map","red",,"red")
			var/icon/lastimage
			world.log << "Rendering Turfs."
			//_message(world,"Map Log","Turfs..","red",,"red")
			for(var/turf/T in world)//This loop puts all the minimap turfs together
				if(maprendering!=T.z)
					maprendering=T.z
					//_message(world,"World Info","Turf Map [maprendering]","red",,"red")
					world<<"Turf Map [maprendering]"
				if(T.type==/turf) continue
				var/icon/worldicon=wholemap[T.z]
				if(!wholemap[T.z])
					wholemap[T.z]=new/icon('blank2.dmi')
					var/sizex=world.maxx
					var/sizey=world.maxy
					worldicon=wholemap[T.z]
					worldicon.Crop(sizex*4,sizey*4)
				if(!minimap[T.type])
					var/icon/i=icon(T.icon,T.icon_state)
					if(T.icon==null||!i.GetPixel(i.Width()/2,i.Height()/2)||i==null) continue
					var/scalex=i.Width()/8
					var/scaley=i.Height()/8
					if(scalex<1) scalex=(1-scalex)*15
					if(scaley<1) scaley=(1-scaley)*15
					i.Scale(scalex,scaley)
					minimap[T.type]=i
				var/imageobj=minimap[T.type]
				if(!isicon(imageobj))//If no icon for turf we will just use the last icon found
					imageobj=lastimage
				else lastimage=imageobj
				if(imageobj) worldicon.Blend(imageobj,ICON_OVERLAY,T.x*4,T.y*4)
				if(T.x==world.maxx&&T.y%2==0)//Incrementally sleep so game doesn't completely pause while rendering
					sleep(1)
			//_message(world,"World Info","Turf Map [maprendering]","red",,"red
			world.log << "Rendering Objects."
			//_message(world,"Map Log","Objects..","red",,"red")
			maprendering=0
			for(var/obj/T in world)//Same as turfs but for objects
				if(maprendering!=T.z)
					maprendering=T.z
					//_message(world,"World Info","Objs Map [maprendering]","red",,"red")
					//world<<"Objs Map [maprendering]"
				if(T.z==0) continue
				var/icon/worldicon=wholemap[T.z]
				//var/tmp/atom/K = minimap[T.type]
				if(!minimap[T.type]||T._multi)
					//world.log << "Generating [T.name]:[T.icon_state]"
					var/icon/i=icon(T.icon,T.icon_state)
					if(T.icon==null||!i.GetPixel(i.Width()/2,i.Height()/2)||i==null) continue
					var/scalex=i.Width()/8
					var/scaley=i.Height()/8
					if(scalex<1) scalex=(1-scalex)*15
					if(scaley<1) scaley=(1-scaley)*15
					i.Scale(scalex,scaley)
					minimap[T.type]=i
				var/imageobj=minimap[T.type]
				if(!isicon(imageobj))
					imageobj=lastimage
					sleep(1)
				else lastimage=imageobj
				if(imageobj)
					if(T.color)
						if(T.color=="#0000ff")
							worldicon.Blend(imageobj+rgb(0,0,255),ICON_OVERLAY,T.x*4,T.y*4)
						else
							worldicon.Blend(imageobj+rgb(255,0,0),ICON_OVERLAY,T.x*4,T.y*4)
					else worldicon.Blend(imageobj,ICON_OVERLAY,T.x*4,T.y*4)
				if(T.x%(world.maxx)==0)
					sleep(rand(0,1))
			world.log << "Saving World Minimap."
			//_message(world,"Map Log","Saving World Minimap..","red",,"red")
			created=1
			SaveMiniMap()
			for(var/Player/Player in world)
				if(Player.loggedin)
					Player.FigureUpdate("[mastersx]:[masterpx],[mastersy]:[masterpy]")
var/list/wholemap[world.maxz]
var/mastersx=28
var/mastersy=18
var/masterpx=1
var/masterpy=1
var/mpx=32
var/mpy=32
var/created=0
mob
	var
		obj
			tmp
				worldmap//Each player need a Copyable of the world map since each image will be shifting depend on the players location
				planemaster//defined to display allys/enemy objects on it
	proc
		GiveMiniHud()
			worldmap=new/obj/WorldMap
			planemaster=new/obj/minimap_plane
			client.screen += planemaster
			planemaster.overlays += /image/border
			planemaster.overlays += /image/border2
			planemaster.overlays += /image/visiblearea
			client.screen += worldmap
			FigureUpdate("[mastersx]:[masterpx],[mastersy]:[masterpy]")
obj
	WorldMap
		blend_mode = BLEND_MULTIPLY
		plane = 4
		layer=4
		proc
			ChangeIcon(mob/O)//Function called when player moves to make minimap move
				set waitfor=FALSE
				if(O&&wholemap.len>=O.z&&O.z)
					src.icon=wholemap[O.z]
					var/icon/worldicon=wholemap[1]
					if(worldicon)
						var/sx=1
						var/sy=1
						var/px=mastersx*32+masterpx-O.x*4+1
						var/py=mastersy*32+masterpy-O.y*4
						screen_loc="[sx]:[px+mpx],[sy]:[py+mpy]"
obj/minimap_plane//Master Plane
	plane = 4
	blend_mode = BLEND_DEFAULT
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR
	mouse_opacity = 0
	alpha=180
	New()
		..()
		screen_loc = "[mastersx]:[masterpx],[mastersy]:[masterpy]"
image/visiblearea
	plane = 4
	blend_mode = BLEND_ADD
	icon = 'blank2.dmi'//White icon crops minimap(Visible Area of minimap)
	icon_state=""
image/border
	plane =4
	blend_mode = BLEND_ADD
	icon = 'blank3.dmi'  //Gives minimap a circular black border
	//icon_state="black"
image/border2
	plane = 4
	//blend_mode = BLEND_ADD
	icon = 'BlankBorder.dmi'  //Gives minimap a circular black border
	pixel_x=-2
	pixel_y=-2
	//icon_state="black"
proc//Saving and loading so you dont have to recreate the entire world maps each reboot
	SaveMiniMap()
		var/savefile/F=new("savefiles/minimap.sav")
		F<<wholemap
	LoadMiniMap()
		var/savefile/F=new("savefiles/minimap.sav")
		var/list/l
		F>>l
		if(l)
			world.log << "MiniMap has Loaded."
			//_message(world,"Map Log","World MiniMap Loaded","red",,"red")
			//world<<"World MiniMap Loaded"
			wholemap=l
			created=1
			return 1
		else
			return 0
mob
	proc
		FigureUpdate(screenloc)
			set waitfor=FALSE
			if(!src.client) return
			var/obj/j=planemaster
			var/list/objects=new
			j.screen_loc=screenloc
			src.client.screen+=j
			while(src)
				for(var/mob/T in viewers(12))
					if(T)//.dead==0)
						var/image/i
						if(objects[T])
							i=objects[T]
							i.pixel_x=0
							i.pixel_y=0
						else
							i=new
							if(T==src)
								i=image(/obj/Spot/You,,,3)
							else if(T.client)
								switch(T.village)
									if("Leaf")
										i=image(/obj/Spot/Leaf_Player,,,2)
									if("Sand")
										i=image(/obj/Spot/Sand_Player,,,2)
									if("Mist")
										i=image(/obj/Spot/Mist_Player,,,2)
							else if(!T.client)
								switch(T.village)
									if("Leaf")
										i=image(/obj/Spot/Leaf_NPC,,,2)
									if("Sand")
										i=image(/obj/Spot/Sand_NPC,,,2)
									if("Mist")
										i=image(/obj/Spot/Mist_NPC,,,2)
								if(istype(T,/Non_Player/Friendly/Sand_Headmaster))
									i=image(/obj/Spot/Exclamation,,,2)
								else if(istype(T,/Non_Player/Friendly/Gaara))
									i=image(/obj/Spot/Boss,,,2)
							//else i=image(/obj/Spot/Ally,,,2)
								/*
								if(src.team.type==T.team) i=image(/obj/Spot/Ally,,,2)
								else i=image(/obj/Spot/Ally,,,2)*/
							objects[T]=i
						i.pixel_x+=(T.x*4-src.x*4)+16+mpx
						i.pixel_y+=(T.y*4-src.y*4)+16+mpy
						j.OverPut(i,2)
				sleep(2)

obj
	Spot
		plane=5
		icon='Piece.dmi'
		Cover
			icon_state="cover"
			layer=MOB_LAYER+16
			screen_loc="19,19 to 21,21"
		Sand_NPC
			icon_state="sand(npc)"
		Sand_Player
			icon_state="sand(player)"
		Leaf_NPC
			icon_state="leaf(npc)"
		Leaf_Player
			icon_state="leaf(player)"
		Mist_NPC
			icon_state="mist(npc)"
		Mist_Player
			icon_state="mist(player)"
		Question
			icon_state="?"
		Question2
			icon_state="?2"
		Exclamation
			icon_state="!"
		Enemy
			icon_state="enemy"
		Creature
			icon_state="creature"
		You
			plane=5
			icon_state="you"
		Boss
			icon_state="boss"