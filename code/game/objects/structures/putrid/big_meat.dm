/obj/structure/meatvine/papameat
	name = "papa meat"
	desc = "You feel a combination of fear and disgust, just by looking at that thing."
	icon = 'icons/obj/cellular/papameat.dmi'
	icon_state = "papameat"
	density = TRUE

	pass_flags = PASSTABLE

	max_integrity = 1000

	pixel_x = -48
	pixel_y = -48

	var/healed = FALSE

	var/obj/effect/abstract/particle_holder/Particle

/obj/structure/meatvine/papameat/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)

	Particle = new(src, /particles/papameat)

	set_light(3, 3, 1, l_color = "#ff6533")

/obj/structure/meatvine/papameat/Destroy()
	// Notify master before destruction
	if(master)
		master.papameat_destroyed(src)

	puff_gas(TRUE)
	STOP_PROCESSING(SSfastprocess, src)
	qdel(Particle)
	return ..()

/obj/structure/meatvine/papameat/attackby(obj/item/I, mob/user, params)
	if(!master)
		return ..()

	// Check if item is organic matter
	var/organic_value = 0

	if(istype(I, /obj/item/reagent_containers/food))
		var/obj/item/reagent_containers/food/meat = I
		if(meat.foodtype & MEAT)
			organic_value = 10
	else if(istype(I, /obj/item/bodypart))
		organic_value = 50
	else if(istype(I, /mob/living))
		var/mob/living/L = I
		if(L.stat == DEAD)
			organic_value = 100
	else if(istype(I, /obj/item/organ))
		organic_value = 30

	if(organic_value > 0)
		to_chat(user, "<span class='notice'>The meatvine absorbs [I]!</span>")
		master.feed_organic_matter(organic_value)
		qdel(I)

		// Chance to grow immediately when fed
		if(prob(30))
			spread()

		return TRUE

	return ..()

/obj/structure/meatvine/papameat/process()
	var/integrity_percent = round(get_integrity()/max_integrity)

	switch(integrity_percent)
		if(75)
			if(prob(10))
				transfer_feromones(2)

		if(50)
			if(prob(10))
				transfer_feromones(5)

			if(prob(1))
				var/mobtype = pick(/mob/living/simple_animal/hostile/retaliate/meatvine, /mob/living/simple_animal/hostile/retaliate/meatvine/range)
				new mobtype(loc)

			if(healed && (master.vines.len <= master.collapse_size) && master.reached_collapse_size)
				master.reached_collapse_size = FALSE

		if(25)
			if(prob(20))
				puff_gas(TRUE)
			if(healed && (master.vines.len >= master.slowdown_size) && master.reached_slowdown_size)
				master.reached_slowdown_size = FALSE

	if(!healed)
		if(!repair_damage(10))
			healed = TRUE

/obj/structure/meatvine/papameat/grow()
	return


/obj/structure/meatvine/papameat/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(.)
		// Send signal to all nearby mobs when damaged
		var/integrity_percent = atom_integrity / max_integrity
		SEND_GLOBAL_SIGNAL(COMSIG_PAPAMEAT_DAMAGED, src, integrity_percent)

		// Send critical signal if below threshold
		if(integrity_percent < PAPAMEAT_CRITICAL_HEALTH)
			SEND_GLOBAL_SIGNAL(COMSIG_PAPAMEAT_CRITICAL, src)

/obj/structure/meatvine/papameat/proc/consume_mob(mob/living/sacrifice)
	if(!istype(sacrifice) || sacrifice.stat != DEAD)
		return FALSE

	visible_message("<span class='danger'>[src] absorbs [sacrifice]!</span>")

	// Heal the papameat based on mob size
	var/heal_amount = 100
	if(ismob(sacrifice))
		var/mob/living/L = sacrifice
		heal_amount = max(50, L.maxHealth * 0.5)

	atom_integrity = min(atom_integrity + heal_amount, max_integrity)

	// Feed the controller
	if(master)
		master.feed_organic_matter(100)

	qdel(sacrifice)
	return TRUE

/obj/structure/meatvine/papameat/proc/sacrifice_living_mob(mob/living/sacrifice)
	if(!istype(sacrifice) || sacrifice.stat == DEAD)
		return FALSE

	visible_message("<span class='danger'>[sacrifice] throws itself into [src], being consumed alive!</span>")

	// Damage and eventually kill the mob
	sacrifice.adjustBruteLoss(sacrifice.health + 10)

	// Then consume them
	return consume_mob(sacrifice)
