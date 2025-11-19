/datum/job/advclass/cantor
	title = "Cantor"
	tutorial = "While other prospective inquisitors have their blades or their cords, you have faith. The Ordo Venatari has allowed the Ordo Sanctae Cruoris to bless you - Psydon hears your prayers. Play your music, soothe your allies' souls, and lull the unwary to sleep."
	outfit = /datum/outfit/job/cantor
	traits = list(TRAIT_DODGEEXPERT, TRAIT_EMPATH, TRAIT_INQUISITION, TRAIT_PSYDONIAN_GRIT, TRAIT_PSYDONITE)
	category_tags = list(CTAG_INQUISITION)

	jobstats = list(
		STATKEY_END = 1,
		STATKEY_SPD = 3,
	) //4 Statline

	skills = list(
		/datum/skill/misc/music = SKILL_LEVEL_MASTER,
		/datum/skill/magic/holy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/magic/blood = SKILL_LEVEL_JOURNEYMAN, //for their transfix. taught the basics by the Ordo Sanctae
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE
	)
	spells = list(
		/datum/action/cooldown/spell/undirected/transfix/lesser,
		/datum/action/cooldown/spell/vicious_mockery,
	)

/datum/outfit/job/cantor/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/armor/leather/studded/cantor
	backl = /obj/item/storage/backpack/satchel/otavan
	cloak = /obj/item/clothing/cloak/cantor
	shirt = /obj/item/clothing/armor/gambeson/heavy/inq
	gloves = /obj/item/clothing/gloves/leather/otavan
	wrists = /obj/item/clothing/neck/psycross/silver
	pants = /obj/item/clothing/pants/tights/colored/black
	shoes = /obj/item/clothing/shoes/psydonboots
	belt = /obj/item/storage/belt/leather/knifebelt/black/psydon
	beltr = /obj/item/weapon/knife/dagger/silver/psydon
	beltl = /obj/item/storage/belt/pouch/coins/mid
	ring = /obj/item/clothing/ring/signet/silver
	backpack_contents = list(
		/obj/item/key/inquisition = 1,
		/obj/item/paper/inqslip/arrival/ortho = 1,
		/obj/item/collar_detonator = 1,
	)

	if(H.mind)
		var/weapons = list("Harp","Lute","Accordion","Guitar","Hurdy-Gurdy","Viola","Vocal Talisman", "Psyaltery", "Flute")
		var/weapon_choice = browser_input_list(H, "Choose your instrument.", "TAKE UP ARMS", weapons)
		H.set_blindness(0)
		switch(weapon_choice)
			if("Harp")
				backr = /obj/item/instrument/harp
			if("Lute")
				backr = /obj/item/instrument/lute
			if("Accordion")
				backr = /obj/item/instrument/accord
			if("Guitar")
				backr = /obj/item/instrument/guitar
			if("Hurdy-Gurdy")
				backr = /obj/item/instrument/hurdygurdy
			if("Viola")
				backr = /obj/item/instrument/viola
			if("Vocal Talisman")
				backr = /obj/item/instrument/vocals
			if("Psyaltery")
				backr = /obj/item/instrument/psyaltery
			if("Flute")
				backr = /obj/item/instrument/flute

/datum/outfit/job/cantor/post_equip(mob/living/carbon/human/H, visuals_only)
	. = ..()
	GLOB.inquisition.add_member_to_school(H, "Order of the Venatari", 0, "Cantor")
