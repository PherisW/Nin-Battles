

General
	parent_type=/Hud/Skill
//S Rank//
//A Rank//
//B Rank//
//C Rank//
//D Rank//
//E Rank//
	Clone
		Stat_Usage = "ninjutsu"
		Skill_Name = "Bunshin"
		//Power=40
		Description="Make an illusion of yourself."
		icon_state = "Clone Tech"
		Rank = "C"
		UsesNeeded = 3
		Copyable=0
		Drain = 10
		Cooldown = 5
		Seals_Needed=1

Player
	proc
		Clone(_nin,cooldowns,var/_triggered)
			_message(view(src),"[src]","Clone Jutsu!","grey",,"grey")
			var/Clone/C = new(src,"Normal")
			C.loc= Jutsu_Spawn(usr,"east")
			C.dir = usr.dir
			flick("smoke",C)
			spawn()
				C.alpha=255

//Executions of jutsus