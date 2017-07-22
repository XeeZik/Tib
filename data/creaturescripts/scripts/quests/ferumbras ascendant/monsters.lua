local monsters = {
	["destabilized ferumbras"] = Position(33409, 32280, 14),
	["mazoran"] = Position(33582, 32681, 14),
	["plagirath"] = Position(33172, 31497, 13),
	["ragiaz"] = Position(33484, 32326, 13),
	["razzagorn"] = {stone = 1353, pos = Position(33433, 32469, 14),
	["shulgrax"] = Position(33487, 32780, 13),
	["tarbaz"] = Position(33457, 32837, 11),
	["the shatterer"] = Position(33392, 32400, 14),
	["zamulosh"] = Position(33643, 32751, 11),
}

local function cristalCheck(pos)
	local tile = Tile(pos)
	if tile then
		local item = tile:getItemById(1353)
		if item then
			item:remove()
		else
			Game.createItem(1353, 1, pos)
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
