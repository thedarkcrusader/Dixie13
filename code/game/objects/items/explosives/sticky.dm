
/obj/item/explosive/sticky
	name = "Sticky Bomb"
	desc = "A regular blastpowder bomb covered in sticky goo, held on a stick. It looks very unsafe"
	icon_state = ""
	icon = 'icons/obj/bombs.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	grid_height = 64
	grid_width = 32
	impact_explode = FALSE
	embedchance = 100

	sticky = TRUE  //dear god borbop PLEASE let your code with the sticky var work
	ex_dev = 1
	ex_heavy = 1
	ex_light = 3

	det_time = 5 SECONDS