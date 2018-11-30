#define PHASE "Pre-Alpha"
#define VERSION 0.6
Hud_Object
	parent_type = /obj
	mouse_opacity=1
	plane=4
	Weather_Effects
		plane=1
		mouse_opacity=1
		icon='weathereffects.dmi'
		screen_loc="WEST,SOUTH to EAST,NORTH"
		alpha=0
	Version
		screen_loc="WEST,SOUTH"
		maptext_width = 200
		New(var/keys)
			..()
			spawn(1)
				STArt
				if(keys=="Heyblinx")
					maptext  = "<font size=-9>  [PHASE] Version: [VERSION] (CPU:[world.cpu]%)"
					Ticks(10)
					goto STArt
				else
					maptext  = "<font size=-9>  [PHASE] Version: [VERSION]"


	Vill_Pic
		icon = 'LeafHUD.dmi'
		alpha=200
		plane=4
		F1
			icon_state="0"
			screen_loc="2,NORTH-1"
		F2
			icon_state = "1"
			screen_loc="3,NORTH-1"
		F3
			icon_state = "2"
			screen_loc="2,NORTH"
		F4
			icon_state = "3"
			screen_loc="3,NORTH"
	Clock
		//icon = 'Clock3.dmi'
		alpha=200
		screen_loc="EAST-1,NORTH-1"
	Hand
		//icon = 'hand.dmi'
		alpha200
		screen_loc="EAST-1,NORTH-1"
		/*New()
			spawn(1)
				while(src)
					for(var/j=1 to 4)
						animate(src, transform = turn(matrix(), (90*j)), time =150)
						Ticks(150)
						src.icon = turn('hand.dmi', (90*i))*/


	Bars
		icon='Hud Test22.dmi'
		icon_state="1"
		plane=3
		alpha=180
		N1
			icon='Hud Test22.dmi'
			icon_state="1"
			screen_loc="2,NORTH"
		N2
			icon='Hud Test22.dmi'
			icon_state="2"
			screen_loc="3,NORTH"
		N3
			icon_state="3"
			screen_loc="4,NORTH"
		N4
			icon_state="4"
			screen_loc="5,NORTH"
		N5
			icon_state="5"
			screen_loc="6,NORTH"
		N6
			icon_state="6"
			screen_loc="7,NORTH"
		N7
			icon_state="7"
			screen_loc="2,NORTH-1"
		N8
			icon_state="8"
			screen_loc="3,NORTH-1"
		N9
			icon_state="9"
			screen_loc="4,NORTH-1"
		N10
			icon_state="10"
			screen_loc="5,NORTH-1"
		N11
			icon_state="11"
			screen_loc="6,NORTH-1"
		N12
			icon_state="12"
			screen_loc="7,NORTH-1"
	Money
		icon='Coin.dmi'
		alpha=200
		screen_loc="3,NORTH-2:16"
		maptext_width=128
		maptext_height=32
		maptext_x=24
		maptext_y=8
		maptext="<b>0</b>"
		New()
			transform = matrix()*0.75
			..()

Player/proc
	HudAdd()
		var/Hud_Object/Bars/N1/N1 = new
		var/Hud_Object/Bars/N2/N2 = new
		var/Hud_Object/Bars/N3/N3 = new
		var/Hud_Object/Bars/N4/N4 = new
		var/Hud_Object/Bars/N5/N5 = new
		var/Hud_Object/Bars/N6/N6 = new
		var/Hud_Object/Bars/N7/N7 = new
		var/Hud_Object/Bars/N8/N8 = new
		var/Hud_Object/Bars/N9/N9 = new
		var/Hud_Object/Bars/N10/N10 = new
		var/Hud_Object/Bars/N11/N11 = new
		var/Hud_Object/Bars/N12/N12 = new
		//var/Hud_Object/Clock/C1=new
		//var/Hud_Object/Hand/H1=new
		var/Hud_Object/Vill_Pic/F1/F1 = new
		var/Hud_Object/Vill_Pic/F2/F2 = new
		var/Hud_Object/Vill_Pic/F3/F3 = new
		var/Hud_Object/Vill_Pic/F4/F4 = new
		var/Hud_Object/Money/M=new
		src.client.screen += N1
		src.client.screen += N2
		src.client.screen += N3
		src.client.screen += N4
		src.client.screen += N5
		src.client.screen += N6
		src.client.screen += N7
		src.client.screen += N8
		src.client.screen += N9
		src.client.screen += N10
		src.client.screen += N11
		src.client.screen += N12
		//src.client.screen += C1
		//src.client.screen += H1
		src.client.screen += F1
		src.client.screen += F2
		src.client.screen += F3
		src.client.screen += F4
		src.client.screen += M
		spawn(1)
			src.Ryocheck()
	Ryocheck()
		set background=1
		for(var/Hud_Object/Money/Z in src.client.screen)
			Z.maptext="<b><font color=black>[applycommas(src.Ryo)]</b>"//"<b>[num2text(src.Ryo,20)]</b>"

