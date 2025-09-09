/datum/clan/caitiff
	name = "Caitiff"
	desc = "The clanless"
	blood_preference = BLOOD_PREFERENCE_ALL
	clane_covens = list(
		/datum/coven/obfuscate,
		/datum/coven/auspex,
		/datum/coven/bloodheal
    )
	force_VL_if_clan_is_empty = TRUE
/datum/clan/caitiff/apply_clan_components(mob/living/carbon/human/H)
	H.AddComponent(/datum/component/vampire_disguise)
