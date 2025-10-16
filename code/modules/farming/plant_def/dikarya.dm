/datum/plant_def/mushroom
	plant_family = FAMILY_DIKARYA
	can_grow_underground = TRUE
	mound_growth = TRUE
	produce_amount_min = 1
	produce_amount_max = 4
	potassium_requirement = 0 // Ash won't work well as fertilizer for these

/* Cultivars */
/datum/plant_def/mushroom/coprinus
	name = "coprinus cluster"
	icon_state = "coprinus"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/coprinus
	produce_amount_min = 2
	produce_amount_max = 5
	produce_time = FAST_PRODUCE_TIME
	nitrogen_requirement = 0
	phosphorus_requirement = 30 // Grows well with its companion, porcini
	nitrogen_production = 20
	phosphorus_production = 0
	potassium_production = 0
	seed_identity = "coprinus spores"

/datum/plant_def/mushroom/coprinus/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_POOR

/datum/plant_def/mushroom/porcini
	name = "porcini cluster"
	icon_state = "porcini"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/porcini
	produce_amount_min = 2
	produce_amount_max = 5
	produce_time = DEFAULT_PRODUCE_TIME
	nitrogen_requirement = 40 // Porcini is a cultivar that produces more and heartier mushrooms, but requires more N than most.
	phosphorus_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 20
	potassium_production = 0
	seed_identity = "porcini spores"

/datum/plant_def/mushroom/porcini/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD

/* Wild varieties */
/datum/plant_def/mushroom/reishi
	name = "reishi cluster"
	icon_state = "reishi"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/reishi
	produce_time = SLOW_PRODUCE_TIME
	nitrogen_requirement = 35
	phosphorus_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 24
	potassium_production = 0
	seed_identity = "reishi spores"

/datum/plant_def/mushroom/reishi/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD

/datum/plant_def/mushroom/morel
	name = "morel cluster"
	icon_state = "morel"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/morel
	produce_time = SLOW_PRODUCE_TIME
	nitrogen_requirement = 38 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	nitrogen_production = 16
	phosphorus_production = 20 // Wider production spread that makes the wait more worthwhile
	potassium_production = 12
	seed_identity = "morel spores"

/datum/plant_def/mushroom/morel/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_POOR // Grow slowly
	base_genetics.cold_resistance = TRAIT_GRADE_GOOD // But grow in a wider range of conditions

/datum/plant_def/mushroom/oyster
	name = "oyster cluster"
	icon_state = "oyster"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/oyster
	produce_time = SLOW_PRODUCE_TIME
	nitrogen_requirement = 32 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 26
	potassium_production = 0
	seed_identity = "oyster spores"

/datum/plant_def/mushroom/oyster/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_POOR
	base_genetics.cold_resistance = TRAIT_GRADE_GOOD // Oysters can grow in harsher conditions
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD

/datum/plant_def/mushroom/chanterelle
	name = "chanterelle cluster"
	icon_state = "chanterelle"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/chanterelle
	produce_time = DEFAULT_PRODUCE_TIME
	nitrogen_requirement = 32 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 28
	seed_identity = "chanterelle spores"

/datum/plant_def/mushroom/chanterelle/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD
