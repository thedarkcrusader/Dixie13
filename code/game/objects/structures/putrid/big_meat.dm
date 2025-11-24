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
	puff_gas(TRUE)
	master.die()
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
				var/mobtype = pick(/mob/living/simple_animal/hostile/meatvine, /mob/living/simple_animal/hostile/meatvine/range)
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
