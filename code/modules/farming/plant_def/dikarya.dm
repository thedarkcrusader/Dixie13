/datum/plant_def/coprinus
	name = "coprinus cluster"
	icon_state = "coprinus"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/coprinus
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 50 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	// Mushrooms won't produce ANY. For now.
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 0
	seed_identity = "coprinus seeds"

/datum/plant_def/coprinus/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_AVERAGE

/* /datum/plant_def/reishi
	name = "reishi cluster"

/datum/plant_def/morel
	name = "morel cluster"

/datum/plant_def/oyster
	name = "oyster cluster"

/datum/plant_def/porcini
	name = "porcini cluster"

/datum/plant_def/chanterelle
	name = "chanterelle cluster" */
