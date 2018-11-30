mob
    var/tmp
        last_message = -1
        list/chatlist = list()
client
	var/tmp/chatlog
	var/hidechat=0
	// don't touch
	var/tmp/chatbox/_chatbox
//	var/tmp/_chatbox
	proc
		chatbox_build()
			chatbox_remove()
			_chatbox = new
			screen += _chatbox._shadow
			screen += _chatbox
			for(var/gui in typesof(/chatbox_gui))
				switch(gui)
					if(/chatbox_gui)
					else
						screen += new gui

		chatbox_remove()
			if(_chatbox)
				if(_chatbox._shadow)
					del _chatbox._shadow
				del _chatbox
			for(var/chatbox_gui/extra in screen)
				del extra

		chatbox_clear()
			if(_chatbox)
				_chatbox._clear()

		chatbox_show()
			var
				fadeTime = 1
				fadeValue = 130

			if(_chatbox)
				animate(_chatbox)
				animate(_chatbox,alpha = 255, fadeTime)
				if(_chatbox._shadow)
					animate(_chatbox._shadow)
					animate(_chatbox._shadow,alpha = 180, fadeTime)
			for(var/chatbox_gui/background/bg in screen)
				animate(bg)
				animate(bg,alpha = fadeValue, fadeTime)
			for(var/chatbox_gui/buttons/b in screen)
				animate(b)
				animate(b,alpha = 230, fadeTime)
			_chatbox.mouse_opacity=1
			if(src.hidechat)
				chatbox_fade()


		chatbox_fade()
			set waitfor = 0
			var/time = world.time
			if(src.mob.last_message<time)
				src.mob.last_message = time
				sleep(50)
				if(src.mob.last_message==time)
					var/fadeTime = 3
					for(var/chatbox_gui/extra in screen)
						animate(extra,alpha = 0, fadeTime)
					sleep(110)
					if(src.mob.last_message==time)
						if(_chatbox)
							animate(_chatbox,alpha = 0, fadeTime)
							if(_chatbox._shadow)
								animate(_chatbox._shadow,alpha = 0, fadeTime)
								_chatbox.mouse_opacity=0


		chatlog_record(str)
			if(chatlog)
				src << output("[str]",chatlog)

		chatlog_clear()
			if(chatlog)
				src << output(null,chatlog)