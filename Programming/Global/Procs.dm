proc
	PunchEffect(var/atom/A)
		sleep(2)
		var/tmp/_x = rand(-5,3)
		var/tmp/_y = rand(-12,8)
		var/FX/Punch/P = new(A.loc)
		P.SetCenter(A)
		P.px+=_x
		P.py+=_y
		//P.loc = locs
		sleep(3)
		del(P)
		return
	_underscoreremove(var/text)
		if(findtext(text,"_"))
			text = replacetext(text,"_"," ")
		return text
	_underscoreadd(var/text)
		if(findtext(text," "))
			text = replacetext(text," ","_")
		return text

	Load_Data(var/table,var/_name)
		var/sql4dm/SqliteDatabaseConnection/conn = new("ProjectNindo.db")
		switch(table)
			if("Item")
				var/sql4dm/ResultSet/Q = conn.Query("SELECT * FROM ItemList WHERE ItemName = '[_name]'")
				while(Q.Next())
					var/itemtype = Q.GetString("Type")
					if(itemtype == "Clothing")
						var/Items/Apparel/A = new(_name)
						return A
			if("Skill")
				var/sql4dm/ResultSet/Q = conn.Query("SELECT * FROM SkillData WHERE SkillName = '[_name]'")
				while(Q.Next())
					//var/SkillType = Q.GetString("SkillType")
					//var/SkillName = Q.GetString("SkillName")
					//world.log << SkillType
					var/Hud/Skill/A = new(_name)
					return A
			//	var/sql4dm/ResultSet/Q = conn.Query("SELECT * FROM ItemList WHERE ItemName = '[_name]'")
			if("Quest")
				var/sql4dm/ResultSet/Q = conn.Query("SELECT * FROM QuestData WHERE QuestTitle = '[_name]'")
				while(Q.Next())
					//var/QuestName = Q.GetString("QuestTitle")
					var/Quest/_quest = new(_name)
					return _quest
		//	if("Village")
		//		var/sql4dm/ResultSet/Q = conn.Query("SELECT * FROM ItemList WHERE ItemName = '[_name]'")

FX
	parent_type = /obj
	Punch
		icon = 'puncheffect.dmi'
		plane=3
Visuals
	parent_type = /obj
	layer=5


Player
	set_state()
		if(flight)
			icon_state="bird"
		else
			..()
	proc
		AppearenceReset()
		RefreshSkills()
			var/yy = 0
			var/iconlist = list()
			//for(var/Hud/Skill/a in typesof(/Hud/Skill))
				//if(a.Skill_Name == src.Skill_Name)
					//src = a
			for(var/Hud/Skill/_skill in src.HotKeys)
				if(_skill.slotnum<=10)
					_skill.screen_loc = "CENTER-4+[_skill.slotnum-1]:[10+_skill.slotnum],1+[yy]:5"
					for(var/i in icon_states(_skill.icon))
						iconlist+=i
					if(_skill.Skill_Name in iconlist)
						_skill.icon_state = "[_skill.Skill_Name]"
					else
						_skill.icon_state = "."
					_skill.name = _skill.Skill_Name
					_skill.maptext = _skill.slotnum
					_skill.maptext_x = 24
					_skill.maptext_y = -4
					_skill.maptext_height = 16
					//_skill._hotkey=_skill.slotnum
					//src.HotKeys[_skill.slotnum]= _skill
					src.client.screen += _skill
					//slotnum = slotnum + xx

		Fadeout(timer=10)
			if(nonplayer)return
			var/Hud/Effects/Black_Screen/B = new
			B.alpha = 255
			src.client.screen += B
			src.movement_locked=1
			animate(B,alpha=0,time=timer)
			sleep(timer)
			del(B)
			src.movement_locked=0
		AddSkill(var/skillname)
			var/Hud/Skill/K = Load_Data("Skill",skillname)
			//_Skill = new _Skill
			K.slotnum = length(src.Skillset) +1
			if(K.slotnum<=9)
				K._hotkey=K.slotnum
				src.HotKeys[K.slotnum] = K
			src.Skillset+=(K)
			RefreshSkills()
			//if(K.slotnum<=9)
				//K._hotkey=K.slotnum
				//src.HotKeys[K.slotnum] = K
				//src.client.screen += K
		StartQuest(var/QuestName)
			var/Quest = Load_Data("Quest",QuestName)
			if(src._quests>=5)
				_message(src,"Quest info","You have too many quests!")
				return
			else
				src._quests++
				_message(src,"Quest info","You have started the quest [QuestName]!")
				ActiveQuest[_quests] = Quest
			/*if(!src.ActiveQuest)
				ActiveQuest[1] = Quest
			else
				if(length(src.Quests>=5))
					_message(src,"Quest info","You have too many quests!")
					return
				for(var/i=1,i<5, i++)
					if(length(src.ActiveQuest)>=i)continue
					else
						src.ActiveQuest[i] = Quest
						break*/
				src.UpdateQuestLog()
		ChangeHair(var/HairID,Color)

		GiveItems(var/item_name1,var/item_name2 = null,var/item_name3 = null,var/item_name4 = null)
			var/Items/item1 = Load_Data("Item",item_name1)
			if(item1._type=="Clothing")
				var/Items/Apparel/_trueitem1 = new(item_name1)
				src.Inventory+= _trueitem1
			if(item_name2 != (null))
				var/Items/item2 = Load_Data("Item",item_name2)
				if(item2._type=="Clothing")
					var/Items/Apparel/_trueitem2 = new(item_name2)
					src.Inventory+= _trueitem2
			if(item_name3 != (null))
				var/Items/item3 = Load_Data("Item",item_name3)
				if(item3._type=="Clothing")
					var/Items/Apparel/_trueitem3 = new(item_name3)
					src.Inventory+= _trueitem3
			if(item_name4 != (null))
				var/Items/item4 = Load_Data("Item",item_name4)
				if(item4._type=="Clothing")
					var/Items/Apparel/_trueitem4 = new(item_name4)
					src.Inventory+= _trueitem4
		Knockback(var/Player/P,pix)
			var/tmp/pix_x = 0
			var/tmp/pix_y= 0
			switch(P.dir)
				if(NORTH)
					pix_y = pix
				if(SOUTH)
					pix_y = -pix
				if(EAST)
					pix_x = pix
				if(WEST)
					pix_x = -pix
			src.vel_x = pix_x
			src.vel_y = pix_y

Grid
	parent_type = /obj
	icon = 'InvGui.dmi'
	var/used = 0
	var/Items/Apparel/item
	var/Hud/Skill/Skillcard
	Click()
		if(usr.client._leftclick)
			if(item)
				if(item.worn)
					usr.overlays -= item
					item.worn=0
					RemoveShadow(usr)
					GenerateShadowMob(usr,EAST)
					icon_state=""
					src.maptext = ""
				else if(!item.worn)
					usr.overlays += item
					item.worn=1
					RemoveShadow(usr)
					GenerateShadowMob(usr,EAST)
					icon_state="worn"
		else if(usr.client._rightclick)
			if(item)
				var/Player/Player = usr
				if(item.worn)
					_message(Player,"loot info","You can not remove an item you are wearing!")
					return
				else if(!item.worn)
					item.loc = Player.loc
					_message(usr,"loot info","You dropped [_underscoreremove(item)] on the ground!")
					Player.Inventory.Remove(item)
					item=(null)
					used=0
					Player.contents_refresh()
					//src.maptext = "<font color=yellow><u><b>E"
	MouseDrop(var/atom/a,src_location,var/atom/Location,src_control,map1,params)
		if(istype(a,/Player))
			var/Player/Reciver = a
			var/Player/Player = usr
			if(src.item)
				if(src.item.worn)
					_message(usr,"loot info","You can not remove an item you are wearing!")
					return
				if(Reciver)
					if(Reciver!=Player)
						Reciver.Inventory.Add(src.item)
						Reciver.contents_refresh()
						_message(usr,"loot info","You given [Reciver] your [src.item].")
						Player.Inventory.Remove(src.item)
						src.item=new()
						Player.contents_refresh()
			else if(src.Skillcard)
			else
				var/tmp/Items/Item = src.item
				Item.loc = Player.loc
				_message(Player,"loot info","You dropped [Item] on the ground!")
				Player.Inventory-=src.item
				src.item=new()
				Player.contents_refresh()
				return
	MouseEntered()
		if(item&&item.description)
			winset(usr,"Backpack.ItemText","text=\"[item.name]:[item.description]")
		else
			if(Skillcard)
				winset(usr,"Backpack.ItemText","text=\"[Skillcard.Skill_Name]:[Skillcard.Description]")
			else
	New(var/Player/P)
		if(P.bagtype=="Skills")
			src.icon_state="white"
		..()


Player
	var
		bagopen=0
		BagHud=list()
		bagtype="Inventory"
		slots = "Clothing"
	proc
		contents_refresh()
			if(src.BagHud)
				src.client.screen -= src.BagHud
			for(var/Column = 5; Column >=1; Column--) for(var/Row = 0 to 4)
				var/Grid/G = new(src)
				G.screen_loc = "Backpack:[Row],[Column]"
				src.client.screen += G
				src.BagHud+=G
			if(bagtype=="Inventory")
				for(var/atom/P in src.Inventory)
					src.AddInv(P)
			if(bagtype == "Skills")
				for(var/Hud/Skill/P in src.Skillset)
					src.AddSkills(P)
		AddInv(Items/Apparel/P)
			for(var/Grid/G in src.client.screen)
				if(G.used) continue
				P.screen_loc = G.screen_loc ;P.mouse_opacity=0; src.client.screen+=P ;src.BagHud+=P;G.item = P
				//src << "[P]"
				if(P.worn)
					G.icon_state="worn"
				G.used =1; return
		AddSkills(Hud/Skill/P)
			for(var/Grid/G in src.client.screen)
				if(G.used) continue
				var/Hud/Skill/N = new(P.Skill_Name)
				/*N.icon_state = P.icon_state
				N.Skill_Name = P.Skill_Name
				N.Description = P.Description
				N.Skill_Name =
				//N.icon_state="[Skill_Name]"
				N.Stat_Usage =createq.GetString("Stat Usage")
				N.Description =createq.GetString("Description")
				N.Power =createq.GetNumber("Power")
				N.Rank =createq.GetString("Rank")
				N.UsesNeeded =createq.GetNumber("UsesNeeded")
				N.Seals_Needed =createq.GetNumber("Seals Needed")
				N.Cooldown =createq.GetString("Cooldown")
				N.Chakra_Control_Trigger =createq.GetString("Control Trigger")
				N.MaxLevel =createq.GetString("MaxLevel")
				//src.SkillType =createq.GetString("SkillType")
				N.Drain =createq.GetString("Drain")
				N.Skill_Category =createq.GetString("Skill Category")*/
				N.maptext=""
				N.alpha=255
				N.screen_loc = G.screen_loc ; src.client.screen+=N ;src.BagHud+=N;G.Skillcard = N
				//src << "[P]"
				G.used =1; return
	proc
		BagOpens()
			var/tmp/Player/P = src
			if(!P.bagopen)
				P.contents_refresh()
				winset(P,"Inventory","is-visible=true")
				//winset(P,"Inventory","transparent-color = #000")
				P.bagopen=1
				//P.contents_refresh()
			else
				winset(P,"Inventory","is-visible=false")
				P.bagopen=0
	verb
		CategorySwitch(var/side as text)
			var/tmp/Player/P = usr
			switch(side)
				if("Main")
					if(src.bagtype=="Inventory")
						src.bagtype="Skills"
						src.slots="All"
					else
						src.bagtype="Inventory"
						src.slots="Clothing"
					winset(P,"Backpack.Label1","text=\"[src.bagtype]\"")
					winset(P,"Backpack.Label4","text=\"[src.slots]\"")
					P.contents_refresh()
				//if("Main")
				//if("Sub Left")
				//if("Sub Right")
		FullScreen()
			var/Player/Player = src
			if(!Player.fullscreen)
				Player.fullscreen = 1
				Player.client.view = "37x21"
				winset(src,"Mainwindow","is-maximized=true")
				winset(src,"MainMap","is-maximized=true")\
				//src.view = "22x
			else
				Player.fullscreen = 0
				winset(src,"Mainwindow","is-maximized=false")
				winset(src,"MainMap","is-maximized=true")
				Player.client.view = "32x22"
/*Non_Player
	proc/
		Talk(var/Player/P)
			src.dir = turn(P.dir, 180)
			//_message(usr, src, "Welcome! press 1,2,3 to try hotkey moves")

*/
Player
	verb
		//MOVEMENT
		NewNorth(var/run as num)
			set hidden=1;set instant=1
			if(src.Movement) return
			if(src.movement_locked) return
			src.Movement =1
			if(run)
				src.icon_state = "Run"
			else
				src.icon_state = ""
			step(src,NORTH)
			if(run)
				Ticks(src.RunSpeed)
			else
				Ticks(src.WalkSpeed)
			src.Movement=0
		NewSouth(var/run as num)
			set hidden=1;set instant=1
			if(src.Movement) return
			if(src.movement_locked) return
			src.Movement =1
			if(run)
				src.icon_state = "Run"
			else
				src.icon_state = ""
			step(src,SOUTH)
			if(run)
				Ticks(src.RunSpeed)
			else
				Ticks(src.WalkSpeed)
			src.Movement=0
		NewEast(var/run as num)
			set hidden=1;set instant=1
			if(src.Movement) return
			if(src.movement_locked) return
			src.Movement =1
			if(run)
				src.icon_state = "Run"
			else
				src.icon_state = ""
			step(src,EAST)
			if(run)
				Ticks(src.RunSpeed)
			else
				Ticks(src.WalkSpeed)
			src.Movement=0
		NewWest(var/run as num)
			set hidden=1;set instant=1
			if(src.Movement) return
			if(src.movement_locked) return
			src.Movement =1
			if(run)
				src.icon_state = "Run"
			else
				src.icon_state = ""
			step(src,WEST)
			if(run)
				Ticks(src.RunSpeed)
			else
				Ticks(src.WalkSpeed)
			src.Movement=0
	proc
		HotKey(var/number)
			set hidden =1
			set instant=1
			var/Player/P = src
			if(!HotKeys[number])
				_message(P,"Skill Info","You do not have a skill in this skillslot!.","white",,"white")
				return
			if(length(P.HotKeys) < number) return
			var/tmp/Hud/Skill/Skillcard = P.HotKeys[number]
			if(P.firing) return
			if(Skillcard.in_cooldown&&!P.activeskills.Find("[Skillcard.Skill_Name]"))
				_message(usr,"Skill Info","This skill is still on cooldown for [Skillcard.cooldown_remaining] seconds","white",,"white")
			else
				P.firing=1
				Execute(P.HotKeys[number],P)
				return

/*
//////////////////////////////////////
             JUTSU EXECUTION PROCS
/////////////////////////////////////
*/


	proc
		Execute(var/Hud/Skill/Tech,Player/Player)
			Player.firing=1
			var/statmod = Stat_Gain(lowertext("[Tech.Style]"))
			spawn(20)
				Player.firing=0
			//if(Tech.in_cooldown&&!Tech.Skill_Name in Player.activeskills) return
			if(!Tech._hotkey)
				_message(Player,"Skill Info" ,"This is just a container for jutsu. Please attach to a hotkey to use it.","white",,"white")
				return
			if(Tech._Triggered&&Player.activeskills.Find("[Tech.Skill_Name]"))
				var/_triggered = Tech._Triggered
				world.log << "[_triggered] 2"
				call(Player,"[_underscoreadd(Tech.Skill_Name)]")(statmod,Tech.Cooldown,_triggered,Tech.level,Tech.Power)
				return
			if(!VitalCheck("[Tech.Stat_Usage]",Tech.Drain)) return
			if(!SealCheck(Tech.Seals_Needed)) return
			if(!ControlCheck(Tech.Chakra_Control_Trigger,Tech.Drain)) return
			if(Tech.in_cooldown&&!Player.activeskills.Find("[Tech.Skill_Name]"))return
			Tech.in_cooldown=1
			spawn()
				//Tech.in_cooldown=1
				Tech.uses++
				if(Tech.uses >= Tech.UsesNeeded)
					Tech.level++
					Tech.UsesNeeded = Tech.UsesNeeded*2
					_message(src,"Move Information","[Tech.Skill_Name] has increased its level to [Tech.level]!",,,"red")
				spawn(1)
					if(Timer(Tech.Cooldown,Tech,Player)==1)
						_message(src,"Move Information" , "You can use [Tech.Skill_Name] again!",,,"red")
						Tech.in_cooldown=0
				world.log << "[Tech._Triggered]"
				call(Player,"[_underscoreadd(Tech.Skill_Name)]")(statmod,Tech.Cooldown,Tech._Triggered,Tech.level,Tech.Power)

/*
		if(S)
			var/tmp/_timelog=world.timeofday
			do
				sleep(1)
				S.cooldown_remaining =(_timelog+(time)-world.timeofday)
			while(_timelog+time>world.timeofday)
			return 1
*/
		Skill_Use(_Name,_Type,_stat,_in_cooldown,_cooldown,_jutsuuse,_seals)
			usr.firing=1
			if(_in_cooldown)
				usr << "You must wait!" ;return
			if(!VitalCheck(_Type,_stat)) return
			if(!SealCheck(_seals)) return
			if(!ControlCheck(1,_stat)) return
			var/statmod = Stat_Gain(_Type)
			spawn()
				call(usr,"[_Name]")(statmod,_cooldown)
				var/Player/P = usr
				for(var/tmp/i=1 to 5)
					if(P.Skills[i][1] == _Name)
						P.Skills[i][4]=0
						if(Timer(_cooldown)==1)
							P.Skills[i][4]=0
			Ticks(15)
			usr.firing=0

/*		Add_Skill(Skill_Name)
			var/_skillpath
			var/_skill
			for(var/skill in /Skill)
				if(skill == Skill_Name)
					_skillpath = skill.type
					_skill = new skill[length(src.Skillset)+1]*/



/*			var/Sand/SandControl/Sand = new("SandControl",1)
			Sand._hotkey=1
			src.Skillset[1]=Sand
			src.HotKeys[1] = Sand
			src.client.screen += Sand*/

		Exp_Gain()
			var/_exp
			/*
			calc exp gains
			variables:
			world gains
				exp booster(1-3)

			player gains
				Rank(1-5)
				affinity(0-2)
				focus(0 or 5)
			Battle gains
				training (1)
				sparing (2)
				combat (4)
	parent function
		exp = log(x)


			*/

		Stat_Gain(_style,tier=1,exp=1)
			for(var/varcheck in src.vars)
				if(findtext(varcheck,_style)) continue
			if(exp)
				src.vars["[lowertext(_style)]_exp"] += 5*tier
				var/tmp/_stat = src.vars[_style]
				var/tmp/_exp = src.vars["[_style]_exp"]
				while(_exp >_stat * 5)
					_stat++
				if(src.vars[_style] != _stat)
					src.vars[_style] = _stat++
					src.vars["[_style]_exp"]=0
					_message(src,"System Information" , "Your [_underscoreremove(_style)] has leveled up to [src.vars[_style]]!",,,"red")
				return src.vars[_style]
			else
				src.vars[_style] += 1 * tier
				_message(src,"System Information","Your [_underscoreremove(_style)] has increased to [src.vars[_style]]!",,,"red")


		VitalCheck(_Type="chakra",_cost)
			var/tmp/response ="chakra"
			switch(_Type)
				if("Chakra"||"Dojutsu")
					if(src.chakra >= _cost)
						src.chakra -= _cost
						return 1
				if("Genjutsu"||"Chakra")
					if(src.chakra >= _cost)
						src.chakra -= _cost
						return 1
				if("Taijutsu")
					if(src.stamina >= _cost)
						src.stamina -= _cost
						return 1
					response = "stamina"
				if("special")
					if(src.health >= _cost)
						src.health -= _cost
						return 1
					response = "health"
			_message(src, , "You do not have enough [response] for this.::[_cost]/[chakra]",,,usr.name_color)
			return

		SealCheck(Seals_Needed = 0)
			if(Seals_Needed)
				while(src.Move()!=1)
					_message(src, , "You attempt the handseals...",,,usr.name_color)
					Ticks(50)
					if(prob(src.sealmastery))
						if(src.sealmastery<100)
							Stat_Gain("sealmastery")
						return 1
					else
						_message(src, , "Your hands slip!",,,usr.name_color)
						return 0
				_message(src, , "You lost concentration by moving!...",,,usr.name_color)
				return 0
			else
				return 1

		ControlCheck(ifneeded=1,chakrause=0)
			if(!ifneeded)
				return 1
			else if(prob(src.chakra_control))
				if(src.chakra_control<100)
					Stat_Gain("chakra_control",3,0)
				world.log << "chakracontrolled"
				return 1
			else
				var/tmp/newc = rand(1,10)
				if(prob(50))
					_message(src, , "You did not mold enough chakra and the jutsu failed.",,,usr.name_color)
					src.chakra-= chakrause * (newc/10)
					return 0
				else
					_message(src, , "You used much more chakra than needed for this jutsu!",,,usr.name_color)
					src.chakra-= chakrause/2
					Stat_Gain("chakra_control",1,0)
					return 1

		Title_Screen2()
			//src << sound('Title Screen(Itachi Theme).ogg',channel=1,volume=30)
			src.loc = (null)
			var/Screens/Title/T = new
			var/Screens/Start/S = new
			src.client.screen += T
			animate(T,alpha=255,time=40)
			Ticks(40)
			T.alpha=255
			Ticks(30)
			src.client.screen += S
			animate(S,alpha=255,time=20)
			Ticks(20)
			S.alpha=255

			Ticks(120)
		Footprint(var/tmp/mob/P,_x,_y,_z,water=0)
			var/Objects/Effects/Footprints/F= new
			if(P.client&&P.vars["flight"])
				return
			if(water)
				F.icon_state = "water"
				F.dir=P.dir
				F.SetCenter(P)
				sleep(5)
				animate(F,alpha=0,time=5)
				sleep(5)
				del(F)
			else
				F.dir=P.dir
				F.SetCenter(P)
				Ticks(20)
				animate(F,alpha=0,time=40)
				sleep(40)
				del(F)
var
	WeatherOn=0
proc
	Timer(var/tmp/time=0,var/Hud/Skill/S=(null),var/Player/P=(null))
		set background=1
		if(S)
			S.cooldown_remaining=time
		if(P)
			if(S in P.client.screen)
				S.alpha=30
				animate(S,alpha=150,time=time)
		do
			Ticks(10,1)
			time--
			if(S)
				S.cooldown_remaining = time
		while(time>=0)
		if(S)
			S.cooldown_remaining=0
			S.alpha=150
		return 1
	applycommas(number)
		number=round(number,1)
		number=num2text(number,1000)
		var/digits=length(number)
		var/remaining=0
		var/returnnumber
		while(digits>=1)
			if(digits>3)
				var/end=","+copytext(number,digits-2,digits+1)
				var/get=end
				returnnumber=get+returnnumber
				remaining=(length(get)-1)+remaining
				digits-=3
			else
				var/get=copytext(number,1,(length(number)+1)-remaining)
				returnnumber=get+returnnumber
				digits=0
		return returnnumber
	Multi_Hud(var/mob/A,var/Hud/S,wid,high)
		var/lens = length(icon_states(S.icon))
		var/iconstates = new/list()
		var/list/maxy = new/list()
		for(var/texts in icon_states(S.icon))
			iconstates+=texts
		var/loc_check
		for(var/i=1 to lens)
			loc_check = splittext(iconstates[i], ",")
			maxy.Add(text2num(loc_check[2]))
		for(var/i=1 to lens)
			loc_check = splittext(iconstates[i], ",")
			var/Hud/N = new S.type(A,0)
			N.icon_state = "[loc_check[1]],[loc_check[2]]"
			N.screen_loc = "[wid] + [loc_check[1]],[high] +[loc_check[2]]"
			A.client.screen +=N
Player
	var
		dashdistnormal=3
		tmp/todash=0
		tmp/amdashing=0
		tmp/s=3
	proc
		Dash(dashdistnormal=5)
			var/Player/P = src
			if(src.todash==0&&P.can_dash())
				P.todash=1
				//var/returndistance=usr.dashdistnormal
				//usr.dashdistnormal=3
				//usr<<"You prepare to dash!"
				P.amdashing=1
				if(src.Target&&!src._Movement_locked)
					src.dir = get_dir(src,Target)
				P.dash(P.dashdistnormal,P.dir)
				P.amdashing=0
				//usr.dashdistnormal=returndistance
				spawn(12)
					P.todash=0
					//usr<<"You can now dash again."




#define DASH_COOLDOWN 8 // 10 seconds
#define DASH_STAMINA_DRAIN 50

Player
	var/tmp/last_dash = 0

	proc
		get_dash_distance(var/distance)
			return distance

		can_dash()
			if(last_dash) return 0

			if(DASH_STAMINA_DRAIN >= stamina)
				_message(src,,"You do not have enough stamina to dash!")
				return 0

			stamina -= DASH_STAMINA_DRAIN
			return 1

		dash(distance, dir)
			if(!can_dash(src)||amdashing==0)
				return

			distance = distance || get_dash_distance(distance)
			distance = dashdistnormal
			last_dash=1
			world.log << "Dash Fired"
			if(distance<1)
				distance=1

			for(var/i in 1 to distance)
				afterimage_effect(loc, src, state = icon_state, dir = dir)
				step(src, dir)
				sleep(world.tick_lag)

			if(Timer(DASH_COOLDOWN)==1)
				world.log<<"Dash Cooldown"//= world.time - DASH_COOLDOWN - (world.tick_lag * distance)//was world.time + DASH_COOLDOWN + (world.tick_lag * distance)
				last_dash=0

proc/afterimage_effect(turf/loc, atom/movable/user, fade_time = 20,
	state,
	dir,
	pixel_x = 0, pixel_y = 0
	)

	var/obj/temp = new/obj {alpha = 160} (loc)
	temp.icon = user.icon
	temp.overlays = user.overlays
	temp.underlays = user.underlays
	temp.icon_state = state
	temp.dir = dir
	//temp.step_x = step_x
	//temp.step_y = step_y
	temp.pixel_x = pixel_x
	temp.pixel_y = pixel_y

	animate(temp, alpha = 0, time = fade_time)
	spawn(fade_time) if(temp) temp.loc = null

mob
	var
		tmp/dashcheck=0

/*Player/Move()
	..()
	if(src.client)
		//if(!src.move)
		if(src.dashcheck&&!src.amdashing)
			if(src.dir==dashcheck)
				src.amdashing=1
				spawn()
					src.dash(3,src.dir)*/

atom/proc
	OverPut(obj/M,time=null)
		set waitfor = FALSE
		src.overlays+=M
		if(time)
			sleep(time)
			src.overlays-=M
	UnderPut(obj/M,time=null)
		set waitfor = FALSE
		src.underlays+=M
		if(time)
			sleep(time)
			if(M) src.underlays-=M
	UnderTook(obj/M,time=null)
		set waitfor = FALSE
		underlays-=M
		if(time)
			sleep(time)
			underlays+=M
	OverTook(obj/M,time=null)
		set waitfor = FALSE
		overlays-=M
		if(time)
			sleep(time)
			overlays+=M
	Delete(time=0)
		set waitfor=FALSE
		sleep(time)
		del(src)
	Dissapate(time,delete)
		set waitfor=FALSE
		animate(src,alpha=0,time=time)
		if(delete)
			sleep(time)
			Delete(src)


