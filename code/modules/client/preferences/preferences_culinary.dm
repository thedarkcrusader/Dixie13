/datum/preferences/proc/validate_culinary_preferences()
	if(!culinary_preferences)
		culinary_preferences = list()

	if(!culinary_preferences[CULINARY_FAVOURITE_FOOD])
		culinary_preferences[CULINARY_FAVOURITE_FOOD] = get_default_food()

	if(!culinary_preferences[CULINARY_FAVOURITE_DRINK])
		culinary_preferences[CULINARY_FAVOURITE_DRINK] = get_default_drink()

/datum/preferences/proc/reset_culinary_preferences()
	culinary_preferences = list()
	culinary_preferences[CULINARY_FAVOURITE_FOOD] = get_default_food()
	culinary_preferences[CULINARY_FAVOURITE_DRINK] = get_default_drink()

/datum/preferences/proc/get_default_food()
	return /obj/item/reagent_containers/food/snacks/breadslice

/datum/preferences/proc/get_default_drink()
	return /datum/reagent/consumable/ethanol/beer

/datum/preferences/proc/handle_culinary_topic(mob/user, href_list)
	switch(href_list["preference"])
		if("choose_food")
			show_food_selection_ui(user)
		if("choose_drink")
			show_drink_selection_ui(user)
		if("confirm_food")
			var/food_type = text2path(href_list["food_type"])
			if(ispath(food_type, /obj/item/reagent_containers/food))
				culinary_preferences[CULINARY_FAVOURITE_FOOD] = food_type
				user << browse(null, "window=food_selection")
				show_culinary_ui(user)
		if("confirm_drink")
			var/drink_type = text2path(href_list["drink_type"])
			if(ispath(drink_type, /datum/reagent/consumable))
				culinary_preferences[CULINARY_FAVOURITE_DRINK] = drink_type
				user << browse(null, "window=drink_selection")
				show_culinary_ui(user)

/datum/preferences/proc/print_culinary_page()
	var/list/dat = list()

	var/current_food = culinary_preferences[CULINARY_FAVOURITE_FOOD]
	var/current_drink = culinary_preferences[CULINARY_FAVOURITE_DRINK]

	var/food_name = "None"
	if(current_food)
		var/obj/item/food_instance = current_food
		food_name = initial(food_instance.name)

	var/drink_name = "None"
	if(current_drink)
		var/datum/reagent/drink_instance = current_drink
		drink_name = initial(drink_instance.name)

	dat += "<b>Favourite Food:</b> <a href='byond://?_src_=prefs;preference=choose_food;task=change_culinary_preferences'>[food_name]</a><br>"
	dat += "<b>Favourite Drink:</b> <a href='byond://?_src_=prefs;preference=choose_drink;task=change_culinary_preferences'>[drink_name]</a><br>"

	return dat

/datum/preferences/proc/show_food_selection_ui(mob/user)
	var/list/dat = list()

	var/list/food_types = subtypesof(/obj/item/reagent_containers/food)

	var/list/food_with_faretypes = list()
	for(var/food_type in food_types)
		var/obj/item/reagent_containers/food/food_instance = food_type
		var/food_faretype = initial(food_instance.faretype)
		var/food_name = initial(food_instance.name)
		food_with_faretypes += list(list("type" = food_type, "faretype" = food_faretype, "name" = food_name))

	food_with_faretypes = sortTim(food_with_faretypes, /proc/cmp_food_by_faretype_and_name)

	for(var/list/food_data in food_with_faretypes)
		var/food_type = food_data["type"]
		var/food_name = food_data["name"]
		var/food_faretype = food_data["faretype"]

		dat += "[icon2html(food_type, user)] <a href='byond://?_src_=prefs;preference=confirm_food;food_type=[food_type];task=change_culinary_preferences'>[food_name]</a> (Faretype: [food_faretype])<br>"

	var/datum/browser/popup = new(user, "food_selection", "<div align='center'>Select Favourite Food</div>", 400, 600)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/show_drink_selection_ui(mob/user)
	var/list/dat = list()

	var/list/drink_types = subtypesof(/datum/reagent/consumable)

	var/list/drink_with_qualities = list()
	for(var/drink_type in drink_types)
		var/datum/reagent/consumable/drink_instance = drink_type
		var/drink_quality = initial(drink_instance.quality)
		var/drink_name = initial(drink_instance.name)
		drink_with_qualities += list(list("type" = drink_type, "quality" = drink_quality, "name" = drink_name))

	drink_with_qualities = sortTim(drink_with_qualities, /proc/cmp_drink_by_quality_and_name)

	for(var/list/drink_data in drink_with_qualities)
		var/drink_type = drink_data["type"]
		var/drink_name = drink_data["name"]
		var/drink_quality = drink_data["quality"]

		var/icon_type
		if(drink_quality <= 0)
			icon_type = /obj/item/reagent_containers/glass/cup/wooden
		else if(drink_quality <= 1)
			icon_type = /obj/item/reagent_containers/glass/cup
		else if(drink_quality <= 2)
			icon_type = /obj/item/reagent_containers/glass/bottle
		else if(drink_quality <= 3)
			icon_type = /obj/item/reagent_containers/glass/cup/silver
		else
			icon_type = /obj/item/reagent_containers/glass/cup/golden

		dat += "[icon2html(icon_type, user)] <a href='byond://?_src_=prefs;preference=confirm_drink;drink_type=[drink_type];task=change_culinary_preferences'>[drink_name]</a> (Quality: [drink_quality])<br>"

	var/datum/browser/popup = new(user, "drink_selection", "<div align='center'>Select Favourite Drink</div>", 400, 600)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/proc/cmp_food_by_faretype_and_name(list/a, list/b)
	var/faretype_a = a["faretype"]
	var/faretype_b = b["faretype"]

	if(faretype_a != faretype_b)
		return faretype_a - faretype_b

	var/name_a = a["name"]
	var/name_b = b["name"]
	return sorttext(name_a, name_b)

/proc/cmp_drink_by_quality_and_name(list/a, list/b)
	var/quality_a = a["quality"]
	var/quality_b = b["quality"]

	if(quality_a != quality_b)
		return quality_a - quality_b

	var/name_a = a["name"]
	var/name_b = b["name"]
	return sorttext(name_a, name_b)

/datum/preferences/proc/show_culinary_ui(mob/user)
	var/list/dat = list()
	dat += print_culinary_page()
	var/datum/browser/popup = new(user, "culinary_customization", "<div align='center'>Culinary Preferences</div>", 305, 245)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/apply_culinary_preferences(mob/living/carbon/human/character)
	if(!culinary_preferences)
		return

	character.culinary_preferences = culinary_preferences.Copy()
