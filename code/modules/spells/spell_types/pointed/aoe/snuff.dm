/datum/action/cooldown/spell/aoe/snuff
	name = "snuff lights"
	desc = "Snuff the light around you"
	button_icon_state = "light"
	sound = 'sound/magic/soulsteal.ogg'
	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	invocation = "O'veta tela" // incantation in zizo chant
	invocation_type = INVOCATION_WHISPER
	charge_required = FALSE
	cooldown_time = 1 MINUTES
	spell_cost = 20
	cast_range = 2

/datum/action/cooldown/spell/aoe/snuff/get_things_to_cast_on(atom/center)
	var/checkrange = (cast_range + owner.get_skill_level(/datum/skill/magic/holy))
	for(var/obj/O in range(checkrange, owner))
		O.extinguish()
	for(var/mob/M in range(checkrange, owner))
		for(var/obj/O in M.contents)
			O.extinguish()
