/// Sent from [/mob/living/examine] late, after the first signal is sent, but BEFORE flavor text handling,
/// for when you prefer something guaranteed to appear at the bottom of the stack
/// (Flavor text should stay at the very very bottom though)
#define COMSIG_LIVING_LATE_EXAMINE "late_examine"

/// Item generating their worn icon
#define COMSIG_ITEM_WORN_ICON_MADE "item_worn_icon_made"

/// Entering or exiting a vent.
#define COMSIG_HANDLE_VENTCRAWLING "handle_ventcrawl"
	/// Return to block entrance / exit
	#define COMPONENT_NO_VENT (1<<0)

/// A carbon is being flashed - actually being blinded and taking (eye) damage
#define COMSIG_CARBON_FLASH_ACT "carbon_flash_act"
