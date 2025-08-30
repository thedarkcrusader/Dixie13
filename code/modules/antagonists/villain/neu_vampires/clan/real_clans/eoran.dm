
/datum/clan_leader/eoran
	lord_spells = list(
		/datum/action/cooldown/spell/undirected/mansion_portal,
		/datum/action/cooldown/spell/undirected/shapeshift/frog,
		/datum/action/cooldown/spell/vampiric_charm,
		/datum/action/cooldown/spell/undirected/list_target/encode_thoughtsvampire
	)
	lord_verbs = list(
		/mob/living/carbon/human/proc/demand_submission,
		/mob/living/carbon/human/proc/punish_spawn
	)
	lord_traits = list(TRAIT_HEAVYARMOR, TRAIT_NOSTAMINA)
	lord_title = "Elder"

/datum/clan/eoran
	name = "House Eoran"
	desc = "TBA"
	curse = "Obsession with love"
	blood_preference = BLOOD_PREFERENCE_ALL
	clane_traits = list(
		TRAIT_BEAUTIFUL,
		TRAIT_EMPATH,
		TRAIT_EXTEROCEPTION,
		)

	clane_covens = list(
		/datum/coven/auspex,
		/datum/coven/presence,
		/datum/coven/bloodheal,
		/datum/coven/eora
	)
	leader = /datum/clan_leader/eoran

/datum/clan/thronleer/get_blood_preference_string()
	return "Regular blood, blood of your loved ones"

/datum/clan/thronleer/get_downside_string()
	return "You are perfect, you do not have any downsides."

/datum/clan/eoran/apply_clan_components(mob/living/carbon/human/H)
	H.AddComponent(/datum/component/vampire_disguise)
