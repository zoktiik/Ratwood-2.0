//Not to be confused with /obj/item/reagent_containers/food/drinks/bottle
GLOBAL_LIST_INIT(wisdoms, world.file2list("strings/rt/wisdoms.txt"))

/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A bottle with a cork."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "clear_bottle1"
	amount_per_transfer_from_this = 10
	amount_per_gulp = 5
	possible_transfer_amounts = list(10)
	volume = 50
	fill_icon_thresholds = list(0, 25, 50, 75, 100)
	dropshrink = 0.8
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	obj_flags = CAN_BE_HIT|UNIQUE_RENAME
	spillable = FALSE
	var/closed = TRUE
	reagent_flags = TRANSPARENT
	w_class = WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	experimental_onhip = TRUE
	debris = list(/obj/item/natural/glass_shard = 1)
	var/desc_uncorked = "An open bottle. Hopefully the cork is nearby."
	var/fancy		// for bottles with custom descriptors that you don't want to change when bottle manipulated
	var/glass_on_impact = FALSE // If TRUE, bottle will generate glass shard on impact. Otherwise it won't.
	var/close_verb = "recork"

/obj/item/reagent_containers/glass/bottle/update_icon(dont_fill=FALSE)
	if(!fill_icon_thresholds || dont_fill || !reagents)
		return

	cut_overlays()
	underlays.Cut()

	if(reagents.total_volume)
		var/fill_name = fill_icon_state? fill_icon_state : icon_state
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[fill_name][fill_icon_thresholds[1]]")

		var/percent = round((reagents.total_volume / volume) * 100)
		for(var/i in 1 to fill_icon_thresholds.len)
			var/threshold = fill_icon_thresholds[i]
			var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
			if(threshold <= percent && percent < threshold_end)
				filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		underlays += filling

	if(closed)
		add_overlay("[icon_state]cork")

/obj/item/reagent_containers/glass/bottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum, do_splash = TRUE)
	playsound(loc, 'sound/combat/hits/onglass/glassbreak (4).ogg', 100)
	shatter(get_turf(src))
	..()

/obj/item/reagent_containers/glass/bottle/proc/shatter(turf/T)
	if(istransparentturf(T))
		shatter(GET_TURF_BELOW(T))
		return 
	glass_on_impact && new /obj/item/natural/glass_shard(get_turf(T))
	new /obj/effect/decal/cleanable/debris/glassy(get_turf(T))
	qdel(src)

/obj/item/reagent_containers/glass/bottle/rmb_self(mob/user)
	. = ..()
	closed = !closed
	user.changeNext_move(CLICK_CD_RAPID, override = TRUE)
	if(closed)
		do_close(user)
	else
		do_open(user)

/obj/item/reagent_containers/glass/bottle/rmb_in_bag(mob/user)
	. = ..()
	rmb_self(user)
	if((item_flags & IN_STORAGE))
		var/notiffy = FALSE
		if(user.mob_timers["uncork_warning"] && (world.time < (user.mob_timers["uncork_warning"] + 45 MINUTES)))
			notiffy = TRUE
		if(!notiffy)
			to_chat(user, span_warning("If I move without sneaking, some of the liquid will spill!"))
			user.mob_timers["uncork_warning"] = world.time

/obj/item/reagent_containers/glass/bottle/proc/do_close(mob/user, no_msg = FALSE)
	if(user)
		if(!no_msg)
			to_chat(user, span_smallnotice("I carefully press the cork back into the mouth of [src]."))
	reagent_flags = TRANSPARENT
	reagents.flags = reagent_flags
	spillable = FALSE
	GLOB.weather_act_upon_list -= src
	desc = initial(desc)
	if(!fancy)
		desc = "A bottle sealed with a cork."
	update_icon()

/obj/item/reagent_containers/glass/bottle/proc/do_open(mob/user, no_msg = FALSE, no_snd = FALSE)
	if(user)
		if(!no_snd)
			playsound(user.loc,'sound/items/uncork.ogg', 100, TRUE)
		if(!no_msg)
			to_chat(user, span_smallnotice("I thumb off the cork from [src]."))
	reagent_flags = OPENCONTAINER
	reagents.flags = reagent_flags
	desc += desc_uncorked
	spillable = TRUE
	GLOB.weather_act_upon_list |= src
	if(!fancy)
		desc = "An open bottle. Hopefully a cork is nearby."
	update_icon()

/obj/item/reagent_containers/glass/bottle/proc/handle_storage_autoclose(notify_user = TRUE, mob/living/actor = null, datum/component/storage/concrete/stor = null)
	// I hate my stupid hacky chud proc, but alas.
	if(closed)
		return
	
	// we will try to find the user
	if(!actor && (istype(stor.real_location(), /atom/movable)))
		var/atom/movable/baggy = stor.real_location()
		if(!isturf(baggy.loc))
			if(isliving(baggy.loc)) 
				actor = baggy.loc
			else if(istype(baggy.loc, /obj/item/storage)) // i.e. pouch within a bag
				var/obj/item/storage/baggy2 = baggy.loc
				if(istype(baggy2.loc, /mob/living))
					actor = baggy2.loc

	var/already_notified = FALSE
//	var/stealthed = FALSE
	if(actor)/*
		if(actor.m_intent == MOVE_INTENT_SNEAK)
			stealthed = TRUE

		if(!stealthed)*/
		if(actor.mob_timers["autocork_notif"] && (world.time < (actor.mob_timers["autocork_notif"] + 0.5 SECONDS)))
			already_notified = TRUE //anti-spam, in case you're gathering with a sack.
		if(notify_user && !already_notified)
			to_chat(actor, span_info("I [close_verb] [src] before storing it."))
			actor.mob_timers["autocork_notif"] = world.time
	closed = TRUE
	do_close(actor, no_msg = TRUE)
	// if you want to add closing sound to do_close, consider using already_notified to prevent accidental sound spam
/*
		else
			var/already_notified = FALSE
			if(actor.mob_timers["bottlespiller"] && (world.time < (actor.mob_timers["bottlespiller"] + 1 HOURS)))
				already_notified = TRUE					
			if(!already_notified)
				to_chat("I ")
				actor.mob_timers["bottlespiller"] = world.time
*/

/obj/item/reagent_containers/glass/bottle/on_enter_storage(datum/component/storage/concrete/S)
	. = ..()
	handle_storage_autoclose(notify_user = TRUE, stor = S)

/obj/item/reagent_containers/glass/bottle/attack_obj(obj/target, mob/living/user)
	// try insert storage would be more accurate, but it's way too computationally expensive for this.
	if(!closed && (SEND_SIGNAL(target, COMSIG_CONTAINS_STORAGE)))
		to_chat(user, span_info("test"))
		handle_storage_autoclose(notify_user = TRUE, actor = user)
	return ..()

/obj/item/reagent_containers/glass/bottle/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "clear_bottle1"
	if(icon_state == "clear_bottle1")
		icon_state = "clear_bottle[rand(1,4)]"
	update_icon()
