/datum/action/cooldown/spell/undirected/list_target/convert_role/brotherhood
	name = "Recruit Brotherhood"
	button_icon_state = "recruit_servant" //N/A change this to the correct sprite when its made

	new_role = "Brother"
	recruitment_faction = "Brotherhood"
	recruitment_message = "We're in this together now, %RECRUIT!"
	accept_message = "All for one and one for all!"
	refuse_message = "I refuse."

/datum/action/cooldown/spell/undirected/list_target/convert_role/guard/on_conversion(mob/living/cast_on)
	. = ..()

/datum/job/brother
	title = "Brother"
	f_title = "Sister"
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 0
