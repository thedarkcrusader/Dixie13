/obj/effect/meatvine_controller
	var/list/obj/structure/meatvine/vines = list()
	var/list/growth_queue = list()
	var/reached_collapse_size
	var/reached_slowdown_size
	var/isdying = FALSE
	//What this does is that instead of having the grow minimum of 1, required to start growing, the minimum will be 0,
	//meaning if you get the spacevines' size to something less than 20 plots, it won't grow anymore.

	var/slowdown_size = 200
	var/collapse_size = 1000

/obj/effect/meatvine_controller/Initialize(mapload, ...)
	. = ..()
	if(!isfloorturf(loc))
		return INITIALIZE_HINT_QDEL

	var/obj/structure/meatvine/SV = locate() in src.loc
	if(!SV)
		spawn_spacevine_piece(src.loc)
	else
		SV.master = src
		growth_queue += SV
		vines += SV

	START_PROCESSING(SSfastprocess, src)

/obj/effect/meatvine_controller/proc/die()
	isdying = TRUE

/obj/effect/meatvine_controller/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/effect/meatvine_controller/proc/spawn_spacevine_piece(turf/location, piece_type = /obj/structure/meatvine/floor)
	var/obj/structure/meatvine/SV = new piece_type(location)
	SV.master = src
	growth_queue += SV
	vines += SV

/obj/effect/meatvine_controller/process()
	if(!vines.len)
		qdel(src) //space  vines exterminated. Remove the controller
		return
	if(!growth_queue)
		qdel(src) //Sanity check
		return
	if(vines.len >= collapse_size && !reached_collapse_size)
		reached_collapse_size = 1
	if(vines.len >= slowdown_size && !reached_slowdown_size)
		reached_slowdown_size = 1

	var/length = min( slowdown_size , vines.len)
	if(reached_collapse_size)
		length = 25
	else if(reached_slowdown_size)
		length = min( slowdown_size , vines.len / 10 )

	if(!length)
		return

	var/i = 0
	var/list/obj/structure/meatvine/queue_end = list()

	for( var/obj/structure/meatvine/SV in growth_queue )
		i++
		growth_queue -= SV

		if(isdying)
			SV.rot()
			vines -= SV
		else
			queue_end += SV
			if(prob(20))
				SV.grow()
				continue
			else //If tile is fully grown
				if(prob(25))
					var/mob/living/carbon/C = locate() in SV.loc
					if(C)
						if(!C.buckled)
							SV.buckle_mob(C)
						else
							C.try_wrap_up("meat", "meatthings")


			if(!reached_collapse_size)
				SV.spread()
		if(i >= length)
			break

	growth_queue = growth_queue + queue_end
	//sleep(5)
	//process()
