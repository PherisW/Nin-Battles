var/NinjaPic = list(
"Sakura",'Sakura Haruno.png',
"Temari",'Temari.png',
"Pheris",'Pheris Hozuki.png')

Player
	proc
		Talk(var/atom/_object, Message, Response1 = null, Response2 = null)
			usr = src
			//usr._Movement_locked=1
			if(Response1==null)
				Response1 = "Continue"
			winset(usr, "Dialouge.Desc", "text='[Message]'")
			winset(usr, "Dialouge.Response1", "text=[Response1]")
			if(Response2)
				winset(usr, "Dialouge.Response2","text=[Response2]")
				winset(usr, "Dialouge.Response2", "is-visible=true")
			winset(usr, "child3","is-visible=true")
			winshow(usr,"Dialouge")
			sleep(10)
			//usr._Movement_locked=0

Quest
	var
		QuestName
		NPCStart
		Description
		Dialogue
		Quest_Requirement
		Reward
		Next_Quest
		Prereq
		MainLine
	New(var/_name)
		var/sql4dm/SqliteDatabaseConnection/conn = new("ProjectNindo.db")
		var/sql4dm/ResultSet/Q = conn.Query("SELECT * FROM QuestData WHERE QuestTitle = '[_name]'")
		while(Q.Next())
			QuestName = Q.GetString("QuestTitle")
			NPCStart = Q.GetString("NPC start")
			Description = Q.GetString("Description")
			Dialogue = Q.GetString("NPC Dialogue")
			Quest_Requirement =Q.GetString("Quest Requirement")
			Reward = Q.GetString("Reward")
			Next_Quest = Q.GetString("Next Quest")
			Prereq = Q.GetString("Prereq")
			MainLine = Q.GetString("MainLine")


