/datum/repeatable_crafting_recipe/crafting
	abstract_type = /datum/repeatable_crafting_recipe/crafting
	skillcraft = /datum/skill/craft/crafting
	category = "Misc Crafting"
	allow_inverse_start = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/mantrap
	name = "mantrap"
	requirements = list(
		/obj/item/grown/log/tree/stake = 1,
		/obj/item/rope = 1,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stake
	starting_atom  = /obj/item/rope
	output = /obj/item/restraints/legcuffs/beartrap/crafted/makeshift
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/mantrap/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/datum/repeatable_crafting_recipe/crafting/earnecklace
	name = "ear necklace"
	requirements = list(
		/obj/item/organ/ears= 4,
		/obj/item/rope = 1,
	)
	attacked_atom = /obj/item/rope
	starting_atom= /obj/item/organ/ears
	output = /obj/item/clothing/neck/menears
	subtypes_allowed = TRUE
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/earnecklace/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/datum/repeatable_crafting_recipe/crafting/earnecklace/elf
	name = "elf ear necklace"
	requirements = list(
		/obj/item/organ/ears/elf = 4,
		/obj/item/rope = 1,
	)
	starting_atom= /obj/item/organ/ears/elf
	output = /obj/item/clothing/neck/elfears

/datum/repeatable_crafting_recipe/crafting/earnecklace/elfw
	hides_from_books = TRUE
	name = "elf ear necklace"
	requirements = list(
		/obj/item/organ/ears/elfw = 4,
		/obj/item/rope = 1,
	)
	starting_atom= /obj/item/organ/ears/elfw
	output = /obj/item/clothing/neck/elfears

/datum/repeatable_crafting_recipe/crafting/wickercloak
	name = "wicker cloak"
	requirements = list(
		/obj/item/natural/dirtclod = 2,
		/obj/item/grown/log/tree/stick= 4,
		/obj/item/natural/fibers = 3,
	)
	attacked_atom = /obj/item/natural/dirtclod
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/clothing/cloak/wickercloak
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/bog_cowl
	name = "bog cowl"
	requirements = list(
		/obj/item/natural/dirtclod= 1,
		/obj/item/grown/log/tree/stick= 3,
		/obj/item/natural/fibers = 2,
	)
	attacked_atom = /obj/item/natural/dirtclod
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/clothing/neck/bogcowl
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/skull_mask
	name = "skull mask"
	requirements = list(
		/obj/item/alch/bone= 3,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/natural/fibers
	starting_atom= /obj/item/alch/bone
	output = /obj/item/clothing/face/skullmask
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/antlerhood
	name = "antler hood"
	requirements = list(
		/obj/item/alch/bone= 2,
		/obj/item/natural/hide = 1,
	)
	attacked_atom = /obj/item/natural/hide
	starting_atom= /obj/item/alch/bone
	output = /obj/item/clothing/head/antlerhood
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/antlerhood/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/natural/hide)

/datum/repeatable_crafting_recipe/crafting/short_bow
	name = "short bow"
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 3,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom  = /obj/item/natural/fibers
	allow_inverse_start = FALSE
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/bow
	name = "wooden bow"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/natural/fibers = 5,
	)

	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/natural/wood/plank
	allow_inverse_start = FALSE
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/long_bow
	name = "long bow"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/natural/fibers = 7,
		/obj/item/reagent_containers/food/snacks/fat = 1,
	)
	attacked_atom = /obj/item/natural/wood/plank
	starting_atom  = /obj/item/natural/fibers
	allow_inverse_start = FALSE
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/wsword
	name = "wooden sword"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	starting_atom = /obj/item/grown/log/tree/stick
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/mace/woodclub/train_sword
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/wshield
	name = "wooden shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
	)

	starting_atom = /obj/item/natural/wood/plank
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/shield/wood/crafted
	allow_inverse_start = FALSE // so we can typecheck less

/obj/item/weapon/shield/wood/crafted
	sellprice = 6

/datum/repeatable_crafting_recipe/crafting/heatershield
	name = "heater shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/hide/cured = 1,
	)

	starting_atom = /obj/item/natural/hide/cured
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/shield/heater/crafted
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/drum
	name = "drum"
	starting_atom = /obj/item/natural/hide/cured
	attacked_atom = /obj/item/grown/log/tree/small
	requirements = list(
		/obj/item/natural/hide/cured = 1,
		/obj/item/grown/log/tree/small = 1,
	)
	output = /obj/item/instrument/drum

/datum/repeatable_crafting_recipe/crafting/dart
	name = "dart"
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/thorn = 1,
	)

	starting_atom = /obj/item/natural/thorn
	attacked_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/ammo_casing/caseless/dart
	craftdiff = 0
	output_amount = 3

/datum/repeatable_crafting_recipe/crafting/blowgun
	name = "blowgun"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/candle
	name = "candle"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/fat= 1,
		/obj/item/natural/fibers= 1,
	)
	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/reagent_containers/food/snacks/fat
	output = /obj/item/candle/yellow
	output_amount = 2

/datum/repeatable_crafting_recipe/crafting/imp_saw
	name = "improvised saw"
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/stone = 1,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/saw/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/imp_clamp
	name = "improvised clamp"
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/hemostat/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/imp_retractor
	name = "improvised retractor"
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/retractor/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/stone_mortar
	name = "stone mortar"
	requirements = list(
		/obj/item/natural/stone = 1,
	)

	starting_atom = /obj/item/weapon/knife
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/reagent_containers/glass/mortar
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/pestle
	name = "pestle"
	requirements = list(
		/obj/item/natural/stone = 1,
	)

	starting_atom = /obj/item/weapon/knife
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/pestle
	craftdiff = 0
	skillcraft = /datum/skill/craft/masonry
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/stone_tongs
	name = "stone tongs"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/grown/log/tree/stick = 2,
	)

	attacked_atom = /obj/item/natural/stone
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/tongs/stone
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/quarterstaff
	name = "wooden quarterstaff"
	requirements = list(
		/obj/item/grown/log/tree= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff
	required_intent = /datum/intent/dagger/cut
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/iron_quarterstaff
	name = "iron quarterstaff"
	requirements = list(
		/obj/item/weapon/polearm/woodstaff/quarterstaff = 1,
		/obj/item/ingot/iron = 1,
	)
	attacked_atom = /obj/item/weapon/polearm/woodstaff/quarterstaff
	starting_atom  = /obj/item/ingot/iron
	allow_inverse_start = FALSE
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff/iron
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/steel_quarterstaff
	name = "steel quarterstaff"
	requirements = list(
		/obj/item/weapon/polearm/woodstaff/quarterstaff = 1,
		/obj/item/ingot/steel = 1,
	)
	attacked_atom = /obj/item/weapon/polearm/woodstaff/quarterstaff
	starting_atom  = /obj/item/ingot/steel
	allow_inverse_start = FALSE
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff/steel
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/caningstick
	name = "caning stick"
	requirements = list(
		/obj/item/grown/log/tree/stick= 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE
	allow_inverse_start = FALSE
	output = /obj/item/weapon/whip/cane
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/spoon
	name = "wooden spoon"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/kitchen/spoon
	craft_time = 3 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/fork
	name = "wooden fork"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/kitchen/fork
	craft_time = 3 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/rollingpin
	name = "wooden rollingpin"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/kitchen/rollingpin
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodbowl
	name = "wooden bowl"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/reagent_containers/glass/bowl
	output_amount = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/woodcup
	name = "wooden cup"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/reagent_containers/glass/cup/wooden/crafted
	output_amount = 3
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodtray
	name = "wooden tray"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/plate/tray
	output_amount = 2
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodplatter
	name = "wooden platter"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/plate
	output_amount = 2
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodspade
	name = "wooden spade"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/shovel/small
	craft_time = 2 SECONDS

/datum/repeatable_crafting_recipe/crafting/pipe
	name = "wooden pipe"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/clothing/face/cigarette/pipe/crafted
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/broom
	name = "broom"
	requirements = list(
		/obj/item/grown/log/tree/stick= 4,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/broom

/datum/repeatable_crafting_recipe/crafting/wpsycross
	name = "wooden psycross"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/clothing/neck/psycross
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/bottle_kit
	name = "bottle kit"
	requirements = list(
		/obj/item/reagent_containers/glass/bottle = 2,
		/obj/item/paper = 2,
	)
	attacked_atom = /obj/item/paper
	starting_atom = /obj/item/reagent_containers/glass/bottle
	allow_inverse_start = FALSE
	output = /obj/item/bottle_kit
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/bottle_kit/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/paper)

/datum/repeatable_crafting_recipe/crafting/woodflail
	name = "wooden flail"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/rope/chain = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/flail/towner
	output_amount = 2
	craftdiff = 2
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/militia_flail
	name = "militia flail"
	requirements = list(
		/obj/item/weapon/flail/towner= 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/weapon/flail/towner
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/flail/militia
	craftdiff = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/woodthresher
	name = "wooden thresher"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/rope = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/thresher
	craftdiff = 1
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/woodthresher/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/datum/repeatable_crafting_recipe/crafting/bigflail
	name = "great militia flail"
	requirements = list(
		/obj/item/weapon/thresher= 1,
		/obj/item/rope/chain = 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom =/obj/item/weapon/thresher
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/thresher/military
	craftdiff = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/ironcudgel
	name = "peasant cudgel"
	requirements = list(
		/obj/item/weapon/mace/woodclub = 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/weapon/mace/woodclub
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/mace/cudgel/carpenter
	subtypes_allowed = TRUE
	craftdiff = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/scroll
	name = "parchment scroll"
	requirements = list(
		/obj/item/paper = 2,
		/obj/item/natural/fibers = 1,
	)
	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/paper
	output = /obj/item/paper/scroll
	subtypes_allowed = TRUE
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/scroll/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/paper)

/datum/repeatable_crafting_recipe/crafting/cart_upgrade
	name = "cart upgrade"
	requirements = list(
		/obj/item/natural/wood/plank= 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/natural/wood/plank
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE
	allow_inverse_start = FALSE
	output = /obj/item/gear/wood/basic
	craftdiff = 3
	skillcraft = /datum/skill/craft/carpentry

/datum/repeatable_crafting_recipe/crafting/wheatlbait
	name = "bait (wheat)"
	output = /obj/item/bait
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/grain/wheat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/grain/wheat
	attacked_atom = /obj/item/natural/cloth

/datum/repeatable_crafting_recipe/crafting/oatbait
	name = "bait (oat)"
	output = /obj/item/bait
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/grain/oat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/grain/oat
	attacked_atom = /obj/item/natural/cloth

/datum/repeatable_crafting_recipe/crafting/sweetbait
	name = "sweet bait (apple)"
	output = /obj/item/bait/sweet
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fruit/apple = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/apple
	attacked_atom = /obj/item/natural/cloth

/datum/repeatable_crafting_recipe/crafting/berrybait
	name = "sweet bait (berry)"
	output = /obj/item/bait/sweet
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry
	attacked_atom = /obj/item/natural/cloth
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/bloodbait
	name = "blood bait"
	output = /obj/item/bait/bloody
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/meat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/meat
	attacked_atom = /obj/item/natural/cloth
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/alchemical_vial
	name = "Alchemical Vial"
	output = /obj/item/reagent_containers/glass/alchemical
	requirements = list(
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife
	output_amount = 3
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/alchemical_bottle
	name = "Alchemical Bottle"
	output = /obj/item/reagent_containers/glass/bottle
	requirements = list(
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife
	output_amount = 1
	craftdiff = 3

// -------------------------- Gems ------------------------------ //

// jade //

/datum/repeatable_crafting_recipe/crafting/cutjade
	name = "cut joapstone gem"
	output = /obj/item/carvedgem/jade/cutgem
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/jadefork
	name = "joapstone fork"
	output = /obj/item/carvedgem/jade/fork
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/jadespoon
	name = "joapstone spoon"
	output = /obj/item/carvedgem/jade/spoon
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/jadecameo
	name = "joapstone cameo"
	output = /obj/item/carvedgem/jade/cameo
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/jadebowl
	name = "joapstone bowl"
	output = /obj/item/reagent_containers/glass/bowl/jade
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/jadecup
	name = "joapstone cup"
	output = /obj/item/reagent_containers/glass/cup/jade
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/jadeplatter
	name = "joapstone platter"
	output = /obj/item/plate/jade
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadering
	name = "joapstone ring"
	output = /obj/item/clothing/ring/jade
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadeamulet
	name = "joapstone amulet"
	output = /obj/item/clothing/neck/jadeamulet
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadevase
	name = "joapstone vase"
	output = /obj/item/carvedgem/jade/vase
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadefigurine
	name = "joapstone figurine"
	output = /obj/item/carvedgem/jade/figurine
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadefish
	name = "joapstone fish figurine"
	output = /obj/item/carvedgem/jade/fish
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadetablet
	name = "joapstone tablet"
	output = /obj/item/carvedgem/jade/tablet
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadeteapot
	name = "joapstone teapot"
	output = /obj/item/reagent_containers/glass/carafe/teapotjade
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/jadebust
	name = "joapstone bust"
	output = /obj/item/carvedgem/jade/bust
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3
/datum/repeatable_crafting_recipe/crafting/fancyvase
	name = "fancy joapstone vase"
	output = /obj/item/carvedgem/jade/fancyvase
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/jadecomb
	name = "joapstone comb"
	output = /obj/item/carvedgem/jade/comb
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/jadeduck
	name = "joapstone duck"
	output = /obj/item/carvedgem/jade/duck
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/jadebracelet
	name = "joapstone bracelets"
	output = /obj/item/clothing/wrists/gem/jadebracelet
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/jadecirclet
	name = "joapstone circlet"
	output = /obj/item/clothing/head/crown/circlet/jade
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/jadefancycup
	name = "fancy joapstone cup"
	output = /obj/item/reagent_containers/glass/cup/jadefancy
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/jademask
	name = "joapstone mask"
	output = /obj/item/clothing/face/jademask
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/jadeurn
	name = "joapstone urn"
	output = /obj/item/carvedgem/jade/urn
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4
/datum/repeatable_crafting_recipe/crafting/jadestatue
	name = "joapstone statue"
	output = /obj/item/carvedgem/jade/statue
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/jadeobelisk
	name = "joapstone obelisk"
	output = /obj/item/carvedgem/jade/obelisk
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/jadewyrm
	name = "joapstone wyrm"
	output = /obj/item/carvedgem/jade/wyrm
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5


/datum/repeatable_crafting_recipe/crafting/jadekukri
	name = "joapstone kukri"
	output = /obj/item/weapon/knife/stone/kukri
	requirements = list(
		/obj/item/gem/jade = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out the raw joapstone", "start to carve the raw joapstone")
	)
	attacked_atom = /obj/item/gem/jade
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

// shell //

/datum/repeatable_crafting_recipe/crafting/openclam
	name = "opened clam"
	output = list (
		/obj/item/carvedgem/shell/openoyster,
		/obj.item/carvedgem/rose/rawrose
	)

	requirements = list(
		/obj/item/gem/oyster = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to pry open the clam shell", "pry open the clam shell")
	)
	attacked_atom = /obj/item/gem/oyster
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/rawshell

	name = "2x clam shells "
	output = /obj/item/carvedgem/shell/rawshell
	requirements = list(
		/obj/item/carvedgem/shell/openoyster = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to pull apart the clam shell", "pull apart the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/openoyster
	starting_atom = /obj/item/weapon/knife
	output_amount = 2
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/cutshell

	name = "polished clam shell"
	output = /obj/item/carvedgem/shell/cutgem
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to polish the clam shell", "start to polish the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/shellfork

	name = "shell fork"
	output = /obj/item/carvedgem/shell/fork
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/shellspoon

	name = "shell spoon"
	output = /obj/item/carvedgem/shell/spoon
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/shellcameo

	name = "shell cameo"
	output = /obj/item/carvedgem/shell/cameo
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/shellbowl

	name = "shell bowl"
	output = /obj/item/reagent_containers/glass/bowl/shell
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/shellcup

	name = "shell cup"
	output = /obj/item/reagent_containers/glass/cup/shell
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/shellplatter

	name = "shell platter"
	output = /obj/item/plate/shell
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/shellring

	name = "shell ring"
	output = /obj/item/clothing/ring/shell
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/shellteapot

	name = "shell teapot"
	output = /obj/item/reagent_containers/glass/carafe/teapotshell
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/shellamulet

	name = "shell amulet"
	output = /obj/item/clothing/neck/shellamulet
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/shellfigurine

	name = "shell figurine"
	output = /obj/item/carvedgem/shell/figurine
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1

/datum/repeatable_crafting_recipe/crafting/shelltablet

	name = "shell tablet"
	output = /obj/item/carvedgem/shell/tablet
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/shellfish

	name = "shell fish figurine"
	output = /obj/item/carvedgem/shell/fish
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/shellvase

	name = "shell vases"
	output = /obj/item/carvedgem/shell/vase
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/shellbust

	name = "shell bust"
	output = /obj/item/carvedgem/shell/bust
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/shellcirclet

	name = "shell circlet"
	output = /obj/item/clothing/head/crown/circlet/shell
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/shellbracelet

	name = "shell bracelets"
	output = /obj/item/clothing/wrists/gem/shellbracelet
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/shellfancycup

	name = "fancy shell cup"
	output = /obj/item/reagent_containers/glass/cup/shellfancy
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/shellfancyvase

	name = "fancy shell vase"
	output = /obj/item/carvedgem/shell/fancyvase
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/shellcomb

	name = "shell comb"
	output = /obj/item/carvedgem/shell/comb
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/shellduck

	name = "shell duck"
	output = /obj/item/carvedgem/shell/duck
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/shellmask

	name = "shell mask"
	output = /obj/item/clothing/face/shellmask
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/shellurn

	name = "shell urn"
	output = /obj/item/carvedgem/shell/urn
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/shellstatue

	name = "shell statue"
	output = /obj/item/carvedgem/shell/statue
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/shellobelisk

	name = "shell obelisk"
	output = /obj/item/carvedgem/shell/obelisk
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/shellturtle

	name = "turtle carving"
	output = /obj/item/carvedgem/shell/turtle
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

/datum/repeatable_crafting_recipe/crafting/shellrungu

	name = "shell rungu"
	output = /obj/item/weapon/mace/cudgel/shellrungu
	requirements = list(
		/obj/item/carvedgem/shell/rawshell = 1
	)
	tool_usage = list(		/obj/item/weapon/knife = list("starts to carve the clam shell", "start to carve the clam shell")
	)
	attacked_atom = /obj/item/carvedgem/shell/rawshell
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

// rose //

/datum/repeatable_crafting_recipe/crafting/cutrose
	name = "rosellusk pearl"
	output = /obj/item/carvedgem/rose/cutgem
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("refines the rosellusk pearl", "refine the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/rosespoon
	name = "rosellusk spoon"
	output = /obj/item/carvedgem/rose/spoon
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/rosefork
	name = "rosellusk fork"
	output = /obj/item/carvedgem/rose/fork
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/rosecup
	name = "rosellusk cup"
	output = /obj/item/reagent_containers/glass/cup/rose
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/rosebowl
	name = "rosellusk bowl"
	output = /obj/item/reagent_containers/glass/bowl/rose
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/rosecameo
	name = "rosellusk cameo"
	output = /obj/item/carvedgem/rose/cameo
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/rosefigurine
	name = "rosellusk figurine"
	output = /obj/item/carvedgem/rose/figurine
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/rosefish
	name = "rosellusk fish figurine"
	output = /obj/item/carvedgem/rose/fish
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/rosevase
	name = "rosellusk vase"
	output = /obj/item/carvedgem/rose/vase
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/rosetablet
	name = "rosellusk tablet"
	output = /obj/item/carvedgem/rose/tablet
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/roseteapot
	name = "rosellusk teapot"
	output = /obj/item/reagent_containers/glass/carafe/teapotrose
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/rosering
	name = "rosellusk ring"
	output = /obj/item/clothing/ring/rose
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/roseamulet
	name = "rosellusk amuelt"
	output = /obj/item/clothing/neck/roseamulet
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/roseplatter
	name = "rosellusk platter"
	output = /obj/item/plate/rose
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/rosebust
	name = "rosellusk bust"
	output = /obj/item/carvedgem/rose/bust
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/rosefancyvase
	name = "fancy rosellusk vase"
	output = /obj/item/carvedgem/rose/fancyvase
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/rosecomb
	name = "rosellusk comb"
	output = /obj/item/carvedgem/rose/comb
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/roseduck
	name = "rosellusk duck"
	output = /obj/item/carvedgem/rose/duck
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/rosebracelet
	name = "rosellusk bracelets"
	output = /obj/item/clothing/wrists/gem/rosebracelet
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/rosecirclet
	name = "rosellusk circlet"
	output = /obj/item/clothing/head/crown/circlet/rose
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/rosefancycup
	name = "fancy rosellusk cup"
	output = /obj/item/reagent_containers/glass/cup/rosefancy
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/roseurn
	name = "rosellusk urn"
	output = /obj/item/carvedgem/rose/urn
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/rosestatue
	name = "rosellusk statue"
	output = /obj/item/carvedgem/rose/statue
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/roseobelisk
	name = "rosellusk obelisk"
	output = /obj/item/carvedgem/rose/obelisk
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/rosemask
	name = "rosellusk mask"
	output = /obj/item/clothing/face/rosemask
	requirements = list(
		/obj/item/carvedgem/rose/rawrose
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/roseflower
	name = "rosellusk flower carving"
	output = /obj/item/carvedgem/rose/flower
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

/datum/repeatable_crafting_recipe/crafting/rosecarp
	name = "rosellusk carp statue"
	output = /obj/item/carvedgem/rose/carp
	requirements = list(
		/obj/item/carvedgem/rose/rawrose = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the rosellusk pearl", "carve the rosellusk pearl")
	)
	attacked_atom = /obj/item/carvedgem/rose/rawrose
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

// onyxa //

/datum/repeatable_crafting_recipe/crafting/cutonyxa
	name = "cut onyxa gem"
	output = /obj/item/carvedgem/onyxa/cutgem
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/onyxafork
	name = "onyxa fork"
	output = /obj/item/carvedgem/onyxa/fork
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/onyxaspoon
	name = "onyxa spoon"
	output = /obj/item/carvedgem/onyxa/spoon
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/onyxacameo
	name = "onyxa cameo"
	output = /obj/item/carvedgem/onyxa/cameo
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/onyxacup
	name = "onyxa cup"
	output = /obj/item/reagent_containers/glass/cup/opal
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/onyxabowl
	name = "onyxa bowl"
	output = /obj/item/reagent_containers/glass/bowl/onyxa
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1


/datum/repeatable_crafting_recipe/crafting/onyxafigurine
	name = "onyxa figurine"
	output = /obj/item/carvedgem/onyxa/figurine
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2


/datum/repeatable_crafting_recipe/crafting/onyxafish
	name = "onyxa fish figurine"
	output = /obj/item/carvedgem/onyxa/fish
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/onyxavase
	name = "onyxa vase"
	output = /obj/item/carvedgem/onyxa/vase
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/onyxatablet
	name = "onyxa tablet"
	output = /obj/item/carvedgem/onyxa/tablet
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/onyxateapot
	name = "onyxa teapot"
	output = /obj/item/reagent_containers/glass/carafe/teapotonyxa
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/onyxaring
	name = "onyxa ring"
	output = /obj/item/clothing/ring/onyxa
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/onyxaamulet
	name = "onyxa amulet"
	output = /obj/item/clothing/neck/onyxaamulet
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/onyxaplatter
	name = "onyxa platter"
	output = /obj/item/plate/onyxa
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/onyxabust
	name = "onyxa bust"
	output = /obj/item/carvedgem/onyxa/bust
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/onyxafancyvase
	name = "fancy onyxa vase"
	output = /obj/item/carvedgem/onyxa/fancyvase
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/onyxacomb
	name = "onyxa comb"
	output = /obj/item/carvedgem/onyxa/comb
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/onyxaduck
	name = "onyxa duck"
	output = /obj/item/carvedgem/onyxa/duck
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/onyxafancycup
	name = "fancy onyxa cup"
	output = /obj/item/reagent_containers/glass/cup/onyxafancy
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/onyxabracelet
	name = "onyxa bracelets"
	output = /obj/item/clothing/wrists/gem/onyxabracelet
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/onyxacirclet
	name = "onyxa circlet"
	output = /obj/item/clothing/head/crown/circlet/onyxa
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/onyxamask
	name = "onyxa mask"
	output = /obj/item/clothing/face/onyxamask
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/onyxaurn
	name = "onyxa urn"
	output = /obj/item/carvedgem/onyxa/urn
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/onyxastatue
	name = "onyxa statue"
	output = /obj/item/carvedgem/onyxa/statue
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/onyxaobelisk
	name = "onyxa obelisk"
	output = /obj/item/carvedgem/onyxa/obelisk
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/onyxaurn
	name = "onyxa urn"
	output = /obj/item/carvedgem/onyxa/urn
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/onyxaspider
	name = "onyxa spider statue"
	output = /obj/item/carvedgem/onyxa/spider
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

/datum/repeatable_crafting_recipe/crafting/onyxasnake
	name = "onyxa snake statue"
	output = /obj/item/carvedgem/onyxa/snake
	requirements = list(
		/obj/item/gem/onyxa = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw onyxa", "carve the raw onyxa")
	)
	attacked_atom = /obj/item/gem/onyxa
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

// ceruleabaster //

/datum/repeatable_crafting_recipe/crafting/cutturq
	name = "cut ceruleabaster gem"
	output = /obj/item/carvedgem/turq/cutgem
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/turqfork
	name = "ceruleabaster fork"
	output = /obj/item/carvedgem/turq/fork
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/turqspoon
	name = "ceruleabaster spoon"
	output = /obj/item/carvedgem/turq/spoon
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/turqcameo
	name = "ceruleabaster cameo"
	output = /obj/item/carvedgem/turq/cameo
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/turqbowl
	name = "ceruleabaster bowl"
	output = /obj/item/reagent_containers/glass/bowl/turq
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/turqcup
	name = "ceruleabaster cup"
	output = /obj/item/reagent_containers/glass/cup/turq
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/turqfigurine
	name = "ceruleabaster figurine"
	output = /obj/item/carvedgem/turq/figurine
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/turqfish
	name = "ceruleabaster fish figurine"
	output = /obj/item/carvedgem/turq/fish
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/turqvase
	name = "ceruleabaster vase"
	output = /obj/item/carvedgem/turq/vase
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/turqamulet
	name = "ceruleabaster amulet"
	output = /obj/item/clothing/neck/turqamulet
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/turqtablet
	name = "ceruleabaster tablet"
	output = /obj/item/carvedgem/turq/tablet
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/turqring
	name = "ceruleabaster ring"
	output = /obj/item/clothing/ring/turq
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/turqplatter
	name = "ceruleabaster platter"
	output = /obj/item/plate/turq
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/turqbracelet
	name = "ceruleabaster bracelets"
	output = /obj/item/clothing/wrists/gem/turqbracelet
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/turqcirclet
	name = "ceruleabaster circlet"
	output = /obj/item/clothing/head/crown/circlet/turq
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/turqfancycup
	name = "fancy ceruleabaster cup"
	output = /obj/item/reagent_containers/glass/cup/turqfancy
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/turqfancyvase
	name = "fancy ceruleabaster vase"
	output = /obj/item/carvedgem/turq/fancyvase
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/turqbust
	name = "ceruleabaster bust"
	output = /obj/item/carvedgem/turq/bust
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/turqcomb
	name = "ceruleabaster comb"
	output = /obj/item/carvedgem/turq/comb
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/turqduck
	name = "ceruleabaster duck"
	output = /obj/item/carvedgem/turq/duck
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/turqurn
	name = "ceruleabaster urn"
	output = /obj/item/carvedgem/turq/urn
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/turqstatue
	name = "ceruleabaster statue"
	output = /obj/item/carvedgem/turq/statue
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/turqobelisk
	name = "ceruleabaster obelisk"
	output = /obj/item/carvedgem/turq/obelisk
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/turqmask
	name = "ceruleabaster urn"
	output = /obj/item/clothing/face/turqmask
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/turqka
	name = "ceruleabaster ka statue"
	output = /obj/item/carvedgem/turq/ka
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

/datum/repeatable_crafting_recipe/crafting/turqscarab
	name = "ceruleabaster scarab"
	output = /obj/item/carvedgem/turq/scarab
	requirements = list(
		/obj/item/gem/turq = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw ceruleabaster", "carve the raw ceruleabaster")
	)
	attacked_atom = /obj/item/gem/turq
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

// aoetal //

/datum/repeatable_crafting_recipe/crafting/cutcoral
	name = "cut aoetal gem"
	output = /obj/item/carvedgem/coral/cutgem
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/coralfork
	name = "aoetal fork"
	output = /obj/item/carvedgem/coral/fork
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/coralspoon
	name = "aoetal spoon"
	output = /obj/item/carvedgem/coral/spoon
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/coralcameo
	name = "aoetal cameo"
	output = /obj/item/carvedgem/coral/cameo
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/coralcup
	name = "aoetal cup"
	output = /obj/item/reagent_containers/glass/cup/coral
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/coralbowl
	name = "aoetal bowl"
	output = /obj/item/reagent_containers/glass/bowl/coral
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/coralfigurine
	name = "aoetal figurine"
	output = /obj/item/carvedgem/coral/figurine
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coralfish
	name = "aoetal fish figurine"
	output = /obj/item/carvedgem/coral/fish
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coralvase
	name = "aoetal vase"
	output = /obj/item/carvedgem/coral/vase
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coraltablet
	name = "aoetal tablet"
	output = /obj/item/carvedgem/coral/tablet
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coralteapot
	name = "aoetal teapot"
	output = /obj/item/reagent_containers/glass/carafe/teapotcoral
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coralplatter
	name = "aoetal platter"
	output = /obj/item/plate/coral
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coralamulet
	name = "aoetal amulet"
	output = /obj/item/clothing/neck/coralamulet
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coralring
	name = "aoetal ring"
	output = /obj/item/clothing/ring/coral
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/coralbust
	name = "aoetal bust"
	output = /obj/item/carvedgem/coral/bust
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/coralfancyvase
	name = "fancy aoetal vase"
	output = /obj/item/carvedgem/coral/fancyvase
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/coralcomb
	name = "aoetal comb"
	output = /obj/item/carvedgem/coral/comb
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/coralduck
	name = "aoetal duck"
	output = /obj/item/carvedgem/coral/duck
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/coralfancycup
	name = "fancy aoetal cup"
	output = /obj/item/reagent_containers/glass/cup/coralfancy
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/coralcirclet
	name = "aoetal circlet"
	output = /obj/item/clothing/head/crown/circlet/coral
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/coralbracelet
	name = "aoetal bracelets"
	output = /obj/item/clothing/wrists/gem/coralbracelet
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/coralmask
	name = "aoetal mask"
	output = /obj/item/clothing/face/coralmask
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/coralstatue
	name = "aoetal statue"
	output = /obj/item/carvedgem/coral/statue
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/coralstatue
	name = "aoetal statue"
	output = /obj/item/carvedgem/coral/statue
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/coralurn
	name = "aoetal urn"
	output = /obj/item/carvedgem/coral/urn
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/coralobelisk
	name = "aoetal obelisk"
	output = /obj/item/carvedgem/coral/obelisk
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/coraljaw
	name = "shark jaw statue"
	output = /obj/item/carvedgem/coral/jaw
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

/datum/repeatable_crafting_recipe/crafting/coralshark
	name = "aoetal shark statue"
	output = /obj/item/carvedgem/coral/shark
	requirements = list(
		/obj/item/gem/coral = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw aoetal", "carve the raw aoetal")
	)
	attacked_atom = /obj/item/gem/coral
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

// petriamber //

/datum/repeatable_crafting_recipe/crafting/ambercutgem
	name = "cut petriamber gem"
	output = /obj/item/carvedgem/amber/cutgem
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/amberspoon
	name = "petriamber spoon"
	output = /obj/item/carvedgem/amber/spoon
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/amberfork
	name = "petriamber fork"
	output = /obj/item/carvedgem/amber/fork
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/ambercameo
	name = "petriamber cameo"
	output = /obj/item/carvedgem/amber/cameo
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/amberbowl
	name = "petriamber bowl"
	output = /obj/item/reagent_containers/glass/bowl/amber
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/ambercup
	name = "petriamber cup"
	output = /obj/item/reagent_containers/glass/cup/amber
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/amberfigurine
	name = "petriamber figurine"
	output = /obj/item/carvedgem/amber/figurine
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/amberfish
	name = "petriamber fish figurine"
	output = /obj/item/carvedgem/amber/fish
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/ambertablet
	name = "petriamber tablet"
	output = /obj/item/carvedgem/amber/tablet
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/ambervase
	name = "petriamber vase"
	output = /obj/item/carvedgem/amber/vase
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/amberteapot
	name = "petriamber teapot"
	output = /obj/item/reagent_containers/glass/carafe/teapotamber
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/amberplatter
	name = "petriamber platter"
	output = /obj/item/plate/amber
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/amberring
	name = "petriamber ring"
	output = /obj/item/clothing/ring/amber
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/amberamulet
	name = "petriamber amulet"
	output = /obj/item/clothing/neck/amberamulet
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/amberbracelet
	name = "petriamber bracelets"
	output = /obj/item/clothing/wrists/gem/amberbracelet
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/ambercirclet
	name = "petriamber circlet"
	output = /obj/item/clothing/head/crown/circlet/amber
	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/amberfancycup
	name = "fancy petriamber cup"
	output = /obj/item/reagent_containers/glass/cup/amberfancy

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/amberfancyvase
	name = "fancy petriamber vase"
	output = /obj/item/carvedgem/amber/fancyvase

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/amberbust
	name = "petriamber bust"
	output = /obj/item/carvedgem/amber/bust

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/ambercomb
	name = "petriamber comb"
	output = /obj/item/carvedgem/amber/comb

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/amberduck
	name = "petriamber duck"
	output = /obj/item/carvedgem/amber/duck

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/ambermask
	name = "petriamber mask"
	output = /obj/item/clothing/face/ambermask

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/amberobelisk
	name = "petriamber obelisk"
	output = /obj/item/carvedgem/amber/obelisk

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/amberurn
	name = "petriamber urn"
	output = /obj/item/carvedgem/amber/urn

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/amberstatue
	name = "petriamber statue"
	output = /obj/item/carvedgem/amber/statue

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/amberbeaver
	name = "petriamber beaver statue"
	output = /obj/item/carvedgem/amber/beaver

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

/datum/repeatable_crafting_recipe/crafting/ambersun
	name = "petriamber sun carving"
	output = /obj/item/carvedgem/amber/sun

	requirements = list(
		/obj/item/gem/amber = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw petriamber", "carve the raw petriamber")
	)
	attacked_atom = /obj/item/gem/amber
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

// opaloise //

/datum/repeatable_crafting_recipe/crafting/opalcutgem
	name = "cut opaloise gem"
	output = /obj/item/carvedgem/opal/cutgem

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/opalspoon
	name = "opaloise spoon"
	output = /obj/item/carvedgem/opal/spoon

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/opalfork
	name = "opaloise fork"
	output = /obj/item/carvedgem/opal/fork

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/opalcameo
	name = "opaloise cameo"
	output = /obj/item/carvedgem/opal/cameo

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/opalbowl
	name = "opaloise bowl"
	output = /obj/item/reagent_containers/glass/bowl/opal

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/opalcup
	name = "opaloise cup"
	output = /obj/item/reagent_containers/glass/cup/opal

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/opalteapot
	name = "opaloise teapot"
	output = /obj/item/reagent_containers/glass/carafe/teapotopal

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opalplatter
	name = "opaloise platter"
	output = /obj/item/plate/opal

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opalring
	name = "opaloise ring"
	output = /obj/item/clothing/ring/opal

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opalamulet
	name = "opaloise amulet"
	output = /obj/item/clothing/neck/opalamulet

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opalfigurine
	name = "opaloise figurine"
	output = /obj/item/carvedgem/opal/figurine

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opalfish
	name = "opaloise fish figurine"
	output = /obj/item/carvedgem/opal/fish

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opalvase
	name = "opaloise vase"
	output = /obj/item/carvedgem/opal/vase

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opaltablet
	name = "opaloise tablet"
	output = /obj/item/carvedgem/opal/tablet

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/opalbracelet
	name = "opaloise bracelets"
	output = /obj/item/clothing/wrists/gem/opalbracelet

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/opalcirclet
	name = "opaloise circlet"
	output = /obj/item/clothing/head/crown/circlet/opal

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/opalfancycup
	name = "fancy opaloise cup"
	output = /obj/item/reagent_containers/glass/cup/opalfancy

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/opalbust
	name = "opaloise bust"
	output = /obj/item/carvedgem/opal/bust

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/opalfancyvase
	name = "fancy opaloise vase"
	output = /obj/item/carvedgem/opal/fancyvase

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/opalcomb
	name = "opaloise comb"
	output = /obj/item/carvedgem/opal/comb

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/opalduck
	name = "opaloise duck"
	output = /obj/item/carvedgem/opal/duck

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/opalmask
	name = "opaloise mask"
	output = /obj/item/clothing/face/opalmask

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/opalobelisk
	name = "opaloise obelisk"
	output = /obj/item/carvedgem/opal/obelisk

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/opalurn
	name = "opaloise urn"
	output = /obj/item/carvedgem/opal/urn

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/opalstatue
	name = "opaloise statue"
	output = /obj/item/carvedgem/opal/statue

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 4

/datum/repeatable_crafting_recipe/crafting/opalcrab
	name = "opaloise crab sculpture"
	output = /obj/item/carvedgem/opal/crab

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5

/datum/repeatable_crafting_recipe/crafting/opalknife
	name = "opaloise knife"
	output = /obj/item/weapon/knife/stone/opal

	requirements = list(
		/obj/item/gem/opal = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("carves the raw opaloise", "carve the raw opaloise")
	)
	attacked_atom = /obj/item/gem/opal
	starting_atom = /obj/item/weapon/knife
	output_amount = 1
	craftdiff = 5
