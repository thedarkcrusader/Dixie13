/datum/action/cooldown/spell/undirected/snuff
	name = "snuff lights"
	desc = "Snuff the light around you"
	button_icon_state = "light"
	sound = 'sound/magic/soulsteal.ogg'
	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	invocation = "O'veta tela"
	invocation_type = INVOCATION_SHOUT
	charge_required = FALSE
	cooldown_time = 1 MINUTES
	spell_cost = 20
	cast_range = 2

/datum/action/cooldown/spell/undirected/snuff/cast(list/targets, mob/user = usr)
	. = ..()
	var/checkrange = (cast_range + user.get_skill_level(/datum/skill/magic/holy))
	for(var/obj/O in range(checkrange, user))
		O.extinguish()
	for(var/mob/M in range(checkrange, user))
		for(var/obj/O in M.contents)
			O.extinguish()
	return TRUE
