/datum/enchantment/orphan_bane
	enchantment_name = "Punishment"
	should_process = TRUE
	var/list/last_used = list()

/datum/enchantment/orphan_bane/on_pickup(obj/item/i, mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_ORPHAN))
		return
	to_chat(user, span_danger("The familiar weight of the weapon in your hand triggers a crippling memory of past beatings. You drop it in a panic!"))
	user.Paralyze(3 SECONDS)
	var/obj/item/I = user.get_active_held_item()
	if(I)
		user.dropItemToGround(I, silent = FALSE)

/datum/enchantment/orphan_bane/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	if(world.time < (src.last_used[source] + (5 SECONDS)))
		return
	if(isliving(target))
		var/mob/living/L = target
		if(is_matron_job(user.mind?.assigned_role))
			if(HAS_TRAIT(L, TRAIT_ORPHAN))
				switch(rand(1,3))
					if(1)
						L.apply_damage(10, BRUTE)
						L.Knockdown(10 SECONDS)
						to_chat(L, span_warning("The blow land, sending you on the ground as painful memory flash in your in mind"))
					if(2)
						L.OffBalance(10 SECONDS) //Kick them, Matron, Kick them.
						to_chat(L, span_warning("You instinctively recoil from the strike, staggering and losing your footing!"))
						to_chat(user, span_warning("[L] lost their footing when recoiling away from your strike!"))
					if(3) //Rolled the worst one.
						L.Paralyze(20 SECONDS)
						L.Knockdown(20 SECONDS)
						L.confused += 20 SECONDS
						to_chat(L, span_warning("The impact rattles your skull, leaving you dazed and down!"))
	last_used[source] = world.time
