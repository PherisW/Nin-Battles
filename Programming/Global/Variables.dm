/*
	Table Of Contents
///////////////////////////
	i.Datum
	I.Mobs
		A.Player
		B.Non-Player
			i.Hostile
			ii.Friendly
	II.Objects
		A.Tools
			i.Scrolls
			ii.Thowing Weapons
			iii.Hand to hand weapons
		B.Clothes
		C.Hair
		D.Jutsus

		E.Flora
		F.Buildings
		G.Effects
		H.Huds
		J.Mission
	III.Turfs

/////////////////////////////
*/
/*
possible things to add
Perception variable
*/
datum
	var
		Logos
			Title
var
	TimeofDay="Day"
	Weathertype=""
Turfs/var/Weatherproof=0

client
	var/_leftclick=0
	var/_rightclick=0
	Click(object,location,control,params)
		params=params2list(params)
		if(params["right"])
			_rightclick=1
			spawn(1)
				_rightclick=0
		if(params["left"])
			_leftclick=1
			spawn(1)
				_leftclick=0

		..()

/*
Branch
	Three Choices
		The normal Milita
			Genin
			Chuunin
			Special-Jounin
			Jounin
			Leading Jounin (Head Ninja, Jounin Commander, etc.)
				perks
					Request ANBU Exam
					Request Chuunin Exam
					Request Jounin Exam
					Request Exile
					Request Enlisting
		Medical Team
			Field Medic
			Focus Medic
				(those who want to get a head start in a craft?
		ANBU
			This is what would be considered the Hard version:
			in this branch you will have a lot of harder PvE missions
			and have higher Ranked PVP missions. Your role in the villages
			influence will be the highest of the entire force, excluding
			the Leading Jounin.
			*If you choose to start in anbu you will get a higher exp boost
			due to the training regime of a assaination force, but extremely
			harder missions. Failing these missions will signicantly decrease
			training exp  you have collected.
			* Due to your life being an extremely high factor in village influence
				Your idenity wil be chosen and  you will be renamed to your code name
				while on duty.
			*To start in the ANBU you need to have a special skill:
				Nano-bugs,Bone-mani kaguya,Kekkai genkai,or High
				Unlock rate of MS
			*Leading Jounin can request a player to become ANBU
				to take an exam from the council


		ANBU(unlocked for those who played for 2 wipes)
		ANBU(Sub-Branch) - (Unlocked for those who played 5)
		(Every Wipe played gives you a higher chance of
		rolling better starting stats and abilities)
chance on if high stats or a rare ability, you can join ROOT on
on graduation in leaf, puppet bridage in sand, or swordsman training in Mist"
Of if your clan has a passive ability that is useful to the village, you could
join the special jounin Rank

	Rejection/Exiled
		Defected Ninja
			(can choose to defect at any time, but cosidering the reasoning why
			you could be ignored by the village, or to be put on the Bingo Book
			to be hunted down by the ANBU Branch of that village.
			You will have to go to different locations and be a merc to survive
			It is possible to get an organization going with enough power to
			Create a base and be a group of importance)

Kages would be an NPC for story purposes,
but players can be the Lead Jounin Rank for each village
they would have the same authority, since their vote is
important to the council of the village
*/


mob
	var
		village="Unaffiliated"
		clan="None"
		branch="Ninja Force"
		Rank="Student"
		Attributes
			var
				Health
				Chakra
				Stamina
				Handseals
				SealSpeed
				Ninjutsu
				Doujutsu
				Senjutsu
				Taijutsu
				Genjutsu
				Fuuninjutsu
				Chakra_Control

		health = 100
		health_max = 100
		stamina = 100
		stamina_max = 100
		firing

Attributes
	var
		true_value=0
		max_value=0
		bonus_value=0
		experience=0

Eyes
	var
		level=0
		experience=0
		varient=""
		active=0


Clan

Player
	parent_type = /mob
	appearance_flags = KEEP_TOGETHER
	health_max = 10000
	stamina_max=10000
	can_bump(atom/m)
		if(src.flight)
			return 0
		if(istype(m,/Projectile))
			var/tmp/Projectile/K = m
			if(K.owner)
				return 0
		return ..()

	var/_wanderon=0
	var/distance=3
	_chatbox
	var
		list
			Inventory[1]
			Skillset[0]
			HotKeys[9]
			ActiveQuest[5]
		defdialogue=""
		offdialogue=""
		evasdialogue=""
		class
		_Movement_locked
		MovementSpeed
		_displayname=""
		_Incognitoname="???"
		occupation
		_quests=0
		fullscreen=0
		flight
		hairselect=""
		squad
		nonplayer=0
		weathereffect="None"
		chakra
		chakra_max = 10000
		taiganOn
		Chakra_Reserves=10000
		chakra_control = 10
		shape_transformation_skill
		nature_transformation_skill
		_in_barrier=0
		sealmastery=100
		Ryo = 5000
		CombatSkill
		_intelligence=0
		doujutsu = 0
		doujutsu_exp = 0
		ninjutsu = 5
		ninjutsu_exp =0
		taijutsu = 5
		taijutsu_exp =0
		genjutsu = 5
		genjutsu_exp =0
		//subskills
			//Leaf Style//
		strongfist
		//	Mist Style//
		//	Sand Style//
		fan
		puppet
		//  General //
		kenjutsu
		fuuninjutsu
		medical
		jinchuuriki
		affinty_element
		second_element
		third_element
		wall_bounced
		//Movement var//
		Movement
		movement_locked
		WalkSpeed = 3
		RunSpeed = 2
	bump(atom/a, d)
		if(wall_bounced) return
		if(d == EAST || d == WEST)
			vel_x *= -1
		else if(d == NORTH || d == SOUTH)
			vel_y *= -1
		wall_bounced=1
		spawn(10)
			wall_bounced=0

Non_Player
	parent_type = /Player
	health_max = 1000
	nonplayer=1
	_wanderon=1
	New()




Objects
	Missions
		var
			tmp
		class
		description
		reward
		type
Screens
	parent_type = /obj
	Title
		//icon = 'Nindo alpha title screen.png'
		screen_loc = "1,1"
		plane=2
		alpha = 0
	Start
		screen_loc= "Center+4,Center+3"
		plane=2
		maptext_width = 360
		maptext_height = 360
		maptext = "<font size=+10><font color = black><center>Press Space"
		alpha = 0


/*

Our fires lords babes with power glowed
1  Earth (Rhalic
2 Blood (Tir-Cendelius
3 Air (Duna
4 Fire (Zorl-Stissa
5 Mind (Xantessa
6 Muscle (Vrogir
7 Amailia
*/



