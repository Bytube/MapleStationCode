/// -- Modular security clothing. --
//BO clothing
//Unused, may be reimplamented later if we get a different sprite
/obj/item/clothing/under/rank/security/bridge_officer
	name = "bridge officer uniform"
	desc = "A formal blue suit and tie kitted out with padding for protection worn by the officers that work the bridge. Someone owes you a beer..."
	icon_state = "blueshift"
	inhand_icon_state = null
	armor_type = /datum/armor/brige_uniform
	sensor_mode = SENSOR_COORDS
	can_adjust = FALSE

/datum/armor/brige_uniform
	melee = 5
	fire = 50
	acid = 50
	bio = 10
	wound = 5

/obj/item/clothing/under/rank/security/bridge_officer/black
	name = "bridge officer suit"
	desc = "A distinguished black suit kitted out with padding for protection worn by the officers that work the bridge."
	icon = 'icons/obj/clothing/under/suits.dmi'
	worn_icon = 'icons/mob/clothing/under/suits.dmi'
	icon_state = "really_black_suit"
	inhand_icon_state = "lawyer_black"

/obj/item/clothing/under/rank/security/bridge_officer/black/skirt //putting this here god fucking forbid it pulls the lawyers black suit
	name = "bridge officer suitskirt"
	desc = "A distinguished black suit kitted out with padding for protection worn by the officers that work the bridge."
	icon_state = "really_black_suit_skirt"
	inhand_icon_state = "lawyer_black"
	dying_key = DYE_REGISTRY_JUMPSKIRT
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

//AP clothing
/obj/item/clothing/under/rank/security/officer/blueshirt/asset_protection
	name = "asset protection suit"
	desc = "A formal blue suit and tie kitted out with padding for protection worn by the protection units assisting command."
	icon_state = "blueshift"
	inhand_icon_state = null
	armor_type = /datum/armor/brige_uniform
	sensor_mode = SENSOR_COORDS
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/officer/grey/asset_protection
	name = "asset protection uniform"
	desc = "It gives you unease, the grey. But hey, that tie looks swanky! ..Is it even a tie?"
	armor_type = /datum/armor/brige_uniform
