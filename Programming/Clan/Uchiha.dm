Uchiha
	parent_type = /Hud/Skill/Clans
	Copyable=0
	Sharingan
		Stat_Usage = "ninjutsu"
		Skill_Name = "Sharingan"
		//Power=40
		icon_state = "Sharingan"
		Description="Acetivate your special eye abilites"
		Rank = "C"
		UsesNeeded = 30
		Chakra_Control_Trigger=0
		Copyable=0
		Drain = 20
		Cooldown = 5
		Seals_Needed=0
/*	Skill_Template
		Stat_Usage = "ninjutsu"
		Skill_Name = "Name of justsu"
		//Power=40
		icon_state = "Clone Tech"
		Rank = "C"
		UsesNeeded = 3
		Copyable=0
		Drain = 10
		Cooldown = 5
		Seals_Needed=1*/
Player
	var
		activeskills[0]
	proc
		Sharingan(_nin,cooldowns,var/triggered=0)
			if(triggered==1)
				if("Sharingan" in src.activeskills)
					src.activeskills-=("Sharingan")
					_message(src,"Battle Info","Your eyes return to normal.","white",,"white")
					//world.log << "Inactive:[src.activeskills[1]]"
					for(var/Hud/Effects/Black_Screen/B in src.client.screen)
						B.color= rgb(0,0,0)
					//view(src) << "[src]'s eyes return to normal."
					src.see_invisible = 0
					src.see_infrared = 0
					src.ninjutsu -= 100
					return

				else
					//if(length(activeskills)>=1)
					//	src.activeskills.Add("Sharingan")
					//else
					src.activeskills+=("Sharingan")
					//world.log << "Active:[src.activeskills[i]]"
					for(var/Hud/Effects/Black_Screen/B in src.client.screen)
						B.color +=rgb(255,0,0)
					_message(view(src),"[src]","Sharingan!","red",,"grey")
					src.see_invisible = 2
					src.see_infrared=40
					src.ninjutsu += 100
					return