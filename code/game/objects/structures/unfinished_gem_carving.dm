/obj/structure/unfinished_gem_carving
	name = "bugged item"
	icon_state = "raw"
	desc = "report to coders"
	density = FALSE
	max_integrity = 100
	var/datum/gem_material/material_datum
	var/completion_percentage = 100
	var/next_side_to_hit
	var/list/skill_hits = list()

/obj/structure/unfinished_gem_carving/Initialize(mapload, /datum/gem_material/passed_material_datum)
	. = ..()
	if(isnull(passed_material_datum))
		stack_trace("a carving initialized without a material datum")
		return INITIALIZE_HINT_QDEL

	completion_percentage = 0
	material_datum = passed_material_datum
	name = "unfinished [material_datum::material_name] carving"
	desc = "an unfinished carving, this one is made of [material_datum::material_name]!"
	icon = material_datum::icon_path

/obj/structure/unfinished_gem_carving/Crossed(atom/movable/AM)
	. = ..()
	if(!isliving(AM))
		return
	obj_integrity -= rand(7, 15)
	to_chat(AM, span_danger("You step on the [name]!"))
	playsound(src, 'sound/foley/glass_step.ogg', 50, TRUE)
	handle_health_change()

/obj/structure/unfinished_gem_carving/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(!istype(I, /obj/item/weapon/knife))
		return
	process_hit(I, user)

/obj/structure/unfinished_gem_carving/proc/process_hit(obj/item/weapon/knife/carving_item, mob/living/user)
	var/end_result = 0
	var/skill_level = user.get_skill_level(/datum/skill/craft/masonry)
	skill_hits += skill_level
	var/randomness = max(-10, rand((user.STALUC - 10), (user.STALUC + 2) * 2) - 10)
	if(randomness <= 0 && skill_level)
		randomness /= skill_level
	else
		randomness *= skill_level
	end_result = skill_level * 10 += randomness

	if(next_side_to_hit)
		if(get_dir(src, user) == next_side_to_hit)
			end_result += 5
		else
			end_result -= 5

	var/feedback_message = span_notice("You carve the [src], but nothing happens!")

	if(end_result < 0)
		feedback_message = span_danger("You carve the [src] and damage it!")
		obj_integrity -= end_result
		completion_percentage = max(0, completion_percentage - end_result / 4)
	if(end_result > 0)
		feedback_message = span_green("You carve the [src] and get some progress done!")
		completion_percentage += end_result
		obj_integrity = min(100, obj_integrity + end_result / 4)

	var/amt2raise = user.STAINT + 5
	var/boon = user.get_learning_boon(/datum/skill/craft/masonry)
	user.adjust_experience(/datum/skill/craft/masonry, amt2raise * boon)

	if(handle_health_change(user))
		return

	next_direction_to_hit = pick(ALL_CARDINALS)

	to_chat(user, span_notice("now from the [dir2text(next_direction_to_hit)]"))

/obj/structure/unfinished_gem_carving/proc/spawn_carving()
	if(!length(skill_hits))
		stack_trace("skill_hits was 0 in [src], please alert a coder.")
		qdel(src)
	var/final_skill = 0

	for(var/number as anything in skill_hits)
		final_skill += number

	final_skill /= length(skill_hits)
	final_skill = round(final_skill, 1)

	var/list/possible_types_to_spawn = list()
	for(var/datum/gem_carving_type/checking_type as anything in subtypesof(/datum/gem_carving_type))
		if(is_abstract(checking_type))
			continue
		if(final_skill < checking_type::needed_skill)
			continue

		possible_types_to_spawn[checking_type] += checking_type::spawn_weight

	new (loc, material_datum, pick_weight(possible_type_to_spawn), final_skill)

	qdel(src)

	return TRUE

/obj/structure/unfinished_gem_carving/proc/handle_health_change(mob/living/user)
	if(obj_integrity < 0)
		qdel(src)

	if(completion_percentage >= 100)
		spawn_carving()
		return TRUE
