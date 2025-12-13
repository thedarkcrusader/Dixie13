GLOBAL_LIST_EMPTY(hidden_door_managers)

/// do NOT initialize these without an id.
/datum/hidden_door_manager
	var/id
	var/accessor_trait
	var/list/vip

	var/list/doors = list()
	//don't set this directly unless it's part of initialization. use set_phrase()
	var/open_phrase

/datum/hidden_door_manager/New(_id, _accessor_trait, list/_vip)
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_spawn))
	if(!_id)
		qdel(src)
		return
	id = _id
	accessor_trait = _accessor_trait
	vip = _vip
	GLOB.hidden_door_managers[id] = src

/datum/hidden_door_manager/Destroy(force, ...)
	UnregisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN)
	GLOB.hidden_door_managers -= id
	for(var/obj/structure/door/secret/door in doors)
		door.door_manager = null
	. = ..()

/datum/hidden_door_manager/proc/set_phrase(new_phrase)
	open_phrase = new_phrase
	for(var/obj/structure/door/secret/door in doors)
		door.open_phrase = new_phrase

/datum/hidden_door_manager/proc/on_job_spawn(source, datum/job/job, mob/living/spawned, client/player_client)
	//really these two factors should be synced but ya never know.
	if((job.type in vip) || (accessor_trait && (accessor_trait in job.mind_traits) || (accessor_trait in job.traits)))
		var/msg = "The [id]'s secret doors answer to: '[open_phrase]'"
		spawned.mind?.store_memory(msg)


/obj/structure/door/secret
	name = "wall"
	icon = 'icons/turf/smooth/walls/stone_brick.dmi'
	icon_state = MAP_SWITCH("stone_brick", "stone_brick-0")
	hover_color = "#607d65"
	resistance_flags = NONE
	max_integrity = 9999
	damage_deflection = 30
	layer = ABOVE_MOB_LAYER

	lock = /datum/lock/locked

	smoothing_flags = NONE
	smoothing_groups = SMOOTH_GROUP_DOOR_SECRET
	smoothing_list = SMOOTH_GROUP_DOOR_SECRET +  SMOOTH_GROUP_CLOSED_WALL

	can_add_lock = FALSE
	can_knock = FALSE
	redstone_structure = TRUE

	repair_thresholds = null
	broken_repair = null
	repair_skill = null
	metalizer_result = null

	//the perception DC to use this door
	var/hidden_dc = 10

	var/datum/hidden_door_manager/door_manager
	//used for door manager
	var/id
	/// Used for traits that automatically indicate there is a hidden door here.
	var/accessor_trait

	var/use_phrases = FALSE
	var/open_phrase = "open sesame"
	var/speaking_distance = 1
	var/lang = /datum/language/common
	var/list/vip

/obj/structure/door/secret/Initialize(mapload, ...)
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	open_phrase = "[open_word()] [magic_word()]"
	if(id)
		door_manager = GLOB.hidden_door_managers[id] || new /datum/hidden_door_manager(id, accessor_trait, vip)
		door_manager.doors += src
		if(door_manager.open_phrase)
			open_phrase = door_manager.open_phrase
		else
			door_manager.open_phrase = open_phrase

/obj/structure/door/secret/Destroy(force)
	door_manager?.doors -= src
	lose_hearing_sensitivity()
	return ..()

/obj/structure/door/secret/redstone_triggered(mob/user)
	if(!door_opened)
		force_open()
	else
		force_closed()

/obj/structure/door/secret/rattle()
	return

/obj/structure/door/secret/attack_hand(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	to_chat(user, span_notice("I start feeling around [src]"))
	if(!do_after(user, 1.5 SECONDS, src))
		return

//can't kick it open, but you can kick it closed
/obj/structure/door/secret/onkick(mob/user)
	if(locked())
		return
	..()

/obj/structure/door/secret/examine(mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/L = user
		if(HAS_MIND_TRAIT(user, accessor_trait))
			. += span_purple("There's a hidden door here...")
		else
			var/bonuses = (HAS_TRAIT(user, TRAIT_THIEVESGUILD) || HAS_TRAIT(user, TRAIT_ASSASSIN)) ? 2 : 0
			if(L.STAPER + bonuses >= hidden_dc)
				. += span_purple("Something isn't right about this wall...")

/obj/structure/door/secret/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), original_message)
	if(!use_phrases)
		return FALSE
	var/mob/living/carbon/human/H = speaker
	if(speaker == src) //door speaking to itself
		return FALSE
	var/distance = get_dist(speaker, src)
	if(distance > speaking_distance)
		return FALSE
	if(obj_broken) //door is broken
		return FALSE
	if(!ishuman(speaker))
		return FALSE

	var/message2recognize = SANITIZE_HEAR_MESSAGE(original_message)

	if(is_type_in_list(H.mind?.assigned_role, vip)) //are they a VIP?
		var/list/mods = list(WHISPER_MODE = MODE_WHISPER)
		if(findtext(message2recognize, "help"))
			send_speech(span_purple("'say phrase'... 'set phrase'..."), speaking_distance, src, message_language = lang, message_mods = mods)
			return TRUE
		if(findtext(message2recognize, "say phrase"))
			send_speech(span_purple("[open_phrase]..."), speaking_distance, src, message_language = lang, message_mods = mods)
			return TRUE
		if(findtext(message2recognize, "set phrase"))
			var/new_pass = stripped_input(H, "What should the new open phrase be?")
			open_phrase = new_pass
			door_manager?.set_phrase(new_pass)
			send_speech(span_purple("It is done, [flavor_name()]..."), speaking_distance, src, message_language = lang, message_mods = mods)
			return TRUE

	if(findtext(message2recognize, open_phrase))
		if(!door_opened)
			force_open()
		else
			force_closed()
		return TRUE

/obj/structure/door/secret/Open(silent = FALSE)
	switching_states = TRUE
	if(!silent)
		playsound(src, open_sound, 90)
	if(!windowed)
		mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		set_opacity(FALSE)
	animate(src, pixel_x = -22, alpha = 50, time = animate_time)
	sleep(animate_time)
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE)
	switching_states = FALSE

	if(close_delay > 0)
		addtimer(CALLBACK(src, PROC_REF(Close), silent), close_delay)

/obj/structure/door/secret/force_open()
	switching_states = TRUE
	if(!windowed)
		mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		set_opacity(FALSE)
	animate(src, pixel_x = -22, alpha = 50, time = animate_time)
	sleep(animate_time)
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE)
	switching_states = FALSE

	if(close_delay > 0)
		addtimer(CALLBACK(src, PROC_REF(Close)), close_delay)

/obj/structure/door/secret/Close(silent = FALSE)
	if(switching_states || !door_opened)
		return
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T)
		return
	switching_states = TRUE
	if(!silent)
		playsound(src, close_sound, 90)
	animate(src, pixel_x = 0, alpha = 255, time = animate_time)
	sleep(animate_time)
	density = TRUE
	if(!windowed)
		mouse_opacity = MOUSE_OPACITY_ICON
		set_opacity(TRUE)
	door_opened = FALSE
	layer = CLOSED_DOOR_LAYER
	air_update_turf(TRUE)
	switching_states = FALSE
	lock()

/obj/structure/door/secret/force_closed()
	switching_states = TRUE
	if(!windowed)
		mouse_opacity = MOUSE_OPACITY_ICON
		set_opacity(TRUE)
	animate(src, pixel_x = 0, alpha = 255, time = animate_time)
	sleep(animate_time)
	density = TRUE
	door_opened = FALSE
	layer = CLOSED_DOOR_LAYER
	air_update_turf(TRUE)
	switching_states = FALSE

/// mood determines opinion of the magic word. 1 = positive, 2 = negative
/obj/structure/door/secret/proc/open_word()
	return pick("open", "pass", "part", "break", "reveal", "unbar", "extend", "widen", "unfold", "rise", "remember")

/obj/structure/door/secret/proc/magic_word()
	return pick("sesame", "abyss", "fire", "wind", "psydonia", "shadow", "nite", "oblivion", "void", "time", "dead", "decay",
		"gods", "ancient", "twisted", "corrupt", "secrets", "lore", "text", "ritual", "sacrifice", "deal", "pact", "bargain", "ritual", "dream",
		"nitemare", "vision", "hunger",	"lust", "psydon")

/obj/structure/door/secret/proc/flavor_name()
	return pick("my friend", "love", "my love", "honey", "darling", "knave", "stranger", "companion", "mate", "you harlot",
		"comrade", "fellow", "chum", "bafoon")

///// DOOR TYPES //////
/obj/structure/door/secret/keep
	id = "keep"
	hidden_dc = 14
	use_phrases = TRUE
	accessor_trait = TRAIT_KNOW_KEEP_DOORS
	vip = list(/datum/job/lord, /datum/job/consort, /datum/job/prince, /datum/job/hand, /datum/job/butler, /datum/job/archivist)

//little note on these. This is specifically for psydonic inquisition. if you use these for rosewood's they are going to have issues with the fact it's psydonic.
/obj/structure/door/secret/inquisition
	id = "inquisition"
	hidden_dc = 15
	use_phrases = TRUE
	accessor_trait = TRAIT_KNOW_INQUISITION_DOORS
	vip = list(/datum/job/inquisitor)
	lang = /datum/language/oldpsydonic

/obj/structure/door/secret/thieves_guild
	hidden_dc = 12
	use_phrases = TRUE
	id = "thieves' guild"
	accessor_trait = TRAIT_KNOW_THIEF_DOORS
	vip = list(/datum/job/matron)
	lang = /datum/language/thievescant

///// MAPPERS /////
/obj/effect/mapping_helpers/secret_door_creator
	name = "Secret Door Creator"
	icon = 'icons/effects/hidden_door.dmi'
	icon_state = "hidden_door"

	var/redstone_id

	var/obj/structure/door/secret/door_type = /obj/structure/door/secret
	var/override_floor = TRUE //Will only use the below as the floor tile if true. Source turf have at least 1 baseturf to use false
	var/turf/open/floor_turf = /turf/open/floor/blocks

/obj/effect/mapping_helpers/secret_door_creator/Initialize()
	if(!isclosedturf(get_turf(src)))
		return ..()
	var/turf/closed/source_turf = get_turf(src)
	var/obj/structure/door/secret/new_door = new door_type(source_turf)

	new_door.name = source_turf.name
	new_door.desc = source_turf.desc
	new_door.icon = source_turf.icon
	new_door.icon_state = source_turf.icon_state
	new_door.color = source_turf.color

	new_door.uses_integrity = source_turf.uses_integrity
	if(new_door.uses_integrity)
		new_door.max_integrity = source_turf.max_integrity
		new_door.update_integrity(new_door.max_integrity, FALSE)
		new_door.integrity_failure = source_turf.integrity_failure
	new_door.damage_deflection = source_turf.damage_deflection
	new_door.explosion_block = source_turf.explosion_block
	new_door.blade_dulling = source_turf.blade_dulling
	new_door.attacked_sound = source_turf.attacked_sound
	new_door.break_sound = source_turf.break_sound
	new_door.resistance_flags = source_turf.resistance_flags

	var/smooth = source_turf.smoothing_flags & ~SMOOTH_QUEUED
	if(smooth)
		new_door.smoothing_flags |= smooth
		new_door.smoothing_icon = initial(source_turf.icon_state)
		QUEUE_SMOOTH(new_door)
		QUEUE_SMOOTH_NEIGHBORS(new_door)

	if(redstone_id)
		new_door.redstone_id = redstone_id
		GLOB.redstone_objs += new_door
		new_door.LateInitialize()

	if(override_floor || length(source_turf.baseturfs) < 1)
		source_turf.ChangeTurf(floor_turf)
	else
		source_turf.ChangeTurf(source_turf.baseturfs[1])

	. = ..()

/obj/effect/mapping_helpers/secret_door_creator/keep
	name = "Keep Secret Door Creator"
	color = "#792BD0"
	door_type = /obj/structure/door/secret/keep
	override_floor = FALSE

/obj/effect/mapping_helpers/secret_door_creator/inquisition
	name = "Inquisition Secret Door Creator"
	color = "#d02b2b"
	door_type = /obj/structure/door/secret/inquisition
	override_floor = FALSE

/obj/effect/mapping_helpers/secret_door_creator/thieves_guild
	name = "Thieves' Guild Secret Door Creator"
	color = "#3ed02b"
	door_type = /obj/structure/door/secret/thieves_guild
	override_floor = FALSE
