/datum/voicepack/male/glutton/get_sound(soundin, modifiers)
	var/used
	switch(soundin)
		if("grumble")
			used = list('sound/vo/mobs/troll/aggro2.ogg')
		if("burploud")
			used = list('sound/vo/burploud.ogg')
		if("groan")
			used = list('sound/vo/mobs/troll/idle1.ogg')
	if(!used)
		used = ..(soundin, modifiers)
	return used

/datum/voicepack/female/glutton/get_sound(soundin, modifiers)
	var/used
	switch(soundin)
		if("grumble")
			used = list('sound/vo/mobs/troll/aggro2.ogg')
		if("burploud")
			used = list('sound/vo/burploud.ogg')
		if("groan")
			used = list('sound/vo/mobs/troll/idle1.ogg')
	if(!used)
		used = ..(soundin, modifiers)
	return used
