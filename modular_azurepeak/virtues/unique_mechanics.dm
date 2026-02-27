// Unique Mechanical Virtues - Special abilities that change gameplay

/datum/virtue/unique
	category = "feats"

// ============================================
// FERAL INSTINCTS - Natural Weapons
// ============================================

// Weaker version of werewolf claws
/obj/effect/proc_holder/spell/self/claws/feral
	name = "feral claws"
	desc = "Extend or retract my natural claws."
	overlay_state = "claws"
	antimagic_allowed = TRUE
	recharge_time = 20 // 2 seconds
	ignore_cockblock = TRUE

/obj/effect/proc_holder/spell/self/claws/feral/cast(list/targets, mob/user)
	. = ..()
	var/list/current_hands = list(FALSE, FALSE)
	current_hands[LEFT_HANDS] = user.get_item_for_held_index(LEFT_HANDS)
	current_hands[RIGHT_HANDS] = user.get_item_for_held_index(RIGHT_HANDS)
	var/extending_claws = FALSE
	
	if(!(current_hands[LEFT_HANDS] || !user.has_hand_for_held_index(LEFT_HANDS)) || !(current_hands[RIGHT_HANDS] || !user.has_hand_for_held_index(RIGHT_HANDS)))
		extending_claws = TRUE
	
	for(var/hand_index = 1, hand_index < 3, hand_index++)
		var/current_item = current_hands[hand_index]
		if(extending_claws)
			if(current_hands[hand_index])
				continue
			if(!user.has_hand_for_held_index(hand_index))
				continue
			var/new_claw
			if(hand_index == LEFT_HANDS)
				new_claw = new /obj/item/rogueweapon/feral_claw/left(user)
				user.put_in_l_hand(new_claw)
				extended_claw_record[LEFT_HANDS] = new_claw
			else
				new_claw = new /obj/item/rogueweapon/feral_claw/right(user)
				user.put_in_r_hand(new_claw)
				extended_claw_record[RIGHT_HANDS] = new_claw
			RegisterSignal(new_claw, COMSIG_QDELETING, PROC_REF(clear_claw_entry))
			continue
		
		var/claw_entry = extended_claw_record[hand_index]
		if(istype(current_item, claw_type))
			if(!claw_entry)
				log_runtime("[user] had a feral claw that wasn't being tracked: [current_item]")
			user.temporarilyRemoveItemFromInventory(I = current_item, force = TRUE)
			qdel(current_item)
		extended_claw_record[hand_index] = FALSE		
	return TRUE

// Weaker feral claw weapon (compared to werewolf)
/obj/item/rogueweapon/feral_claw
	name = "feral claws"
	desc = "Sharp natural claws."
	item_state = null
	lefthand_file = null
	righthand_file = null
	icon = 'icons/roguetown/weapons/unarmed32.dmi'
	max_blade_int = 600
	max_integrity = 600
	force = 15 // Much weaker than werewolf (25)
	block_chance = 0
	wdefense = 1
	armor_penetration = 10 // Lower than werewolf (15)
	associated_skill = /datum/skill/combat/unarmed
	wlength = WLENGTH_SHORT
	wbalance = WBALANCE_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	can_parry = TRUE
	sharpness = IS_SHARP
	parrysound = "bladedsmall"
	swingsound = BLADEWOOSH_SMALL
	possible_item_intents = list(/datum/intent/unarmed/claw/feral, /datum/intent/uanrmed/claw/rend)
	embedding = list("embedded_pain_multiplier" = 0, "embed_chance" = 0, "embedded_fall_chance" = 0)
	item_flags = DROPDEL

/obj/item/rogueweapon/feral_claw/right
	icon_state = "claw_r"

/obj/item/rogueweapon/feral_claw/left
	icon_state = "claw_l"

/obj/item/rogueweapon/feral_claw/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NOEMBED, TRAIT_GENERIC)

/datum/intent/unarmed/claw/feral
	name = "slash"
	icon_state = "instrike"
	attack_verb = list("slashes", "claws")
	animname = "cut"
	blade_class = BCLASS_CUT
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	chargetime = 0
	penfactor = 10
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE
	item_d_type = "slash"


/datum/intent/uanrmed/claw/rend
	name = "rend"
	icon_state = "inrend"
	attack_verb = list("rends", "tears")
	animname = "cut"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	chargetime = 0
	penfactor = 15
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE
	item_d_type = "slash"



// ============ SCORCHED STATUS EFFECTS ============

// Moon-Touched (Noc-Scorched virtue)
/datum/status_effect/moon_touched
	id = "moon_touched"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/moon_touched

/datum/status_effect/moon_touched/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_SILVER_WEAK, "moon_touched")
	ADD_TRAIT(owner, TRAIT_NOCSIGHT, "moon_touched")
	return TRUE

/datum/status_effect/moon_touched/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_SILVER_WEAK, "moon_touched")
	REMOVE_TRAIT(owner, TRAIT_NOCSIGHT, "moon_touched")

/atom/movable/screen/alert/status_effect/moon_touched
	name = "Moon-Touched"
	desc = "The moonlight has awakened something primal in me. My night vision sharpens but my body burns and my mind is slipping..."
	icon_state = "nite_bad"

// Sun-Scorched (Astrata-Scorched virtue)
/datum/status_effect/sun_scorched
	id = "sun_scorched"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/sun_scorched

/datum/status_effect/sun_scorched/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_CRITICAL_WEAKNESS, "sun_scorched")
	ADD_TRAIT(owner, TRAIT_SPELLCOCKBLOCK, "sun_scorched")
	return TRUE

/datum/status_effect/sun_scorched/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_CRITICAL_WEAKNESS, "sun_scorched")
	REMOVE_TRAIT(owner, TRAIT_SPELLCOCKBLOCK, "sun_scorched")

/atom/movable/screen/alert/status_effect/sun_scorched
	name = "Sun-Scorched"
	desc = "Astrata's light burns through me. My wounds are grave, silver cuts deep, and the sun strips me of my resilience."
	icon_state = "sun_bad"

// Blood Hunger (Astrata-Scorched virtue)
/datum/status_effect/debuff/blood_hunger_t1
	id = "blood_hunger_t1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/blood_hunger_t1
	effectedstats = list(STATKEY_STR = -1, STATKEY_SPD = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/blood_hunger_t1
	name = "Blood Thirst"
	desc = "I'm getting thirsty... I need blood soon."
	icon_state = "debuff"

/datum/status_effect/debuff/blood_hunger_t2
	id = "blood_hunger_t2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/blood_hunger_t2
	effectedstats = list(STATKEY_STR = -2, STATKEY_SPD = -2, STATKEY_END = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/blood_hunger_t2
	name = "Severe Blood Thirst"
	desc = "The hunger grows unbearable. I NEED blood!"
	icon_state = "debuff"

/datum/status_effect/debuff/blood_hunger_t3
	id = "blood_hunger_t3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/blood_hunger_t3
	effectedstats = list(STATKEY_STR = -3, STATKEY_SPD = -3, STATKEY_END = -2, STATKEY_WIL = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/blood_hunger_t3
	name = "Starving for Blood"
	desc = "I'm losing control! The beast within demands blood!"
	icon_state = "debuff"

// Meat Hunger (Noc-Scorched virtue)
/datum/status_effect/debuff/meat_hunger_t1
	id = "meat_hunger_t1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/meat_hunger_t1
	effectedstats = list(STATKEY_END = -1, STATKEY_WIL = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/meat_hunger_t1
	name = "Bestial Hunger"
	desc = "The beast stirs... I need raw meat."
	icon_state = "debuff"

/datum/status_effect/debuff/meat_hunger_t2
	id = "meat_hunger_t2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/meat_hunger_t2
	effectedstats = list(STATKEY_END = -2, STATKEY_WIL = -2, STATKEY_INT = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/meat_hunger_t2
	name = "Ravenous Hunger"
	desc = "My thoughts turn feral. I NEED flesh!"
	icon_state = "debuff"

/datum/status_effect/debuff/meat_hunger_t3
	id = "meat_hunger_t3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/meat_hunger_t3
	effectedstats = list(STATKEY_END = -3, STATKEY_WIL = -3, STATKEY_INT = -2, STATKEY_STR = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/meat_hunger_t3
	name = "Feral Starvation"
	desc = "The beast is taking over! I cannot think straight!"
	icon_state = "debuff"
