
/obj/item/clothing/wrists/wrappings
	name = "solar wrappings"
	desc = "Common Astratan vestments for the forearms."
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "wrappings"
	item_state = "wrappings"

/obj/item/clothing/wrists/nocwrappings
	name = "moon wrappings"
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "nocwrappings"
	item_state = "nocwrappings"

/obj/item/clothing/wrists/silverbracelet
	name = "silver bracelets"
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "bracelets"
	sellprice = 30

/obj/item/clothing/wrists/silverbracelet/Initialize()
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/clothing/wrists/goldbracelet
	name = "gold bracelets"
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "braceletg"
	sellprice = 65

//Queensleeves
/obj/item/clothing/wrists/royalsleeves
	name = "royal sleeves"
	desc = "Sleeves befitting an elaborate gown."
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "royalsleeves"
	item_state = "royalsleeves"
	detail_tag = "_detail"
	detail_color = CLOTHING_SOOT_BLACK
	uses_lord_coloring = LORD_PRIMARY
