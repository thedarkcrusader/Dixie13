/obj/item/servant_bell
	name = "service bell"
	desc = "Summon a servant to you. This enchanted bell resonates its chime in the minds of those who serve you. There is not enough silver present to be effective against those who live in death."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "servantbell"
	detail_tag = "_detail"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	detail_color = CLOTHING_MAGE_BLUE

	dropshrink = 0.7
	grid_height = 32
	grid_width = 32

	var/hear_distance = 40 // just a little shorter than Vanderlin's manor
	// if other roles needed these it can be subtyped with this. in the future it might be better to bind these
	// to players but that's not really necessary atm
	var/list/servant_types = list(/datum/job/butler, /datum/job/servant)

	COOLDOWN_DECLARE(nearby_ring_bell)
	var/nearby_cooldown = 5 SECONDS
	COOLDOWN_DECLARE(ring_bell_noble)
	var/noble_cooldown = 1 MINUTES
	COOLDOWN_DECLARE(ring_bell)
	var/cooldown = 3 MINUTES

/obj/item/servant_bell/attack_self(mob/living/user, params)
	. = ..()
	if(!istype(user)) // ???
		return
	if(HAS_TRAIT(user, TRAIT_NOBLE))
		if(COOLDOWN_FINISHED(src, ring_bell_noble))
			ring_bell(user)
			// reset both cooldowns so we can't just have a noble ring it and then a beggar
			COOLDOWN_START(src, ring_bell_noble, noble_cooldown)
			COOLDOWN_START(src, nearby_ring_bell, nearby_cooldown)
			return
	else if(COOLDOWN_FINISHED(src, ring_bell))
		ring_bell(user)
		// same as above
		COOLDOWN_START(src, ring_bell, cooldown)
		COOLDOWN_START(src, nearby_ring_bell, nearby_cooldown)
		return

	//A fake ring that doesnt ping all the servants if we're on cooldown
	if(COOLDOWN_FINISHED(src, nearby_ring_bell))
		nearby_ring_bell(user)
		COOLDOWN_START(src, nearby_ring_bell, nearby_cooldown)
		//resets our cooldowns to the minimum here so we can't double up and do weird stuff
		if(COOLDOWN_TIMELEFT(src, ring_bell_noble) < nearby_cooldown)
			COOLDOWN_START(src, ring_bell_noble, nearby_cooldown)
		if(COOLDOWN_TIMELEFT(src, ring_bell) < nearby_cooldown)
			COOLDOWN_START(src, ring_bell, nearby_cooldown)


//just the local sound
/obj/item/servant_bell/proc/nearby_ring_bell(mob/living/user)
	// This sound was also done by fem_tanyl
	playsound(src, 'sound/items/servant_bell.ogg', 100, TRUE)

/obj/item/servant_bell/proc/ring_bell(mob/living/user)
	user.visible_message("[user] rings [src].")
	nearby_ring_bell(user)
	var/turf/origin_turf = get_turf(src)
	for(var/mob/living/player in GLOB.player_list)
		if(player.stat == DEAD)
			continue
		if(!player.can_hear())
			continue
		if(isbrain(player))
			continue
		//if(player == user)
		//	continue
		if(!is_in_zweb(player.z, origin_turf.z))
			continue
		if(!is_type_in_list(player.mind.assigned_role, servant_types))
			continue
		var/distance = get_dist(player, origin_turf)
		if(distance > hear_distance)
			continue
		player.apply_status_effect(/datum/status_effect/signal_horn/servant_bell, null, origin_turf)
		var/dirText = ""
		var/z_dist = origin_turf.z - player.z
		if(z_dist != 0)
			var/abs_z = abs(z_dist) // we can tell which floor it's on if it's only 2 away
			switch(abs_z)
				if(1)
					dirText += " one story"
				if(2)
					dirText += " two stories"
				else
					dirText += " far"
			dirText += z_dist > 0 ? " above me" : " below me"
		to_chat(player, span_warning("I hear a service bell being rung[dirText]."))
		if(distance <= 7)
			continue
		//sound played for other players, by fem_tanyl !!!1!!
		player.playsound_local(get_turf(player), 'sound/items/servant_bell.ogg', 35, FALSE, pressure_affected = FALSE)

/datum/status_effect/signal_horn/servant_bell
	id = "servant bell indicator"
	duration = 25 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/servant_bell

/atom/movable/screen/alert/status_effect/servant_bell
	name = "Servant Bell"
	desc = "I've been summoned by the bell."
	icon_state = "servant_bell"
