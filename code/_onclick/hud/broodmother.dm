/atom/movable/screen/broodmother/bar
	icon = 'icons/mob/broodmother_hud/4x128.dmi'

/atom/movable/screen/broodmother/button
	icon = 'icons/mob/broodmother_hud/8x8.dmi'

/atom/movable/screen/broodmother/bar/tier_1_biomass_bar
	name = "Tier 1 Biomass"
	icon_state = "t1_biomass"
	screen_loc = "WEST+1,NORTH-6"

/atom/movable/screen/broodmother/button/tier_1_biomass_lay
	name = "Lay a tier 1 egg"
	icon_state = "t1_lay_egg"
	screen_loc = "WEST+1,NORTH-12"

/atom/movable/screen/broodmother/bar/tier_2_biomass_bar
	name = "Tier 2 Biomass"
	icon_state = "t2_biomass"
	screen_loc = "WEST+7,NORTH-6"

/atom/movable/screen/broodmother/button/tier_2_biomass_lay
	name = "Lay a tier 2 egg"
	icon_state = "t2_lay_egg"
	screen_loc = "WEST+7,NORTH-12"

/atom/movable/screen/broodmother/bar/tier_3_biomass_bar
	name = "Tier 3 Biomass"
	icon_state = "t3_biomass"
	screen_loc = "WEST+13,NORTH-6"

/atom/movable/screen/broodmother/button/tier_3_biomass_lay
	name = "Lay a tier 3 egg"
	icon_state = "t3_lay_egg"
	screen_loc = "WEST+13,NORTH-12"

/datum/hud/broodmother/New(mob/owner)
	..()
	var/atom/movable/screen/using

	if(!GLOB.admin_datums[owner.ckey]) // If you are adminned, you will not get the dead hud obstruction.
		using =  new /atom/movable/screen/backhudl/ghost()
		using.hud = src
		static_inventory += using

	scannies = new /atom/movable/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70

	using = new /atom/movable/screen/broodmother/tier_1_biomass_bar()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/broodmother/tier_1_biomass_lay()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/broodmother/tier_2_biomass_bar()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/broodmother/tier_2_biomass_lay()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/broodmother/tier_3_biomass_bar()
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/broodmother/tier_3_biomass_lay()
	using.hud = src
	static_inventory += using

/datum/hud/broodmother/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory
