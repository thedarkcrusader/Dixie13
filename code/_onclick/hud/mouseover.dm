/atom/MouseEntered(location, control, params)
	if(!QDELETED(src))
		SSmouse_entered.hovers[usr.client] = src

/// Fired whenever this atom is the most recent to be hovered over in the tick.
/// Preferred over MouseEntered if you do not need information such as the position of the mouse.
/// Especially because this is deferred over a tick, do not trust that `client` is not null.
/atom/proc/on_mouse_enter(client/client)
	SHOULD_NOT_SLEEP(TRUE)

	var/mob/user = client?.mob
	if(!user)
		return

	if(!no_over_text)
		INVOKE_ASYNC(src, PROC_REF(create_over_text), client)

	SEND_SIGNAL(client, COMSIG_CLIENT_HOVER_NEW, src)
	SEND_SIGNAL(src, COMSIG_ATOM_MOUSE_ENTERED, user)
	SEND_SIGNAL(user, COMSIG_USER_MOUSE_ENTERED, src)

	if(isturf(src))
		SEND_SIGNAL(user, COMSIG_MOUSE_ENTERED, src)

/atom/MouseExited(params)
	if(!no_over_text)
		handle_mouseexit()

/atom/proc/handle_mouseexit()
	var/client/client = usr?.client
	if(!client)
		return
	if(client.mouseovertext.loc != null)
		client.mouseovertext.moveToNullspace()
	client.mouseovertext.screen_loc = null

#define HOVER_TEXT_WIDTH 128

/// Create a maptext over a hovered atom, at the hovered atom's position
/atom/proc/create_over_text(client/client)
	if(!client)
		return
	var/used_content = get_over_text_content(client)
	var/height = maptext_height
	var/atom/movable/mouse_over = client.mouseovertext
	if(ismovable(src))
		var/atom/movable/AM = src
		if(AM.bound_height > 32)
			height = AM.bound_height
		if(AM.screen_loc)
			mouse_over.screen_loc = AM.screen_loc
		else if(ismob(src) && src == client.mob) // Special little snowflake because it looks awful otherwise :(
			mouse_over.screen_loc = "CENTER"
	if(!mouse_over.screen_loc)
		mouse_over.abstract_move(get_turf(src))
	mouse_over.maptext = MAPTEXT_CENTER("<span style='color:[hover_color]'>[used_content]</span>")
	mouse_over.maptext_y = height + base_pixel_y + pixel_y
	mouse_over.maptext_x = (HOVER_TEXT_WIDTH - world.icon_size) * -0.5 - base_pixel_x + pixel_x
	WXH_TO_HEIGHT(client.MeasureText(used_content, null, HOVER_TEXT_WIDTH), mouse_over.maptext_height)
	mouse_over.maptext_width = HOVER_TEXT_WIDTH
	client.screen |= client.mouseovertext

#undef HOVER_TEXT_WIDTH

/atom/proc/get_over_text_content(client/client)
	return name

/obj/structure/get_over_text_content(client/client)
	var/mob/user = client?.mob
	if(!user)
		return
	if(HAS_TRAIT(user, TRAIT_ENGINEERING_GOGGLES) && (((rotation_structure && rotation_network) || istype(src, /obj/structure/water_pipe)) || accepts_water_input))
		return "<span style='color:#e6b120'>[return_rotation_chat()]</span>"
	return ..()

/mob/living/carbon/human/get_over_text_content(client/client)
	if(voice_color && name != "Unknown")
		return "<span style='color:#[voice_color]'>[name]</span>"
	return ..()

/atom/proc/return_rotation_chat()
	return

/atom/movable/screen
	no_over_text = TRUE

/atom/movable/screen/movable/mouseover
	name = ""
	icon = 'icons/mouseover.dmi'
	icon_state = "mouseover"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = ABOVE_HUD_PLANE + 1

/atom/movable/screen/movable/mouseover/maptext
	name = ""
	icon = null
	icon_state = null
	animate_movement = NO_STEPS
	alpha = 190
