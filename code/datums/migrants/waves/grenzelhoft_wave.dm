/datum/migrant_role/grenzelhoft/count
	name = "Grenzelhoft Count"
	description = "A Count hailing from the Grenzelhoft Imperiate, here on an official visit to the Peninsula of Vanderlin alongside his beloved convoy and spouse."
	migrant_job = /datum/job/grenzelhoft_count

/datum/job/grenzelhoft_count
	title = "Grenzelhoft Count"
	tutorial = "A Count hailing from the Grenzelhoft Imperiate, here on an official visit to the Peninsula of Vanderlin alongside his beloved convoy and spouse."
	outfit = /datum/outfit/job/grenzelhoft_count
	allowed_sexes = list(MALE)
	allowed_races = RACES_PLAYER_GRENZ
	is_recognized = TRUE

	jobstats = list(
		STATKEY_INT = 1,
		STATKEY_END = 2,
	)

	skills = list(
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 3,
		/datum/skill/misc/riding = 3,
		/datum/skill/misc/reading = 4,
		/datum/skill/misc/music = 1,
		/datum/skill/craft/cooking = 2,
		/datum/skill/combat/bows = 1,
		/datum/skill/combat/crossbows = 2,
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/swords = 3,
		/datum/skill/combat/knives = 2,
		/datum/skill/labor/mathematics = 3,
	)

	traits = list(TRAIT_HEAVYARMOR, TRAIT_MEDIUMARMOR, TRAIT_NOBLE)
	languages = list(/datum/language/oldpsydonic)
	cmode_music = 'sound/music/cmode/combat_grenzelhoft.ogg'

/datum/outfit/job/grenzelhoft_count
	shoes = /obj/item/clothing/shoes/rare/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	wrists = /obj/item/clothing/neck/psycross/g
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/armor/brigandine
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/weapon/sword/sabre/dec
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/gold
	shirt = /obj/item/clothing/shirt/grenzelhoft
	pants = /obj/item/clothing/pants/grenzelpants
	neck = /obj/item/clothing/neck/gorget
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich)

/datum/outfit/job/grenzelhoft_count/pre_equip(mob/living/carbon/human/equipped_human, visuals_only)
	. = ..()

	if(visuals_only)
		return

	var/prev_real_name = equipped_human.real_name
	var/prev_name = equipped_human.name
	var/honorary = "Count"
	equipped_human.real_name = "[honorary] [prev_real_name]"
	equipped_human.name = "[honorary] [prev_name]"

	if(!equipped_human.dna?.species)
		return
	var/datum/species/species = equipped_human.dna.species
	species.native_language = "Old Psydonic"
	species.accent_language = species.get_accent(species.native_language)

/datum/migrant_role/grenzelhoft/countess
	name = "Grenzelhoft Countess"
	description = "A Countess hailing from the Grenzelhoft Imperiate, here on an official visit to the Isle of the Enigma alongside her beloved convoy and husband."
	migrant_job = /datum/job/grenzelhoft_countess

/datum/job/grenzelhoft_countess
	title = "Grenzelhoft Countess"
	tutorial = "A Countess hailing from the Grenzelhoft Imperiate, here on an official visit to the Isle of the Enigma alongside her beloved convoy and husband."
	outfit = /datum/outfit/job/grenzelhoft_countess
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_PLAYER_GRENZ
	is_recognized = TRUE

	jobstats = list(
		STATKEY_INT = 1,
		STATKEY_END = 2,
	)

	skills = list(
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 3,
		/datum/skill/misc/riding = 3,
		/datum/skill/misc/reading = 4,
		/datum/skill/misc/music = 1,
		/datum/skill/craft/cooking = 2,
		/datum/skill/combat/bows = 1,
		/datum/skill/combat/crossbows = 2,
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/swords = 3,
		/datum/skill/combat/knives = 2,
	)

	traits = list(TRAIT_MEDIUMARMOR, TRAIT_NOBLE)
	languages = list(/datum/language/oldpsydonic)
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

/datum/outfit/job/grenzelhoft_countess
	shoes = /obj/item/clothing/shoes/rare/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	wrists = /obj/item/clothing/neck/psycross/g
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/armor/gambeson/heavy/dress/alt
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/weapon/sword/rapier/dec
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/gold
	shirt = /obj/item/clothing/shirt/grenzelhoft
	pants = /obj/item/clothing/pants/grenzelpants
	neck = /obj/item/clothing/neck/gorget
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich)

/datum/outfit/job/grenzelhoft_countess/pre_equip(mob/living/carbon/human/equipped_human, visuals_only)
	. = ..()

	if(visuals_only)
		return

	var/prev_real_name = equipped_human.real_name
	var/prev_name = equipped_human.name
	var/honorary = "Countess"
	equipped_human.real_name = "[honorary] [prev_real_name]"
	equipped_human.name = "[honorary] [prev_name]"

	if(!equipped_human.dna?.species)
		return
	var/datum/species/species = equipped_human.dna.species
	species.native_language = "Old Psydonic"
	species.accent_language = species.get_accent(species.native_language)

/datum/migrant_role/grenzelhoft/grenzelhoft_knight
	name = "Grenzelhoft Knight"
	description = "Your liege, the count and the countess have both took the duty gaved by the Kaiser itself to voyage to the Isle of Enigma, ensure their survival and obey their orders."
	migrant_job = /datum/job/grenzelhoft_migration/grenzelhoft_knight

/datum/job/grenzelhoft_migration/grenzelhoft_knight
	title = "Grenzelhoft Knight"
	tutorial = "Your liege, the count and the countess have both took the duty gaved by the Kaiser itself to voyage to the Isle of Enigma, ensure their survival and obey their orders."
	outfit = /datum/outfit/job/grenzelhoft_migration/grenzelhoft_knight
	allowed_sexes = list(MALE)
	allowed_races = RACES_PLAYER_GRENZ
	is_recognized = TRUE

	jobstats = list(
		STATKEY_STR = 2,
		STATKEY_END = 2,
		STATKEY_CON = 2,
		STATKEY_SPD = -1,
	)

	skills = list(
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 3,
		/datum/skill/combat/swords = 4,
		/datum/skill/misc/climbing = 1,
		/datum/skill/misc/athletics = 3,
		/datum/skill/misc/reading = 2,
	)

	traits = list(TRAIT_HEAVYARMOR)
	languages = list(/datum/language/oldpsydonic)
	cmode_music = 'sound/music/cmode/combat_grenzelhoft.ogg'

/datum/outfit/job/grenzelhoft_migration/grenzelhoft_knight
	pants = /obj/item/clothing/pants/tights/colored/black
	backr = /obj/item/weapon/sword/long/greatsword/flamberge
	beltl = /obj/item/storage/belt/pouch/coins/mid
	shoes = /obj/item/clothing/shoes/boots/rare/grenzelplate
	gloves = /obj/item/clothing/gloves/rare/grenzelplate
	belt = /obj/item/storage/belt/leather
	shirt = /obj/item/clothing/armor/gambeson
	armor = /obj/item/clothing/armor/rare/grenzelplate
	backl = /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/head/rare/grenzelplate
	wrists = /obj/item/clothing/wrists/bracers
	neck = /obj/item/clothing/neck/chaincoif

/datum/outfit/job/grenzelhoft_migration/grenzelhoft_knight/pre_equip(mob/living/carbon/human/equipped_human, visuals_only)
	. = ..()

	if(visuals_only)
		return

	var/prev_real_name = equipped_human.real_name
	var/prev_name = equipped_human.name
	var/honorary = "Ritter"
	if(equipped_human.gender == FEMALE)
		honorary = "Ritterin"
	equipped_human.real_name = "[honorary] [prev_real_name]"
	equipped_human.name = "[honorary] [prev_name]"

	if(!equipped_human.dna?.species)
		return
	var/datum/species/species = equipped_human.dna.species
	species.native_language = "Old Psydonic"
	species.accent_language = species.get_accent(species.native_language)

/datum/migrant_role/grenzelhoft/grenzelhoft_men_at_arms
	name = "Grenzelhoft Men-at-Arms"
	description = "You and your fellows are men at arms from Grenzelhoft, except your local liege has been sent to the Isle of Enigma, obey the Ritter and make sure the nobles goes home."
	migrant_job = /datum/job/grenzelhoft_men_at_arms

/datum/job/grenzelhoft_men_at_arms
	title = "Grenzelhoft Men-at-Arms"
	tutorial = "You and your fellows are men at arms from Grenzelhoft, except your local liege has been sent to the Isle of Enigma, obey the Ritter and make sure the nobles goes home."
	outfit = /datum/outfit/job/grenzelhoft_men_at_arms
	allowed_races = RACES_PLAYER_GRENZ

	jobstats = list(
		STATKEY_STR = 2,
		STATKEY_END = 1,
		STATKEY_CON = 2,
	)

	skills = list(
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 3,
		/datum/skill/misc/sneaking = 3,
		/datum/skill/combat/wrestling = 3,
		/datum/skill/misc/athletics = 4,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/swords = 3,
		/datum/skill/misc/reading = 1,
		/datum/skill/craft/cooking = 1,
	)

	traits = list(TRAIT_MEDIUMARMOR)
	languages = list(/datum/language/oldpsydonic)
	cmode_music = 'sound/music/cmode/combat_grenzelhoft.ogg'

/datum/job/grenzelhoft_men_at_arms/adjust_values(mob/living/carbon/human/spawned)
	. = ..()
	skills += list(
		/datum/skill/combat/whipsflails = pick(1, 1, 2),
		/datum/skill/combat/axesmaces = pick(2, 3),
		/datum/skill/combat/shields = pick(0, 0, 1),
	)

/datum/outfit/job/grenzelhoft_men_at_arms
	beltr = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/clothing/neck/chaincoif
	pants = /obj/item/clothing/pants/grenzelpants
	shoes = /obj/item/clothing/shoes/rare/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/weapon/mace/cudgel
	shirt = /obj/item/clothing/shirt/grenzelhoft
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/armor/cuirass/grenzelhoft
	backl = /obj/item/storage/backpack/satchel
	backr = /obj/item/weapon/sword/long/greatsword/zwei

/datum/outfit/job/grenzelhoft_men_at_arms/pre_equip(mob/living/carbon/human/equipped_human, visuals_only)
	. = ..()

	if(equipped_human.gender == FEMALE)
		equipped_human.underwear = "Femleotard"
		equipped_human.underwear_color = CLOTHING_SOOT_BLACK
		equipped_human.update_body()

	if(visuals_only)
		return

	if(!equipped_human.dna?.species)
		return
	var/datum/species/species = equipped_human.dna.species
	species.native_language = "Old Psydonic"
	species.accent_language = species.get_accent(species.native_language)

/datum/migrant_wave/grenzelhoft_visit
	name = "The Grenzelhoft visit"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zalad_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	weight = 25
	downgrade_wave = /datum/migrant_wave/grenzelhoft_visit_down
	roles = list(
		/datum/migrant_role/grenzelhoft/count = 1,
		/datum/migrant_role/grenzelhoft/countess = 1,
		/datum/migrant_role/grenzelhoft/grenzelhoft_knight = 1,
		/datum/migrant_role/grenzelhoft/grenzelhoft_men_at_arms = 2)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a diplomatic envoy to engage into diplomacy within the Kingdom of Vanderlin."

/datum/migrant_wave/grenzelhoft_visit_down
	name = "The Grenzelhoft visit"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zalad_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/grenzelhoft/count = 1,
		/datum/migrant_role/grenzelhoft/countess = 1,
		/datum/migrant_role/grenzelhoft/grenzelhoft_knight = 1)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a diplomatic envoy to engage into diplomacy within the Kingdom of Vanderlin."
