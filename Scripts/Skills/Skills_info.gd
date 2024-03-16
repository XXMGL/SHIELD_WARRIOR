extends Node

var skill_data = {
	"Normal":{
		"Healbird":{
			"LV1":{"LV1":"Feather: Gain a Healing Bird that follows the player after respawning, providing continuous health regeneration."},
			"LV2":{"LV2":"Growth: The Healing Bird will provide increased healing."},
			"LV3":{"LV3":"Praise: The Healing Bird now enhances the player's stamina regeneration rate."},
			"LV4":{"LV4":"Support: The Healing Bird provides additional stamina regeneration."},
			"LV5":{"LV5":"Care: During a Perfect Parry, the Healing Bird provides extra health and stamina regeneration."}		
		},
		"Bouncing Ball":{
			"LV1":{"LV1":"Gift: Bullet flight speed increased by 25%."},
			"LV2":{"LV2":"Roll and Roll: Bullets deal increased damage as their flight speed increases."},
			"LV3":{"LV3":"Rebound: Bullets gain an additional bounce chance. When hitting a wall, they bounce instead of disappearing."},
			"LV4":{"LV4":"Bounce and Bounce: Bullets gain three additional bounce chances. When hitting a wall, they bounce instead of disappearing."},
			"LV5":{"LV5":"Magical Rebound Magic: Each bounce increases bullet damage by 20%."}		
		}
	},
	"Rare":{
		"Guardian Shield":{
			"LV1":{"LV1":"Vigilant Shield: Gain a blue shield token slot that can block one attack. Gain one shield token upon precise parry."},
			"LV2":{"LV2":"Sanctuary Shield: All blue shield tokens turn yellow. Health regeneration speed increases when holding a shield token."},
			"LV3":{"LV3":"Guardian Aegis: All yellow shield tokens turn red. Automatically triggers a perfect parry upon taking damage while holding a shield token."}
		},
		"Mystic Familiar":{
			"LV1":{"LV1":"Arcane Familiar: Gain a drone that orbits the player and periodically fires regular bullets."},
			"LV2":{"LV2":"Enchanted Companion: Reduce the drone's attack interval."},
			"LV3":{"LV3":"Sorcerous Ally: Increase the drone's bullet damage."},
			"LV4":{"LV4A":"Warded Guardian: The drone generates a shield periodically, which destroys bullets upon contact.",
			"LV4B":"Runebound Familiar: Drone bullets are aimed at the player's mouse direction."},
			"LV5":{"LV5A":"Warding Sentinel: If the player does not have a shield token slot, the drone provides one. Gain a shield indicator token when the drone generates a shield.",
			"LV5B":" Glyphic Familiar: The drone inherits the player's bullet effects."}
		}
	},
	"Legendary":{
		"Shards Shoot":{
			"LV1":{"LV1":"Shard Burst: Bullets now split into 3 fragments, dealing 30% of the original damage."},
			"LV2":{"LV2":"Increased Shards: Bullets now split into 5 fragments."},
			"LV3":{"LV3":"Massive Shards: Bullets now split into 9 fragments."}
		},
		"Reposition":{
			"LV1":{"LV1":"Repositioning: Bullets will fly towards the nearest enemy unit after traveling for a while."},
			"LV2":{"LV2":"Accelerated Repositioning: Bullets' flight speed increases by 50% after repositioning."},
			"LV3":{"LV3":"High-speed Repositioning: Bullets' flight speed increases by 200% after repositioning."}
		},
		"Wingman":{
			"LV1":{"LV1":"Protection!: Your wing man now blocks bullets for you and sends them back."},
			"LV2":{"LV2":"Assistant!: Your wing man now fires bullets alongside the player."},
			"LV3":{"LV3":"Synchronization!: Your wing man now inherits the player's bullet type."}
		},
		"Resilient Heart":{
			"LV1":{"LV1":"Steadfast Grace: Players will lose their health bar and instead gain three red hearts. When damaged, the player loses one heart, and gains one heart upon perfect parry."},
			"LV2":{"LV2":"Conservative Strategy: Players gain a fourth red heart."},
			"LV3":{"LV3":"Easygoing: Players regain all hearts upon a perfect parry."}
		}
	},
	"Empty":{
		"Empty":{
			"LV1":{"LV1":"111"},
			"LV2":{"LV2":"222"},
			"LV3":{"LV3":"333"}
		}
	}
}
