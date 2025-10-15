/* Cultivars */
/datum/plant_def/coprinus
	name = "coprinus cluster"
	icon_state = "coprinus"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/coprinus
	produce_amount_min = 2
	produce_amount_max = 5
	perennial = FALSE
	can_grow_underground = TRUE
	prefer_boxed = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = FAST_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 35 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 25
	seed_identity = "coprinus spores"

/datum/plant_def/coprinus/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_POOR

/datum/plant_def/porcini
	name = "porcini cluster"
	icon_state = "porcini"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/porcini
	produce_amount_min = 2
	produce_amount_max = 5
	perennial = FALSE
	can_grow_underground = TRUE
	prefer_boxed = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = DEFAULT_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Porcini is a cultivar that produces more and heartier mushrooms, but requires more NPK.
	phosphorus_requirement = 10
	potassium_requirement = 12
	nitrogen_production = 0
	phosphorus_production = 20
	potassium_production = 0
	seed_identity = "porcini spores"

/datum/plant_def/porcini/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD

/* Wild varieties */
/datum/plant_def/reishi
	name = "reishi cluster"
	icon_state = "reishi"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/reishi
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	prefer_boxed = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 35
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 24
	potassium_production = 0
	seed_identity = "reishi spores"

/datum/plant_def/reishi/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD

/datum/plant_def/morel
	name = "morel cluster"
	icon_state = "morel"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/morel
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	prefer_boxed = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 16
	phosphorus_production = 20 // Wider production spread that makes the wait more worthwhile
	potassium_production = 12
	seed_identity = "morel spores"

/datum/plant_def/morel/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_POOR // Grow slowly
	base_genetics.cold_resistance = TRAIT_GRADE_GOOD // But grow in a wider range of conditions

/datum/plant_def/oyster
	name = "oyster cluster"
	icon_state = "oyster"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/oyster
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	prefer_boxed = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = SLOW_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 38 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 30
	potassium_production = 0
	seed_identity = "oyster spores"

/datum/plant_def/oyster/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_POOR
	base_genetics.cold_resistance = TRAIT_GRADE_GOOD // Oysters can grow in harsher conditions
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD

/datum/plant_def/chanterelle
	name = "chanterelle cluster"
	icon_state = "chanterelle"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/mushroom/chanterelle
	produce_amount_min = 1
	produce_amount_max = 4
	perennial = FALSE
	can_grow_underground = TRUE
	prefer_boxed = TRUE
	maturation_time = DEFAULT_GROW_TIME
	produce_time = DEFAULT_PRODUCE_TIME
	plant_family = FAMILY_DIKARYA
	nitrogen_requirement = 40 // Mushrooms thrive on nitrogen
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 28
	seed_identity = "chanterelle spores"

/datum/plant_def/chanterelle/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.growth_speed = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD
