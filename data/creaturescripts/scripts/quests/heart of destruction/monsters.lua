local monsters = {
	["eradicatorr"] = Position(32317, 31284, 14),
	["rupture"] = Position(32327, 31250, 14),
	["the hunger"] = Position(32253, 31372, 14),
	["the rage"] = Position(32290, 31372, 14),
	["world devourer"] = Position(32280, 31348, 14),
}

local function cristalCheck(pos)
	local tile = Tile(pos)
	if tile then
		local item = tile:getItemById(1304)
		if item then
			item:remove()
		else
			Game.createItem(1304, 1, pos)
			addEvent(cristalCheck, pos, 300 * 1000)
		end
	end
end

function onKill(creature, target)
	local targetMonster = monsters[target:getMonster():getName():lower()]
	if not targetMonster then
		return true
	end

	addEvent(cristalCheck, targetMonster, 5 * 1000)
	return true
end
