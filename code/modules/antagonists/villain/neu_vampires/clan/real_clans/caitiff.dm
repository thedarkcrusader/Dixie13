/datum/clan/none
	name = "Caitiff"
	desc = "TBA"
	curse = "Weakness of the soul."
	blood_preference = BLOOD_PREFERENCE_ALL
	clane_covens = list(
		/datum/coven/obfuscate,
		/datum/coven/auspex,
		/datum/coven/bloodheal
    )

/datum/clan/none/apply_clan_components(mob/living/carbon/human/H)
	H.AddComponent(/datum/component/vampire_disguise)
