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
		for(var/datum/objective/personal/objective in user.mind.personal_objectives)
			data += "<B>[objective.name]</B>:<br> [objective.explanation_text][objective.completed ? " (COMPLETED)" : ""]"

			if(length(objective.immediate_effects))
				data += "<br>"
				data += "<br><span style='color: #f1d669;'><B>Immediate Effects:</B></span>"
				data += "<ul style='color: #f1d669; margin: 2px 0;'>"
				for(var/effect in objective.immediate_effects)
					data += "<li>[effect]</li>"
				data += "</ul>"

			if(length(objective.rewards))
				data += "<br><span style='color: #80b077;'><B>Rewards:</B></span>"
				data += "<ul style='color: #80b077; margin: 2px 0;'>"
				for(var/reward in objective.rewards)
					data += "<li>[reward]</li>"
				data += "</ul>"

			data += "<br>"

		var/datum/browser/popup = new(user, "purpose_menu", "My Tasks", 385, 400)
		popup.set_content(data.Join())
		popup.open()
