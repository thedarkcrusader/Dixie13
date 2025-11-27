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
	if(master)
		master.papameat_destroyed(src)
	puff_gas(TRUE)
	STOP_PROCESSING(SSfastprocess, src)
	qdel(Particle)
	return ..()

/obj/structure/meatvine/papameat/proc/begin_evolution(mob/living/simple_animal/hostile/retaliate/meatvine/evolving_mob)
	to_chat(evolving_mob, span_boldnotice("You begin burrowing into the papa meat..."))

	if(!do_after(evolving_mob, 5 SECONDS, src))
		to_chat(evolving_mob, span_warning("The evolution process was interrupted!"))
		return FALSE

	// Show evolution selection screen
	show_evolution_screen(evolving_mob)
	return TRUE

/obj/structure/meatvine/papameat/proc/show_evolution_screen(mob/living/simple_animal/hostile/retaliate/meatvine/evolving_mob)
	evolving_mob.incorporeal_move = INCORPOREAL_MOVE_JAUNT
	evolving_mob.density = FALSE
	evolving_mob.invisibility = INVISIBILITY_ABSTRACT

	var/mob/camera/evolution_picker/picker = new(get_turf(src))
	picker.evolving_mob = evolving_mob
	picker.papa_meat = src
	evolving_mob.client?.eye = picker
	picker.show_evolution_options()

/obj/structure/meatvine/papameat/attackby(obj/item/I, mob/user, params)
	if(!master)
		return ..()

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
		to_chat(user, span_notice("The meatvine absorbs [I]!"))
		master.feed_organic_matter(organic_value)

		// Grant evolution progress to user if they're a meatvine mob
		if(istype(user, /mob/living/simple_animal/hostile/retaliate/meatvine))
			var/mob/living/simple_animal/hostile/retaliate/meatvine/vine_mob = user
			vine_mob.gain_evolution_progress(organic_value * 0.3)

		qdel(I)
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
		var/integrity_percent = atom_integrity / max_integrity
		SEND_GLOBAL_SIGNAL(COMSIG_PAPAMEAT_DAMAGED, src, integrity_percent)
		if(integrity_percent < PAPAMEAT_CRITICAL_HEALTH)
			SEND_GLOBAL_SIGNAL(COMSIG_PAPAMEAT_CRITICAL, src)

/obj/structure/meatvine/papameat/proc/consume_mob(mob/living/sacrifice)
	if(!istype(sacrifice) || sacrifice.stat != DEAD)
		return FALSE
	visible_message(span_danger("[src] absorbs [sacrifice]!"))
	var/heal_amount = 100
	if(ismob(sacrifice))
		var/mob/living/L = sacrifice
		heal_amount = max(50, L.maxHealth * 0.5)
	atom_integrity = min(atom_integrity + heal_amount, max_integrity)
	if(master)
		master.feed_organic_matter(100)
	if(sacrifice.client)
		master.consume_client_mob(sacrifice)
	qdel(sacrifice)
	return TRUE

/obj/structure/meatvine/papameat/proc/sacrifice_living_mob(mob/living/sacrifice)
	if(!istype(sacrifice) || sacrifice.stat == DEAD)
		return FALSE
	visible_message(span_danger("[sacrifice] throws itself into [src], being consumed alive!"))
	sacrifice.adjustBruteLoss(sacrifice.health + 10)
	return consume_mob(sacrifice)

/mob/camera/evolution_picker
	name = "evolution viewer"
	real_name = "evolution viewer"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	invisibility = INVISIBILITY_ABSTRACT
	see_in_dark = 8
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	var/mob/living/simple_animal/hostile/retaliate/meatvine/evolving_mob
	var/obj/structure/meatvine/papameat/papa_meat
	var/list/obj/screen/evolution_choice/evolution_buttons = list()

/mob/camera/evolution_picker/Destroy()
	cleanup_evolution_screen()
	return ..()

/mob/camera/evolution_picker/proc/show_evolution_options()
	if(!evolving_mob || !evolving_mob.client)
		qdel(src)
		return

	var/client/C = evolving_mob.client
	var/list/available_evos = evolving_mob.possible_evolutions

	var/total_choices = length(available_evos)
	var/start_x = 8 - (total_choices * 2)

	for(var/i = 1 to total_choices)
		var/evolution_path = available_evos[i]

		var/obj/screen/evolution_choice/button = new()
		button.evolution_path = evolution_path
		button.available = TRUE
		button.picker = src
		button.screen_loc = "[start_x + (i * 3)],7"

		button.update_appearance()

		evolution_buttons += button
		C.screen += button

	add_prerequisite_display(C)

/mob/camera/evolution_picker/proc/add_prerequisite_display(client/C)
	if(!evolving_mob.chosen_evolution)
		return

	var/list/future_evos = list()
	var/list/current_evos = evolving_mob.possible_evolutions

	for(var/evo_path in current_evos)
		var/mob/living/simple_animal/hostile/retaliate/meatvine/temp_mob = evo_path
		var/list/next_tier = initial(temp_mob.possible_evolutions)
		if(length(next_tier))
			for(var/next_evo in next_tier)
				if(!(next_evo in future_evos))
					future_evos += next_evo

	if(!length(future_evos))
		return

	var/x_pos = 6
	for(var/evo_path in future_evos)
		var/obj/screen/evolution_choice/preview = new()
		preview.evolution_path = evo_path
		preview.available = FALSE
		preview.picker = src
		preview.screen_loc = "[x_pos],10"
		preview.color = "#555555"

		preview.update_appearance()

		evolution_buttons += preview
		C.screen += preview
		x_pos += 3

/mob/camera/evolution_picker/proc/cleanup_evolution_screen()
	if(evolving_mob?.client)
		for(var/obj/screen/evolution_choice/button in evolution_buttons)
			evolving_mob.client.screen -= button
			qdel(button)
	evolution_buttons.Cut()

/mob/camera/evolution_picker/proc/select_evolution(evolution_path)
	if(!evolving_mob || !papa_meat)
		qdel(src)
		return

	cleanup_evolution_screen()

	var/mob/new_mob = apply_evolution(evolution_path)

	if(new_mob && evolving_mob.client)
		evolving_mob.client.eye = null
		new_mob.client?.eye = new_mob

	qdel(src)

/mob/camera/evolution_picker/proc/apply_evolution(evolution_path)
	var/turf/spawn_loc = get_turf(papa_meat)
	var/mob/living/new_mob = new evolution_path(spawn_loc)

	if(evolving_mob.client)
		evolving_mob.mind.transfer_to(new_mob, TRUE)

	if(istype(new_mob, /mob/living/simple_animal/hostile/retaliate/meatvine))
		var/mob/living/simple_animal/hostile/retaliate/meatvine/new_vine = new_mob
		new_vine.chosen_evolution = evolution_path
		new_vine.evolution_progress = 0
		new_vine.master = evolving_mob.master

	// Restore visibility and movement
	if(istype(new_mob, /mob/living/simple_animal/hostile/retaliate/meatvine))
		var/mob/living/simple_animal/hostile/retaliate/meatvine/new_vine = new_mob
		new_vine.incorporeal_move = 0
	new_mob.density = TRUE
	new_mob.invisibility = 0

	papa_meat.visible_message(span_danger("[papa_meat] bulges and births a transformed creature!"))

	to_chat(new_mob, span_nicegreen("You have evolved into [new_mob.name]!"))

	qdel(evolving_mob)

	var/datum/hud/putrid/new_hud = new_mob.hud_used
	new_hud?.setup_mob()

	return new_mob

/obj/screen/evolution_choice
	name = "Evolution Choice"
	icon = 'icons/obj/cellular/putrid_abilities.dmi'
	icon_state = "button_bg"
	plane = HUD_PLANE

	var/evolution_path
	var/available = TRUE
	var/mob/camera/evolution_picker/picker

/obj/screen/evolution_choice/Initialize()
	. = ..()
	update_appearance()

/obj/screen/evolution_choice/update_name()
	. = ..()
	if(evolution_path)
		var/mob/living/temp = evolution_path
		name = initial(temp.name)

/obj/screen/evolution_choice/update_desc()
	. = ..()
	if(evolution_path)
		var/mob/living/temp = evolution_path
		desc = initial(temp.desc)

	if(!available)
		desc += "\n<span class='warning'>This evolution is not yet available.</span>"

/obj/screen/evolution_choice/update_overlays()
	. = ..()
	if(evolution_path)
		var/mob/living/simple_animal/temp = evolution_path
		. += mutable_appearance(initial(temp.icon), initial(temp.icon_state))


/obj/screen/evolution_choice/Click()
	if(!available)
		to_chat(usr, span_warning("This evolution is not available!"))
		return

	if(!picker)
		return

	picker.select_evolution(evolution_path)

/obj/screen/evolution_choice/MouseEntered(location, control, params)
	. = ..()
	if(available)
		transform = matrix() * 1.1

	if(evolution_path)
		var/mob/living/temp = evolution_path
		var/tooltip_text = "<b>[initial(temp.name)]</b><br>[initial(temp.desc)]"
		if(!available)
			tooltip_text += "<br><span class='warning'>Locked</span>"

		to_chat(usr, span_info(tooltip_text))

/obj/screen/evolution_choice/MouseExited()
	. = ..()
	transform = matrix()
