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
		},
		"Papper Airplane":{
			"LV1":{"LV1":"Simple Construction: Bullets' duration doubled."},
			"LV2":{"LV2":"Aerodynamics: Longer bullet duration increases damage multiplier."},
			"LV3":{"LV3":"Resistance: Bullets' base flight speed reduced by 30%."},
			"LV4":{"LV4":"Creativity: Bullets no longer vanish automatically."},
			"LV5":{"LV5":"Stuck: Bullets' speed gradually decreases to 0 after firing."}		
		},
		"Sapling":{
			"LV1":{"LV1":"Rooted: Initial movement speed of incoming enemies reduced by 10%."},
			"LV2":{"LV2":"Seedling: Every 10 enemies killed by the player, a healing orb is spawned at a specific location on the battlefield, restoring the player's health."},
			"LV3":{"LV3":"Rain: When the player kills 100 enemies (60 in the testing version), the Sapling transforms into a Wardenwood, granting the player a legendary skill selection opportunity."},
			"LV4":{"LV4":"Thorns: Sapling: Player's stamina consumption increased by 30%, immediately providing the Sapling with 20 additional enemy kill counts. Wardenwood: Deals 0.2 damage per second to all enemies on the battlefield."},
			"LV5":{"LV5":"Wild Growth: Sapling: Player's stamina increased by 30%, immediately providing the Sapling with 40 additional enemy kill counts. Wardenwood: Any damage dealt by the player applies a 30% slow effect to enemies and grants a slow debuff marker."}		
		},
		"Green Soup":{
			"LV1":{"LV1":"Witch's Exclusive Recipe: One chapter from the witch's five magic potion recipes, detailing the ingredients and steps to make the Green Soup. Perhaps collecting all the magic potion recipes will yield different results."},
			"LV2":{"LV2":"Red Mushroom and Green Soup: Enemies receive a stack of Poison debuff upon taking any form of damage (Poison: Enemies lose one health point per second per stack of poison; boss maximum stack limit is 50 layers)."},
			"LV3":{"LV3":"Foul Odor: Player gains a Poisonous Aura; enemies within the aura suffer 0.5 damage per second. Enemies within the aura suffer Poison debuff triggering 30% faster."},
			"LV4":{"LV4":"Extra Ingredients!: Increased Poisonous Aura activation frequency by 5% when picking up items (maximum increase is 50%)."},
			"LV5":{"LV5":"Keep Your Distance from That Pot: Poisonous Aura now moves to the player's cursor position instead of staying on the player."}		
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
