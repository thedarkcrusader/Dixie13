/datum/voicepack/male/assassin/get_sound(soundin, modifiers)
	var/used
	switch(soundin)
		if("laugh")
			used = list('sound/vo/assassin/mlaugh.ogg')
		if("whistle")
			used = list('sound/vo/assassin/whistle1.ogg', 'sound/vo/assassin/whistle2.ogg')
		if("chuckle")
			used = list('sound/vo/assassin/mchuckle1.ogg', 'sound/vo/assassin/mchuckle2.ogg', 'sound/vo/assassin/mchuckle3.ogg')
			if(prob(1))
				used = 'sound/vo/assassin/mchuckle4.ogg'
	if(!used)
		used = ..(soundin, modifiers)
	return used
