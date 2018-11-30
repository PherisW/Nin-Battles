mob/var/Ctoggle=1
atom
	Click()
		..()
		if(!usr.Ctoggle)
			usr.Ctoggle=1
			//world << "CHECK"
			//winset(usr,null,"Textbox.transparent-color = #000;Textbox.input1.border=none;Textbox.output1.border=none;Textbox.label2.border=none;Textbox.titlebar=false;Textbox.is-default=false;mainwindow.is-default=false;oocbutton.is-visible=false;sarahbutton.is-visible=false;saybutton.is-visible=false;label2.is-visible=false;Mainwindow.Map.focus=true")
			winset(usr,"Texts.input2","focus=false")
			winset(usr,null,"textbox2.is-visible=false")
mob
	verb
		ChatToggle()
			set hidden = 1
			/*if(!Ctoggle)
				Ctoggle=1
				for(var/turf/o in world)
					if(Click(o,"Mainwindow.Map"))
						//winset(usr,null,"Textbox.transparent-color = #000;Textbox.input1.border=none;Textbox.output1.border=none;Textbox.label2.border=none;Textbox.titlebar=false;Textbox.is-default=false;mainwindow.is-default=true")
						winset(usr,"Textbox2.is-default=true;is-visible=true")
					winset(usr, "Textbox","border=none")*/
//					else
			if(Ctoggle)
				Ctoggle=0
				//winset(usr,"Texts","input2.is-default=true")
				winset(usr,"Texts","focus=true")
				winset(usr,null,"textbox2.is-visible=true")
				//winset(usr,null,"Textbox.transparent-color = none;Textbox.input1.border=sunken;Textbox.output1.border=sunken;Textbox.label2.border=sunken;Textbox.titlebar=true;Textbox.is-default=true;mainwindow.is-default=false;oocbutton.is-visible=true;sarahbutton.is-visible=true;saybutton.is-visible=true;label2.is-visible=true;Textbox.input1.focus=true")
