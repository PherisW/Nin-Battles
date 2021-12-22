/*
/////////////////
Table of Contents
//////////////////
*/
atom
	var/_multi=0
Letters
	parent_type = /obj
	icon = 'Letters.dmi'
	plane=5

mob/var/tmp/list/Loaded=new/list()
mob//Mob hmmm, let me think...
	proc//We all know what a proc is.
		Name(text as text,person)//Make it so the proc requires some text.
			set background=1
			if(!text||!src.client)
				return
			var/mob/M=person
			if(text in M.Loaded)return//stop loading more than once

			M.Loaded.Add(text)

			if(length(text)>=21)//If the text has more than 20 characters;
				text=copytext(text,1,21)//Make the text the first 21 characters;
				text+="...."//And for fun lets add the "....".

			var/list/letters=list()//Make a list for later.
			var/CX//Another variable, for the pixel x.
			var/OOE=(lentext(text))//A variable so you can center it.
			if(OOE%2==0)//If you don't know what an if statment is, you probably shouldn't download this.
				CX+=11-((lentext(text))/2*5)//We do want it centered?
			else
				CX+=12-((lentext(text))/2*5)//Right. P.S. Don't fool around with this unless you know exactly what you are doing.
			for(var/a=1, a<lentext(text)+1, a++)//Cut all of the letters up;
				letters+=copytext(text,a,a+1)//And add them to our letters list().
			for(var/X in letters)//For EVERY character in the letters list();
				var/Letters/O=new/Letters//Make a new letter obj.
				O.icon_state=X//Make the obj look like the character.
				O.pixel_x=CX//Set it on the correct pixel x, like in a map.
				O.pixel_y=-24//Put underneath the player.
				switch(src.village)
					if("Leaf")
						O.color= rgb(0,255,0)
					if("Sand")
						O.color= rgb(218,165,32)
					if("Mist")
						O.color= rgb(32,178,170)
					else
						O.color= rgb(120,120,120)
				//O.icon=O.icon-src.color//Remove any color; just for fun.
				//O.color= rgb(0,255,0) //Genin Green
				//O.color= rgb(32,178,170) //Chuunin Blue
				//O.color= rgb(120,120,120) //Rogue Black
				//O.color= rgb(200,200,200) //Acad White
				//O.color= rgb(147,112,219)
				//O.color= rgb(218,165,32)
				//O.icon=O.icon + rgb(139,0,128)
				CX+=6//Increase the pixel x variable so they won't all end up on top of each other.
				var/image/B = image(O,src)

				M.client.images += B//Add the letter to the players overlays.
				spawn(30)
					if(M&&M.loggedin)
						M.Loaded=new
						M.client.images -= B

Objects
	parent_type= /obj
	bound_width = 32
	bound_height = 32
	var/icon_width = 0
	var/icon_height = 0
	proc
		set_icon_size2()
			if(isnum(world.icon_size))
				icon_width = world.icon_size
				icon_height = world.icon_size
			else
				var/p = findtext(world.icon_size, "x")
				icon_width = text2num(copytext(world.icon_size, 1, p))
				icon_height = text2num(copytext(world.icon_size, p + 1))
		Multi_Tile(var/Objects/S,dens=0,layers=S.layer,OverRide=0,override_layers,_x= (null))
			var/lens = length(icon_states(S.icon))
			var/iconstates = new/list()
			var/list/maxy = new/list()
			var/list/maxx = new/list()
			//S.appearance_flags = PIXEL_SCALE
			if(!_x)
				_x = text2num(copytext(S.icon_state,1,2))

			//GenerateShadow(S,EAST)
			for(var/texts in icon_states(S.icon))
				iconstates+=texts
			var/loc_check

			for(var/i=1 to lens)
				loc_check = splittext(iconstates[i], ",")
				maxy.Add(text2num(loc_check[2]))
				maxx.Add(text2num(loc_check[1]))

			for(var/i=1 to lens)
				loc_check = splittext(iconstates[i], ",")
				var/Objects/N = new S.type(0)
				//N.PixelMovement.set_icon_size()
				if(text2num(loc_check[2]) == (min(maxy)))
					N.layer = layers
					if(OverRide)
						N.density=0
				if(text2num(loc_check[2]) >= (max(maxy)-dens))
					N.density = 0
					if(!override_layers)
						N.layer = layers+ abs(text2num(loc_check[2])-(min(maxy)))
				if(S.icon_state == "[loc_check[1]],[loc_check[2]]") continue
				//loc_check[1]=="0" && loc_check[2]=="0") //continue
				N.icon_state = "[loc_check[1]],[loc_check[2]]"
				N.loc = locate(src.x +text2num(loc_check[1]) - _x,src.y +text2num(loc_check[2]),src.z)
				//N.loc= locate(N.x - _x,N.y,N.z)
				N.px = PixelMovement.tile_width * N.x
				N.py = PixelMovement.tile_height * N.y
				if(N.shadow)
					S.shadows += GenerateShadow(N,EAST,text2num(loc_check[2]),text2num(loc_check[1]),max(maxy),max(maxx))
	Flora
		Tree
			//icon = '2ndtree.dmi'
			//icon = '3rd Tree.dmi'
			icon='NewTree.dmi'
			icon_state="1,0"
			layer=5
			shadow=1
			mouse_opacity=0
			density=0
			//pixel_x=-48
			_multi=1
			New(c=1)
				if(c)
					spawn()
						..()
						Multi_Tile(src,0)
	Misc
		icon_state = "0,0"
		layer=6
		shadow=1
		density=1
		Wood_Fence
			icon = 'WoodFence.dmi'

		Uchiha_Banner
			icon='Uchiha Banner.dmi'
			_multi=1
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src,1)
						..()
		Bench
			icon='Bench.dmi'
			density=0
			layer=3
			_multi=1
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src,1)
						..()
		Sand_Flag
			var/turns=0
			icon ='SandFlag.dmi'
			_multi=1
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src,2)
						..()
		Sand_Flag2
			icon ='sandflag2.dmi'
			_multi=1
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src,2)
						..()
		Memorial
			icon = 'memorial.dmi'
			icon_state = "1,0"
			_multi=1
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src,2)
						..()
		Fence_Log
			shadow=1
			icon='log fence.dmi'
			density=1
			pixel_y=-16
			New()
				..()
				GenerateShadow(src,SOUTH)


		life
			//icon = 'random objects.dmi'
	Training_Obj
		Logs
			icon = 'Training Dummy.dmi'
			//icon_state = "0,0"
			layer=6
			density=1
			shadow=1
			New(c=1)
				..()
				GenerateShadow(src,EAST)
				/*if(c)
					spawn()
						Multi_Tile(src)
						..()*/
		Cactus
			icon = 'Cactus.dmi'
			layer=6
			shadow=1
			density=1
			New()
				..()
				GenerateShadow(src,EAST)

	Buildings
		icon_state = "0,0"
		layer=6
		shadow=1
		density=1
		mouse_opacity=0
		_multi=1
		var/_layer=0
		var/nodense=4
		New(c=1)
			if(c)
				spawn()
					..()
					Multi_Tile(src,nodense,override_layers=_layer)
		Kirigakure
			layer=6
			icon_state="4,0"
			MizukageBulding
				icon = 'NewMizukageBuilding.dmi'
			MistAcad
				icon = 'Mist Academy.dmi'
			MistHosp
				icon = 'Mist Hospital.dmi'
				icon_state="8,0"
			MistTower
				icon = 'MistTower.dmi'
				icon_state="2,0"
			MistWeaponShop
				icon = 'MistWeaponShop.dmi'
				icon_state="3,0"
			MistClothingShip
				icon = 'MistClothingShop.dmi'
				icon_state="4,0"
			MistBuilding
				icon = 'MistBuilding1.dmi'
				icon_state="3,0"
			MistDojo
				icon = 'MistDojo.dmi'
				icon_state="2,0"

		Konohagakure
			layer=6
			HokageBuilding
				icon = 'HokageBuilding.dmi'
				icon_state="4,0"
			LeafClothing
				icon = 'LeafClothingShop.dmi'
				icon_state="4,0"
				nodense=2
			LeafWeaponShop
				icon = 'LeafWeaponShop.dmi'
				icon_state="4,0"
				nodense=2
			LeafPolice
				icon = 'LeafPolice.dmi'
				icon_state="2,0"
			LeafHouse1
				icon = 'LeafBuilding1.dmi'
				icon_state="5,0"
				pixel_x=11
			LeafHouse2
				icon = 'LeafBuilding2.dmi'
				icon_state="3,0"
				pixel_x=8
			LeafHouse3
				icon = 'LeafBuilding3.dmi'
				icon_state="4,0"
				pixel_x=4
			LeafAcad
				icon = 'LeafAcademy.dmi'
				icon_state="8,0"

		Sunagakure
			icon_state="4,0"
			Sand_Building_Small
				//icon = 'Small Sand House.dmi'
				density=1
			SandHosp
				icon = 'SandHospital.dmi'
				icon_state="3,0"
				density=1
			SandAcad
				icon = 'SandAcad.dmi'
				icon_state="3,0"
				density=1
			SandLeader
				icon = 'KazekageBuilding.dmi'
				icon_state="3,0"
				density=1
			SandBulding
				icon='Sand Building1.dmi'
				icon_state="2,0"
				density=1
			SandTower1
				icon='Sand Tower.dmi'
				icon_state="3,0"
				density=1
			SandTower2
				icon='Sand Tower2.dmi'
				icon_state="3,0"
				density=1
			SandArena
				icon='SandArena.dmi'
				nodense=7
				density=1
			SandWeaponShop
				icon='SunaWeaponShop.dmi'
				density=1
			SandClothing
				icon='SunaClothingShop.dmi'
				icon_state="4,0"
		Leaf_WallL
			layer=6
			shadow=0
			icon = 'LeafLeftEnd.dmi'
		Leaf_WallR
			layer=6
			shadow=0
			icon = 'LeafWallRedge.dmi'
		Leaf_Gate
			layer=9
			density=0
			pixel_y=-18
			shadow=0
			nodense=5
			icon = 'LeafEnterance.dmi'
			//icon_state="4,0"

		Leaf_WallCenter
			layer=4
			shadow=0
			pixel_y=-16
			icon = 'LeafMiddle.dmi'
		Leaf_Gate_Turf
			layer=TURF_LAYER
			shadow=0
			_layer=1
			icon_state="6,0"
			icon = 'GateTurf.dmi'
	Summons
		layer=7
		Manda
			icon = 'Manda(New).dmi'
			icon_state="0,0"
			layer=7
			pixel_y=-16
			pixel_x=-4
			shadow=1
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src)
						..()
		Katusya
			icon = 'Katusya(New).dmi'
			icon_state="0,0"
			layer=7
			shadow=1
			pixel_y= 10
			pixel_x= 12
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src)
						..()
		Gabaunta
			icon = 'Gabaunta(New).dmi'
			icon_state="0,0"
			layer=7
			shadow=1
			pixel_y
			pixel_x=20
			New(c=1)
				if(c)
					spawn()
						Multi_Tile(src)
						..()


	Effects
		Footprints
			icon = 'Footprint.dmi'
			New()
				if(dir==WEST||dir==EAST)
					src.pixel_y=-20
		Chakra
			icon = 'chakra flows.dmi'
			icon_state="normal"
			layer = FLOAT_LAYER
			invisibility = 1


Non_Player
	shadow=1
	density = 1
	Friendly
		layer=5
		Sand_Headmaster
			icon = 'Bet taker.dmi'
			icon_state ="sand"
			village = "Sand"
			/*Talk()
				..()
				_message(*/
		Gaara
			icon = 'KKG.dmi'
			village = "Sand"
		Kankurou
			icon = 'Kankurou.dmi'
			village = "Sand"
		Tsunade
			icon = 'Tsu.dmi'
			density = 0
			village = "Leaf"
		Orochimaru
			icon = 'Oro.dmi'
			density = 0
			village = "Leaf"
		Jirayia
			icon = 'Jiraiya.dmi'
			density = 0
			village = "Leaf"
	Villager
		icon='shinobi.dmi'
		shadow=1
		_wanderon=1
		density=1
		village="Sand"
		New()
			..()
			if(prob(20))
				icon='Dark base.dmi'
			var/Items/Apparel/Hair/hair = new(src,pick(hairlist),rgb(rand(50,200),rand(50,200),rand(50,200)))
			if(village=="Sand")
				//var/Objects/Effects/Chakra/Chakra = new
				//src.overlays.Add(Chakra)
				src.overlays+='pants.dmi'
				src.overlays+='Suna_Formal.dmi'
				src.overlays+='Sandals.dmi'
				//var/icon/A = pick('hair_mei.dmi','hair_hinata.dmi','hair_long.dmi','hair_sasori.dmi','hair_anko.dmi')
				//A += rgb(rand(50,190),rand(50,190),rand(50,190))
				//src.overlays+=A
			if(village=="Leaf")
				src.overlays+='pants.dmi'
				src.overlays+='shirt.dmi'
				src.overlays+='bluesandels.dmi'
			if(village=="Mist")
				src.overlays+='pants.dmi'
				src.overlays+='shirt.dmi'
				src.overlays+='Sandals.dmi'
				if(prob(30))
					src.overlays+='Shades.dmi'
				src.overlays+='ninjascarf.dmi'
			spawn(5) ai();//attackproc();defenseproc()

		/*Footprint(var/tmp/mob/P,_x,_y,_z,water=0)
			var/Objects/Effects/Footprints/F= new
			if(water)
				F.icon_state = "water"
				F.dir=P.dir
				F.loc=locate(_x,_y,_z)
				Ticks(5)
				animate(F,alpha=0,time=5*world.tick_lag)
				Ticks(5)
				del(F)
			else
				F.dir=P.dir
				//if(P.dir==8)
					//F.pixel_y=-16
				F.loc=locate(_x,_y,_z)
				Ticks(20)
				animate(F,alpha=0,time=40*world.tick_lag)
				Ticks(40)
				del(F)*/

MapTools
	parent_type = /turf
	Turfs
		Dense
			density=1
		dirt
			icon = 'newdirt.dmi'
			icon_state = "1,1"
		grass
			icon = 'newgrass.dmi'
			icon_state = "0,0"
			New()
				if(icon_state == "0,0")
					src.icon_state = pick("0,0","1,1","0,2","1,3","0,4","2,4")
		Mountain
			icon = 'Mountainridge2.dmi'
			density=1
		Sand
			icon = 'newsand.dmi'
			icon_state = "0,0"
			Exited(Player/M)
				if(ismob(M))
					spawn()
						M.Footprint(M,src.x,src.y,src.z)
		Water
			//icon = 'Water2.dmi'
			icon = 'flooring.dmi'
			icon_state="water"
			Click()
				if(istype(usr,/Player))
					var/Player/A = usr
					if(A.WaterReplace)
						var/Clone/C = new
						C.loc = A.loc
						A.loc = src
			Exited(Player/M)
				if(ismob(M))
					spawn()
						M.Footprint(M,src.x,src.y,src.z,water=1)
		Walls
			icon = 'house stuff.dmi'
			density = 1
		SandWalls
			//icon = 'SandHouse.dmi'
			density=1
			shadow=1
			New()
				GenerateShadow(src,EAST)
				..()
		Floor
			icon = 'Interior Floors.dmi'
			New()
				..()
	Interior
		icon = 'house stuff.dmi'
		Wall
			density=1
			layer = 6
		Chalkboard
			density=1
			layer=10
			icon = 'flooring.dmi'
		Stacks
			density=0
			layer=7
		Chairs
			density=0
			mouse_opacity=0
			layer=7
			shadow=1
			New()
				..()
				GenerateShadow(src,EAST)
		sides
			icon = 'SandRoofing.dmi'
			layer = 7
			density=0
		Shaders
			mouse_opacity=0
			icon = 'flooring.dmi'
			layer = 6
		Floor_Turf
			icon = 'flooring.dmi'
		Turfs
			icon = 'flooring.dmi'

	Connectors
		alpha=0
		var
			dir_need = NORTH
			connect
			slot=0
			interiors=0
			sound
				Music
		Entered(A)
			if(ismob(A))
				if(istype(A,/Player))
					var/Player/M = A
					if(M.dir == dir_need)
						//M << sound('Battle Open.ogg',volume = 20)
						if(Music)
							spawn(2)
								M << sound(Music,1,0,1,40)
						spawn(5)
							M.Fadeout(10)
						spawn(5)
							M.loc = locate(connect)
							M.interior = src.interiors
							M.OverworldHUD(M,"[TimeofDay]")
						//M << "[TimeofDay] [M.interior] HUH"

					return 1
				else
					var/mob/M = A
					if(!slot)
						if(M.dir == dir_need)
							M.loc = locate(connect)
						return 1
					else
						for(connect in world)
							var/MapTools/Connectors/a = connect
							if(a.slot==src.slot)
								M.loc = locate(connect)
							return 1
		Sand_Academy
			Entrance
				connect = /MapTools/Connectors/Sand_Academy/Exit
				interiors=1
				Music = 'Sand Academy.ogg'
			Exit
				dir_need=SOUTH
				connect = /MapTools/Connectors/Sand_Academy/Entrance
				interiors=0
				Music = 'Sand Village.ogg'
			TopFloor
				dir_need=SOUTH
				connect = /MapTools/Connectors/Sand_Academy/BottomFloor
				interiors=1
			BottomFloor
				connect = /MapTools/Connectors/Sand_Academy/TopFloor
				interiors=1
		Sand_Weap
			Entrance
				connect = /MapTools/Connectors/Sand_Weap/Exit
				interiors=1
			Exit
				dir_need=SOUTH
				connect = /MapTools/Connectors/Sand_Weap/Entrance
				interiors=0
Items
	parent_type = /obj
	Cross(mob/A)
		if(istype(A,/Player)&&can_pickup)
			spawn() src.Pickedup(A)
			//src.Pickedup(A)
			return 1
	var
		ammount
		can_pickup = 1
	proc
		Pickedup(Player/B)
			if(can_pickup)
				_message(B,"Loot","You found [src]","white",,"purple")
				//B << "You found [src]!"
				if(istype(src,/Items/Apparel))
					var/Items/Apparel/Item = new("[src]")
					B.Inventory += Item
				else
					var/Items/S = new src.type(0)
					B.Inventory +=S
				if(B.bagopen)
					B.contents_refresh()
				del(src)
				return 1
			else
				return 0


	Ryo
		//icon = ''
		ammount = 2000000
	Chakra_Paper
		//can_pickup=0
		icon = 'Chakracard.dmi'
		Click()
			AffinityPick(usr)



