/datum/job/advclass/disciple
	title = "Disciple"
	tutorial = "Some train their steel, others train their wits. You have honed your body itself into a weapon, anointing it with faithful markings to fortify your soul. You serve and train under the Ordo Benetarus, and one day you will be among Psydon’s most dauntless warriors."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/disciple
	category_tags = list(CTAG_INQUISITION)
	jobstats = list(
		STATKEY_STR = 3,
		STATKEY_END = 3,
		STATKEY_CON = 3,
		STATKEY_INT = -2,
		STATKEY_SPD = -1
	)
	skills = list(
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/magic/holy = SKILL_LEVEL_APPRENTICE,
	)

	traits = list(
		TRAIT_INQUISITION,
		TRAIT_SILVER_BLESSED,
		TRAIT_STEELHEARTED,
	)

/datum/job/advclass/disciple/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	GLOB.inquisition.add_member_to_school(spawned, "Benetarus", 0, "Disciple")

	if(!spawned.mind)
		return

	var/static/list/weapons = list(
		"Discipline - Unarmed" = null,
		"Katar" = /obj/item/weapon/katar/psydon,
		"Knuckledusters" = /obj/item/weapon/knuckles/psydon,
		"Quarterstaff" = /obj/item/weapon/polearm/woodstaff/quarterstaff,
	)
	var/weapon_choice = spawned.select_equippable(player_client, weapons, message = "TAKE UP PSYDON'S ARMS!")
	var/obj/item/clothing/gloves/gloves_to_wear = /obj/item/clothing/gloves/bandages/weighted
	switch(weapon_choice)
		if("Discipline - Unarmed")
			spawned.clamped_adjust_skillrank(/datum/skill/combat/unarmed, 5, 5)
			spawned.clamped_adjust_skillrank(/datum/skill/misc/athletics, 5, 5)
			gloves_to_wear = /obj/item/clothing/gloves/bandages/pugilist
			ADD_TRAIT(spawned, TRAIT_CRITICAL_RESISTANCE, JOB_TRAIT)
			ADD_TRAIT(spawned, TRAIT_IGNOREDAMAGESLOWDOWN, JOB_TRAIT)
		if("Katar")
			ADD_TRAIT(spawned, TRAIT_CRITICAL_RESISTANCE, JOB_TRAIT)
		if("Knuckledusters")
			ADD_TRAIT(spawned, TRAIT_CRITICAL_RESISTANCE, JOB_TRAIT)
		if("Quarterstaff")
			spawned.clamped_adjust_skillrank(/datum/skill/combat/polearms, 3, 3)
			spawned.adjust_stat_modifier("job_stats", STATKEY_PER, 1)
			spawned.adjust_stat_modifier("job_stats", STATKEY_INT, 1)
	spawned.equip_to_slot_or_del(new gloves_to_wear, ITEM_SLOT_GLOVES, TRUE)

	var/static/list/gear = list(
		"Grenzelhoftian - Heavyweight, Blacksteel Thorns",
		"Naledian - Lightweight, Arcyne-Martiality",
	)
	var/armor_choice = browser_input_list(player_client, "Choose your ARCHETYPE.", "TAKE UP PSYDON'S DUTY.", gear)
	switch(armor_choice)
		if("Grenzelhoftian - Heavyweight, Blacksteel Thorns")
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/head/roguehood/psydon(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/head/helmet/blacksteel/psythorns(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/wrists/bracers/psythorns(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/neck/psycross/silver(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/ring/signet/silver(), TRUE, TRUE)
		if("Naledian - Lightweight, Arcyne-Martiality")
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/head/headband/naledi(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/face/lordmask/naledi/sojourner(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/wrists/bracers/naledi(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/neck/psycross/g(), TRUE, TRUE)
			spawned.equip_to_appropriate_slot(new /obj/item/clothing/ring/signet(), TRUE, TRUE)
			spawned.put_in_hands(new /obj/item/spellbook_unfinished/pre_arcyne)
			ADD_TRAIT(spawned, TRAIT_DODGEEXPERT, JOB_TRAIT)
			REMOVE_TRAIT(spawned, TRAIT_CRITICAL_RESISTANCE, JOB_TRAIT)
			var/list/spells = list(
				/datum/action/cooldown/spell/undirected/forcewall,
				/datum/action/cooldown/spell/projectile/sickness,
				/datum/action/cooldown/spell/projectile/fetch,
				/datum/action/cooldown/spell/undirected/message,
				/datum/action/cooldown/spell/undirected/touch/bladeofpsydon,
			)
			for(var/datum/action/cooldown/spell/spell as anything in spells)
				spawned.add_spell(spell)
			var/list/stats = list(
				STATKEY_CON = -3,
				STATKEY_INT = 3,
				STATKEY_SPD = 2,
			)
			spawned.adjust_stat_modifier_list("job_stats", stats)

/datum/outfit/disciple
	name = "Disciple"
	shoes = /obj/item/clothing/shoes/psydonboots
	armor = /obj/item/clothing/armor/regenerating/skin/disciple
	backl = /obj/item/storage/backpack/satchel/otavan
	belt = /obj/item/storage/belt/leather/rope/dark
	pants = /obj/item/clothing/pants/tights/colored/black
	beltl = /obj/item/storage/belt/pouch/coins/mid
	cloak = /obj/item/clothing/cloak/psydontabard/alt
	backpack_contents = list(
		/obj/item/key/inquisition = 1,
		/obj/item/paper/inqslip/arrival/ortho = 1,
		/obj/item/gem/amethyst = 1,
	)
