--[[
local function getCreaturePosition(creature)
	return creature:getPosition()
end
]]

function onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster or targetMonster:getName():lower() ~= 'parasite' then
		return true
	else
		local target = targetMonster
		pos = {
			{ x = 33097, y = 31976, z = 11 },
			{ x = 33097, y = 31977, z = 11 },
			{ x = 33097, y = 31978, z = 11 },
			{ x = 33097, y = 31979, z = 11 }
		}
		barrier = false
		for i = 1, 4 do
			if (getCreaturePosition(target).x == pos[i].x and 
				getCreaturePosition(target).y == pos[i].y and 
				getCreaturePosition(target).z == pos[i].z) then
					barrier = true
			end
		end

		last = false
		if (barrier == true) then
			crystals = {
				{ x = 33098, y = 31976, z = 11 },
				{ x = 33098, y = 31977, z = 11 },
				{ x = 33098, y = 31978, z = 11 },
				{ x = 33098, y = 31979, z = 11 }
			}

			local crystalItem = Tile(crystals[1]):getTopTopItem()
			if (crystalItem:getId() == 18459) then
				for i = 1, 4 do
					crystalItem = Tile(crystals[i]):getTopTopItem()
					crystalItem:transform(18460)
					crystalItem:decay()
				end
			elseif (crystalItem:getId() == 18460) then
				for i = 1, 4 do
					crystalItem = Tile(crystals[i]):getTopTopItem()
					crystalItem:transform(18461)
					crystalItem:decay()
				end
			elseif (crystalItem:getId() == 18461) then
				for i = 1, 4 do
					crystalItem = Tile(crystals[i]):getTopTopItem()
					crystalItem:remove()
					addEvent(doCreateItem, 30 * 1000, 18459, 1, crystals[i])
				end
				last = true
			end

			if (barrier == true and last == true) then
				setGlobalStorageValue(3144, 1)
				addEvent(setGlobalStorageValue, 30 * 60 * 1000, 3144, 0)
			end
		end
	end

	return true
end
