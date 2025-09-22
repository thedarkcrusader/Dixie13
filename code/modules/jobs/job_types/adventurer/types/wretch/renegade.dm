/datum/advclass/wretch/renegade
	name = "Renegade"
	tutorial = "A renegade, a deserter, a gunslinger. \
	Favoured by Matthios, you've turned your back on the Black Empire and Psydon alike. \
	You wander around Faience, wielding black powder, grit, and a gambler's instinct."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_GRENZ
	outfit = /datum/outfit/job/wretch/renegade
	category_tags = list(CTAG_WRETCH)
	maximum_possible_slots = 1
	pickprob = 25

//basically adept turned back into a bandit, stole gear from the inquisition
/datum/outfit/job/wretch/renegade/pre_equip(mob/living/carbon/human/H)
	H.set_patron(/datum/patron/inhumen/matthios) //The idea is that they're a matthiosite with a boon from said god.

	neck = /obj/item/clothing/neck/highcollier/iron/renegadecollar
	armor = /obj/item/clothing/armor/leather/jacket/leathercoat/renegade
	mask = /obj/item/clothing/face/spectacles/inqglasses
	pants =  /obj/item/clothing/pants/trou/leather
	shirt = /obj/item/clothing/armor/gambeson/heavy/colored/dark
	armor = /obj/item/clothing/armor/leather/jacket/leathercoat/renegade
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/black
	gloves = /obj/item/clothing/gloves/leather
	shoes = /obj/item/clothing/shoes/boots
	wrists = /obj/item/clothing/wrists/bracers/iron
	beltl =  /obj/item/weapon/sword/iron
	beltr = /obj/item/storage/belt/pouch/bullets
	backpack_contents = list(
		/obj/item/weapon/knife/hunting = 1,
		/obj/item/gun/ballistic/revolver/grenadelauncher/pistol = 1,
		/obj/item/reagent_containers/glass/bottle/aflask = 1,
		/obj/item/storage/fancy/cigarettes/zig = 1,
		/obj/item/flint = 1,
	)

	//combat
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)

	//athletics and movement
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)

	//crafting
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)

	//misc
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)

	//stats
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_LCK, 2) //Lucky son of a bitch
	//since the conjured puffer was removed, the luck is their boon

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

/datum/outfit/job/wretch/renegade/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()

	var/option = browser_input_list(H, "Do you wish for a random title?", "RENEGADE", DEFAULT_INPUT_CHOICES)
	if(option)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title
		var/list/titles = list("The Showoff", "The Gunslinger", "Mammon Shot", "The Desperado", "Last Sight", "The Courier", "Lethal Shot", "Guns Blazing", "Punished Shade", "The One Who Sold Creation", "V1", "V2", "The Opposition", "Mattarella", "High Noon", "Subterra-Walker", "Big Iron") //Dude, Trust.
		title = pick(titles)
		H.real_name = "[prev_real_name], [title]"
		H.name = "[prev_name], [title]"

	var/static/list/selectablehat = list(
		"Tricorn" = /obj/item/clothing/head/helmet/leather/tricorn,
		"Former Inquisitors hat" = /obj/item/clothing/head/leather/inqhat,
		"Hood" = /obj/item/clothing/head/roguehood/colored/random/,
	)
	H.select_equippable(H, selectablehat, message = "Choose your hat of choice", title = "RENEGADE")

	if(!H.has_language(/datum/language/oldpsydonic))
		H.grant_language(/datum/language/oldpsydonic)
		to_chat(H, span_info("I can speak Old Psydonic with ,m before my speech."))

	wretch_select_bounty(H)
