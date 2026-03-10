/mob/living/carbon/human/species/abductor
	race = /datum/species/abductor


/datum/species/abductor
	name = "Abductor"
	id = "abductor"
	desc = "<b>Abductor</b><br>\
	Mysterious beings not native to the lands of the Weeping God. Their physiology \
	differs greatly from humen stock, with strange organs and an otherworldly appearance."

	skin_tone_wording = "Skin Tone"
	default_color = "A0FFB0"

	species_traits = list(NOBLOOD)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	possible_ages = ALL_AGES_LIST

	disliked_food = NONE
	liked_food = NONE
	inherent_traits = list(
		TRAIT_NOHUNGER,
		TRAIT_BLOODLOSS_IMMUNE,
		TRAIT_NOBREATH,
		TRAIT_ZOMBIE_IMMUNE,
		TRAIT_NOSLEEP,
		TRAIT_NOMETABOLISM,
		)

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/abduct.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/m/abduct.dmi'

	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	use_m = TRUE

	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female


	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/abductor_eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix
	)

	race_bonus = list(
		STAT_INTELLIGENCE = 1
	)


	offset_features = list(
		OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,0),\
		OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), \
		OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), \
		OFFSET_NECK = list(0,0), OFFSET_MOUTH = list(0,0), OFFSET_PANTS = list(0,0), \
		OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,0), OFFSET_UNDIES = list(0,0), \
		OFFSET_BREASTS = list(0,0), \

		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,-1), \
		OFFSET_BREASTS_F = list(0,-1)
	)