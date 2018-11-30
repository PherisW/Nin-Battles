chatbox
	plane=3
	screen_loc = "1:11,2:12"

	maptext_height = 352
	maptext_width = 352

	maxlines = 30
	chatlines = 30

	font_family = "Arial"
	font_color = "#FFFFFF"
	name_color = "#000000"

	text_shadow = "#222d"

chatbox_gui
	icon = 'chatbox_gui.dmi'
	//icon = 'newchatbar.png'
	alpha = 0
	plane=3

	background
		//icon = 'Chat.dmi'
		icon = 'newchatbar.png'
		screen_loc = "1:8,2:10"
		mouse_opacity = 0
	buttons
		mouse_opacity = 1
		start
			icon_state = "start"
			screen_loc = "12:9,12:28"
			//y is 5

		up
			icon_state = "up"
			screen_loc = "12:9,12:13"

		down
			icon_state = "down"
			screen_loc = "12:9,2:25"

		end
			icon_state = "end"
			screen_loc = "12:9,2:10"


// implementation

mob
	var/name_color = "#FFFFFF"
	// chatbox creation
	proc/LoadChatGUI()
		if(client)
			client.chatbox_build()
			//  This could be for a fuller chatlog option
			//client.chatlog = "outputwindow.output" // set chatlog
			//client.chatlog_record("\b\[ This is your chatlog ]") // enter a text into your chatlog

	verb
		worldSay(txt as text)
			set category = "chatbox"
			_message(world, "[usr]", "[txt]",,,usr.name_color)
			//_message(ToWhom, FromWhom(astext), Message, Colour)

		Show_Text()
			set category = "chatbox"
			var/x
			switch(pick(1,2,3,4,5))
				if(1) x = "Lorem ipsum dolor sit amet."
				if(2) x = "Quo fabellas assueverit at."
				if(3) x = "Causae aliquando ex sea."
				if(4) x = "Vix no graece reprimique, no iusto verear qui."
				if(5) x = "Sea te solet quaerendum, affert repudiandae eam ad."

			_message(world, usr, "[x]",,,usr.name_color)


	// chatbox
		clear_chatbox()
			set category = "chatbox"
			if(client)
				client.chatbox_clear()

		hide_chatbox()
			set category = "chatbox"
			if(client)
				client.chatbox_show()

		show_chatbox()
			set category = "chatbox"
			if(client)
				client.chatbox_show(0)
