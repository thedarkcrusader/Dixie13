/datum/status_effect/purpose
	id = "purpose"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/purpose

/atom/movable/screen/alert/status_effect/purpose
	name = "Tasks"
	desc = "I have things to do."
	icon_state = "purpose"
	alert_group = ALERT_STATUS

/atom/movable/screen/alert/status_effect/purpose/Click(location, control, params)
	. = ..()
	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/user = usr
	if(length(user.mind?.personal_objectives))
		var/list/data = list()
		data += "<B>Personal Objectives:</B>"
		var/personal_count = 1
		for(var/datum/objective/personal/objective in user.mind.personal_objectives)
			data += "<br><B>Personal Goal #[personal_count]</B>: [objective.explanation_text][objective.completed ? " (COMPLETED)" : ""]"
			personal_count++
		data += "<br>"

		var/datum/browser/popup = new(user, "purpose_menu", "My Tasks", 385, 420)
		popup.set_content(data.Join())
		popup.open()
