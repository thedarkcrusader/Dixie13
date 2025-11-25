/datum/job/advclass/banditlead/leadbrigand //Strength class, starts with axe or flails and medium armor training
    title = "Warband Leader"
    tutorial = "You lead these groups of free men through the worst of the worst, standing on the front line while leading by example, you could have cared less for leadership but time changed you. Tactics started making sense, the success started pouring in."
    category_tags = list(CTAG_BANDITLEAD)
    allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
    jobstats = list(
        STATKEY_STR = 2,
		STATKEY_PER = -2,
        STATKEY_END = 2,
        STATKEY_CON = 3,
        STATKEY_INT = 1,
        STATKEY_SPD = -1,
    )

    skills = list(
        /datum/skill/misc/reading = 1,
        /datum/skill/misc/climbing = 3,
        /datum/skill/misc/athletics = 4,
        /datum/skill/misc/sewing = 1,
        /datum/skill/misc/medicine = 1,
        /datum/skill/craft/crafting = 2,
        /datum/skill/craft/carpentry = 1,
        /datum/skill/combat/polearms = 2,
        /datum/skill/combat/axesmaces = 2,
        /datum/skill/combat/wrestling = 3,
        /datum/skill/combat/unarmed = 3,
        /datum/skill/combat/swords = 2,
        /datum/skill/combat/shields = 2,
        /datum/skill/combat/whipsflails = 2,
        /datum/skill/combat/knives = 2,
        /datum/skill/combat/bows = 2,
        /datum/skill/combat/crossbows = 2,
    )

    traits = list(
        TRAIT_MEDIUMARMOR,
    )

    cmode_music = 'sound/music/cmode/antag/combat_bandit2.ogg'
    outfit = /datum/outfit/banditlead/leadbrigand

/datum/outfit/banditlead/leadbrigand
    belt = /obj/item/storage/belt/leather
    pants = /obj/item/clothing/pants/trou/leather/splint
    shirt = /obj/item/clothing/armor/gambeson/arming
    shoes = /obj/item/clothing/shoes/boots/armor/ironmaille
    backr = /obj/item/storage/backpack/satchel
    mask = /obj/item/clothing/face/facemask/goldmask
    wrists = /obj/item/clothing/wrists/bracers
    neck = /obj/item/clothing/neck/chaincoif
    armor = /obj/item/clothing/armor/cuirass/fluted
    head = /obj/item/clothing/head/helmet/leather/volfhelm
    gloves = /obj/item/clothing/gloves/leather/advanced
    cloak = /obj/item/clothing/cloak/cape/thief/brown

    backpack_contents = list(
        /obj/item/needle/thorn = 1,
        /obj/item/natural/cloth = 1
    )

/datum/job/advclass/banditlead/leadbrigand/after_spawn(mob/living/carbon/human/H)
    . = ..()
    var/weapons = list("Great Axe", "Warhammer and Shield")
    var/weapon_choice = input(H, "CHOOSE YOUR WEAPON.", "GO ROB SOME FOOLS.") as anything in weapons
    switch(weapon_choice)
        if("Great Axe")
            H.equip_to_slot_or_del(new /obj/item/weapon/greataxe/steel, ITEM_SLOT_BACK_L, TRUE)
            H.equip_to_slot_or_del(new /obj/item/weapon/axe/steel, ITEM_SLOT_BELT_L, TRUE)
            H.put_in_hands(new /obj/item/weapon/scabbard/sword/noble(get_turf(H)), TRUE)
            H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
            H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
        if("Katar and Knuckle")
            H.equip_to_slot_or_del(new /obj/item/weapon/mace/warhammer/steel, ITEM_SLOT_BELT_L, TRUE)
            H.equip_to_slot_or_del(new /obj/item/weapon/shield/heater, ITEM_SLOT_BACK_L, TRUE)
            H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
            H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
