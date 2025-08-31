/obj/item/gun/ballistic/revolver/grenadelauncher/airgun
	name = "airgun"
	desc = "A complex masterwork of engineering that propells projectiles via pressurized steam."
	icon = 'icons/roguetown/weapons/bows.dmi'
	icon_state = "crossbow0"
	//icon = 'icons/roguetown/weapons/airgun.dmi'
	//icon_state = "airgun"
	possible_item_intents = list(/datum/intent/shoot/airgun, /datum/intent/arc/airgun, /datum/intent/mace/smash/heavy)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/airgun
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	bigboy = TRUE
	wlength = WLENGTH_LONG
	sellprice = 250
	can_parry = TRUE
	wdefense = BAD_PARRY
	wbalance = EASY_TO_DODGE
	force = DAMAGE_MACE - 5
	force_wielded = DAMAGE_MACE_WIELD
	cartridge_wording = "bullet"
	fire_sound = 'sound/combat/Ranged/firebow-shot-03.ogg'
	load_sound = 'sound/foley/nockarrow.ogg'
	equip_sound = 'sound/foley/gun_equip.ogg'
	pickup_sound = 'sound/foley/gun_equip.ogg'
	drop_sound = 'sound/foley/gun_drop.ogg'
	dropshrink = 0.7
	associated_skill = /datum/skill/combat/axesmaces //what is used when swinging with it
	var/cocked = FALSE

/obj/item/gun/ballistic/revolver/grenadelauncher/airgun/apply_components()
	AddComponent(/datum/component/steam_storage, 500, 0)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/ammo_box/magazine/internal/shot/airgun
	ammo_type = /obj/item/ammo_casing/caseless/bullet
	caliber = "musketball"
	max_ammo = 1
	start_empty = TRUE

/datum/intent/shoot/airgun
	chargedrain = 0 //no drain to aim

/datum/intent/shoot/airgun/get_chargetime()
	var/mob/living/master = get_master_mob()
	if(master && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 18
		newtime = newtime - (master.get_skill_level(/datum/skill/combat/crossbows) * 3)
		//per block
		newtime = newtime + 20
		newtime = newtime - (master.STAPER)
		if(newtime > 0)
			return newtime
		else
			return 0.1
	return chargetime

/datum/intent/arc/airgun
	chargetime = 1
	chargedrain = 0 //no drain to aim

/datum/intent/arc/airgun/get_chargetime()
	var/mob/living/master = get_master_mob()
	if(master && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 18
		newtime = newtime - (master.get_skill_level(/datum/skill/combat/crossbows) * 3)
		//per block
		newtime = newtime + 20
		newtime = newtime - (master.STAPER)
		if(newtime > 0)
			return newtime
		else
			return 1
	return chargetime

/obj/item/gun/ballistic/revolver/grenadelauncher/airgun/shoot_with_empty_chamber()
	if(!cocked)
		return
	playsound(src.loc, 'sound/combat/Ranged/crossbow_medium_reload-03.ogg', 100, FALSE)
	cocked = FALSE
	update_appearance(UPDATE_ICON_STATE)

/obj/item/gun/ballistic/revolver/grenadelauncher/airgun/attack_hand_secondary(mob/user, params)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!user.is_holding(src))
		to_chat(user, span_warning("I need to hold [src] to cock it!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(cocked)
		cocked = FALSE
		to_chat(user, span_warning("I carefully de-cock [src]."))
		playsound(src.loc, 'sound/combat/Ranged/crossbow_medium_reload-03.ogg', 100, FALSE)
	else
		playsound(src.loc, 'sound/combat/Ranged/crossbow_medium_reload-03.ogg', 100, FALSE)
		to_chat(user, span_warningbig("I cock [src]!"))
		cocked = TRUE
	update_appearance(UPDATE_ICON_STATE)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/ballistic/revolver/grenadelauncher/airgun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(user.usable_hands < 2)
		return FALSE
	if(user.get_inactive_held_item())
		return FALSE
	if(user.client)
		if(user.client.chargedprog >= 100)
			spread = 0
		else
			spread = 150 - (150 * (user.client.chargedprog / 100))
	else
		spread = 0
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/BB = CB.BB
		if(user.client.chargedprog >= 100)
			BB.accuracy += 15 //better accuracy for fully aiming
		if(user.STAPER > 8)
			BB.accuracy += (user.STAPER - 8) * 4 //each point of perception above 8 increases standard accuracy by 4.
			BB.bonus_accuracy += (user.STAPER - 8) //Also, increases bonus accuracy by 1, which cannot fall off due to distance.
		if(user.STAPER > 10)
			BB.damage = BB.damage * (user.STAPER / 10)

		if(user.STAPER > 10)
			BB.accuracy += (user.STAPER - 10) * 2 //each point of perception above 10 increases standard accuracy by 2.
			BB.bonus_accuracy += (user.STAPER - 10) //Also, increases bonus accuracy by 1, which cannot fall off due to distance.
		BB.bonus_accuracy += (user.get_skill_level(/datum/skill/combat/crossbows) * 4) //+4 accuracy per level. Bonus accuracy will not drop-off.
	. = ..()
	if(.)
		if(istype(user) && user.mind)
			var/modifier = 1.25/(spread+1)
			var/boon = user.get_learning_boon(/datum/skill/combat/crossbows)
			var/amt2raise = user.STAINT/2
			user.adjust_experience(/datum/skill/combat/crossbows, amt2raise * boon * modifier, FALSE)

/obj/item/gun/ballistic/revolver/grenadelauncher/airgun/update_overlays()
	. = ..()

