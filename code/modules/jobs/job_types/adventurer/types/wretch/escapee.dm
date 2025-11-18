/datum/job/advclass/wretch/escapee
	title = "Red Sands Escapee"
	tutorial = "You are a survivor, a runaway. You managed to escape the brutal conditions of the zaladin silver mines, freeing yourself from a lifetime of servitude, but at a cost. You now roam Faience, seeking your worth and redemption, to prove you are more than a dying workhorse. Your former whiskered masters still hunt you, show those fools that noone, not even gods can own you."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/wretch/escapee
	total_positions = 1

	allowed_patrons = list(/datum/patron/divine/xylix, /datum/patron/inhumen/matthios, /datum/patron/godless/defiant) //theyve lost hope in most gods

/datum/outfit/wretch/escapee/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/neck/keffiyeh/colored/uncolored //bunch of stuff stolen from a guard/slaver, styled like the desert rider
	mask = /obj/item/clothing/face/facemask/prisoner //marked mask, I imagine zaladin would brand slaves but we don't have that so this works
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown
	wrists = /obj/item/rope/net
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots/leather/advanced
	gloves = /obj/item/clothing/gloves/angle
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/shalal
	armor = /obj/item/clothing/armor/leather/splint
	backpack_contents = list(
		/obj/item/lockpickring/mundane = 1,
		/obj/item/weapon/scabbard/knife = 1,
		/obj/item/rope/chain = 1, //old chains
		/obj/item/reagent_containers/glass/bottle/stronghealthpot = 1,
		/obj/item/explosive/bottle = 2,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/bombs, 3, TRUE) //had to escape somehow, giant smoking hole in the wall will do
	H.change_stat(STATKEY_STR, -3) //EXTREME malnutrition
	H.change_stat(STATKEY_PER, -1) //sunblindness from the desert work camps
	H.change_stat(STATKEY_END, 3) //used to being whipped and beaten
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, 4) //figured out how to escape
	H.change_stat(STATKEY_SPD, 2)

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)  //theyve been whipped so many times pain barely effects them
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)  //sneaky and speedy boi
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)

/datum/outfit/wretch/escapee/post_equip(mob/living/carbon/human/H) //mainly weapons stolen during escape, except for the dagger which is chain breaker gear
	var/static/list/selectableweapon = list( \
		"Whip" = /obj/item/weapon/whip, \
		"Dagger" = /obj/item/weapon/knife/jile/steel, \
		"Mace" = /obj/item/weapon/mace/goden/steel, \
		"Sabre" = /obj/item/weapon/sword/sabre, \
		)
	var/choice = H.select_equippable(H, selectableweapon, message = "Choose Your Specialisation", title = "BERSERKER")
	if(!choice)
		return
	switch(choice)
		if("Whip")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, 4, TRUE)
		if("Dagger")
			H.clamped_adjust_skillrank(/datum/skill/combat/knives, 4, 4, TRUE)
		if("Mace")
			H.clamped_adjust_skillrank(/datum/skill/combat/axesmaces, 4, 4, TRUE)
		if("Sabre")
			H.clamped_adjust_skillrank(/datum/skill/combat/swords, 4, 4, TRUE)
	wretch_select_bounty(H)
