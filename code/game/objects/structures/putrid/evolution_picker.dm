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
	var/list/obj/screen/evolution_choice/future_preview_buttons = list()

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
		var/button_x = start_x + (i * 3)
		button.screen_loc = "[button_x],7"
		button.button_x_position = button_x  // Store the x position

		button.update_appearance()

		evolution_buttons += button
		C.screen += button

	add_prerequisite_display(C)

/mob/camera/evolution_picker/proc/add_prerequisite_display(client/C)
	// Display parent evolutions (going upwards)
	var/list/parent_evos = list()
	var/list/current_evos = evolving_mob.possible_evolutions

	for(var/evo_path in current_evos)
		var/mob/living/simple_animal/hostile/retaliate/meatvine/temp_mob = evo_path
		var/list/their_evolutions = initial(temp_mob.possible_evolutions)
		if(length(their_evolutions))
			for(var/their_evo in their_evolutions)
				if(!(their_evo in parent_evos))
					parent_evos += their_evo

	if(length(parent_evos))
		var/total_parents = length(parent_evos)
		var/parent_start_x = 8 - (total_parents * 1.5)

		for(var/i = 1 to total_parents)
			var/evo_path = parent_evos[i]
			var/obj/screen/evolution_choice/parent_preview = new()
			parent_preview.evolution_path = evo_path
			parent_preview.available = FALSE
			parent_preview.picker = src
			parent_preview.screen_loc = "[parent_start_x + (i * 2.5)],10"
			parent_preview.color = "#555555"

			parent_preview.update_appearance()

			evolution_buttons += parent_preview
			C.screen += parent_preview

/mob/camera/evolution_picker/proc/show_future_evolutions(evolution_path, hovered_button_x)
	if(!evolving_mob?.client)
		return

	hide_future_evolutions()

	var/client/C = evolving_mob.client
	var/mob/living/simple_animal/hostile/retaliate/meatvine/temp_mob = evolution_path
	if(!(temp_mob in GLOB.putrid_evolutions))
		GLOB.putrid_evolutions |= temp_mob
		var/mob/living/simple_animal/hostile/retaliate/meatvine/real = new evolution_path(get_turf(src))
		GLOB.putrid_evolutions[temp_mob] = real.possible_evolutions.Copy()
		qdel(real)

	var/list/future_evos = GLOB.putrid_evolutions[temp_mob]

	if(!length(future_evos))
		return

	var/total_future = length(future_evos)
	// Center the future evolutions around the hovered button's x position
	// If even count, center on the gap between buttons for better visual balance
	var/future_start_x
	if(total_future % 2 == 0)  // Even count - center on gap
		future_start_x = hovered_button_x - (total_future * 1.25) - 1.25
	else  // Odd count - center on middle button
		future_start_x = hovered_button_x - (total_future * 1.25)

	for(var/i = 1 to total_future)
		var/evo_path = future_evos[i]
		var/obj/screen/evolution_choice/preview = new()
		preview.evolution_path = evo_path
		preview.available = FALSE
		preview.picker = src
		preview.screen_loc = "[future_start_x + (i * 2.5)],10"  // Changed from 4 to 10 (above)
		preview.color = "#555555"
		preview.alpha = 200

		preview.update_appearance()

		future_preview_buttons += preview
		C.screen += preview

/mob/camera/evolution_picker/proc/hide_future_evolutions()
	if(!evolving_mob?.client)
		return

	var/client/C = evolving_mob.client
	for(var/obj/screen/evolution_choice/button in future_preview_buttons)
		C.screen -= button
		qdel(button)
	future_preview_buttons.Cut()

/mob/camera/evolution_picker/proc/cleanup_evolution_screen()
	hide_future_evolutions()

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
		new_vine.evolution_progress = 0
		new_vine.master = evolving_mob.master

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
	var/button_x_position

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
		picker?.show_future_evolutions(evolution_path, button_x_position)

/obj/screen/evolution_choice/MouseExited()
	. = ..()
	if(available)
		transform = matrix()
		picker?.hide_future_evolutions()
