
/obj/item/explosive/sticky
	name = "Sticky Bomb"
	desc = "A strange engorged leach with blastpowder leaking out of its maw. It looks like it is in severe pain, and it seems to be covered in especially sticky slime."
	icon_state = ""
	icon = 'icons/obj/bombs.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	grid_height = 64
	grid_width = 32
	impact_explode = FALSE
	var/embedchance = 100

	sticky = TRUE  //dear god borbop PLEASE let your code with the sticky var work
	ex_dev = 1
	ex_heavy = 1
	ex_light = 3

	det_time = 5 SECONDS