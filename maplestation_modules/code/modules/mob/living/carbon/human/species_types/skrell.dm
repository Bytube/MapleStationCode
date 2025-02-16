// -- Modular Skrell species --
/// GLOB list of head tentacle sprites / options
GLOBAL_LIST_EMPTY(head_tentacles_list)

// The datum for Skrell.
/datum/species/skrell
	name = "Skrell"
	plural_form = "Skrellian"
	id = SPECIES_SKRELL
	species_traits = list(MUTCOLORS, EYECOLOR, LIPS)
	inherent_traits = list(TRAIT_LIGHT_DRINKER)
	external_organs = list(/obj/item/organ/external/head_tentacles = "Long")
	toxic_food = MEAT | RAW | DAIRY | TOXIC | SEAFOOD
	disliked_food = GROSS
	liked_food = VEGETABLES | FRUIT
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/skrell
	exotic_bloodtype = "S"
	mutanttongue = /obj/item/organ/internal/tongue/skrell
	species_pain_mod = 0.80

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/skrell,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/skrell,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/skrell,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/skrell,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/skrell,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/skrell,
	)

	mutanteyes = /obj/item/organ/internal/eyes/skrell
	mutanttongue = /obj/item/organ/internal/tongue/skrell

/datum/species/skrell/get_species_speech_sounds(sound_type)
	switch(sound_type)
		if(SOUND_QUESTION)
			return string_assoc_list(list('maplestation_modules/sound/voice/huff_ask.ogg' = 120))
		if(SOUND_EXCLAMATION)
			return string_assoc_list(list('maplestation_modules/sound/voice/huff_exclaim.ogg' = 120))
		else
			return string_assoc_list(list('maplestation_modules/sound/voice/huff.ogg' = 120))

/datum/species/skrell/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.missing_eye_file = 'maplestation_modules/icons/mob/skrell_eyes.dmi'

/datum/species/skrell/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	C.missing_eye_file = initial(C.missing_eye_file)
	return ..()

/datum/species/skrell/spec_life(mob/living/carbon/human/skrell_mob, seconds_per_tick, times_fired)
	. = ..()
	if(skrell_mob.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
		skrell_mob.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)

/datum/species/skrell/randomize_features(mob/living/carbon/human_mob)
	randomize_external_organs(human_mob)

/datum/species/skrell/get_species_description()
	return "Skrell are a semi-aquatic species hailing from tropical worlds."

/datum/species/skrell/get_species_lore()
	return list("Skrell lore.")

/datum/species/skrell/create_pref_unique_perks()
	var/list/perks = list()

	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "utensils",
		SPECIES_PERK_NAME = "Weight Watchers",
		SPECIES_PERK_DESC = "No matter how much they eat, the Skrell can never become overweight.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "wine-bottle",
		SPECIES_PERK_NAME = "Light Drinkers",
		SPECIES_PERK_DESC = "Skrell naturally don't get along with alcohol \
			and find themselves getting inebriated very easily.",
	))
	return perks

/datum/species/skrell/create_pref_blood_perks()
	var/list/perks = list()

	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Exotic Blood",
		SPECIES_PERK_DESC = "The Skrell have a unique \"S\" type blood. Instead of \
			regaining blood from iron, they regenerate it from copper.",
	))

	return perks

/datum/species/skrell/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features["mcolor"] = COLOR_BLUE_GRAY
	human.update_body(is_creating = TRUE)

// Preset Skrell species
/mob/living/carbon/human/species/skrell
	race = /datum/species/skrell

// Skrell bloodbag, for S type blood
/obj/item/reagent_containers/blood/skrell
	blood_type = "S"

// Copper restores blood for Skrell instead of iron.
/datum/reagent/copper/on_mob_life(mob/living/carbon/C, seconds_per_tick)
	if(is_species(C, /datum/species/skrell) && C.blood_volume < BLOOD_VOLUME_NORMAL)
		C.blood_volume += 0.5 * seconds_per_tick
	..()

// Organ for Skrell head tentacles.
/obj/item/organ/external/head_tentacles
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HEAD_TENTACLES
	dna_block = DNA_HEAD_TENTACLES_BLOCK
	preference = "feature_head_tentacles"
	bodypart_overlay = /datum/bodypart_overlay/mutant/head_tentacles

/datum/bodypart_overlay/mutant/head_tentacles
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT
	feature_key = "head_tentacles"

/datum/bodypart_overlay/mutant/head_tentacles/can_draw_on_bodypart(mob/living/carbon/human/human)
	if(istype(human.head) && (human.head.flags_inv & HIDEHAIR))
		return FALSE
	if(istype(human.wear_mask) && (human.wear_mask.flags_inv & HIDEHAIR))
		return FALSE
	var/obj/item/bodypart/head/our_head = human.get_bodypart(BODY_ZONE_HEAD)
	if(!IS_ORGANIC_LIMB(our_head))
		return FALSE
	return TRUE

/datum/bodypart_overlay/mutant/head_tentacles/get_global_feature_list()
	return GLOB.head_tentacles_list

/obj/item/bodypart/arm/left/skrell
	limb_id = SPECIES_SKRELL
	icon_greyscale = 'maplestation_modules/icons/mob/skrell_parts_greyscale.dmi'

/obj/item/bodypart/arm/right/skrell
	limb_id = SPECIES_SKRELL
	icon_greyscale = 'maplestation_modules/icons/mob/skrell_parts_greyscale.dmi'

/obj/item/bodypart/head/skrell
	limb_id = SPECIES_SKRELL
	icon_greyscale = 'maplestation_modules/icons/mob/skrell_parts_greyscale.dmi'

/obj/item/bodypart/leg/left/skrell
	limb_id = SPECIES_SKRELL
	icon_greyscale = 'maplestation_modules/icons/mob/skrell_parts_greyscale.dmi'

/obj/item/bodypart/leg/right/skrell
	limb_id = SPECIES_SKRELL
	icon_greyscale = 'maplestation_modules/icons/mob/skrell_parts_greyscale.dmi'

/obj/item/bodypart/chest/skrell
	limb_id = SPECIES_SKRELL
	icon_greyscale = 'maplestation_modules/icons/mob/skrell_parts_greyscale.dmi'

/obj/item/organ/internal/eyes/skrell
	desc = "Gooey."
	eye_overlay_file = 'maplestation_modules/icons/mob/skrell_eyes.dmi'
