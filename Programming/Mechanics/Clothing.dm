/*
list dictionary
take the data info into a multi-array
Item:Stats,Clothing_Type,Rarity,Sell Value
*/


var
	const
		LONG = 'hair_long.dmi'
		MADARA = 'hair_madara.dmi'
		ANKO = 'hair_anko.dmi'
		HINATA = 'hair_hinata.dmi'
		MEI = 'hair_mei.dmi'
		SASORI = 'hair_sasori.dmi'


	hairlist = list(
	"Long" = 'hair_long.dmi',
	"Madara" = 'hair_madara.dmi',
	"Mei" = 'hair_mei.dmi',
	"Sasori" = 'hair_sasori.dmi',
	"Afro" = 'hair_afro.dmi',
	"Anko" = 'hair_anko.dmi',
	"Asuma" = 'hair_asuma.dmi',
	"Tenten" = 'hair_buns.dmi',
	"Fade" = 'hair_buzz cut.dmi',
	"Choji" = 'hair_choji.dmi',
	"Deidara" = 'hair_deidara.dmi',
	"Haku" = 'hair_haku.dmi',
	"Hidan" = 'hair_hidan.dmi',
	"Hinata" = 'hair_hinata.dmi',
	"Ino" = 'hair_ino.dmi',
	"Itachi" = 'hair_itachi.dmi',
	"Jiraiya" = 'hair_jiraiya.dmi',
	"Juugo" = 'hair_juugo.dmi',
	"Kabuto" = 'hair_kabuto.dmi',
	"Kakashi" = 'hair_kakashi.dmi',
	"Kisame" = 'hair_kisame.dmi',
	"Konan" = 'hair_konan.dmi',
	"Lee" = 'hair_lee.dmi',
	"Edgy" = 'hair_mohawk.dmi',
	"Nagato" = 'hair_nagato.dmi',
	"Orochimaru" = 'hair_orochimaru.dmi',
	"Raggy" = 'hair_raggy.dmi',
	"Sakura" = 'hair_sakura.dmi',
	"Sasuke(Teen)" = 'hair_sasuke time skip.dmi',
	"Sasuke(Young)" = 'hair_sasuke.dmi',
	"Shikamaru" = 'hair_shikamaru.dmi',
	"Short" = 'hair_short.dmi',
	"Spikey" = 'hair_spikey.dmi',
	"Temari" = 'hair_temari.dmi',
	"Zabuza" = 'hair_zabuza.dmi',

	)

	headbandlist = list(
	"Around Neck" = 'Around Neck.dmi',
	"As Shirt" = 'As Shirt.dmi',
	"Backwards" = 'Backwards.dmi',
	"Bandanna" = 'Bandanna Style.dmi',
	"Choji Style" = 'Choji Style.dmi',
	"Top of the Head" = 'Head Band.dmi',
	"Eyepatch" = 'Kakashi Style.dmi',
	"Neji Style" = 'Neji Style.dmi',
	"Standard" = 'Normal.dmi',
	"Arm" = 'On Arm.dmi',
	"Leg" = 'On Leg.dmi',
	"Zabuza Style" = 'Zabuza Style.dmi',
	)


	clothlist = list(
	"Akatsuki Robe" = 'akacloak.dmi',
	"Akatsuki Robe(Open)" = 'akacloak2.dmi',
	"Akatsuki Hat" = 'akahat.dmi',
	"Straw Hat" = 'Big Hat.dmi',
	"Sandals" = 'blacksandels.dmi',
	"Goggles" = 'Goggles.dmi',
	"Kiri Pants" = 'mistpants.dmi',
	"Kiri Shirt" = 'mistshirt.dmi',
	"Red Battle Armor" = 'Red Armor.dmi',
	"Suna Flak Jacket" = 'SandVest.dmi',
	"Suna Robes" = 'Suna_Formal.dmi',
	"Akamichi Clan Outfit" = 'akamichiclothes.dmi',
	"Choji (Teen) Outfit" = 'Akimichi(Time Skip Clothes).dmi',
	"Hunter Ninja Robe" = 'ANBUmistRobe.dmi',
	"Kona Anbu Battle Suit" = 'ANBUattacksuit.dmi',
	"Kona Flak Jacket" = 'LeafVest.dmi',
	"Kiri Flak Jacket" = 'MistVest.dmi',
	//"Kumo Flak Jacket" = 'CloudVest.dmi',
	"Blue Battle Armor" = 'Blue Armor.dmi',
	"Cloak" = 'cloak.dmi',
	"FishNet Undershirt" = 'colornetshirt.dmi',
	"Baggy Pants" = 'colorpantsbaggy.dmi',
	"Light Armor" = 'colorxvest.dmi',
	"Deidara Outfit" = 'deidaraclothes.dmi',
	"Demon Brothers Outfit" = 'Demoncloak.dmi',
	"Dosu Outfit" = 'Dosu.dmi',
	"Edo Cloak" = 'EdoCloak.dmi',
	"Gaara Outfit" = 'Gaarasuit.dmi',
	"Green Armor" = 'Green Armor.dmi',
	"Haku Outfit" = 'Haku Clothes.dmi',
	"Haku's Mask" = 'Haku mask.dmi',
	"Hanzou's Mask" = 'Hanzou Mask.dmi',
	"Suigetsu Outfit" = 'hozuki_clothing.dmi',
	"Neji(Young) Outfit" = 'Hyuugasuit.dmi',
	"Itachi Outfit" = 'Itachi Clothing.dmi',
	"Jiraiya Outfit" = 'jiraiya outfit.dmi',
	"Kona Jounin Undershirt" = 'jsuit2.dmi',
	"Snake Sage Outfit" = 'kabutocloak.dmi',
	"Kimimaru Outfit" = 'Kaguya Clothes.dmi',
	"Kakashi Outfit(Young)" = 'kakashigaiden.dmi',
	"Kakuzu Outfit" = 'Kakuzu clothes.dmi',
	"Kakuzu's Mask" = 'Kakuzu mask.dmi',
	"Evil Armor" = 'Kalak.dmi',
	"Evil Mask" = 'KalakHelm.dmi',
	"Karin Outfit" = 'karinclothing.dmi',
	"Kiba Outfit" = 'KibaSuit.dmi',
	"White Mask" = 'Madaran.dmi',
	"Might Guy Outfit" = 'Maitosuit.dmi',
	"White Cloak" = 'Matt.dmi',
	"Medical Mask" = 'medicalmask.dmi',
	"Medical Pants" = 'medicalpants.dmi',
	"Medical Shirt" = 'medicaltop.dmi',
	"Shikamaru Outfit" = 'Narasuit.dmi',
	"Naruto(Teen) Outfit" = 'Naruto.dmi',
	"Naruto(Young) Outfit" = 'NarutoPast.dmi',
	"Hyuuga Outfit" = 'nejiTSclo.dmi',
	"Face Mask" = 'ninjamask.dmi',
	"Scarf" = 'ninjascarf.dmi',
	"Pants" = 'pants.dmi',
	"Sarutobi Battle Outfit" = 'Robe.dmi',
	"Sai Outfit" = 'sai_clothes.dmi',
	"Suna Head Turban" = 'sandmask.dmi',
	"Sasuke (Young)" = 'Sasuke Outfit.dmi',
	"Sasuke (Hebi)" = 'SasukeSound.dmi',
	"Shades" = 'Shades.dmi',
	"Shino Outfit" = 'Shino Out Fit.dmi',
	"Sound Belt" = 'Sound Cloths.dmi',
	"Orange Mask" = 'Tobimask.dmi',
	"Zabuza's Outfit" = 'zab2.dmi',
	"Zabuza's Face Bandage" = 'ZabuzaFB.dmi',
	"Hokage Hat" = 'Hokagehat.dmi',
	"Hokage Cloak" = 'hokagecloak.dmi',

	)


	weaplist = list(
	"Gourd" = 'Garra Gourd.dmi',
	"Hiramekarei" = 'Hiramekarei.dmi',
	"Hiramekarei(Awakened)" = 'Hiramekarei(Unleashed).dmi',
	"Samehada" = 'Samehada.dmi',
	"Samehada(Awakened)" = 'Samehada2.dmi',
	"Shibuki" = 'SplashSword.dmi',
	"Aburame Jar" = 'Aburamejar.dmi',
	"Large Fan" = 'Fan.dmi',
	"Chakra Knives" = 'AsumaKnives.dmi',
	"Chakra Knives(Left)" = 'AsumaKnife1_Chakra.dmi',
	"Chakra Knives(Right)" = 'AsumaKnife2_Chakra.dmi',
	"Tanto" = 'Hatake Tanto.dmi',
	"Katana" = 'Held.dmi',
	"3 Pronged Scythe" = 'Hidan3S.dmi',
	"Staff" = 'hokagestaff.dmi',
	"Sage Scroll" = 'JirayaScroll.dmi',
	"Kabutowari" = 'KabutowariSword.dmi',
	"Kunai" = 'kunai.dmi',
	"Kusarigama" = 'Kusarigama.dmi',
	"Kusangi" = 'Legendarykusangi.dmi',
	"Sword" = 'ninjasword.dmi',
	"Nuibari" = 'NuibariSword.dmi',
	"Raiga" = 'RaigaSword.dmi',
	"Raijin" = 'Raijin Sword.dmi',
	"Shurikens" = 'Shurikens.dmi',
	"Flute" = 'tayuya_flute.dmi',
	"Senbons" = 'Throwing_Needle.dmi',
	"Kubikiribocho" = 'Zabuzacleaver.dmi',
	"Broadsword" = 'ZanbatouSword.dmi',




	)


	layerlist= list(
			"CHEST" = 1,"ARMOR" = 2,"EYEWEAR"=3,"PANTS" = 1,"SHOES" = 2,
			"CLOAK"=3,"HAT" = 5,"HAIR" = 4,"EYE" = 0,
			"AURAS" = -1,"WEAPONS" = 6,"OUTFIT"=1)

	itemlist = list(
	"Chakra Card" = 'Chakracard.dmi',
	)


/*
Layering
	basic overlays
		Chest
		Armor/Cloak
		Pants
		Shoes
		Headband(Hat)
		Hair
		Eye Effects
		Auras
		Weapons
*/
Items
	var
		value
		_type
		resale_value
		bound=0
	Apparel
		Click(grid2)
			if(src.worn)
				usr.overlays -= src
				src.worn=0
				RemoveShadow(usr)
				GenerateShadowMob(usr,EAST)
			else if(!src.worn)
				usr.overlays += src
				src.worn=1
				RemoveShadow(usr)
				GenerateShadowMob(usr,EAST)
		var
			clothing_type
			Hat
			worn
			Shoe
			description
			_stat1
			_stat2
			const
				CHEST = 1
				ARMOR = 2
				EYEWEAR=3
				PANTS = 1
				SHOES = 2
				CLOAK=3
				HAT = 5
				HAIR = 4
				EYE = 0
				AURAS = -1
				WEAPONS = 6
		proc
			wear(Player/Ninja)
		New(var/_name)
			var/sql4dm/SqliteDatabaseConnection/conn = new("ProjectNindo.db")
			var/sql4dm/ResultSet/createq = conn.Query("SELECT * FROM ItemList WHERE ItemName = '[_name]'")
			while (createq.Next())
				src.icon = clothlist["[_name]"]
				src.icon_state=""
				src.name = createq.GetString("ItemName")
				src._type = createq.GetString("Type")
				src.clothing_type = createq.GetString("EquipLoc")
				src.description = createq.GetString("Description")
				//src.icon_state = createq.GetString("IconState")
			src.layer=4 + (layerlist["[src.clothing_type]"]/10)
			..()
		Hair
			clothing_type="HAIR"
			//color=rgb(255,244,255)
			var/hairselect=(null)
			//icon=hairlist["Madara"]
			New(var/Player/Player,hairstyle,Color = rgb(rand(0,255),rand(0,255),rand(0,255)))
				..()
				src.icon = hairlist[hairstyle]
				src.icon += Color
				Player.hairselect = src
				Player.overlays += src
		Shinobi_Head_Protector
			clothing_type=HAT
			var
				color_set = "Blue"
				Style = "Normal"
		Sandals
			clothing_type=SHOES
			icon = 'blacksandels.dmi'
			description = "Better than nothing."
		ChuuninVest
			var
				village="Leaf"
			icon='LeafVest.dmi'
			New(village="Leaf")
				if(village=="Sand")
					icon='SandVest.dmi'
					..()
		Mist_Shirt
			clothing_type=CHEST
			icon='mistshirt.dmi'
			description = "Part standard attire of the ninjas of the Mist."
		Mist_Pants
			clothing_type=PANTS
			icon='mistpants.dmi'
			description = "Part of the standard attire of the ninjas of the Mist."
		Akat_Robe
			clothing_type=CLOAK
			//layer=4.2
			icon='akacloak2.dmi'
			description = "The offical suit of the Infamous Akatsuki."
		Akat_Hat
			clothing_type=HAT
			//layer=4.3
			icon='akahat.dmi'
			description = "The offical hat of the Infamous Akatsuki."
		Goggles
			clothing_type=EYEWEAR
			icon = 'Goggles.dmi'
			description = "Not that fashionable, but they protect your eyes."
		Mask
			clothing_type=EYEWEAR
			icon = 'ninjamask.dmi'
			description = "You don't want to catch a cold, right?"
		Fan
			clothing_type=WEAPONS
			icon = 'Fan.dmi'
			description = "A replica of the iron fan the great Temari uses."
		Sand_Robes
			clothing_type=CLOAK
			icon = 'Suna_Formal.dmi'
			description = "The offical attire of the Sand Villagers."
		Straw_Hat
			clothing_type=HAT
			icon = 'Big Hat.dmi'
			description = "The offical hat of a young pirate."
		Red_Armor
			clothing_type=ARMOR
			icon = 'Red Armor Uchiha.dmi'
			description = "The armor of the great Madara Uchiha. You can still smell blood from it."
		Gourd
			clothing_type=WEAPONS
			icon = 'Garra Gourd.dmi'
			description = "Just a simple gourd to contain sand in."
