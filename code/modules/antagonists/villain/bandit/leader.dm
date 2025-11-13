
/datum/antagonist/bandit/leader
	name = "Bandit Leader"
	antag_hud_type = ANTAG_HUD_BANDIT
	antag_hud_name = "bandit"
	antag_flags = FLAG_ANTAG_CAP_IGNORE
	confess_lines = list("I BRING THEM FREEDOM!!!", "WE WILL NOT LIVE IN YOUR WALLS!", "I AM WHY YOU CLUTCH YOUR POUCH!")

/datum/antagonist/bandit/leader/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/bandit/leader))
		if(examiner.real_name in GLOB.outlawed_players)
			if(examined.real_name in GLOB.outlawed_players)
				return span_boldnotice("Someone else to lead the tide, they won't overshadow me")
			else
				return span_boldnotice("Hah some leader they were, they've grown scared of the truly free.")
		else if(examined.real_name in GLOB.outlawed_players)
			return span_boldnotice("The other leader... The reason my comrades will die.")
		else
			return span_boldnotice("Good, they've seen it too, being wanted men does us no favors.")
	else
		if(istype(examined_datum, /datum/antagonist/bandit))
			if(examiner.real_name in GLOB.outlawed_players)
				if(examined.real_name in GLOB.outlawed_players)
					return span_boldnotice("One of the free men that follow me, a good pawn.")
				else
					return span_boldnotice("One of ours?! The traitor's abandoned my example!")
			else if(examined.real_name in GLOB.outlawed_players)
				return span_boldnotice("A free man that used to follow me, that bounty makes it harder now.")
			else
				return span_boldnotice("A fellow pardoned one, followed my example quite well.")
