/obj/structure/redstone/torch
	name = "redstone torch"
	desc = "A torch that provides constant redstone power. Inverts when the attached block is powered."
	icon_state = "torch"
	redstone_role = REDSTONE_ROLE_SOURCE
	var/attached_dir = SOUTH
	var/inverted = FALSE
	var/base_power = 15
	can_connect_wires = TRUE

/obj/structure/redstone/torch/Initialize()
	. = ..()
	attached_dir = dir
	power_level = base_power

/obj/structure/redstone/torch/get_source_power()
	return inverted ? 0 : base_power

/obj/structure/redstone/torch/get_effective_power()
	return get_source_power()

/obj/structure/redstone/torch/get_output_directions()
	var/list/dirs = GLOB.cardinals.Copy()
	dirs -= attached_dir
	return dirs

/obj/structure/redstone/torch/get_input_directions()
	return list(attached_dir)

/obj/structure/redstone/torch/can_connect_to(obj/structure/redstone/other, direction)
	return (direction != attached_dir)

/obj/structure/redstone/torch/can_receive_from(obj/structure/redstone/source, direction)
	// Torches receive power from their attached direction (to invert)
	// They also receive wall power (direction will be attached_dir when powered through wall)
	return TRUE  // Accept from any direction, receive_source_power handles the logic

/obj/structure/redstone/torch/receive_source_power(incoming_power, obj/structure/redstone/source)
	// Only invert if we're receiving power (from wall or attached side)
	var/should_invert = (incoming_power > 0)
	if(should_invert != inverted)
		inverted = should_invert
		power_level = get_source_power()
		// Don't schedule update here - we're already in an update

/obj/structure/redstone/torch/update_overlays()
	. = ..()
	var/mutable_appearance/attachment_overlay = mutable_appearance(icon, "torch_attachment")
	attachment_overlay.dir = attached_dir
	. += attachment_overlay

	if(!inverted)
		var/mutable_appearance/power_overlay = mutable_appearance(icon, "torch_on")
		. += power_overlay
	else
		var/mutable_appearance/inverted_overlay = mutable_appearance(icon, "torch_inverted")
		. += inverted_overlay

/obj/structure/redstone/torch/AltClick(mob/user)
	if(!Adjacent(user))
		return
	attached_dir = turn(attached_dir, 90)
	dir = attached_dir
	to_chat(user, "<span class='notice'>You rotate the [name] to attach to the [dir2text_readable(attached_dir)] side.</span>")
	schedule_network_update()

/obj/structure/redstone/torch/proc/dir2text_readable(direction)
	switch(direction)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
	return "unknown"

/obj/structure/redstone/torch/examine(mob/user)
	. = ..()
	. += "It is attached to the [dir2text_readable(attached_dir)] side."
	. += inverted ? "The torch is inverted (off)." : "The torch is providing power."
