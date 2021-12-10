Logos
	parent_type = /obj
	Text
		screen_loc= "Center+2,Center-3"
		alpha = 0
		plane=2
		maptext_width = 360
		maptext_height = 360
		maptext = "<font size=+3><center>Press F to begin.."
	TitleScreen
		screen_loc= "Center,Center"
		icon = 'AoN logo.png'
		plane = 2
Client
	verb
		Interact()
			usr.Interacts = 1
			Ticks(10)
			usr.Interacts = 0
mob
	verb
		Interact()
			set hidden = 1
			Interacts = 1
			spawn()
				if(!usr.loc&&usr.menuscreen)
					Ticks(10)
					Interacts = 0
					src.client.screen = null
					return 1
				else
					Interacts = 0

mob
	var
		Interacts = 0
		menuscreen = 0

	()
/*		src.loc=null
		var/Logos/Text/StartButton = new
		var/Logos/TitleScreen/AoN = new
		menuscreen=1
		src.client.screen += AoN
		src.client.screen += StartButton
		spawn()
			animate(StartButton,alpha=255,time=20)
			StartButton.alpha=255
		if(!Interacts)
			for(var/i=1 to 100)
				if(!Interacts)
					Ticks(5)
		//while(src.Interact() == 0)
		..()
		*/