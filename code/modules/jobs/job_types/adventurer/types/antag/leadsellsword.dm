/datum/job/advclass/banditlead/leadsellsword //Strength class, starts with axe or flails and medium armor training
    title = "Travelled Mercenary"
    tutorial = "You used to fight for coin, being paid to end lives by those who never had to risk their own, you were the best of the best, employers would pay for your ferry just for a chance at your services. Eventually you realized how insufferable these employers were, you brought your sellswords to join you on this new life, the one where you could simply punch the nobles you couldn't stomach."
    category_tags = list(CTAG_BANDITLEAD)
    allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
    jobstats = list(
        STATKEY_STR = 1,
        STATKEY_END = 2,
        STATKEY_CON = 2,
        STATKEY_INT = 2,
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
    outfit = /datum/outfit/banditlead/leadsellsword

/datum/outfit/banditlead/leadsellsword
    belt = /obj/item/storage/belt/leather
    pants = /obj/item/clothing/pants/chainlegs
    shirt = /obj/item/clothing/armor/chainmail
    shoes = /obj/item/clothing/shoes/boots
    backr = /obj/item/storage/backpack/satchel
    mask = /obj/item/clothing/face/facemask/goldmask
    wrists = /obj/item/clothing/wrists/bracers/jackchain
    neck = /obj/item/clothing/neck/chaincoif
    armor = /obj/item/clothing/armor/brigandine/light
    head = /obj/item/clothing/head/hatfur
    gloves = /obj/item/clothing/gloves/leather
    cloak = /obj/item/clothing/cloak/cape/crusader

    backpack_contents = list(
        /obj/item/needle/thorn = 1,
        /obj/item/natural/cloth = 1
    )

/datum/job/advclass/banditlead/leadsellsword/after_spawn(mob/living/carbon/human/H)
    . = ..()
    var/weapons = list("Halberd", "Warhammer and Shield")
    var/weapon_choice = input(H, "CHOOSE YOUR WEAPON.", "GO ROB SOME FOOLS.") as anything in weapons
    switch(weapon_choice)
        if("Halberd")
            H.equip_to_slot_or_del(new /obj/item/weapon/polearm/halberd, ITEM_SLOT_BACK_L, TRUE)
            H.equip_to_slot_or_del(new /obj/item/weapon/sword, ITEM_SLOT_BELT_L, TRUE)
            H.put_in_hands(new /obj/item/weapon/scabbard/sword/noble(get_turf(H)), TRUE)
            H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
            H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
        if("Warhammer and Shield")
            H.equip_to_slot_or_del(new /obj/item/weapon/mace/warhammer/steel, ITEM_SLOT_BELT_L, TRUE)
            H.equip_to_slot_or_del(new /obj/item/weapon/shield/heater, ITEM_SLOT_BACK_L, TRUE)
            H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
            H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
