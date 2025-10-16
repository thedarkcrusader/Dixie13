/datum/action/cooldown/spell/undirected/list_target/convert_role/guard
	name = "Recruit Guardsmen"
	button_icon_state = "recruit_guard"

	new_role = "Garrison Recruit"
	recruitment_faction = "Garrison"
	recruitment_message = "Join the Garrison, %RECRUIT!"
	accept_message = "I swear fealty to the Crown and its garrison!"

/datum/action/cooldown/spell/undirected/list_target/convert_role/guard/on_conversion(mob/living/cast_on)
	. = ..()
	cast_on.verbs |= /mob/proc/haltyell

/datum/action/cooldown/spell/undirected/list_target/convert_role/guard/forest
	name = "Recruit Forest Guard"

	new_role = "Forest Garrison Recruit"
	recruitment_faction = "Forest Garrison"
	recruitment_message = "Join the Forest Garrison, %RECRUIT!"
	accept_message = "I swear to protect the forest!"

/datum/job/garrison_recruit
	title = "Garrison Recruit"
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 0

/datum/job/forest_guard_Recruit
	title = "Forest Garrison Recruit"
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 0
