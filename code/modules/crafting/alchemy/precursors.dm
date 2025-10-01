GLOBAL_LIST_INIT(natural_precursor_registry, list())
/proc/initialize_natural_precursors()
	for(var/datum/natural_precursor/precursor as anything in subtypesof(/datum/natural_precursor))
		var/datum/natural_precursor/created_precursor = new precursor
		for(var/atom/atom_path as anything in created_precursor.init_types)
			GLOB.natural_precursor_registry[atom_path] = created_precursor

/proc/get_precursor_data(obj/item/I)
	if(!length(GLOB.natural_precursor_registry))
		initialize_natural_precursors()
	if(!(I.type in GLOB.natural_precursor_registry))
		return FALSE
	return GLOB.natural_precursor_registry[I.type]

/datum/natural_precursor
	abstract_type = /datum/natural_precursor
	var/category = "Precursor"
	var/name = "precursor"
	var/list/essence_yields = list() // essence_type = amount
	var/list/init_types = list() //list of all types that use this precursor


/datum/natural_precursor/proc/generate_html(mob/user)
	var/client/client = user
	if(!istype(client))
		client = user.client
	SSassets.transport.send_assets(client, list("try4_border.png", "try4.png", "slop_menustyle2.css"))
	user << browse_rsc('html/book.png')

	var/html = {"
		<!DOCTYPE html>
		<html lang="en">
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<style>
			@import url('https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap');
			body {
				font-family: "Charm", cursive;
				font-size: 1.2em;
				text-align: center;
				margin: 20px;
				background-color: #f4efe6;
				color: #3e2723;
				background-color: rgb(31, 20, 24);
				background:
					url('[SSassets.transport.get_asset_url("try4_border.png")]'),
					url('book.png');
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-size: 100% 100%;
			}
			h1 {
				text-align: center;
				font-size: 2em;
				border-bottom: 2px solid #3e2723;
				padding-bottom: 10px;
				margin-bottom: 10px;
			}
			.icon {
				width: 64px;
				height: 64px;
				vertical-align: middle;
				margin-right: 10px;
			}
			.yields {
				margin-bottom: 20px;
			}
			.category {
				font-style: italic;
				color: #8d6e63;
				margin-bottom: 10px;
			}
			.used-in {
				margin-top: 15px;
				font-style: italic;
				color: #5d4037;
			}
		</style>
		<body>
		  <div>
			<h1>[name]</h1>
			<div class="category">[category]</div>
			<div class="yields">
			  <h2>Essence Yields</h2>
	"}

	// Add essence yields
	if(length(essence_yields))
		for(var/datum/thaumaturgical_essence/essence_type as anything in essence_yields)
			var/essence_amount = essence_yields[essence_type]
			html += "[essence_amount] [essence_type.name]<br>"
	else
		html += "No essence yields<br>"

	html += {"
		</div>
	"}

	// Add usage information
	if(length(init_types))
		html += "<div class='used-in'><h2>Splits from</h2>"
		for(var/atom/type_path as anything in init_types)
			html += "[initial(type_path.name)]<br>"
		html += "</div>"

	html += {"
		</div>
	</body>
	</html>
	"}

	return html

/datum/natural_precursor/proc/show_menu(mob/user)
	user << browse(generate_html(user), "window=natural_precursor;size=500x810")

/datum/natural_precursor/manabloom
	name = "manabloom"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 3,
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/life = 1,
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/manabloom,
		/obj/item/reagent_containers/powder/manabloom
	)

/datum/natural_precursor/vegetable
	name = "vegetable"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 5,
		/datum/thaumaturgical_essence/life = 2
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/vegetable,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/cabbage,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/onion,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/turnip,
	)

/datum/natural_precursor/fruit
	name = "fruit"
	essence_yields = list(
		/datum/thaumaturgical_essence/water = 5,
		/datum/thaumaturgical_essence/life = 2,
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit,
		/obj/item/reagent_containers/food/snacks/produce/fruit/strawberry,
		/obj/item/reagent_containers/food/snacks/produce/fruit/raspberry,
		/obj/item/reagent_containers/food/snacks/produce/fruit/blackberry,
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry,
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison,
		/obj/item/reagent_containers/food/snacks/produce/fruit/pear,
		/obj/item/reagent_containers/food/snacks/produce/fruit/apple,
		/obj/item/reagent_containers/food/snacks/produce/fruit/lemon,
		/obj/item/reagent_containers/food/snacks/produce/fruit/lime,
		/obj/item/reagent_containers/food/snacks/produce/fruit/tangerine,
		/obj/item/reagent_containers/food/snacks/produce/fruit/plum,
	)

/datum/natural_precursor/grain
	name = "grain"
	essence_yields = list(
		/datum/thaumaturgical_essence/order = 5,
		/datum/thaumaturgical_essence/life = 2
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/grain,
		/obj/item/reagent_containers/food/snacks/produce/grain/wheat,
		/obj/item/reagent_containers/food/snacks/produce/grain/oat,
	)

/datum/natural_precursor/swampweed
	name = "swampweed"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 3,
		/datum/thaumaturgical_essence/earth = 1,
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/swampweed,
		/obj/item/reagent_containers/food/snacks/produce/swampweed_dried,
	)

/datum/natural_precursor/swampweed_dried
	name = "dried swampweed"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 3
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/swampweed_dried,
	)

/datum/natural_precursor/westleach
	name = "westleach"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 2,
		/datum/thaumaturgical_essence/fire = 1
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/westleach,
		/obj/item/reagent_containers/food/snacks/produce/dry_westleach,
	)

/datum/natural_precursor/sugarcane
	name = "sugarcane"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 5,
		/datum/thaumaturgical_essence/chaos = 2
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/sugarcane,
	)

/datum/natural_precursor/sunflower
	name = "sunflower"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 5,
		/datum/thaumaturgical_essence/light = 2
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/sunflower,
	)

/datum/natural_precursor/fyritius
	name = "fyritius flower"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 5,
		/datum/thaumaturgical_essence/energia = 2
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/fyritius,
	)

/datum/natural_precursor/poppy
	name = "poppy"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 3,
		/datum/thaumaturgical_essence/life = 2,
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/produce/poppy,
	)

/datum/natural_precursor/leech
	name = "leech"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 3,
		/datum/thaumaturgical_essence/water = 2
	)
	init_types = list(
		/obj/item/natural/worms/leech,
		/obj/item/natural/worms/leech/parasite,
		/obj/item/natural/worms/leech/propaganda,
		/obj/item/natural/worms/leech/abyssoid,
	)

/datum/natural_precursor/stone
	name = "stone"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 5
	)
	init_types = list(
		/obj/item/natural/stone,
		/obj/item/natural/stone/sending,
	)

/datum/natural_precursor/gem
	name = "gem"
	essence_yields = list(
		/datum/thaumaturgical_essence/crystal = 5,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/gem,
	)

/datum/natural_precursor/coal
	name = "coal"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 3,
		/datum/thaumaturgical_essence/earth = 2
	)
	init_types = list(
		/obj/item/ore/coal,
	)

/datum/natural_precursor/bone
	name = "bone"
	essence_yields = list(
		/datum/thaumaturgical_essence/void = 10,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/alch/bone,
	)

/datum/natural_precursor/bone_meal
	name = "bone meal"
	essence_yields = list(
		/datum/thaumaturgical_essence/chaos = 10,
		/datum/thaumaturgical_essence/void = 5
	)
	init_types = list(
		/obj/item/fertilizer/bone_meal,
	)

/datum/natural_precursor/feather
	name = "feather"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 2,
		/datum/thaumaturgical_essence/motion = 1
	)
	init_types = list(
		/obj/item/natural/feather,
		/obj/item/natural/feather/infernal
	)

/datum/natural_precursor/obsidian
	name = "obsidian"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 5,
		/datum/thaumaturgical_essence/earth = 5
	)
	init_types = list(
		/obj/item/natural/obsidian
	)

/datum/natural_precursor/leyline
	name = "leyline crystal"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 10
	)
	init_types = list(
		/obj/item/natural/leyline
	)

/datum/natural_precursor/artifact
	name = "arcyne artifact"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 5,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/natural/artifact
	)

/datum/natural_precursor/voidstone
	name = "voidstone"
	essence_yields = list(
		/datum/thaumaturgical_essence/void = 50
	)
	init_types = list(
		/obj/item/natural/voidstone
	)

/datum/natural_precursor/melded
	name = "arcanic meld"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 10,
		/datum/thaumaturgical_essence/chaos = 20
	)
	init_types = list(
		/obj/item/natural/melded,
		/obj/item/natural/melded/t1,
		/obj/item/natural/melded/t2,
		/obj/item/natural/melded/t3,
		/obj/item/natural/melded/t4,
		/obj/item/natural/melded/t5
	)

/datum/natural_precursor/infernalash
	name = "infernal ash"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 5,
		/datum/thaumaturgical_essence/chaos = 10
	)
	init_types = list(
		/obj/item/natural/infernalash
	)

/datum/natural_precursor/hellhoundfang
	name = "hellhound fang"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 10,
		/datum/thaumaturgical_essence/chaos = 15
	)
	init_types = list(
		/obj/item/natural/hellhoundfang
	)

/datum/natural_precursor/moltencore
	name = "molten core"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 15,
		/datum/thaumaturgical_essence/chaos = 20
	)
	init_types = list(
		/obj/item/natural/moltencore
	)

/datum/natural_precursor/abyssalflame
	name = "abyssal flame"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 20,
		/datum/thaumaturgical_essence/chaos = 25
	)
	init_types = list(
		/obj/item/natural/abyssalflame
	)

/datum/natural_precursor/fairydust
	name = "fairy dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 10,
		/datum/thaumaturgical_essence/water = 5
	)
	init_types = list(
		/obj/item/natural/fairydust
	)

/datum/natural_precursor/iridescentscale
	name = "iridescent scale"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 15,
		/datum/thaumaturgical_essence/water = 10
	)
	init_types = list(
		/obj/item/natural/iridescentscale
	)

/datum/natural_precursor/heartwoodcore
	name = "heartwood core"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 20,
		/datum/thaumaturgical_essence/water = 15
	)
	init_types = list(
		/obj/item/natural/heartwoodcore
	)

/datum/natural_precursor/sylvanessence
	name = "sylvan essence"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 25,
		/datum/thaumaturgical_essence/water = 20
	)
	init_types = list(
		/obj/item/natural/sylvanessence
	)

/datum/natural_precursor/elementalmote
	name = "elemental mote"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 10,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/natural/elementalmote
	)

/datum/natural_precursor/elementalshard
	name = "elemental shard"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 15,
		/datum/thaumaturgical_essence/order = 10
	)
	init_types = list(
		/obj/item/natural/elementalshard
	)

/datum/natural_precursor/elementalfragment
	name = "elemental fragment"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 20,
		/datum/thaumaturgical_essence/order = 15
	)
	init_types = list(
		/obj/item/natural/elementalfragment
	)

/datum/natural_precursor/elementalrelic
	name = "elemental relic"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 25,
		/datum/thaumaturgical_essence/order = 20
	)
	init_types = list(
		/obj/item/natural/elementalrelic
	)

/datum/natural_precursor/hide_fur
	name = "animal hide and fur"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 5,
		/datum/thaumaturgical_essence/earth = 3
	)
	init_types = list(
		/obj/item/natural/hide,
		/obj/item/natural/hide/cured,
		/obj/item/natural/cured,
		/obj/item/natural/fur,
		/obj/item/natural/fur/gote,
		/obj/item/natural/fur/volf,
		/obj/item/natural/fur/mole,
		/obj/item/natural/fur/rous,
		/obj/item/natural/fur/cabbit,
	)


/datum/natural_precursor/dendor_essence
	name = "essence of dendor"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 5,
		/datum/thaumaturgical_essence/magic = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/natural/cured/essence,
		/obj/item/grown/log/tree/essence
	)

/datum/natural_precursor/head
	name = "animal head"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 5,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/natural/head,
		/obj/item/natural/head/volf,
		/obj/item/natural/head/saiga,
		/obj/item/natural/head/troll,
		/obj/item/natural/head/troll/axe,
		/obj/item/natural/head/troll/cave,
		/obj/item/natural/head/rous,
		/obj/item/natural/head/spider,
		/obj/item/natural/head/bug,
		/obj/item/natural/head/mole,
		/obj/item/natural/head/gote
	)

/datum/natural_precursor/fibers
	name = "natural fibers"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 1,
		/datum/thaumaturgical_essence/order = 2
	)
	init_types = list(
		/obj/item/natural/fibers,
		/obj/item/natural/silk,
		/obj/item/natural/cloth
	)

/datum/natural_precursor/dirtclod
	name = "dirt clod"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 3
	)
	init_types = list(
		/obj/item/natural/dirtclod
	)

/datum/natural_precursor/glass
	name = "glass shard"
	essence_yields = list(
		/datum/thaumaturgical_essence/crystal = 3
	)
	init_types = list(
		/obj/item/natural/glass,
		/obj/item/natural/glass/shard
	)

/datum/natural_precursor/poo
	name = "animal waste"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 1,
		/datum/thaumaturgical_essence/poison = 2
	)
	init_types = list(
		/obj/item/natural/poo,
		/obj/item/natural/poo/cow,
		/obj/item/natural/poo/horse
	)

/datum/natural_precursor/rock
	name = "rock"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/order = 2
	)
	init_types = list(
		/obj/item/natural/rock,
		/obj/item/natural/rock/gold,
		/obj/item/natural/rock/iron,
		/obj/item/natural/rock/coal,
		/obj/item/natural/rock/salt,
		/obj/item/natural/rock/silver,
		/obj/item/natural/rock/copper,
		/obj/item/natural/rock/tin,
		/obj/item/natural/rock/gemerald,
		/obj/item/natural/rock/random_ore,
		/obj/item/natural/rock/random,
		/obj/item/natural/rock/mana_crystal,
		/obj/item/natural/rock/cinnabar
	)

/datum/natural_precursor/stoneblock
	name = "stone block"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 3,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/natural/stoneblock
	)

/datum/natural_precursor/wood
	name = "wood"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/natural/wood,
		/obj/item/natural/wood/plank
	)

/datum/natural_precursor/clay
	name = "clay"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/water = 1
	)
	init_types = list(
		/obj/item/natural/clay
	)

/datum/natural_precursor/chaff
	name = "grain chaff"
	essence_yields = list(
		/datum/thaumaturgical_essence/order = 1,
		/datum/thaumaturgical_essence/life = 2
	)
	init_types = list(
		/obj/item/natural/chaff,
		/obj/item/natural/chaff/wheat,
		/obj/item/natural/chaff/oat
	)

/datum/natural_precursor/worms
	name = "worms"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 2,
		/datum/thaumaturgical_essence/poison = 1
	)
	init_types = list(
		/obj/item/natural/worms,
		/obj/item/natural/worms/grub_silk
	)

/datum/natural_precursor/gold_ore
	name = "gold ore"
	essence_yields = list(
		/datum/thaumaturgical_essence/order = 2,
		/datum/thaumaturgical_essence/energia = 1
	)
	init_types = list(
		/obj/item/ore/gold
	)

/datum/natural_precursor/silver_ore
	name = "silver ore"
	essence_yields = list(
		/datum/thaumaturgical_essence/light = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/ore/silver
	)

/datum/natural_precursor/iron_ore
	name = "iron ore"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/ore/iron
	)

/datum/natural_precursor/copper_ore
	name = "copper ore"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 1,
		/datum/thaumaturgical_essence/energia = 2
	)
	init_types = list(
		/obj/item/ore/copper
	)

/datum/natural_precursor/tin_ore
	name = "tin ore"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/ore/tin
	)

/datum/natural_precursor/charcoal
	name = "charcoal"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 3
	)
	init_types = list(
		/obj/item/ore/coal/charcoal
	)

/datum/natural_precursor/cinnabar_ore
	name = "cinnabar ore"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 1,
		/datum/thaumaturgical_essence/poison = 2
	)
	init_types = list(
		/obj/item/ore/cinnabar
	)

/datum/natural_precursor/gold_ingot
	name = "gold ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/order = 2,
		/datum/thaumaturgical_essence/light = 1
	)
	init_types = list(
		/obj/item/ingot/gold
	)

/datum/natural_precursor/iron_ingot
	name = "iron ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/ingot/iron
	)

/datum/natural_precursor/copper_ingot
	name = "copper ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 1,
		/datum/thaumaturgical_essence/energia = 2
	)
	init_types = list(
		/obj/item/ingot/copper
	)

/datum/natural_precursor/tin_ingot
	name = "tin ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/ingot/tin
	)

/datum/natural_precursor/bronze_ingot
	name = "bronze ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/ingot/bronze
	)

/datum/natural_precursor/silver_ingot
	name = "silver ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/light = 2,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/ingot/silver
	)

/datum/natural_precursor/steel_ingot
	name = "steel ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/fire = 1
	)
	init_types = list(
		/obj/item/ingot/steel
	)

/datum/natural_precursor/blacksteel_ingot
	name = "blacksteel ingot"
	essence_yields = list(
		/datum/thaumaturgical_essence/void = 2,
		/datum/thaumaturgical_essence/fire = 1
	)
	init_types = list(
		/obj/item/ingot/blacksteel
	)

/datum/natural_precursor/meat
	name = "meat"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 2,
		/datum/thaumaturgical_essence/order = 3,
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/meat,
		/obj/item/reagent_containers/food/snacks/meat/steak,
		/obj/item/reagent_containers/food/snacks/meat/human,
		/obj/item/reagent_containers/food/snacks/meat/fatty,
		/obj/item/reagent_containers/food/snacks/meat/strange,
		/obj/item/reagent_containers/food/snacks/meat/poultry,
		/obj/item/reagent_containers/food/snacks/meat/poultry/cutlet,
		/obj/item/reagent_containers/food/snacks/meat/mince,
		/obj/item/reagent_containers/food/snacks/meat/mince/beef,
		/obj/item/reagent_containers/food/snacks/meat/mince/beef/mett,
		/obj/item/reagent_containers/food/snacks/meat/mince/poultry,
		/obj/item/reagent_containers/food/snacks/meat/mince/fish,
		/obj/item/reagent_containers/food/snacks/meat/sausage,
		/obj/item/reagent_containers/food/snacks/meat/wiener,
		/obj/item/reagent_containers/food/snacks/meat/salami/slice,
	)

/datum/natural_precursor/fish
	name = "fish"
	essence_yields = list(
		/datum/thaumaturgical_essence/water = 2,
		/datum/thaumaturgical_essence/void = 3
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/fish/dead,
		/obj/item/reagent_containers/food/snacks/fish/carp,
		/obj/item/reagent_containers/food/snacks/fish/clownfish,
		/obj/item/reagent_containers/food/snacks/fish/eel,
		/obj/item/reagent_containers/food/snacks/fish/shrimp,
	)

/datum/natural_precursor/fish_angler
	name = "angler fish"
	essence_yields = list(
		/datum/thaumaturgical_essence/water = 10,
		/datum/thaumaturgical_essence/void = 5,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/fish/angler
	)

/datum/natural_precursor/fish_swordfish
	name = "swordfish"
	essence_yields = list(
		/datum/thaumaturgical_essence/water = 5,
		/datum/thaumaturgical_essence/life = 5,
		/datum/thaumaturgical_essence/motion = 5
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/fish/swordfish
	)

/datum/natural_precursor/tree_log
	name = "tree log"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 5,
		/datum/thaumaturgical_essence/life = 3
	)
	init_types = list(
		/obj/item/grown/log/tree
	)

/datum/natural_precursor/tree_log_small
	name = "small tree log"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/life = 1
	)
	init_types = list(
		/obj/item/grown/log/tree/small
	)

/datum/natural_precursor/tree_stick
	name = "tree stick"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 1,
		/datum/thaumaturgical_essence/order = 1
	)
	init_types = list(
		/obj/item/grown/log/tree/stick,
		/obj/item/grown/log/tree/stake,
		/obj/item/natural/thorn //thorn is here because... its a tiny stick with a point end
	)

/datum/natural_precursor/viscera
	name = "viscera"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/poison = 5
	)
	init_types = list(
		/obj/item/alch/viscera
	)

/datum/natural_precursor/waterdust
	name = "water dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/water = 20
	)
	init_types = list(
		/obj/item/alch/waterdust
	)

/datum/natural_precursor/bonemeal
	name = "bonemeal"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/fertilizer/bone_meal
	)

/datum/natural_precursor/seeddust
	name = "seed dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/alch/seeddust
	)

/datum/natural_precursor/runedust
	name = "rune dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/order = 10,
		/datum/thaumaturgical_essence/magic = 5
	)
	init_types = list(
		/obj/item/alch/runedust
	)

/datum/natural_precursor/coaldust
	name = "coal dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 5,
		/datum/thaumaturgical_essence/earth = 10
	)
	init_types = list(
		/obj/item/alch/coaldust
	)

/datum/natural_precursor/silverdust
	name = "silver dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/order = 10,
		/datum/thaumaturgical_essence/void = 5
	)
	init_types = list(
		/obj/item/alch/silverdust
	)

/datum/natural_precursor/magicdust
	name = "magic dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 20
	)
	init_types = list(
		/obj/item/alch/magicdust
	)

/datum/natural_precursor/firedust
	name = "fire dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 20
	)
	init_types = list(
		/obj/item/alch/firedust
	)

/datum/natural_precursor/sinew
	name = "sinew"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/motion = 5
	)
	init_types = list(
		/obj/item/alch/sinew
	)

/datum/natural_precursor/irondust
	name = "iron dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 10,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/alch/irondust
	)

/datum/natural_precursor/airdust
	name = "air dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 20
	)
	init_types = list(
		/obj/item/alch/airdust
	)

/datum/natural_precursor/swampdust
	name = "swamp dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/alch/swampdust
	)

/datum/natural_precursor/tobaccodust
	name = "westleach dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 10,
		/datum/thaumaturgical_essence/poison = 5
	)
	init_types = list(
		/obj/item/alch/tobaccodust
	)

/datum/natural_precursor/earthdust
	name = "earth dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 20
	)
	init_types = list(
		/obj/item/alch/earthdust
	)

/datum/natural_precursor/horn
	name = "horn"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/earth = 10,
		/datum/thaumaturgical_essence/order = 10,
		/datum/thaumaturgical_essence/chaos = 10
	)
	init_types = list(
		/obj/item/alch/horn
	)

/datum/natural_precursor/golddust
	name = "gold dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/order = 10,
		/datum/thaumaturgical_essence/light = 5
	)
	init_types = list(
		/obj/item/alch/golddust
	)

/datum/natural_precursor/feaudust
	name = "feau dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 10,
		/datum/thaumaturgical_essence/chaos = 15
	)
	init_types = list(
		/obj/item/alch/feaudust
	)

/datum/natural_precursor/ozium
	name = "ozium"
	essence_yields = list(
		/datum/thaumaturgical_essence/air = 5,
		/datum/thaumaturgical_essence/void = 10
	)
	init_types = list(
		/obj/item/alch/ozium
	)

/datum/natural_precursor/transisdust
	name = "transis dust"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 10,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/alch/transisdust
	)

// Herbs, mostly life, poison, and cycle essences

/datum/natural_precursor/atropa
	name = "atropa"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/alch/herb/atropa
	)

/datum/natural_precursor/matricaria
	name = "matricaria"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/cycle = 5
	)
	init_types = list(
		/obj/item/alch/herb/matricaria
	)

/datum/natural_precursor/symphitum
	name = "symphitum"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/earth = 5
	)
	init_types = list(
		/obj/item/alch/herb/symphitum
	)

/datum/natural_precursor/taraxacum
	name = "taraxacum"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/cycle = 5
	)
	init_types = list(
		/obj/item/alch/herb/taraxacum
	)

/datum/natural_precursor/euphrasia
	name = "euphrasia"
	essence_yields = list(
		/datum/thaumaturgical_essence/light = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/alch/herb/euphrasia
	)

/datum/natural_precursor/paris
	name = "paris"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/alch/herb/paris
	)

/datum/natural_precursor/calendula
	name = "calendula"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/light = 5
	)
	init_types = list(
		/obj/item/alch/herb/calendula
	)

/datum/natural_precursor/mentha
	name = "mentha"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 5,
		/datum/thaumaturgical_essence/air = 10
	)
	init_types = list(
		/obj/item/alch/herb/mentha
	)

/datum/natural_precursor/urtica
	name = "urtica"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/alch/herb/urtica
	)

/datum/natural_precursor/salvia
	name = "salvia"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/magic = 5
	)
	init_types = list(
		/obj/item/alch/herb/salvia
	)

/datum/natural_precursor/rosa
	name = "rosa"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/light = 5
	)
	init_types = list(
		/obj/item/alch/herb/rosa
	)

/datum/natural_precursor/hypericum
	name = "hypericum"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/order = 5
	)
	init_types = list(
		/obj/item/alch/herb/hypericum
	)

/datum/natural_precursor/benedictus
	name = "benedictus"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/cycle = 5
	)
	init_types = list(
		/obj/item/alch/herb/benedictus
	)

/datum/natural_precursor/valeriana
	name = "valeriana"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/motion = 5
	)
	init_types = list(
		/obj/item/alch/herb/valeriana
	)

/datum/natural_precursor/artemisia
	name = "artemisia"
	essence_yields = list(
		/datum/thaumaturgical_essence/life = 10,
		/datum/thaumaturgical_essence/poison = 5
	)
	init_types = list(
		/obj/item/alch/herb/artemisia
	)

/datum/natural_precursor/euphorbia
	name = "euphorbia"
	essence_yields = list(
		/datum/thaumaturgical_essence/earth = 10,
		/datum/thaumaturgical_essence/life = 5
	)
	init_types = list(
		/obj/item/alch/herb/euphorbia
	)

/datum/natural_precursor/mana_crystal
	name = "mana crystal"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 5,
		/datum/thaumaturgical_essence/earth = 5
	)
	init_types = list(
		/obj/item/mana_battery/mana_crystal/standard
	)

//1 standard crystal can be split into two small ones
/datum/natural_precursor/mana_crystal_small
	name = "small mana crystal"
	essence_yields = list(
		/datum/thaumaturgical_essence/magic = 2,
		/datum/thaumaturgical_essence/earth = 1
	)
	init_types = list(
		/obj/item/mana_battery/mana_crystal/small
	)


//why would you split thaumic iron after making, I do not know, but you can now
/datum/natural_precursor/thaumic_iron
	name = "thaumic iron"
	essence_yields = list(
		/datum/thaumaturgical_essence/fire = 10,
		/datum/thaumaturgical_essence/earth = 5
	)
	init_types = list(
		/obj/item/alch/thaumicdust,
		/obj/item/ingot/thaumic
	)


/datum/natural_precursor/rotten_food
	name = "rotten food"
	essence_yields = list(
		/datum/thaumaturgical_essence/poison = 5,
		/datum/thaumaturgical_essence/chaos = 1
	)
	init_types = list(
		/obj/item/reagent_containers/food/snacks/rotten,
		/obj/item/reagent_containers/food/snacks/rotten/meat,
		/obj/item/reagent_containers/food/snacks/rotten/bacon,
		/obj/item/reagent_containers/food/snacks/rotten/sausage,
		/obj/item/reagent_containers/food/snacks/rotten/poultry,
		/obj/item/reagent_containers/food/snacks/rotten/chickenleg,
		/obj/item/reagent_containers/food/snacks/rotten/breadslice,
		/obj/item/reagent_containers/food/snacks/rotten/egg,
		/obj/item/reagent_containers/food/snacks/rotten/mince,
	)

//generic organs here
/datum/natural_precursor/organs
	name = "organs"
	essence_yields = list(
		/datum/thaumaturgical_essence/chaos = 10,
		/datum/thaumaturgical_essence/void = 5,
		/datum/thaumaturgical_essence/life = 5,
	)
	init_types = list(
		/obj/item/organ/appendix,
		/obj/item/organ/heart,
		/obj/item/organ/eyes,
		/obj/item/organ/liver,
		/obj/item/organ/lungs,
		/obj/item/organ/stomach,
		/obj/item/organ/tongue
	)

//the brain is unique enough that I think it justifies its own precursor
/datum/natural_precursor/brain
	name = "brain"
	essence_yields = list(
		/datum/thaumaturgical_essence/chaos = 20,
		/datum/thaumaturgical_essence/void = 10,
		/datum/thaumaturgical_essence/life = 5,
	)
	init_types = list(
		/obj/item/organ/brain,
	)
