/mob/proc/sate_addiction()
	return

/mob/living/carbon/human/sate_addiction(addiction_type)
	var/datum/charflaw/addiction/A

	// If a specific addiction type is requested, only sate that one.
	if(addiction_type)
		if(length(vices))
			for(var/datum/charflaw/vice in vices)
				if(istype(vice, addiction_type))
					A = vice
					break
		if(!A && istype(charflaw, addiction_type))
			A = charflaw
	else
		// Otherwise, try to find an addiction vice (prefer an unsated one).
		if(length(vices))
			for(var/datum/charflaw/vice in vices)
				if(!istype(vice, /datum/charflaw/addiction))
					continue
				var/datum/charflaw/addiction/candidate = vice
				if(!A)
					A = candidate
					continue
				if(A.sated && !candidate.sated)
					A = candidate
		if(!A && istype(charflaw, /datum/charflaw/addiction))
			A = charflaw

	if(!A)
		return

	if(!A.sated)
		to_chat(src, span_blue(A.sated_text))
	A.sated = TRUE
	A.time = initial(A.time) //reset roundstart sate offset to standard
	A.next_sate = world.time + A.time
	remove_stress(A.stress_event)  // Remove vice-specific stress event
	if(A.debuff)
		remove_status_effect(A.debuff)

/datum/charflaw/addiction
	needs_life_tick = TRUE
	var/next_sate = 0
	var/sated = TRUE
	var/time = 5 MINUTES
//	var/debuff = /datum/status_effect/debuff/addiction
	var/debuff //so heroin junkies can have big problems
	var/needsate_text
	var/sated_text = "That's much better..."
	var/unsate_time
	var/stress_event = /datum/stressevent/vice  // Specific stress event type for this vice


/datum/charflaw/addiction/New()
	..()
	time = rand(6 MINUTES, 30 MINUTES)
	next_sate = world.time + time

// Clean up addiction effects when vice is removed
/datum/charflaw/addiction/on_removal(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	// Remove stress event
	if(stress_event)
		H.remove_stress(stress_event)
	// Remove debuff
	if(debuff)
		H.remove_status_effect(debuff)

/datum/charflaw/addiction/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	if(user.mind?.antag_datums)
		for(var/datum/antagonist/D in user.mind?.antag_datums)
			if(istype(D, /datum/antagonist/vampire/lord) || istype(D, /datum/antagonist/werewolf) || istype(D, /datum/antagonist/skeleton) || istype(D, /datum/antagonist/zombie) || istype(D, /datum/antagonist/lich))
				return
	var/mob/living/carbon/human/H = user
	var/oldsated = sated
	if(oldsated)
		if(next_sate)
			if(world.time > next_sate)
				sated = FALSE
	if(sated != oldsated)
		unsate_time = world.time
		if(needsate_text)
			to_chat(user, span_boldwarning("[needsate_text]"))
	if(!sated)
		H.add_stress(stress_event)  // Use vice-specific stress event
		if(debuff)
			H.apply_status_effect(debuff)



/datum/status_effect/debuff/addiction
	id = "addiction"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction
	effectedstats = list(STATKEY_WIL = -1,STATKEY_LCK = -1)
	duration = 100


/atom/movable/screen/alert/status_effect/debuff/addiction
	name = "Addiction"
	desc = ""
	icon_state = "debuff"


/// ALCOHOLIC

/datum/charflaw/addiction/alcoholic
	name = "Alcoholic"
	desc = "I need to drink alcohol regularly. If I go too long without a drink, I'll become increasingly stressed and suffer withdrawal symptoms (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time for a drink."
	stress_event = /datum/stressevent/vice/alcoholic


/// KLEPTOMANIAC

/datum/charflaw/addiction/kleptomaniac
	name = "Thief-borne"
	desc = "I must steal something regularly to satisfy my compulsion. Going too long without theft causes mounting stress and anxiety (reduced WIL and LCK)."
	time = 30 MINUTES
	needsate_text = "I need to STEAL something! I'll die if I don't!"
	stress_event = /datum/stressevent/vice/kleptomaniac


/// JUNKIE

/datum/charflaw/addiction/junkie
	name = "Junkie"
	desc = "I need hard drugs like ozium, moon dust, or lux regularly. Without my fix, I'll suffer increasing stress and withdrawal symptoms (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time to get really high."
	stress_event = /datum/stressevent/vice/junkie

/// Smoker

/datum/charflaw/addiction/smoker
	name = "Smoker"
	desc = "I need to smoke pipe weed, zig, or westleach regularly. Going without causes mounting stress and irritability (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time for a flavorful smoke."
	stress_event = /datum/stressevent/vice/smoker

/// GOD-FEARING

/datum/charflaw/addiction/godfearing
	name = "Devout Follower"
	desc = "I must pray regularly to maintain my spiritual well-being. Neglecting prayer causes stress and spiritual malaise (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time to pray to my Patron."
	stress_event = /datum/stressevent/vice/godfearing
	debuff = /datum/status_effect/debuff/addiction
/// SADIST

/datum/charflaw/addiction/sadist
	name = "Sadist"
	desc = "I need to inflict pain on others regularly to feel satisfied. Going too long without hurting someone causes mounting stress and irritability (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "I need to hear someone whimper."
	stress_event = /datum/stressevent/vice/sadist

/// MASOCHIST

/datum/charflaw/addiction/masochist
	name = "Masochist"
	desc = "I need to experience pain regularly to feel alive. Without it, I become increasingly stressed and anxious (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "I need someone to HURT me."
	stress_event = /datum/stressevent/vice/masochist

