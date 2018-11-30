
Quest_Log
	parent_type = /Hud/Effects
	maptext_width = 320
	maptext_height=320
	maptext_x = -320
	maptext = ""
	screen_loc="EAST,NORTH-8"
	alpha=255
	New(Player/Player)
		..()
		src.maptext = "<div align=\"right\"><u><b>Current Objective</b></u>\n---------------------------------\n"

Dialouge

/*<span Style=\"text-decoration: underline;text-align: right;font-weight: bold;\">Quest Log</span>\n[src.activequest[q]"
<div align=\"right\"><u><b>Quest Log</b></u>\nTalk to the Headmaster<ddiv>*/

Hud
	Effects
		var
			DAY = 180
			NIGHT = 0
			INTERIOR = 0
		mouse_opacity=0
		alpha = 0
		Black_Screen
			var/WEATHER=60
			DAY = 0;INTERIOR=20;NIGHT = 180
			plane=2
			icon = 'Black.dmi'
			screen_loc = "WEST,SOUTH to EAST,NORTH"
			layer = MOB_LAYER+5
			alpha = 0
		Weather
			var
				_weather="rain"
			DAY=255;NIGHT=255
			plane=1
			icon = 'Weathereffects.dmi'
			icon_state= ""
			screen_loc = "WEST,SOUTH to EAST,NORTH"
			layer = MOB_LAYER+5
			alpha = 0
		Sunlight
			icon='sunglare.png'
			DAY=255
			screen_loc = "WEST,NORTH-13:16"
			alpha = 0
			plane=3
			layer = FLOAT_LAYER
			New()
		Moonlight
			icon='moonlight.dmi'
			screen_loc = "WEST+8,NORTH-13:16"
			NIGHT=255;DAY=0
			alpha = 0
			plane=3
			layer = FLOAT_LAYER
			New()
				var/tmp/icon/A = new('moonlight.dmi')
				//A.MapColors(rgb(51,13,13), rgb(26,77,51), rgb(26,26,102), rgb(0,0,0))
				A.MapColors(rgb(71,33,33), rgb(46,97,71), rgb(46,46,122), rgb(0,0,0))
				src.icon=A
	Data
		Enemy_Hud
			icon='TargetBars.dmi'
			icon_state="0,0"
			New(var/mob/a,c=1,target)
				if(c)
					Multi_Hud(a,src,"CENTER-2","NORTH")
					..()
		Enemy_Underlay
			icon='Thealthunderlay.dmi'
			icon_state="0,0"
			alpha=0
			New(var/mob/a,c=1)
				if(c)
					Multi_Hud(a,src,"CENTER-2","NORTH")
					..()
		Enemy_Text
			screen_loc= "CENTER-2:-8,NORTH:-8"
			maptext_width=200
			maptext="Name here"
			alpha=0
Player/proc
	OverworldHUD(Player/Player,alpha_set)
		if(src.client)
			if(src.interior)
				for(var/Hud/Effects/Sunlight/S in Player.client.screen)
					S.alpha=S.INTERIOR
				for(var/Hud/Effects/Moonlight/M in Player.client.screen)
					M.alpha=M.INTERIOR
				for(var/Hud/Effects/Black_Screen/B in Player.client.screen)
					B.alpha=B.INTERIOR
				for(var/Hud/Effects/Weather/W in Player.client.screen)
					W.alpha=W.INTERIOR
			else
				if(alpha_set=="Day")
					for(var/Hud/Effects/Moonlight/M in Player.client.screen)
						M.alpha=M.DAY
					for(var/Hud/Effects/Black_Screen/B in Player.client.screen)
						B.alpha=B.DAY
					for(var/Hud/Effects/Sunlight/S in Player.client.screen)
						S.alpha=S.DAY
					for(var/Hud/Effects/Weather/W in Player.client.screen)
						W.alpha=W.DAY
						W.icon_state=Player.weathereffect
				if(alpha_set=="Night")
					for(var/Hud/Effects/Moonlight/M in Player.client.screen)
						M.alpha=M.NIGHT
					for(var/Hud/Effects/Black_Screen/B in Player.client.screen)
						B.alpha=B.NIGHT
					for(var/Hud/Effects/Sunlight/S in Player.client.screen)
						S.alpha=S.NIGHT
					for(var/Hud/Effects/Weather/W in Player.client.screen)
						W.alpha=W.NIGHT
						W.icon_state=Player.weathereffect
	UpdateQuestLog()
		for(var/Quest_Log/Quest in src.client.screen)
			Quest.maptext="<div align=\"right\"><u><b>Current Objective</b></u>\n---------------------------------\n"
			for(var/i=1,i<=src._quests,i++)
				var/tmp/Quest/quest = src.ActiveQuest[i]
				Quest.maptext+="<b><center>[quest.QuestName]</center></b>\n[quest.Description]"


mob
	proc
		animateRay(var/ray="Sun")

		LightingEffect(day=1)
			switch(day)
				if(1)
					for(var/Hud/Effects/Moonlight/M in src.client.screen)
						M.alpha=0
					for(var/Hud/Effects/Black_Screen/B in src.client.screen)
						B.alpha=50
					for(var/Hud/Effects/Sunlight/S in src.client.screen)
						S.alpha=255
					_message(src, "Time","The Sun has risen.","yellow",,"yellow")
				if(3)
				if(2)
					for(var/Hud/Effects/Moonlight/M in src.client.screen)
						M.alpha=255
					for(var/Hud/Effects/Black_Screen/B in src.client.screen)
						B.alpha=180
					for(var/Hud/Effects/Sunlight/S in src.client.screen)
						S.alpha=0
					_message(src, "Time","The Sun has set.","grey",,"yellow")
					src << "The sun has set."
proc
	DayTimer(starts=1,Time=1)
		if(Timer(Time*60))
			starts++
			if(starts >2)
				starts=1
			if(starts==1)
				TimeofDay="Day"
				_message(world, "","The Sun has risen.","grey",,"yellow")
			else
				_message(world, "","The Sun has set.","grey",,"yellow")
				TimeofDay="Night"
			for(var/Player/P in world)
				P.OverworldHUD(P,"[TimeofDay]")
			DayTimer(starts,Time)
Hud
	parent_type= /obj
	plane=3
	SkillSlot
		icon = 'NewSkillbar.dmi'
		icon_state = "0,0"
		plane=3
		screen_loc = "CENTER-4,1"
		alpha = 0
		layer = FLOAT_LAYER
		New(var/mob/a,c=1)
			if(c)
				Multi_Hud(a,src,"CENTER-4","1")
				..()
	Skill
		Clans
		var
			slotnum = 1
			Skill_Name=""
			Style=""
			Stat_Usage=""
			Description="Placeholder"
			Cooldown=0
			Drain=0
			cooldown_remaining=0
			Chakra_Control_Trigger=0
			_Triggered=0
			in_cooldown=0
			Skill_Category
			Restrictions
			uses=0
			Power=0
			MaxLevel
			Rank="D"
			_hotkey = 0
			level=1
			kills=0
			UsesNeeded=10
			Copyable=0
			Seals_Needed=1
		icon = 'SkillCards.dmi'
		alpha = 150
		plane=3
		MouseEntered(src)
			if(!_hotkey)
			else
				alpha = 255
		MouseExited(src)
			if(!_hotkey)
				//maptext=""
			else
				alpha = 150
		New(var/names=src.Skill_Name,var/xx=10,var/yy=0)
			var/sql4dm/SqliteDatabaseConnection/conn = new("ProjectNindo.db")
			var/sql4dm/ResultSet/createq = conn.Query("SELECT * FROM SkillData WHERE SkillName = '[names]'")
			while (createq.Next())
				src.Skill_Name =createq.GetString("SkillName")
				src.icon_state="[Skill_Name]"
				src.Style=createq.GetString("Style")
				src.Stat_Usage =createq.GetString("Stat Usage")
				src.Description =createq.GetString("Description")
				src.Power =createq.GetNumber("Power")
				src.Rank =createq.GetString("Rank")
				src.UsesNeeded =createq.GetNumber("UsesNeeded")
				src.Seals_Needed =createq.GetNumber("Seals Needed")
				src.Cooldown =createq.GetNumber("Cooldown")
				src.Chakra_Control_Trigger =createq.GetNumber("Chakra Control Trigger")
				src.MaxLevel =createq.GetNumber("MaxLevel")
				src.Drain =createq.GetNumber("Drain")
				src.Skill_Category =createq.GetString("Skill Category")
				src._Triggered =createq.GetNumber("Active Trigger")


			var/tmp/alignment = 10+xx
			var/tmp/iconlist=new/list()
			//for(var/Hud/Skill/a in typesof(/Hud/Skill))
				//if(a.Skill_Name == src.Skill_Name)
					//src = a
			if(xx<=9)
				screen_loc = "CENTER-4+[xx-1]:[alignment],1+[yy]:5"
			for(var/i in icon_states(src.icon))
				iconlist+=i
			if(names in iconlist)
				src.icon_state = "[names]"
			else
				src.icon_state = "."
			name = "[names]"
			maptext_x = 24
			maptext_y = 4
			maptext_height = 16
			slotnum = slotnum + xx
			maptext = "[slotnum]"
			..()
		Click()
			var/tmp/Player/P = usr
			if(usr.firing) return
			if(src.in_cooldown&&!P.activeskills.Find("[src.Skill_Name]"))
				_message(usr,"Skill Info","This skill is still on cooldown for [src.cooldown_remaining] seconds","white",,"white")
			else
				P.firing=1
				P.Execute(src,P)
/*				for(var/Hud/Skill/_skill in P.Skillset)
					if(_skill.Skill_Name = src.Skill_Name)
						world.log << "Execute 1"
						P.Execute(_skill,P)
						return*/

/*		MouseDrop(src,var/Hud/SkillSlot/Slot)
			var/temp = new(src.type(0))
			temp._hotkey=1
			usr.Skillset[Slot.slotnum] = temp
			_message(usr,"[src] has been set to hotkey number [Slot.slotnum]")

			*/
