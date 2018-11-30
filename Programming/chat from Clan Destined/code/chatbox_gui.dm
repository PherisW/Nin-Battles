
_defaults/chatbox_gui
	parent_type = /atom/movable
	icon = null
	layer = FLY_LAYER


chatbox_gui
	parent_type = /_defaults/chatbox_gui

	Click()
		..()
		if(istype(usr,/Player)&&usr.client&&usr.client._chatbox)
			//_message(world,"System","Good","green",,"red")
			_onclick(usr.client,"[src.name]")
		else
			_message(world,"System","Error","red",,"red")
	proc
		_onclick(var/client/client)
			if(client&&client._chatbox)
				switch(src.icon_state)
					if("up")
						client._chatbox._pageup()
					if("down")
						client._chatbox._pagedown()
					if("start")
						client._chatbox._pagestart()
					if("end")
						client._chatbox._pageend()


	background

	start
		mouse_opacity=2
		_onclick(client/client)
			if(client&&client._chatbox)
				client._chatbox._pagestart()
	up
		_onclick(client/client)
			..()
			//_message(world,"System","Start","green",,"red")
			client._chatbox._pageup()
	/*up
		//mouse_opacity=1
		_onclick(client/client)
			_message(world,"System","Start","yellow",,"red")
			if(client&&client._chatbox)
				_message(world,"System","Fired","green",,"red")
				client._chatbox._pageup()
			else
				_message(world,"System","Error","red",,"red")*/

	down
		_onclick(client/client)
			if(client&&client._chatbox)

				client._chatbox._pagedown()

	end
		_onclick(client/client)
			if(client&&client._chatbox)
				_message(world,"System","We Good","green",,"red")
				client._chatbox._pageend()
			else
				_message(world,"System","Error","red",,"red")

