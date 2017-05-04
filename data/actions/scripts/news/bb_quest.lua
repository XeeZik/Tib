local config = {
	[9520] = {
		boss = {name = "Mazoran", pos = Position(33585, 32687, 14)},
		players = {
			positions = {from = Position(33593, 32644, 14), to = Position(33593, 32648, 14)},
			teleportTo = Position(33587, 32697, 14)
		}
	},
	[9521] = {
		boss = {name = "Razzagorn", pos = Position(33430, 32469, 14)},
		players = {
			positions = {from = Position(33388, 32457, 14), to = Position(33392, 32457, 14)},
			teleportTo = Position(33417, 32471, 14)
		}
	},
	[9522] = {
		boss = {name = "Plagirath", pos = Position(33172, 31502, 13)},
		players = {
			positions = {from = Position(33229, 31500, 13), to = Position(33229, 31504, 13)},
			teleportTo = Position(33176, 31508, 13)
		}
	},
	[9523] = {
		boss = {name = "Destabilized Ferumbras", pos = Position(33409, 32286, 14)},
		players = {
			positions = {from = Position(33380, 32308, 14), to = Position(33389, 32308, 14)},
			teleportTo = Position(33413, 32293, 14)
		}
	},
	[9524] = {
		boss = {name = "Ragiaz", pos = Position(33482, 32333, 13)},
		players = {
			positions = {from = Position(33456, 32356, 13), to = Position(33460, 32356, 14)},
			teleportTo = Position(33485, 32343, 13)
		}
	},
	[9525] = {
		boss = {name = "Zamulosh", pos = Position(33643, 32756, 11)},
		players = {
			positions = {from = Position(33680, 32741, 11), to = Position(33680, 32745, 11)},
			teleportTo = Position(33647, 32763, 11)
		}
	},
	[9526] = {
		boss = {name = "Tarbaz", pos = Position(33459, 32844, 11)},
		players = {
			positions = {from = Position(33418, 32850, 11), to = Position(33418, 32854, 11)},
			teleportTo = Position(33461, 32851, 11)
		}
	},
	[9527] = {
		boss = {name = "Shulgrax", pos = Position(33485, 32786, 13)},
		players = {
			positions = {from = Position(33434, 32785, 13), to = Position(33434, 32789, 13)},
			teleportTo = Position(33489, 32794, 13)
		}
	},
	[9528] = {
		boss = {name = "The Shatterer", pos = Position(33414, 32417, 14)},
		players = {
			positions = {from = Position(33405, 32467, 14), to = Position(33409, 32467, 14)},
			teleportTo = Position(14)
		}
	}
}

local function getPlayersInLever(uid_act)
	local p = 0
	for x = uid_act.players.positions.from.x, uid_act.players.positions.to.x do
		for y = uid_act.players.positions.from.y, uid_act.players.positions.to.y do
			local tile = Tile(Position(x, y, uid_act.players.positions.from.z))
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:isPlayer() then
					p = p + 1
				end
			end
		end
	end
	return p
end

function onUse(cid, item, fromPosition, itemEx) 
	local player = Player(cid)
	if not player then return true end

	if Game.getStorageValue(item.uid) > os.time() then
		player:sendCancelMessage("Please, wait "..Game.getStorageValue(item.uid) - os.time().." seconds counting the last use to start again.")
		return true
	end

	local uid_act = config[item.uid]

	if #Game.getSpectators(uid_act.boss.pos, false, true, 15, 15, 15, 15) > 0 then
		player:sendCancelMessage("There are players inside the room.")
		return true
	end

	if uid_act then
		local xx = uid_act.players.positions.to.x - uid_act.players.positions.from.x
		local yy = uid_act.players.positions.to.y - uid_act.players.positions.from.y
		local pneed = ((xx > 0) and xx+1 or yy+1)
		if getPlayersInLever(uid_act) == pneed then
			local c = 0
			for x = uid_act.players.positions.from.x, uid_act.players.positions.to.x do
				for y = uid_act.players.positions.from.y, uid_act.players.positions.to.y do
					local pos = Position(x, y, uid_act.players.positions.from.z)
					local tile = Tile(pos)
					if tile then
						local creature = tile:getTopCreature()
						if creature and creature:isPlayer() then
							local pos = Position(uid_act.players.teleportTo.x-c, uid_act.players.teleportTo.y, uid_act.players.teleportTo.z)
							creature:getPosition():sendMagicEffect(3)
							creature:teleportTo(pos)
							pos:sendMagicEffect(11)
							c = c + 1
						end
					end
				end
			end
		else
			local xx = uid_act.players.positions.to.x - uid_act.players.positions.from.x
			local yy = uid_act.players.positions.to.y - uid_act.players.positions.from.y
			player:sendCancelMessage("You need "..pneed.." players to do this quest.")		
			return true
		end
		Game.createMonster(uid_act.boss.name, uid_act.boss.pos)
		Game.setStorageValue(item.uid, os.time() + 20*60*1000)
	end	
	return true
end