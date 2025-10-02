/datum/objective/personal/mock
	name = "Mock"
	triumph_count = 2

/datum/objective/personal/mock/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED, PROC_REF(on_mock_used))
	update_explanation_text()

/datum/objective/personal/mock/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED)
	return ..()

/datum/objective/personal/mock/proc/on_mock_used(datum/source, mob/living/target, mob/living/user)
	SIGNAL_HANDLER
	return

/// Monarch variant
/datum/objective/personal/mock/monarch
	name = "Mock Monarch"

/datum/objective/personal/mock/monarch/on_mock_used(datum/source, mob/living/victim)
	. = ..()
	if((istype(victim.mind?.assigned_role, /datum/job/lord) || victim.job == "Monarch") && (source == owner.current))
		to_chat(owner.current, span_greentext("You have mocked the monarch and completed the objective!"))
		owner.current.adjust_triumphs(triumph_count)
		completed = TRUE
		adjust_storyteller_influence(XYLIX, 20)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED)

/datum/objective/personal/mock/monarch/update_explanation_text()
	. = ..()
	explanation_text = "Viciously mock the monarch for Xylix!"

/// Noble variant
/datum/objective/personal/mock/noble
	name = "Mock Nobles"
	var/mocked_targets = 0
	var/required_count = 2

/datum/objective/personal/mock/noble/update_explanation_text()
	. = ..()
	explanation_text = "Viciously mock [required_count] nobles for Xylix!"

/datum/objective/personal/mock/noble/on_mock_used(datum/source, mob/living/victim)
	. = ..()
	var/mob/living/carbon/human/human_victim = victim
	if(!istype(human_victim) || human_victim.stat == DEAD || human_victim == source)
		return

	if(human_victim.is_noble() && (source == owner.current))
		mocked_targets++
		if(mocked_targets >= required_count)
			to_chat(owner.current, span_greentext("You have mocked enough nobles and completed the objective!"))
			owner.current.adjust_triumphs(triumph_count)
			completed = TRUE
			adjust_storyteller_influence(XYLIX, 20)
			escalate_objective()
			UnregisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED)
		else
			to_chat(owner.current, span_notice("Noble mocked! Viciously mock [required_count - mocked_targets] more noble to complete the objective!"))
