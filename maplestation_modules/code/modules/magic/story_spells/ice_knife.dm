/datum/component/uses_mana/story_spell/pointed/ice_knife
	var/ice_knife_attunement = 0.5
	var/ice_knife_cost = 25

/datum/component/uses_mana/story_spell/pointed/ice_knife/get_attunement_dispositions()
	. = ..()
	.[/datum/attunement/ice] = ice_knife_attunement

/datum/component/uses_mana/story_spell/pointed/ice_knife/get_mana_required(atom/caster, atom/cast_on, ...)
	return ..() * ice_knife_cost

/datum/action/cooldown/spell/pointed/projectile/ice_knife
	name = "Ice Knife"
	desc = "Throw an ice knife which'll cover nearby floor with a thin, slippery sheet of ice."
	button_icon = 'maplestation_modules/icons/mob/actions/actions_cantrips.dmi'
	button_icon_state = "ice_knife"
	sound = 'sound/effects/parry.ogg'

	cooldown_time = 1 MINUTES
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	invocation = "Frig'dus humer'm!" //this one sucks,  ireally wis hi had something better
	invocation_type = INVOCATION_SHOUT
	school = SCHOOL_CONJURATION

	active_msg = "You prepare to throw an ice knife."
	deactive_msg = "You stop preparing to throw an ice knife."

	cast_range = 8
	projectile_type = /obj/projectile/magic/ice_knife

/datum/action/cooldown/spell/pointed/projectile/ice_knife/New(Target, original)
	. = ..()

	AddComponent(/datum/component/uses_mana/story_spell/pointed/ice_knife)

/// Special ice made so that I can replace it's Initialize's MakeSlippery call to have a different property.
/turf/open/misc/funny_ice 
	name = "thin ice sheet"
	desc = "A thin sheet of solid ice. Looks slippery."
	icon = 'icons/turf/floors/ice_turf.dmi'
	icon_state = "ice_turf-0"
	base_icon_state = "ice_turf-0"
	slowdown = 1
	bullet_sizzle = TRUE
	underfloor_accessibility = UNDERFLOOR_HIDDEN
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/misc/funny_ice/Initialize(mapload)
	. = ..()
	MakeSlippery(TURF_WET_ICE, INFINITY, 0, INFINITY, TRUE)

/obj/projectile/magic/ice_knife
	name = "ice knife"
	icon_state = "ice_2"
	damage_type = BRUTE
	damage = 15
	wound_bonus = 50
	sharpness = SHARP_EDGED

/obj/projectile/magic/ice_knife/on_hit(atom/target)
	. = ..()
	if(. != BULLET_ACT_HIT)
		return
	playsound(loc, 'sound/weapons/ionrifle.ogg', 70, TRUE, FALSE)

	var/datum/effect_system/steam_spread/steam = new()
	steam.set_up(10, FALSE, target.loc)
	steam.start()

	for(var/turf/open/nearby_turf in range(3, target))
		var/datum/gas_mixture/air = nearby_turf.return_air()
		var/datum/gas_mixture/turf_air = nearby_turf?.return_air()
		if (air && air != turf_air)
			air.temperature = max(air.temperature + -15, 0)
			air.react(nearby_turf)

	for(var/turf/open/nearby_turf in range(1, src)) // this is fuck ugly, could make a new MakeSlippery flag instead.
		if(isgroundlessturf(nearby_turf))
			continue
		var/ice_turf = /turf/open/misc/funny_ice
		var/reset_turf = nearby_turf.type
		nearby_turf.TerraformTurf(ice_turf, flags = CHANGETURF_INHERIT_AIR) // this will also delete decals! consider the comment above. i'm tired.
		addtimer(CALLBACK(nearby_turf, TYPE_PROC_REF(/turf, TerraformTurf), reset_turf, null, CHANGETURF_INHERIT_AIR), 20 SECONDS, TIMER_OVERRIDE|TIMER_UNIQUE)
