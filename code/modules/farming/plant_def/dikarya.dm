/* Cultivars */
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
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	// Mushrooms won't produce ANY. For now.
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 0
	spore_identity = "coprinus spores"

/datum/plant_def/coprinus/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_AVERAGE

/datum/plant_def/porcini
	name = "porcini cluster"
	icon_state = "porcini"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/porcini
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	// Mushrooms won't produce ANY. For now.
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 0
	spore_identity = "porcini spores"

/datum/plant_def/porcini/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_AVERAGE

/* Wild varieties */
/datum/plant_def/reishi
	name = "reishi cluster"
	icon_state = "reishi"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/reishi
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	// Mushrooms won't produce ANY. For now.
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 0
	spore_identity = "reishi spores"

/datum/plant_def/reishi/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_AVERAGE

/datum/plant_def/morel
	name = "morel cluster"
	icon_state = "morel"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/morel
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	// Mushrooms won't produce ANY. For now.
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 0
	spore_identity = "morel spores"

/datum/plant_def/morel/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_AVERAGE

/datum/plant_def/oyster
	name = "oyster cluster"
	icon_state = "oyster"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/oyster
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	// Mushrooms won't produce ANY. For now.
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 0
	spore_identity = "oyster spores"

/datum/plant_def/oyster/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_AVERAGE

/datum/plant_def/chanterelle
	name = "chanterelle cluster"
	icon_state = "chanterelle"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/chanterelle
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	// Mushrooms won't produce ANY. For now.
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 0
	spore_identity = "chanterelle spores"

/datum/plant_def/chanterelle/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_AVERAGE
