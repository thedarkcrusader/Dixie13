
/obj/item/clothing/cloak/apron
	name = "apron"
	desc = ""
	color = null
	icon_state = "apron"
	item_state = "apron"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/cloak/apron/brown
	color = CLOTHING_BARK_BROWN
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/cloak/apron/waist
	name = "apron"
	desc = ""
	color = null
	icon_state = "waistpron"
	item_state = "waistpron"
	body_parts_covered = GROIN
	boobed = FALSE

/obj/item/clothing/cloak/apron/waist/colored
	misc_flags = CRAFTING_TEST_EXCLUDE

/obj/item/clothing/cloak/apron/waist/colored/brown
	color = CLOTHING_BARK_BROWN

/obj/item/clothing/cloak/apron/waist/colored/bar
	color = "#251f1d"

/obj/item/clothing/cloak/apron/cook
	name = "cook apron"
	desc = "An apron covering the frontal part of the body. Apart from protection from spills, won't prevent you from getting cut in half."
	color = null
	icon_state = "aproncook"
	item_state = "aproncook"
	body_parts_covered = GROIN
	boobed = FALSE

/obj/item/clothing/cloak/apron/maid
	name = "maid apron"
	desc = "The frilly apron of a housemaster. It has pockets to store small things."
	detail_color = "_detail"
	slot_flags = ITEM_SLOT_ARMOR | ITEM_SLOT_CLOAK
	detail_color = CLOTHING_DARK_INK
	icon_state = "maidapron"
	item_state = "maidapron"
	boobed = FALSE
	grid_width = 64
	grid_height = 64
	pocket_storage_component_path = /datum/component/storage/concrete/grid/cloak

/obj/item/clothing/cloak/apron/maid/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!user.job)
		return
	if(slot & slot_flags)
		var/datum/job/J = SSjob.GetJob(user.job)
		if(istype(J, /datum/job/butler) || istype(J, /datum/job/servant))
			return //even if they roll noble blood or something, they wont lose their mind.
		if(HAS_TRAIT(user, TRAIT_NOBLE))
			user.add_stress(/datum/stress_event/maidapron/noble)
		else if(J.department_flag & (GARRISON | OUTSIDERS | CHURCHMEN | NOBLEMEN)) // Notice how I've excluded the inquisition.
			user.add_stress(/datum/stress_event/maidapron)

/obj/item/clothing/cloak/apron/maid/dropped(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.wear_armor == src || H.cloak == src)
			H.remove_stress(/datum/stress_event/maidapron)

