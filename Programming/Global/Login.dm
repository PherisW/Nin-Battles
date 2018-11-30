client
 mouse_pointer_icon = /obj/arrowcursor
obj/arrowcursor
 icon = 'Cursor1.dmi'
 name = ""
 layer = FLY_LAYER

datum/var/const
	BGM = 50
	SFX = 10
mob
	var
		loggedin
Player
	var/interior=1
	mouse_opacity=2
	//12,25
	MouseEntered()
		..()
		var/nameentered="[src.name]"
		spawn() src.Name(nameentered,usr)
	Login()
		..()
		client.focus = src
		src.Title_Screen()
	Logout()
		world.log << "[key] has logged out."
		..()
		_message(world,"Login info","[key] has logged out.","red",,"purple")
		del(src)

