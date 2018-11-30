//Dont touch this code, this is what generates the shadow. Simply add this to your game and use
//GenerateShadow(src,DIRECTION)

atom/var/shadows[0]
atom/var/shadow = 0

///SHADOW GENERATOR FOR MOBS/////////////////////////////
proc/GenerateShadowMob(atom/A, var/Dir = EAST,alpha = 120,offset=0)
	var/shadow/SH = new ; SH.appearance = A ; SH.color = "black" ; SH.alpha = alpha
	var/icon/I = new/icon(A.icon,A.icon_state) //Used to calculate the size of the icon
	SH.pixel_y -= I.Height()/1.2
	if(Dir== SOUTH)
		var/matrix/M = matrix(); M.Turn(180) ; SH.transform = M
		SH.pixel_x = 0
	if(Dir == EAST)
		var/matrix/M = matrix(); M.Scale(-1,1); M.Turn(153);  SH.transform = M
		SH.pixel_x += I.Width()/5.1
		SH.pixel_y += offset

	if(Dir == WEST)
		var/matrix/M = matrix(); M.Scale(-1,1); M.Turn(205) ; SH.transform = M
		SH.pixel_x -= I.Width()/5.1
	A.shadows.Add(SH);A.underlays += SH
////////////////////////////////////////////////////////
proc/RemoveShadow(atom/A)
	if(A.shadows.len>=1) // Check to see if they have a shadow in their shadow list we created.
		for(var/shadow/S in A.shadows) //If a shadow is found.
			A.underlays -= S // Remove it from the underlays.
			A.shadows.Cut() // Remove it from the shadow list


///SHADOW GENERATOR FOR ENVIRONMENT//////////////////////
proc/GenerateShadow(atom/A, var/Dir = EAST,var/_y=0,_x=0)
	var/icon/I = new/icon(A.icon,A.icon_state)
	I.Flip(WEST)
	var/shadow/SH = new ; SH.icon = I ; SH.color = "black"
	SH.pixel_y -= (((_y * 60) + I.Height()/1) - (_x*12) -5)
	if(Dir== SOUTH)
		SH.pixel_x = 0 ; SH.transform = turn(SH.transform, 180)
	if(Dir == EAST)
		SH.pixel_x +=((_y * 16) + I.Width()/5) - (_x*2) ; SH.transform = turn(SH.transform, 153)
	if(Dir == WEST)
		SH.pixel_x -= I.Width()/5.1 ;SH.transform = turn(SH.transform, 205)
	A.shadows.Add(SH); A.underlays += SH
////////////////////////////////////////////////////////////

shadow
	parent_type = /obj
	layer = 5 ; density = 0 ; alpha = 120
	mouse_opacity=0
