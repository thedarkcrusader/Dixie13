GLOBAL_DATUM_INIT(inquisition, /datum/oratorium, new)

/mob/living/carbon/human
	var/datum/oratorium/inquisition
	var/datum/inquisition_hierarchy_node/inquisition_position
	var/datum/inquisition_hierarchy_interface/hierarchy_interface

/mob/living/carbon/human/proc/show_inquisition()
	if(!GLOB.inquisition)
		GLOB.inquisition = new /datum/oratorium()

	inquisition = GLOB.inquisition
	if(!hierarchy_interface)
		hierarchy_interface = new /datum/inquisition_hierarchy_interface(src)
	hierarchy_interface.refresh_hierarchy()
