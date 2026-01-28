/datum/virtue/combat/weapon_specialist
	name = "Weapon Specialist"
	desc = "I trained with several weapons of my choice, mastering their use and keeping them close at hand."
	custom_text = "Select weapons to specialize in (up to 3 points). Basic weapons cost 1 point, quality steel weapons cost 2-3 points. You will receive each weapon stashed and a matching skill bonus."
	var/max_points = 3
	var/list/weapon_options = list(
		// SWORDS (Iron/Bronze = 1pt, Steel = 2pt)
		"Iron Arming Sword" = list(
			"items" = list(/obj/item/rogueweapon/sword/iron),
			"skills" = list(/datum/skill/combat/swords),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Bronze Arming Sword" = list(
			"items" = list(/obj/item/rogueweapon/sword/bronze),
			"skills" = list(/datum/skill/combat/swords),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Iron Messer" = list(
			"items" = list(/obj/item/rogueweapon/sword/short/messer/iron/virtue),
			"skills" = list(/datum/skill/combat/swords),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Iron Short Sword" = list(
			"items" = list(/obj/item/rogueweapon/sword/short/iron),
			"skills" = list(/datum/skill/combat/swords),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 1
		),
		"Iron Saber" = list(
			"items" = list(/obj/item/rogueweapon/sword/saber/iron),
			"skills" = list(/datum/skill/combat/swords),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		
		// KNIVES/DAGGERS (Bronze = 1pt, Steel = 2pt)
		"Bronze Hunting Knife" = list(
			"items" = list(/obj/item/rogueweapon/huntingknife/bronze),
			"skills" = list(/datum/skill/combat/knives),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 1
		),
		"Parrying Dagger" = list(
			"items" = list(/obj/item/rogueweapon/huntingknife/idagger/virtue),
			"skills" = list(/datum/skill/combat/knives),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 1
		),
		"Steel Parrying Dagger" = list(
			"items" = list(/obj/item/rogueweapon/huntingknife/idagger/steel),
			"skills" = list(/datum/skill/combat/knives),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		
		// AXES (Bronze/Iron = 1pt, Steel = 2-3pt)
		"Bronze Axe" = list(
			"items" = list(/obj/item/rogueweapon/stoneaxe/woodcut/bronze),
			"skills" = list(/datum/skill/combat/axes),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Iron Axe" = list(
			"items" = list(/obj/item/rogueweapon/stoneaxe/woodcut),
			"skills" = list(/datum/skill/combat/axes),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Steel Axe" = list(
			"items" = list(/obj/item/rogueweapon/stoneaxe/woodcut/steel),
			"skills" = list(/datum/skill/combat/axes),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		"Steel Greataxe" = list(
			"items" = list(/obj/item/rogueweapon/greataxe/steel),
			"skills" = list(/datum/skill/combat/axes),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		
		// MACES/BLUNT (Bronze = 1pt, Steel = 2-3pt)
		"Bronze Mace" = list(
			"items" = list(/obj/item/rogueweapon/mace/bronze),
			"skills" = list(/datum/skill/combat/maces),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Iron Mace" = list(
			"items" = list(/obj/item/rogueweapon/mace),
			"skills" = list(/datum/skill/combat/maces),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Steel Mace" = list(
			"items" = list(/obj/item/rogueweapon/mace/steel),
			"skills" = list(/datum/skill/combat/maces),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		"Steel Morningstar" = list(
			"items" = list(/obj/item/rogueweapon/mace/steel/morningstar),
			"skills" = list(/datum/skill/combat/maces),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		"Steel Warhammer" = list(
			"items" = list(/obj/item/rogueweapon/mace/warhammer/steel),
			"skills" = list(/datum/skill/combat/maces),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		
		// POLEARMS (Bronze/Wood = 1pt)
		"Bronze Spear" = list(
			"items" = list(/obj/item/rogueweapon/spear/bronze),
			"skills" = list(/datum/skill/combat/polearms),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Wooden Spear" = list(
			"items" = list(/obj/item/rogueweapon/spear),
			"skills" = list(/datum/skill/combat/polearms),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		
		// WHIPS (1pt)
		"Leather Whip" = list(
			"items" = list(/obj/item/rogueweapon/whip),
			"skills" = list(/datum/skill/combat/whipsflails),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 1
		),
		
		// UNARMED (Bronze = 1pt)
		"Bronze Knuckles (Pair)" = list(
			"items" = list(/obj/item/rogueweapon/knuckles/bronzeknuckles, /obj/item/rogueweapon/knuckles/bronzeknuckles),
			"skills" = list(/datum/skill/combat/unarmed, /datum/skill/combat/wrestling),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Bronze Katar" = list(
			"items" = list(/obj/item/rogueweapon/katar/bronze),
			"skills" = list(/datum/skill/combat/unarmed, /datum/skill/combat/wrestling),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Recurve Bow" = list(
			"items" = list(/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve, /obj/item/quiver/arrows),
			"skills" = list(/datum/skill/combat/bows),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		"Shepherd's Tools" = list(
			"items" = list(/obj/item/rogueweapon/woodstaff/quarterstaff/iron, /obj/item/gun/ballistic/revolver/grenadelauncher/sling, /obj/item/quiver/sling/iron),
			"skills" = list(/datum/skill/combat/staves, /datum/skill/combat/slings),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 2
		),
		
		// CLASSIC COMBINATIONS FROM DELETED VIRTUES (2pt each for pairs)
		"Duelist's Set" = list(
			"items" = list(/obj/item/rogueweapon/sword/short/messer/iron/virtue, /obj/item/rogueweapon/huntingknife/idagger/virtue),
			"skills" = list(/datum/skill/combat/swords, /datum/skill/combat/knives),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		"Dungeoneer's Set" = list(
			"items" = list(/obj/item/rogueweapon/stoneaxe/woodcut, /obj/item/rogueweapon/whip),
			"skills" = list(/datum/skill/combat/axes, /datum/skill/combat/whipsflails),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		),
		"Militiaman's Set" = list(
			"items" = list(/obj/item/rogueweapon/spear, /obj/item/rogueweapon/mace),
			"skills" = list(/datum/skill/combat/polearms, /datum/skill/combat/maces),
			"min_level" = SKILL_LEVEL_JOURNEYMAN,
			"max_level" = SKILL_LEVEL_JOURNEYMAN,
			"cost" = 3
		)
	)

/datum/virtue/combat/weapon_specialist/apply_to_human(mob/living/carbon/human/recipient)
	var/remaining_points = max_points
	var/list/choices = list()
	for(var/weapon_name in weapon_options)
		choices += weapon_name
	
	var/list/selected = list()
	while(remaining_points > 0 && length(choices))
		var/prompt = "Select a weapon ([remaining_points] points left):"
		var/chosen = input(recipient, prompt, "Weapon Specialization") as null|anything in choices
		if(!chosen)
			break
		
		var/list/option = weapon_options[chosen]
		var/cost = option["cost"]
		if(cost > remaining_points)
			to_chat(recipient, span_warning("Not enough points for [chosen]."))
			continue
		
		selected += chosen
		remaining_points -= cost
		choices -= chosen
	
	if(length(selected))
		for(var/chosen in selected)
			var/list/option = weapon_options[chosen]
			
			// Add weapons to stashed items
			if(option["items"])
				var/list/items = option["items"]
				var/item_index = 1
				for(var/item_type in items)
					var/item_name = chosen
					if(length(items) > 1)
						item_name = "[chosen] ([item_index])"
					recipient.mind?.special_items[item_name] = item_type
					item_index++
			
			// Adjust skill levels
			if(option["skills"])
				var/list/skills = option["skills"]
				var/min_level = option["min_level"]
				var/max_level = option["max_level"]
				for(var/skill in skills)
					if(recipient.get_skill_level(skill) < min_level)
						recipient.adjust_skillrank_up_to(skill, min_level, silent = TRUE)
					else
						recipient.adjust_skillrank_up_to(skill, max_level, silent = TRUE)
