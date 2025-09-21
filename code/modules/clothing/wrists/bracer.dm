
/obj/item/clothing/wrists/bracers
	name = "plate vambraces"
	desc = "Plate forearm guards that offer superior protection while allowing mobility."
	body_parts_covered = ARMS
	icon_state = "bracers"
	item_state = "bracers"
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = null
	melt_amount = 75
	max_integrity = INTEGRITY_STRONG
	armor_class = AC_MEDIUM
	melting_material = /datum/material/steel

/obj/item/clothing/wrists/bracers/iron
	name = "iron plate vambraces"
	desc = "Plate forearm guards that offer good protection while allowing mobility."
	icon_state = "ibracers"
	item_state = "ibracers"
	armor = ARMOR_MAILLE
	max_integrity = INTEGRITY_STANDARD
	melting_material = /datum/material/iron

/obj/item/clothing/wrists/bracers/jackchain
	name = "jack chains"
	desc = "Thin strips of iron attached to small shoulder and elbow plates, worn on the outside of the arms to protect against slashes."
	icon_state = "jackchain"
	item_state = "jackchain"
	armor = ARMOR_MAILLE_IRON
	max_integrity = INTEGRITY_STANDARD - 25
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_CUT)
	armor_class = AC_LIGHT
	melt_amount = 35
	melting_material = /datum/material/iron

/obj/item/clothing/wrists/bracers/copper
	name = "copper bracers"
	desc = "Copper forearm guards that offer some protection while looking rather stylish."
	icon_state = "copperarm"
	item_state = "copperarm"
	armor = ARMOR_MAILLE_IRON //worse than iron bracers
	max_integrity = INTEGRITY_POOR //worse than jackchains in terms of integrity
	//however they protect better than the jackchains
	melt_amount = 75
	armor_class = AC_LIGHT
	melting_material = /datum/material/copper

/obj/item/clothing/wrists/bracers/leather
	name = "leather bracers"
	desc = "Boiled leather bracers typically worn by archers to protect their forearms."
	icon_state = "lbracers"
	item_state = "lbracers"
	armor = ARMOR_LEATHER_BAD
	armor_class = AC_LIGHT
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_CUT)
	resistance_flags = null
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
	salvage_result = null
	smeltresult = /obj/item/fertilizer/ash
	melt_amount = 0
	melting_material = null
	max_integrity = INTEGRITY_STANDARD

/obj/item/clothing/wrists/bracers/leather/advanced
	name = "hardened leather bracers"
	desc = "Hardened leather braces that will keep your wrists safe from bludgeoning."
	armor = list("blunt" = 60, "slash" = 40, "stab" = 20, "piercing" = 0, "fire" = 0, "acid" = 0)
	max_integrity = INTEGRITY_STANDARD + 50

/obj/item/clothing/wrists/bracers/leather/masterwork
	name = "masterwork leather bracers"
	desc = "These bracers are a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	armor = list("blunt" = 80, "slash" = 60, "stab" = 40, "piercing" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_CUT, BCLASS_CHOP)  //We're getting chop here
	max_integrity = INTEGRITY_STANDARD + 100

/obj/item/clothing/wrists/bracers/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

/obj/item/clothing/wrists/bracers/rare
	abstract_type = /obj/item/clothing/wrists/bracers/rare

/obj/item/clothing/wrists/bracers/rare/hoplite
	name = "ancient bracers"
	desc = "Stalwart bronze bracers, from an age long past."
	icon_state = "aasimarwrist"
	item_state = "aasimarwrist"
	armor = ARMOR_PLATE_BAD
	armor_class = AC_LIGHT
	melt_amount = 75
	melting_material = /datum/material/bronze
