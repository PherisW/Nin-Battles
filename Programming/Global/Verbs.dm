Player
	var/meleedelay=0
	proc
		Shortcuts(msg as text)
			var/tmp/holder
			var/tmp/holder2
			if(length(msg) >= 2)
				//if(findtext(msg,"@"))
				//	var/tmp/usr copytext(msg,findtext(msg,"@"))
				var/tmp/msg2 = msg
				if(length(msg2) == 2)
					msg2= msg+" "
				holder = copytext(msg2,1,4)
				holder2 = copytext(msg2,4)
				if(findtext(holder,"/s "))
					winset(src,"Textbox.input1","command= Say")
					winset(src,"Textbox.Saybutton","is-checked = true")
					if(holder2)
						view(6) << "<font color = green>[usr.key]</font>:[holder2]"
					return 2

				else if(findtext(holder,"/w "))
					winset(src,"Textbox.input1","command= OOC")
					winset(src,"Textbox.OOCbutton","is-checked = true")
					for(var/Player/P in world)
						if(holder2)
							P << "<font color = red>[usr.key]</font>:[holder2]"
					return 2
				else if(findtext(holder,"/? "))
					src << "/h - Hotkeys \n /? - Chat Shortcuts \n /s - Say \n /w - OOC"
					return 2
				else if(findtext(holder,"/h "))
					src <<  "::HotKeys:: \n Arrow Keys to move \n F - Interact \n B - bag \n T - Open Chat box \n Click the map to close the chatbox"
					return 2
			else
				return 0
	proc
		Punch(var/style="Light")
			var/base_damage=1
			var/_damage= 0
			var/delay=5
			if(style=="Light")
				base_damage=1
			if(style=="Strong")
				base_damage=2
			_damage = src.taijutsu * base_damage
			if(Target)
				src.dir = get_dir(src,Target)
			if(src.meleedelay)
				return
			src.meleedelay=1
			spawn(5)
				src.meleedelay=0
			AimAssist()
			if(prob(50))
				flick("punch2",src)
			else
				flick("punch",src)
			Ticks(3)
			//var/Player/player = src

			for(var/Clone/A in get_step(src, src.dir))
				if(!A.canhit)
					return
				PunchEffect(A)
				_message(A,"Battle Damage","You take [_damage] damage from [src]'s punch.","red",,"red")
				//A << "you take 100 damage from [player]'s punch"
				if(A)
					A.health -= _damage
					if(A.health <= 0)
						if(A.Bomb())
							Trap(src,A.loc,"WaterClone")

			for(var/Objects/Training_Obj/A in get_step(src, src.dir))
				if(src.VitalCheck("Taijutsu",10))
					PunchEffect(A)
					//_message(usr,"Training Info","You punched the [A]","red",,"red")
					Stat_Gain("taijutsu")
				else
					src << "You are too tired."
/*			for(var/Player/A in get_step(usr, usr.dir))
				PunchEffect(A.loc)
				_message(A,"Battle Damage","You take [player.taijutsu] damage from [usr]'s punch","red",,"red")
				A.health -= player.taijutsu
				if(A.health <= 0)
					A << "You would have died"
					A.health = A.health_max*/
			for(var/Player/A in get_step(src, src.dir))
				if(A==src) continue
				if(A._in_barrier) return
				PunchEffect(A)
				A.Knockback(src,10*base_damage)//10 * base_damage)
				_message(src,"Battle Damage","You punch [A] for [_damage] damage.","red",,"red")
				A.health -= _damage
				if(prob(80))
					flick("kicked",src)
				Stat_Gain("taijutsu",4)
				if(!A.nonplayer)
					_message(A,"Battle Damage","You take [_damage] damage from [src]'s punch","red",,"red")
					if(A.health <= 0)
						_message(A,"Death Info","You would have died")
						A.health = A.health_max
	verb
		Light_Punch()
			set hidden = 1
			var/Player/Player=usr
			Player.Punch()



		OOC(msg as text)
			if(src.Shortcuts(msg)!= 2)
				for(var/Player/P in world)
					P << "<font color = blue>{Leaf Ninja}-{[usr]}</font>:[msg]"
		Say(msg as text)
			if(src.Shortcuts(msg)!= 2)
				view() << "<font color = red>[usr]</font>:[msg]"
				//view(6) << "<font color = green>[usr]</font>:[msg]"
		Toggle_Fullscreen()
			set hidden = 1
			var/Player/Player = src
			Player.FullScreen()
		Med_Punch()
			AimAssist()
			flick("kick",usr)
			for(var/Clone/A in get_step(usr, usr.dir))
				A << "you take 100 damage from [usr]'s kick"
				A.health -= 100
				if(A.health <= 0)
					if(A.Bomb())
						Trap(usr,A.loc,"WaterClone")
	proc
		Combo_Check()
