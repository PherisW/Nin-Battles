
proc
	_ftext(text="",color,face)
		if(color||face)
			text="<font[color ? " color='[color]'" : ][face ? " face='[face]'" : ]>[text]</font>"
		return text

	_message(recipient,sender,msg,color,face,sender_color,sender_face)
		if(!recipient) return

		//sending to mobs
		if(istype(recipient,/mob))
			if(!recipient:client) return
			_message(recipient:client,sender,msg,color,face,sender_color,sender_face)
			return

		//sending to clients
		if(istype(recipient,/client))
			var/client/client = recipient
			if(!client._chatbox) return

			var/chatbox_msg/chatbox_msg = msg
			if(!istype(msg,/chatbox_msg)) chatbox_msg = new/chatbox_msg(msg,color,face,sender,sender_color,sender_face)

			client._chatbox._enter(chatbox_msg)
			client.chatlog_record(chatbox_msg.text)
			client.chatbox_show(1)
			return

		//sending to lists
		if(istype(recipient,/list))
			if(!length(recipient)) return
			if(!istype(msg,/chatbox_msg)) msg = new/chatbox_msg(msg,color,face,sender,sender_color,sender_face)

			//If sending to a list of poeple, all client.mobs and clients get it
			for(var/mob/mob in recipient)
				if(mob.client)
					_message(mob.client,sender,msg)
			for(var/client/client in recipient)
				_message(client,sender,msg)
			return

		//sending to world
		if(istype(recipient,world))
			if(!istype(msg,/chatbox_msg)) msg = new/chatbox_msg(msg,color,face,sender,sender_color,sender_face)
			for(var/client/client)
				_message(client,sender,msg)
			return
