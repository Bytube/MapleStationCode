// -- Assistant Changes --
/datum/job/assistant
	departments_bitflags = DEPARTMENT_BITFLAG_ASSISTANT

// This is done for loadouts, otherwise unique uniforms would be deleted.
/datum/outfit/job/assistant
	uniform = null

/datum/outfit/job/assistant/give_jumpsuit(mob/living/carbon/human/target)
	if(!isnull(uniform))
		return

	return ..()
