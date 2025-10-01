/datum/repeatable_crafting_recipe/narcotics
	abstract_type = /datum/repeatable_crafting_recipe/narcotics
	tool_usage = list(
		/obj/item/pestle = list("starts to grind materials in the mortar", "start to grind materials in the mortar", 'sound/foley/mortarpestle.ogg'),
	)

	reagent_requirements = list(
		/datum/reagent/water = 15,
	)

	starting_atom = /obj/item/pestle
	attacked_atom = /obj/item/reagent_containers/glass/mortar
	skillcraft = /datum/skill/craft/alchemy
	tool_use_time = 2 SECONDS
	craft_time = 3 SECONDS
	category = "Narcotics"

/datum/repeatable_crafting_recipe/narcotics/spice
	name = "Spice"
	output = /obj/item/reagent_containers/powder/spice
	requirements = list(
		/obj/item/alch/tobaccodust = 1,
		/obj/item/fertilizer/bone_meal = 1,
		/obj/item/alch/viscera = 1
	)
	craftdiff = 2

//And let me tell you something else. This ain't alchemy.
//Okay. This is art. Cooking is art. And the shit I cook is the bomb.
//No. No. Chili's P is my signature.

//the impure drugs are mostly here to help level up alchemy, but also for people to mess around with
/datum/repeatable_crafting_recipe/narcotics/moondust_impure
	name = "Impure Moondust"
	output = /obj/item/reagent_containers/powder/moondust/impure
	requirements = list(
		/obj/item/natural/dirtclod = 1,
		/obj/item/reagent_containers/powder/ozium = 1,
		/obj/item/soap = 1,
		/obj/item/reagent_containers/food/snacks/badrecipe = 1
	)
	craftdiff = 2

/datum/repeatable_crafting_recipe/narcotics/moondust_impure_impurify
	name = "Impurify Impure Moondust"//yes thats the joke
	output = /obj/item/reagent_containers/powder/moondust_purest/impure
	requirements = list(
		/obj/item/reagent_containers/powder/flour = 1,
		/obj/item/natural/poo = 1,
		/datum/repeatable_crafting_recipe/narcotics/moondust_impure = 1
	)
	reagent_requirements = list(
		/datum/reagent/water/gross = 20,
	)
	craftdiff = 3

/datum/repeatable_crafting_recipe/narcotics/moondust
	name = "Moondust"
	output = /obj/item/reagent_containers/powder/moondust
	requirements = list(
		/obj/item/alch/earthdust = 1,
		/obj/item/alch/waterdust = 1,
		/obj/item/reagent_containers/powder/ozium = 1
	)
	craftdiff = 3

/datum/repeatable_crafting_recipe/narcotics/moondustpurify
	name = "Purify Moondust"
	output = /obj/item/reagent_containers/powder/moondust_purest
	requirements = list(
		/obj/item/alch/silverdust = 1,
		/obj/item/reagent_containers/powder/moondust = 2
	)
	craftdiff = 5
	output_amount = 2
