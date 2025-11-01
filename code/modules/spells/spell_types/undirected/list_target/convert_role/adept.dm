/datum/action/cooldown/spell/undirected/list_target/convert_role/adept
	name = "Recruit Adept"
	button_icon_state = "recruit_guard"

	new_role = "Adept"
	recruitment_faction = "Inquisition"
	recruitment_message = "You will serve Psydon's will, %RECRUIT!"
	accept_message = "By Psydon I ENDURE!"
	refuse_message = "I FOLLOW MY GOD INTO DEATH!!!"

/datum/action/cooldown/spell/undirected/list_target/convert_role/militia/can_convert(mob/living/carbon/human/cast_on)
	. = ..()
	if(!.)
		return

	//only migrants and peasants
	if(cast_on.has_flaw(/datum/charflaw/addiction/godfearing))
		cast_on.say("I FOLLOW MY GOD INTO DEATH!!!")
		return FALSE

	return TRUE
