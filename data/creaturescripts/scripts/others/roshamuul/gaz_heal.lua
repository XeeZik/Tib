local config = {
	life_ative = 43750,
	life_add = 300000,
	seconds_ative = 7,
}

local function Uheal(cid)
	local gaz = Monster(cid)
	gaz:addHealth(config.life_add)
	gaz:say("Gaz'haragoth HEALS himself!", TALKTYPE_MONSTER_SAY)
	gaz:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if attacker then
		if creature:getHealth() < config.life_ative then
			creature:say("Gaz'haragoth beginns to draw on the nightmares to HEAL himself!", TALKTYPE_MONSTER_SAY)
			addEvent(Uheal, 1000 * config.seconds_ative, creature.uid)
		end
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
