/datum/component/particle_spewer/sparkle
	icon_file = 'icons/effects/particles/special_particles.dmi'
	particle_state = "sparkle"

	unusual_description = "shiny"
	duration = 0.7 SECONDS
	spawn_interval = 0.3 SECONDS
	burst_amount = 0
	offsets = FALSE
	var/spark_total_duration = 9999 MINUTES
	var/end_time = 0

/datum/component/particle_spewer/sparkle/Initialize(spark_total_duration)
	. = ..()
	spark_total_duration = spark_total_duration
	START_PROCESSING(SSprocessing, src)
	end_time = world.time + spark_total_duration

/datum/component/particle_spewer/sparkle/process()
	if(world.time >= end_time)
		RemoveComponent()
		return
	return ..()

datum/component/particle_spewer/sparkle/Destroy()
	if(istype(source_object, /obj/item/clothing/shoes))
		var/obj/item/clothing/shoes/shoes = source_object
		shoes.polished = 0
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/component/particle_spewer/sparkle/animate_particle(obj/effect/abstract/particle/spawned)
	var/matrix/first = matrix()
	spawned.pixel_x += rand(-12, 12) // can be anywhere in the tile bounds
	spawned.pixel_y += rand(-12, 12)
	first.Turn(rand(-90, 90))
	first.Scale(0.1, 0.1)
	spawned.transform = first

	first.Scale(10)
	animate(spawned, transform = first, time = 0.3 SECONDS, alpha = 220)

	first.Scale(0.1 * 0.1)
	first.Turn(rand(-90, 90))
	animate(transform = first, time = 0.3 SECONDS)

	QDEL_IN(spawned, duration)


/datum/component/particle_spewer/sparkle/spark_more
	unusual_description = "brilliantly shiny"
	duration = 1.1 SECONDS
	spawn_interval = 0.2 SECONDS
	burst_amount = 2
	offsets = FALSE

/datum/component/particle_spewer/sparkle/spark_more/animate_particle(obj/effect/abstract/particle/spawned)
	var/matrix/first = matrix()
	spawned.pixel_x += rand(-12, 12)
	spawned.pixel_y += rand(-12, 12)

	first.Turn(rand(-90, 90))
	first.Scale(0.15, 0.15) // Slightly larger starting sparkle
	spawned.transform = first

	first.Scale(10)
	animate(spawned, transform = first, time = 0.3 SECONDS, alpha = 255) // Brighter

	first.Scale(0.15 * 0.1)
	first.Turn(rand(-90, 90))
	animate(transform = first, time = 0.3 SECONDS)

	QDEL_IN(spawned, duration)

