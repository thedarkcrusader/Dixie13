/datum/action/cooldown/spell/undirected/conjure_item/rat
	name = "Summon Rat"
	desc = "Calls for your bretheren to aid you in... who knows what. Summons a rat."
	button_icon_state = "tamebeast"

	sound = 'sound/items/dig_shovel.ogg'

	antimagic_flags = NONE
	associated_stat = STATKEY_CON
	spell_type = SPELL_STAMINA
	has_visual_effects = FALSE
	cooldown_time = 30 SECONDS
	spell_cost = 10

	uses_component = FALSE
	delete_old = FALSE
	item_duration = 0

	item_type = /obj/item/reagent_containers/food/snacks/smallrat
