
PixelMovement
	debug = 1

Player
	proc
		Interact()
			set hidden = 1
			Interacts = 1
			spawn()
				if(!src.loc&&usr.menuscreen)
					if(!created)
						alert(src,"Game is loading. Please wait.","Minimap Rendering")
						Interacts =0
						return
					Ticks(10)
					Interacts = 0
					src.menuscreen=0
					src.client.screen -= src.TitleScreens
					src.TitleScreens=new
					var/Player/P = src
					P.Start()
					. = 1
				else
					Interacts = 0
					var/Player/P = src
					P.Dash()

mob
	var
		Interacts = 0
		menuscreen = 0
		TitleScreens[3]


mob/proc/Title_Screen()
	src.loc=(null)
	src.menuscreen=1
	src << sound('Title Music.ogg',0,0,1,40)
	var/TitleScreen/Background/Background = new(src)

var/list/PassCode = list("Heyblinx","Demon Like Ninja","Lil Bop","Louisthe10")

Player
	proc
		Passcodes()
			for(var/text in PassCode)
				if(src.key == text)
					world.log << "[key] entered the game via passcode"
					return 1
			alert(src,"Sorry but the game is in private testing. Message Heyblinx for more info.")
			world.log << "[key] attempted to log in."
			spawn(5)
				del src
			return 0
Player/proc/Start()
	if(!world_connect)
		if(!Passcodes())
			return
	var/arenaon=0
	src.name =input(src,"What is your name?","Name Registration(Temp)") as text
	var/tmp/location_spawn = input(src, "Which village would you like to see?","Village Choice") in list("Leaf","Mist","Sand")
	src.village = location_spawn
	src.camera.mode = camera.FOLLOW
	switch(location_spawn)
		if("Leaf")
			src.HudAdd()
			src << sound('Leaf Village Overworld Music.ogg',1,0,1,40)
			if(_testing)
				src.loc = locate(68,2,8);src.interior=0//LEAF GATE
				src.AddSkill("Clone")
				src.AddSkill("Sharingan")
				src.AddSkill("Phoenix Flower")
				src.AddSkill("Rotation")
				src.AddSkill("Gunshot")
				src.AddSkill("Taigan")
				src.AddSkill("Water Clone")
				src.weathereffect="rain"
			/*var/Uchiha_Skills/Sharingan/Shar = new("Sharingan",1)
			src.HotKeys[1] = Shar
			src.Skillset[1] = Shar
			src.client.screen+=Shar
			var/Hud/Skill/Katon/Phoenix_Flower/PF = new("Phoenix Flower",2)
			src.Skillset[2] = PF
			src.HotKeys[2] = PF
			src.client.screen+=PF
			src.weathereffect="rain"
			Shar._hotkey=1
			PF._hotkey=1*/
			for(var/Hud_Object/Vill_Pic/F in src.client.screen)
				F.icon = 'LeafHUD.dmi'
			src.ActiveQuest[1] = "Talk to Jiraya"
			src.GiveItems("Kona Flak Jacket","Sandals","FishNet Undershirt","Baggy Pants")
			src.GiveItems("White Mask","White Cloak")
		if("Sand")
			src.HudAdd()
			src << sound('Sand Academy.ogg',1,0,1,40)
			src << sound('Ambience_Location_Interior_Big_Room.ogg',1,0,2,20)
			src.loc = locate(19,17,1)//SAND ACAD (Normal for Sand)
			if(_testing)
				src.AddSkill("Sand Control")
				src.AddSkill("Sand Flight")
				src.AddSkill("Sand Dome")
				src.weathereffect="sandstorm"
				src.AddSkill("Clone")
				for(var/Hud_Object/Vill_Pic/F in src.client.screen)
					F.icon = 'SandHUD.dmi'
				src.GiveItems("Suna Flak Jacket","Sandals","Suna Robes","Baggy Pants")
			//src.ActiveQuest[1] = "Talk to the Headmaster"
		if("Mist")
			src.HudAdd()
			src << sound('Mist Village Overworld.ogg',1,0,1,40)
			src.loc = locate(55,30,9);src.interior=0//MIST SPAWN
			if(_testing)
				src.weathereffect="medium fog"
				src.AddSkill("Water Clone")
				src.AddSkill("Clone")
				src.AddSkill("Taigan")
				src.AddSkill("Gunshot")
				src.AddSkill("Rotation")
			/*var/General_Skills/Clone/D = new("Clone Tech",1)
			D._hotkey=1
			src.Skillset.Add(D)
			src.HotKeys[1]=D
			src.client.screen+=D
			var/Hud/Skill/Suiton/WaterClone/Wclone = new("Water Clone Tech",2)
			Wclone._hotkey=2
			src.Skillset.Add(Wclone)
			src.HotKeys[2]=Wclone
			src.client.screen+=Wclone*/
			for(var/Hud_Object/Vill_Pic/F in src.client.screen)
				F.icon = 'MistHUD.dmi'
			src.GiveItems("Kiri Pants","Kiri Shirt","Sandals","Blue Battle Armor")
			src.ActiveQuest[1] = "Bring back wolf pelt to the Clothing Shop."
	var/tmp/res = input(src,"Would you like to go to the battle arena?","IN PROGRESS") in list("Yes","NO")
	if(res == "Yes")
		src.loc = locate(4,4,16)
	var/Items/Apparel/Hair/hair = new(src,pick(hairlist),rgb(200,200,200))
	src.loggedin=1
	if(key=="Heyblinx")
		src.village="Sand"
		src.move_speed=7
		_set_scheme("developer")
	winset(usr,"MainMap.map1","focus=true")
	if(arenaon)
		src.z = 2
	spawn(10) _message(src,"Motd","Welcome. Remember, this is in Pre-Alpha, which means pure development stage.","white",,"white")
	spawn(5)_message(world,"Login info","[src] has logged in.","purple",,"purple")
	world.log <<"[key] has logged in"
	spawn(5)_message(src,"HotKeys",
	{"Move:WASD or Arrow Keys
	Punch: F
	Kick:G
	OOC: T
	Inventory:B
	Tab: Target"},"purple",,"purple")
	//spawn(10)_message(world,"Update Log","Hotfix 0.02 coming in.","red",,"red")
	src.LoadChatGUI()
	src.client.perspective = EDGE_PERSPECTIVE
	if(src.key == "Heyblinx")
		src.icon = 'dark base.dmi'
		src.chakra_control = 100
	else
		src.icon = 'shinobi.dmi'
	var/Hud/SkillSlot/S = new(src)
	var/Hud/Effects/Black_Screen/screen = new()
	var/Hud/Effects/Weather/Weather=new()
	var/Quest_Log/Questlog=new(src)
	var/Hud/Data/Enemy_Text/T=new()
	var/Hud/Data/Enemy_Underlay/U=new(src)
	var/Hud/Effects/Sunlight/A = new()
	var/Hud/Effects/Moonlight/B = new()
	//E.icon_state = "Sharingan"
	screen.alpha=50
	src.client.screen+=screen
	src.client.screen+=Weather
	src.client.screen+=S

	//src.client.screen+=Questlog
	src.client.screen+=U
	src.client.screen+=T


	//src.client.screen+=G
	src.client.screen+=B
	src.client.screen+=A
	src.client.screen+=Questlog
	src.client.ResetGraphics()
	GenerateShadowMob(src,EAST)
	src.OverworldHUD(src,"[TimeofDay]")
	src.StartQuest("Start your Journey!")
	src.chakra = src.chakra_max
	src.health = src.health_max
	src.stamina = src.stamina_max
	Targeting()

client/verb/Reset_Graphics()
	src.ResetGraphics()
client
	verb
		Toggle_Fullscreen()
			set hidden = 1
			var/Player/Player = usr
			if(!Player.fullscreen)
				Player.fullscreen = 1
				winset(src,"default","is-maximized=true")
			else
				Player.fullscreen = 0
				winset(src,"default","is-maximized=false")

client/proc/ResetGraphics()
	winset(src, null, "command=\".configure graphics-hwmode off\"")
	sleep(2)
	winset(src, null, "command=\".configure graphics-hwmode on\"")

TitleScreen
	parent_type = /obj
	alpha = 0
	Kunai_Effect
		icon = 'Shuriken Effect.png'
		//screen_loc ="Center+1:-8,NORTH-6:2"
		screen_loc ="3,11:24"
	Name_Logo
		icon = 'Title2.png'
		screen_loc ="CENTER-9,SOUTH+12"
	Background
		icon = 'Background(3).png'
		screen_loc="WEST,SOUTH"
		New(var/Player/P)
			..()
			var/Hud_Object/Version/V = new("Heyblinx")
			var/TitleScreen/Name_Logo/Logo = new
			var/TitleScreen/Developer/Signature = new
			var/TitleScreen/Kunai_Effect/Kunai = new
			var/TitleScreen/Text/Enter = new
			var/matrix/m = matrix()
			var/matrix/m2 = matrix()
			m=m.Translate(640,0)
			P.client.screen += V
			P.client.screen += Signature
			P.TitleScreens += Signature
			P.client.screen += Kunai
			P.TitleScreens += Kunai
			animate(Signature,alpha=255,time=20)
			spawn()
				while(P.menuscreen)
					Ticks(10)
				goto END
			sleep(35)
			animate(Signature,alpha=0,time=20)
			sleep(40)
			P.client.screen += src
			P.TitleScreens += src
			P.client.screen += Logo
			P.TitleScreens+= Logo
			P.client.screen += Enter
			P.TitleScreens += Enter
			animate(src,alpha=255,time=50)
			sleep(50)
			animate(Logo,alpha=255,time=20)
			animate(Enter,alpha=150,time=10)
			sleep(20)
			animate(Enter,alpha=255,time=10,loop=-1)
			animate(Kunai,transform = turn(m2,290),time=5)
			animate(Kunai,alpha=255,transform = m,time=2)
			P << sound('Kunai Sound Effect.ogg',0,0,3,60)
			END
				if(!P.menuscreen)
					del(src)
	Text
		screen_loc= "Center-5,SOUTH"
		alpha = 0
		plane=2
		maptext_width = 360
		maptext_height = 360
		maptext = "<font size=+3><center>Press Space to begin.."
	Developer
		icon = 'Pheris Logo.png'
		maptext_width =400
		maptext_y=-160
		maptext_x=-160
		maptext_height = 200
		screen_loc = "CENTER,CENTER+2"
		maptext = "<font size=+3><center>Project In Development By \n Heyblinx \n \n Music By \n Adrian von Ziegler"