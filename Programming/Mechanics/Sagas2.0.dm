mob/var
	Map/instance //= new()
	oldloc = (null)
	list/Saga_list = list("Saiyan Saga: Part 1")
	Sagas_Completed = 0
	Marked
	_in_instance = 0
	BOSS=0
	BOSS_defeated = 0
	BOSS_requirement = 0
	Mission = ""
	form = 1

area
	Block
		opacity = 1
		density = 1

var
	Maps
		map_manager = new()
Non_Player/Friendly
	Vierna
		name = "Viera Sensei"
		icon = 'Sagas.dmi'
		icon_state = "trunks2"
		safe = 1
		frozen = 1
		New()
			..()
			src.CreateName()
		verb
			Talk()
				set src in view(1)
				set category = "Channels"
				var
					tmp
						__instance = (null)
						__BOSS_requirement = 0
						__loc = (null)
						__xloc = (null)
						__yloc = (null)
						__Mission = ""
						__Description = ""
				if(fexists("Global Player Data.sav"))
					var/savefile/G = new("Global Player Data.sav")
					if(usr.GMLevel <=3&&G["[usr.ckey] Pass"] != "1")
						usr << "You do not have  apass to join these sagas"
						return
					usr.it_lock = 1
					usr.it_blocked = 1
					var/Saga_mission = input(usr,"Please pick a saga you would like to go back in time and battle.") in usr.Saga_list + "Nevermind"
					switch(Saga_mission)
						if("Nevermind")
							usr.it_lock = 0
							usr.it_blocked = 0
							return
						if("Saiyan Saga: Part 1")
							__instance = map_manager.Copyable("Maps/Sagas/Saiyan Saga Part A.map")
							__BOSS_requirement = 1
							__xloc = 14
							__yloc = 6
							__Description = "Defeat Raditz and Save Gohan!"
						if("Saiyan Saga: Part 2")
							__instance = map_manager.Copyable("Maps/Sagas/Saiyan Saga Part B.map")
							__BOSS_requirement = 2
							__xloc = 14
							__yloc = 6
							__Description = "Defeat the Saiyans!"
						if("Freeza Saga: Part 1")
							__instance = map_manager.Copyable("Maps/Sagas/Freeza Saga Part A.map")
							__BOSS_requirement = 2
							__xloc = 21
							__yloc = 4
							__Description ="Defeat Dodoria and Zarbon"
						if("Freeza Saga: Part 2")
							__instance = map_manager.Copyable("Maps/Sagas/Freeza Saga Part B.map")
							__BOSS_requirement = 5
							__xloc = 9
							__yloc = 4
							__Description = "Defeat the Ginyu Force!"
						if("Freeza Saga: Part 3")
							__instance = map_manager.Copyable("Maps/Sagas/Freeza Saga Part C.map")
							__BOSS_requirement = 4
							__xloc = 10
							__yloc = 3
							//usr._in_instance = 1
							__Description ="Confront Freeza!"
						if("Cell Games")
							__instance = map_manager.Copyable("Maps/Sagas/Cell Games.map")
							__BOSS_requirement = 1
							__xloc = 14
							__yloc = 6
							__Description ="Attend the Cell Games!"
					if(usr.in_party)
						if(usr.party_leader)
							var/newxloc = 14
							usr.instance = __instance
							for(var/mob/a in world)
								if(a.party_name == usr.party_name)
									if(a.GMLevel >=3||G["[a.ckey] Pass"] == "1")
										a.instance = usr.instance
										a.BOSS_requirement = __BOSS_requirement
										a.oldloc = a.loc
										a.loc =  locate(__xloc, __yloc, usr.instance.z)
										a._in_instance = 1
										a.Mission = Saga_mission
										a << "[__Description]"
										__xloc+=1
									else
										a << "You do not have a pass to join this mission"
										for(var/mob/N in world)
											if(N.party_name==src.party_name)
												N<<"<font color=lime>[src.party_name] Information:<font color=white> [src] Booted [a]!"
										a.in_party=0
										a.party_leader=0
										a.party_member=0
										a.party_name=a.name
										a.verbs += new/mob/PC/verb/Create_Party()
										a.verbs -= new/mob/PartyVerbs/verb/Party_Boot()
										a.verbs -= new/mob/PartyVerbs/verb/Party_Chat()
										a.verbs -= new/mob/PartyVerbs/verb/Party_Invite()
										a.verbs -= new/mob/PartyVerbs/verb/Party_Members()
										a.verbs -= new/mob/PartyVerbs/verb/Party_Leave()
										src.party_members.Remove("[a]")
						else
							usr <<"The leader of the party must assign the missions!"
					else
						usr.instance = __instance
						usr.BOSS_requirement = __BOSS_requirement
						usr.oldloc = usr.loc
						usr.loc =  locate(__xloc, __yloc, usr.instance.z)
						usr._in_instance = 1
						usr.Mission = Saga_mission
						usr << "[__Description]"




	NEW_SAGAS
		var
			list/Techlist = list()
//Saiyan Saga Mobs
		it_blocked=1
		Saibaman
			Green_Saiba_Man
				name = "Green Saibaman {Mob}"
				icon = 'Saibaman - Form 1.dmi'
				powerlevel = 500000
				powerlevel_max = 500000
				ki = 600000
				ki_max = 600000
				kidefense = 600000
				kidefense_max = 600000
				speed = 50000
				strength = 45000
				defence = 45000
				karma = "Evil"
				race = "Green Saibaman"
				level = 500
				zenni = 5000
				exp = 2500
				melee=20
				block=20
				dodge=20
				counter=20
				critical=20
				ki_control=20
				ki_power=20
				ki_use=20
				ki_res=20
				reflect=20
				Bump(mob/M)
					if(istype(M,/mob/PC)&&!src.doing)
						src.Attack2(M)
			White_Saiba_Man
				name = "White Saibaman {Mob}"
				icon = 'Saibaman - Form 6.dmi'
				powerlevel = 25000000
				powerlevel_max = 25000000
				ki = 15000000
				ki_max = 15000000
				kidefense = 16000000
				kidefense_max = 16000000
				speed = 1200000
				strength = 1250000
				defence = 1250000
				karma = "Evil"
				race = "White Saibaman"
				level = 3500
				zenni = 30000
				exp = 15000
				melee=35
				block=35
				dodge=35
				counter=35
				critical=35
				ki_control=35
				ki_power=35
				ki_use=35
				ki_res=35
				reflect=35
				Bump(mob/M)
					if(istype(M,/mob/PC)&&!src.doing)
						src.Attack2(M)
			Black_Saiba_Man
				name = "Black Saibaman {Mob}"
				icon = 'Saibaman - Form 4.dmi'
				powerlevel = 350000000
				powerlevel_max = 350000000
				ki = 260000000
				ki_max = 260000000
				kidefense = 240000000
				kidefense_max = 240000000
				speed = 50000000
				strength = 45000000
				defence = 45000000
				karma = "Evil"
				race = "Black Saibaman"
				level = 9000
				zenni = 100000
				exp = 50000
				melee=60
				block=60
				dodge=60
				counter=60
				critical=60
				ki_control=60
				ki_power=60
				ki_use=60
				ki_res=60
				reflect=60
				Bump(mob/M)
					if(istype(M,/mob/PC)&&!src.doing)
						src.Attack2(M)
			Red_Saiba_Man
				name = "Red Saibaman {Mob}"
				icon = 'Saibaman - Form 5.dmi'
				powerlevel = 2500000000
				powerlevel_max = 2500000000
				ki = 1600000000
				ki_max = 1600000000
				kidefense = 1600000000
				kidefense_max = 1600000000
				speed = 300000000
				strength = 250000000
				defence = 225000000
				karma = "Evil"
				race = "Red Saibaman"
				level = 20000
				zenni = 200000
				exp = 100000
				melee=80
				block=80
				dodge=80
				counter=80
				critical=80
				ki_control=80
				ki_power=80
				ki_use=80
				ki_res=80
				reflect=80
				Bump(mob/M)
					if(istype(M,/mob/PC)&&!src.doing)
						src.Attack2(M)
			God_Saiba_Man
				name = "God Saibaman {Mob}"
				icon = 'Saibaman - Form 7.dmi'
				powerlevel = 2500000000000
				powerlevel_max = 2500000000000
				ki = 1600000000000
				ki_max = 1600000000000
				speed = 250000000000
				strength = 150000000000
				defence = 200000000000
				karma = "Evil"
				race = "God Saibaman"
				level = 40000
				zenni = 750000
				exp = 250000
				melee=100
				block=100
				dodge=100
				counter=100
				critical=100
				ki_control=100
				ki_power=100
				ki_use=100
				ki_res=100
				reflect=100
				Bump(mob/M)
					if(istype(M,/mob/PC)&&!src.doing)
						src.Attack2(M)
		Raditz
			name="Raditz {Boss}"
			icon = 'Sagas.dmi'
			icon_state="raditz"
			Techlist = list("SpecialBeamCannon","Kamehameha")
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Nappa
			name="Nappa {Boss}"
			icon = 'Sagas.dmi'
			icon_state="nappa"
			Techlist = list("Kaioken")
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Vegeta
			name="Vegeta {Boss}"
			icon = 'Sagas.dmi'
			icon_state="vegeta"
			Techlist = list("GalickGun")
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
//Freeza Saga Mobs

		Dodoria
			name="Dodoria {Boss}"
			icon = 'Sagas.dmi'
			icon_state="dodoria"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Zarbon
			name="Zarbon {Boss}"
			icon = 'Sagas.dmi'
			icon_state="zarbon"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Henchmen
			name="Freeza's Henchmen {Mob}"
			icon = 'Sagas.dmi'
			icon_state="Kiwi"
			//energy_code= 1234969
			//BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)

//Ginyu Force Mobs

		Ginyu
			name="Ginyu {Boss}"
			icon = 'Sagas.dmi'
			icon_state="ginyu"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Jeice
			name="Jeice {Boss}"
			icon = 'Sagas.dmi'
			icon_state="jeice"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Burter
			name="Burter {Boss}"
			icon = 'Sagas.dmi'
			icon_state="burter"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)


		Recoom
			name="Recoom {Boss}"
			icon = 'Sagas.dmi'
			icon_state="recoom"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)


		Guldo
			name="Guldo {Boss}"
			icon = 'Sagas.dmi'
			icon_state="guldo"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			//race = "Saiyan"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)

//Freiza Forms
		Freiza
			name="Freiza {Boss}"
			icon = 'Changling - Form 1.dmi'
			//icon_state="guldo"
			//energy_code= 1234969
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			race = "Changling"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)

		Freiza2nd
			name="Freiza {Boss}"
			icon = 'Changling - Form 2.dmi'
			//icon_state="guldo"
			//energy_code= 1234969
			form=2
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			race = "Changling"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)

		Freiza3rd
			name="Freiza {Boss}"
			icon = 'Changling - Form 3.dmi'
			//icon_state="guldo"
			//energy_code= 1234969
			form = 3
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			race = "Changling"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Freiza4th
			name="Freiza {Boss}"
			icon = 'Changling - Form 4.dmi'
			//icon_state="guldo"
			//energy_code= 1234969
			Techlist=list("Deathbeam","DeathBall")
			form = 4
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			race = "Changling"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)



//Andriod Saga Mobs
		Cell
			name="Cell {Boss}"
			icon = 'Sagas.dmi'
			icon_state="cell2"
			//energy_code= 1234969
			Techlist=list("SolarKamehameha")
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=200000000
			powerlevel_max=200000000
			ki=180000000
			ki_max=180000000
			strength=50000000
			strength_max=50000000
			defence=40000000
			defence_max=40000000
			speed=50000000
			zenni=100000000
			exp=5000
			karma = "Evil"
			race = "Bio Android"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
//			CPS=1
		Cell_Jr
			name = "Cell Jr. {Mob}"
			icon = 'Cell Jr.dmi'
			density = 1
			powerlevel = 100000000
			powerlevel_max = 100000000
			ki = 100000000
			ki_max = 100000000
			speed = 4000000
			strength = 5000000
			defence = 5000000
			critical = 20
			karma = "Evil"
			race = "Bio Android"
			level = 5000
			zenni = 50000
			pk = 1
			exp = 25000
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
//Majin Buu Saga Mobs

//Movie Mobs
		Cooler
			name="Cooler {Boss}"
			icon = 'Changling - Form 4.dmi'
			//icon_state="guldo"
			//energy_code= 1234969
			Techlist=list("Deathbeam","DeathBall")
			form = 4
			BOSS=1
			it_blocked=1
			level=500
			powerlevel=20000
			powerlevel_max=20000
			ki=18000
			ki_max=18000
			strength=5000
			strength_max=5000
			defence=4000
			defence_max=4000
			speed=5000
			zenni=10000
			exp=5000
			karma = "Evil"
			race = "Changling"
			Bump(mob/M)
				if(istype(M,/mob/PC)&&!src.doing)
					src.Attack2(M)
		Garlic_Jr
		Bojack
		Broly
		Freiza_Bardock
		Janemba
		Lord_Slug
		Android_18
		Turles
		Meta_Cooler
		Future_18
		Future_17


//Super Saga Mobs
		Beerus
		Golden_Freiza
		Hit
		Cabba
		Frost
		Botamo
		Auta_Magetta
		Zamasu
		Black_Goku


	proc
		Mission_Check(var/mob/M)
		//SAIYAN SAGA
			var/tmp/Party_counter=0
			var/tmp/Party_checker=0
			for(var/mob/Z in world)
				if(Z.party_name == usr.party_name)
					Party_checker++
			if(M.dead && !M.in_party)
				M<< "You failed The [M.Mission]..."
				//M.loc = M.oldloc
				M.it_lock = 0
				M.it_blocked =0
				//M.instance = (null)
				M.Mission = ""
				M.BOSS_defeated = 0
				M._in_instance=0
				//spawn(20)
				M.instance.free()
				return
			if(M.dead && M.in_party&&!M.Marked)
				M.it_lock = 0
				M.it_blocked =0
				M.Marked=1
				//M.instance = (null)
				//M.Mission = ""
				M<< "You died in The [M.Mission]..."
				M.BOSS_defeated = 0
				M._in_instance=0
			for(var/mob/Q in world)
				if(Q.party_name == usr.party_name&&Q.Marked)
					Party_counter++
			if(Party_counter >= Party_checker && M.in_party && M.Marked)
				M << "Everyone in your party has died, You have failed the [M.Mission]"
				spawn(15)
					M.Mission = ""
					M.instance.free()
			if(M.Mission == "Saiyan Saga: Part 1")
				if(M.BOSS_defeated >=M.BOSS_requirement)
					M.BOSS_defeated = 0
					M << "You completed The [M.Mission]!"
					if(!M.Saga_list.Find("Saiyan Saga: Part 2",1))
						M.Saga_list+="Saiyan Saga: Part 2"
					M.loc = M.oldloc
					M.it_lock = 0
					M.it_blocked =0
					//M.instance = (null)
					M.Mission = ""
					M.BOSS_defeated = 0
					M._in_instance=0
					//spawn(20)
					M.instance.free()
					return
					//	map_manager.clear(M.instance)
			if(M.Mission == "Saiyan Saga: Part 2")
				if(M.BOSS_defeated >=M.BOSS_requirement)
					M.BOSS_defeated = 0
					M << "You completed The [M.Mission]!"
					if(!M.Saga_list.Find("Freeza Saga: Part 1",1))
						M.Saga_list+="Freeza Saga: Part 1"
					M.loc = M.oldloc
					M.it_lock = 0
					M.it_blocked =0
					//M.instance = (null)
					M.Mission = ""
					M.BOSS_defeated = 0
					M._in_instance=0
					//map_manager.clear(M.instance)
						//world.maxz -=1
					M.instance.free()
					return
			if(M.Mission == "Freeza Saga: Part 1")
				if(M.BOSS_defeated >=M.BOSS_requirement)
					M.BOSS_defeated = 0
					M << "You completed The [M.Mission]!"
					if(!M.Saga_list.Find("Freeza Saga: Part 2",1))
						M.Saga_list+="Freeza Saga: Part 2"
					M.loc = M.oldloc
					M.it_lock = 0
					M.it_blocked =0
					//M.instance = (null)
					M.Mission = ""
					M.BOSS_defeated = 0
					M._in_instance=0
					//map_manager.clear(M.instance)
						//world.maxz -=1
					M.instance.free()
					return
			if(M.Mission == "Freeza Saga: Part 2")
				if(M.BOSS_defeated >=M.BOSS_requirement)
					M.BOSS_defeated = 0
					M << "You completed The [M.Mission]!"
					if(!M.Saga_list.Find("Freeza Saga: Part 3",1))
						M.Saga_list+="Freeza Saga: Part 3"
					M.loc = M.oldloc
					M.it_lock = 0
					M.it_blocked =0
					//M.instance = (null)
					M.Mission = ""
					M.BOSS_defeated = 0
					M._in_instance=0
					//map_manager.clear(M.instance)
						//world.maxz -=1
					M.instance.free()
					return
			if(M.Mission == "Freeza Saga: Part 3")
				if(M.BOSS_defeated >=M.BOSS_requirement)
					M.BOSS_defeated = 0
					M << "You completed The [M.Mission]!"
					if(!M.Saga_list.Find("Cell Games",1))
						M.Saga_list+="Cell Games"
					M.loc = M.oldloc
					M.it_lock = 0
					M.it_blocked =0
					//M.instance = (null)
					M.Mission = ""
					M.BOSS_defeated = 0
					M._in_instance=0
					//map_manager.clear(M.instance)
						//world.maxz -=1
					M.instance.free()
					return

			if(M.Mission == "Cell Games")
				if(M.BOSS_defeated >=M.BOSS_requirement)
					M.BOSS_defeated = 0
					M << "You completed The [M.Mission]!"
					M.loc = M.oldloc
					M.it_lock = 0
					M.it_blocked =0
					//M.instance = (null)
					M.Mission = ""
					M.BOSS_defeated = 0
					M._in_instance=0
					//spawn(20)
						//M.instance.clear()
					M.instance.free()
					return


		//MobBooster()