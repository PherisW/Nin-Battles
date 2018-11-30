client
	keys = "north|south|east|west|space|w|s|d|a|b|f|g|h|j|k|1|2|3|4|5|6|7|8|9"
	var/Interacts=0
	proc
		Interact()
			Interacts = 1
			Ticks(10)
			Interacts = 0
/*var
	_default_scheme = list(
		"north" = "North",
		"south" = "South",
		"east" = "East",
		"west" = "West",
		"southeast" = "Southeast",
		"southwest" = "Southwest",
		"northeast" = "Northeast",
		"northwest" = "Northwest",
		"center" = "Center",
		"space"="Interact",
		"1"="Hotkey,1",
		"2"="Hotkey,2",
		"3"="Hotkey,3",
		"4"="Hotkey,4",
		"5"="Hotkey,5",
		"6"="Hotkey,6",
		"7"="Hotkey,7",
		"8"="Hotkey,8",
		"9"="Hotkey,9",
		"j"="Punch,Light",
		"k"="Punch,Strong",
		"b"="BagOpens")



	_developer_scheme = list(
		"w" = "North",
		"s" = "South",
		"d" = "East",
		"a" = "West",
		"center" = "Center",
		"space"="Interact",
		"1"="Hotkey,1",
		"2"="Hotkey,2",
		"3"="Hotkey,3",
		"4"="Hotkey,4",
		"5"="Hotkey,(5)",
		"6"="Hotkey(6)",
		"7"="Hotkey,7",
		"8"="Hotkey,8",
		"9"="Hotkey,9",
		"f"="Punch,Light",
		"g"="Punch,Strong",
		"b"="BagOpens")*/
Player
	var
		scheme_type = "default"
	key_down(k)
		if(src.scheme_type == "default")
			default_scheme(k)
		else
			developer_scheme(k)



Player
	proc
		_set_scheme(var/type)
			if(type=="developer")
				src.controls.up = "w"
				src.controls.down = "s"
				src.controls.left = "a"
				src.controls.right = "d"
			else
				src.controls.up = "north"
				src.controls.down = "south"
				src.controls.left = "west"
				src.controls.right = "east"
			src.scheme_type = type

		developer_scheme(var/k)
			if(k=="space")
				Interact()
			if(text2num(k))
				HotKey(text2num(k))
			if(k=="f")
				Punch("Light")
			if(k=="g")
				Punch("Strong")
			if(k=="b")
				BagOpens()
			if(k=="tab")
				TargetCycle()

		default_scheme(k)
			if(k=="j")
				Punch("Light")
			if(k=="k")
				Punch("Strong")
			if(k=="space")
				Interact()
			if(k=="b")
				BagOpens()
			if(k=="tab")
				TargetCycle()
			if(text2num(k))
				HotKey(text2num(k))