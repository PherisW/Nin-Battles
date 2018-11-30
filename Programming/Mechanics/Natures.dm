/*
Sution > Katon > Fuuton > Ration > Doton > Suiton
Kekkei Tota
Kekkei Genkai

Elemental Descriptions
	Earth(Doton)
		Mastery Ability: Change the state of the earth being manipulated without handseals
		allows the user to manipulate the surrounding earth
		for offensive and defensive purposes or create it;
		be it dirt, mud, or rock.
	Fire(Katon)
		Mastery Ability: Blue flames that are guarrented to burn and leave a trail
		It is performed by moulding superheated chakra inside
		the stomach before releasing it via the lungs and mouth.
		There are also variants to this in the form of some mediums
		such as the use of gun powder, ash, explosive tags and
		chakra flow into a weapon.
	Water(Suiton)
		Mastery Ability: Make them dense and create with no water source
		allows the user to manipulate pre-existing water, or create their
		own, by turning their chakra into water.It takes much more
		ability to create the water outside the body than to manipulate
		 what is already available or expel it from their mouths.
	Wind(Fuuton)
		Mastery Ability
			can change the thickness of chakra for a concussive/knockback Style or a slash/bleeding Style jutsu
	Lightning(Ration)
		Mastery Ability: Can be improved into Black Lightning if taught by an existing member.
Affinity
	Everyone gets one element affinty at random but many factors go into play of what it will be.
		Clan and village
	There is a chance to be born with more than one affinity but it is quite extremely rare (less rare for non clans)
*/
var/const
	Element_Prob = 33
	Kekkai_Genkai = 10
	Kekkai_Totai = 5

proc/AffinityPick(Player/Ninja)
	var/tmp/aff
	var/bonus =0
	if(Ninja.clan == "None")
		bonus = 5
	else if(Ninja.clan == "Uchiha")
		aff = "Katon"

	else if(prob(Kekkai_Genkai + bonus))
		Ninja << "You were born with a Kekkai_Genkai!"

	else if(prob(Kekkai_Totai + bonus))
		Ninja << "You were born with the very rare Kekkai Tokai of Dust Relase "
	else
		aff = pick(prob(Element_Prob);"Katon",prob(Element_Prob);"Suiton",prob(Element_Prob);"Ration",prob(Element_Prob);"Doton",prob(Element_Prob);"Fuuton")
		Ninja << "Your element is [aff]!"
		Ninja.affinty_element = aff
