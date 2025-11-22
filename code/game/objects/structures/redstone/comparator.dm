
/obj/structure/redstone/comparator
	name = "redstone comparator"
	desc = "Compares redstone signal strengths."
	icon_state = "comparator"
	redstone_role = REDSTONE_ROLE_PROCESSOR
	var/direction = NORTH
	var/mode = "compare"
	var/main_input = 0
	var/side_input_left = 0
	var/side_input_right = 0
	var/output_power = 0
	can_connect_wires = TRUE

/obj/structure/redstone/comparator/Initialize()
	. = ..()
	direction = dir
	START_PROCESSING(SSobj, src)

/obj/structure/redstone/comparator/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/redstone/comparator/get_source_power()
	return output_power

/obj/structure/redstone/comparator/get_effective_power()
	return output_power

/obj/structure/redstone/comparator/get_output_directions()
	return list(direction)

/obj/structure/redstone/comparator/get_input_directions()
	return list(REVERSE_DIR(direction), turn(direction, 90), turn(direction, -90))

/obj/structure/redstone/comparator/can_connect_to(obj/structure/redstone/other, dir)
	return (dir != direction) || (dir == direction) // All sides

/obj/structure/redstone/comparator/can_receive_from(obj/structure/redstone/source, dir)
	return (dir in get_input_directions())

/obj/structure/redstone/comparator/calculate_received_power(incoming_power, obj/structure/redstone/source)
	var/source_dir = get_dir(src, source)
	var/back_dir = REVERSE_DIR(direction)
	var/left_dir = turn(direction, -90)
	var/right_dir = turn(direction, 90)

	if(source_dir == back_dir)
		main_input = max(main_input, incoming_power)
	else if(source_dir == left_dir)
		side_input_left = max(side_input_left, incoming_power)
	else if(source_dir == right_dir)
		side_input_right = max(side_input_right, incoming_power)

	recalculate_output()
	return 0

/obj/structure/redstone/comparator/proc/recalculate_output()
	var/max_side = max(side_input_left, side_input_right)
	var/new_output = 0

	if(mode == "compare")
		new_output = (main_input >= max_side) ? main_input : 0
	else // subtract
		new_output = max(0, main_input - max_side)

	if(new_output != output_power)
		output_power = new_output
		power_level = output_power

/obj/structure/redstone/comparator/proc/check_storage_input()
	var/turf/back_turf = get_step(src, REVERSE_DIR(direction))
	var/storage_signal = 0

	for(var/obj/O in back_turf)
		var/datum/component/storage/storage_comp = O.GetComponent(/datum/component/storage)
		if(storage_comp)
			storage_signal = calculate_storage_fullness(storage_comp, O)
			break

	if(storage_signal > main_input)
		main_input = storage_signal
		recalculate_output()
		if(output_power != power_level)
			schedule_network_update()

/obj/structure/redstone/comparator/proc/calculate_storage_fullness(datum/component/storage/storage_comp, obj/O)
	var/max_capacity = storage_comp.screen_max_rows * storage_comp.screen_max_columns
	if(max_capacity <= 0)
		return 0

	var/total = 0
	for(var/obj/item/item in O.contents)
		total += (item.grid_width / 32) * (item.grid_height / 32)

	return round((total / max_capacity) * 15)

/obj/structure/redstone/comparator/process()
	// Reset inputs each tick, they'll be recalculated
	main_input = 0
	side_input_left = 0
	side_input_right = 0
	check_storage_input()

/obj/structure/redstone/comparator/attack_hand(mob/user)
	mode = (mode == "compare") ? "subtract" : "compare"
	to_chat(user, "<span class='notice'>Mode: [mode].</span>")
	recalculate_output()
	schedule_network_update()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/redstone/comparator/update_icon()
	. = ..()
	icon_state = (mode == "subtract") ? "comparator_subtract" : "comparator"
	dir = direction

/obj/structure/redstone/comparator/AltClick(mob/user)
	if(!Adjacent(user))
		return
	direction = turn(direction, 90)
	dir = direction
	to_chat(user, "<span class='notice'>You rotate the [name].</span>")
	schedule_network_update()
