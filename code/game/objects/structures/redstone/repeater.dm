/obj/structure/redstone/repeater
	name = "redstone repeater"
	desc = "Amplifies and delays redstone signals."
	icon_state = "repeater"
	redstone_role = REDSTONE_ROLE_PROCESSOR
	true_pattern = "repeater"
	var/facing_dir = NORTH
	var/delay_ticks = 2
	var/output_active = FALSE
	var/scheduled_state = -1  // -1 = no change scheduled, 0 = turning off, 1 = turning on
	can_connect_wires = TRUE
	send_wall_power = TRUE

/obj/structure/redstone/repeater/Initialize()
	. = ..()
	facing_dir = dir

/obj/structure/redstone/repeater/get_source_power()
	return output_active ? 15 : 0

/obj/structure/redstone/repeater/get_effective_power()
	return output_active ? 15 : 0

/obj/structure/redstone/repeater/get_output_directions()
	return list(facing_dir)

/obj/structure/redstone/repeater/get_input_directions()
	return list(REVERSE_DIR(facing_dir))

/obj/structure/redstone/repeater/get_connection_directions()
	return list(facing_dir, REVERSE_DIR(facing_dir))

/obj/structure/redstone/repeater/can_connect_to(obj/structure/redstone/other, direction)
	return (direction == facing_dir || direction == REVERSE_DIR(facing_dir))

/obj/structure/redstone/repeater/can_receive_from(obj/structure/redstone/source, direction)
	return (direction == REVERSE_DIR(facing_dir))

// Called after network recalculation to check input state
/obj/structure/redstone/repeater/on_power_changed()
	// Check what power we're receiving from behind
	var/turf/input_turf = get_step(src, REVERSE_DIR(facing_dir))
	var/input_power = 0

	for(var/obj/structure/redstone/R in input_turf)
		if(R.can_connect_to(src, facing_dir))
			input_power = max(input_power, R.get_effective_power())

	var/should_be_on = (input_power > 0)

	// Schedule state change if needed
	if(should_be_on && !output_active && scheduled_state != 1)
		scheduled_state = 1
		spawn(delay_ticks)
			if(scheduled_state == 1)
				output_active = TRUE
				power_level = 15
				scheduled_state = -1
				schedule_network_update()
				update_appearance(UPDATE_OVERLAYS)
	else if(!should_be_on && output_active && scheduled_state != 0)
		scheduled_state = 0
		spawn(delay_ticks)
			if(scheduled_state == 0)
				output_active = FALSE
				power_level = 0
				scheduled_state = -1
				schedule_network_update()
				update_appearance(UPDATE_OVERLAYS)

/obj/structure/redstone/repeater/update_icon()
	. = ..()
	icon_state = "repeater"
	dir = facing_dir

/obj/structure/redstone/repeater/update_overlays()
	. = ..()
	var/mutable_appearance/delay_overlay = mutable_appearance(icon, "delay_[delay_ticks]")
	delay_overlay.color = output_active ? "#FF0000" : "#8B4513"
	. += delay_overlay

/obj/structure/redstone/repeater/attack_hand(mob/user)
	delay_ticks = (delay_ticks % 4) + 1
	to_chat(user, "<span class='notice'>Delay set to [delay_ticks] tick\s.</span>")
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/redstone/repeater/AltClick(mob/user)
	if(!Adjacent(user))
		return
	facing_dir = turn(facing_dir, 90)
	dir = facing_dir
	to_chat(user, "<span class='notice'>You rotate the [name] to face [dir2text_readable(facing_dir)].</span>")
	schedule_network_update()

/obj/structure/redstone/repeater/proc/dir2text_readable(direction)
	switch(direction)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
	return "unknown"

/obj/structure/redstone/repeater/examine(mob/user)
	. = ..()
	. += "Facing [dir2text_readable(facing_dir)], delay: [delay_ticks] tick\s."
