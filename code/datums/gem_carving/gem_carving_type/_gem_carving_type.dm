/datum/gem_carving_type
	abstract_type = /datum/gem_carving_type
	var/carving_name
	var/carving_material
	var/spawn_weight
	var/needed_skill
	var/carving_description
	var/sell_price
	var/description = "a %CARVING_TYPE_NAME carved out of %MATERIAL_NAME"
	var/exclusive_to_materials = list()
	var/special_item_typepath
