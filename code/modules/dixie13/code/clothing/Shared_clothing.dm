// Confederete soldier shirt
/obj/item/clothing/shirt/soldier
	name = "Confederete Wool Undershirt"
	desc = "A coarse wool undershirt worn directly against the skin. Itches constantly, insulates poorly when wet, and is still better than wearing nothing at all. This one appears to be grey."
	icon_state = "soldiershirt"
	gender = PLURAL
	color = CLOTHING_ASH_GREY

// Union soldier shirt
/obj/item/clothing/shirt/soldier/Union
	name = "Union Wool Undershirt"
	desc = "A coarse wool undershirt worn directly against the skin. Itches constantly, insulates poorly when wet, and is still better than wearing nothing at all. This one appears to be in blue."
	color = CLOTHING_MAGE_BLUE

// Confederete soldier pants
/obj/item/clothing/pants/soldier
	name = "Confederate Infantry Trousers"
	desc = "Rough wool trousers in varying shades of grey and butternut. Padded where possible, patched where necessary. Every pair tells a slightly different supply story."
	icon_state = "soldierpant"
	item_state = "soldierpant"
	sewrepair = TRUE
	blocksound = SOFTHIT
	armor = ARMOR_PADDED_BAD
	prevent_crits = MINOR_CRITICALS
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured
	item_weight = 3
	color = CLOTHING_ASH_GREY

// Union soldier pants
/obj/item/clothing/pants/soldier/union
	name = "Union Infantry Trousers"
	desc = "Wool trousers dyed regulation blue and reinforced at the seams. Durable enough to survive marching, kneeling, and dying in. Issued stiff, broken in the hard way."
	icon_state = "soldierpant"
	item_state = "soldierpant"
	item_weight = 3
	color = CLOTHING_MAGE_BLUE

// Confederete soldier cap
/obj/item/clothing/head/soldiercap
	name = "Confederate Forage Cap"
	desc = "An ash grey forage cap, often faded unevenly by sun and sweat. Regulation in theory, improvised in practice. Some still carry unit pins, others only lice."
	icon_state = "clothcap"
	max_heat_protection_temperature = 60
	color = CLOTHING_ASH_GREY

// Union soldier cap
/obj/item/clothing/head/soldiercap/union
	name = "Union Forage Cap"
	desc = "A soft crowned blue forage cap with a short leather visor. Keeps the sun out of a soldier's eyes and rain off his letters home. Rarely fits properly, but neither does the war.."
	color = CLOTHING_MAGE_BLUE

/obj/item/clothing/head/cowboyhat
	name = "Stetson Hat"
	desc = "A wide brimmed felt hat popular among cavalrymen, scouts, ranchers, and men who never trusted regulation issue. Offers shade, rain protection, and just enough personality to be remembered"
	icon_state = "yeehaw"
	max_heat_protection_temperature = 60

/obj/item/clothing/head/cowboyhat/alt
	name = "Stetson Hat"
	icon_state = "heeehaaw"
