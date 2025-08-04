/obj/item/gem_carving
	name = "bad code"
	desc = "report to coders"
	var/datum/gem_material/material
	var/datum/gem_carving_type/carving_type

/obj/item/gem_carving/Initialize(datum/gem_material/material, datum/gem_carving_type/carving_type)
	. = ..()
	src.material = src.material || material
	src.carving_type = src.carving_type || carving_type
	if(isnull(material) || isnull(carving_type))
		stack_trace("gem carving made without a material or carving type")
		qdel(src)

	var/temp_desc = carving_type::carving_description

	temp_desc = replacetext(temp_name, "%CARVING_TYPE_NAME", carving_type::carving_name)

	temp_desc = replacetext(temp_name, "%MATERIAL_NAME", material::material_name)

	desc = temp_desc

	name = "[material_name] [carving_name]"

	sellprice = carving_type::sell_price + material::material_price + rand(1, 3 * carving_type::needed_skill)
