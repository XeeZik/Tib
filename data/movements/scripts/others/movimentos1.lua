-- <movevent event="StepIn" fromaid="73400" toaid="73403" script="others/oramond_movements.lua"/>

local action_id = {
	[13415] = {x = 33506, y = 31577, z = 8}, -- krailos
	[13416] = {x = 33503, y = 31580, z = 7}, -- krailos
	[13417] = {x = 33622, y = 31789, z = 13}, -- oramond sea 
	[13418] = {x = 32234, y = 32919, z = 9},	-- liberty bay quaras
	[13419] = {x = 32235, y = 32921, z = 8},	-- liberty bay quaras
	[13420] = {x = 32247, y = 32893, z = 9}, -- liberty bay quaras
	[13421] = {x = 32244, y = 32892, z = 8}, -- liberty bay quaras
	[13422] = {x = 32262, y = 32913, z = 9}, -- liberty bay quaras
	[13423] = {x = 32264, y = 32911, z = 8}, -- liberty bay quaras
	[13424] = {x = 32271, y = 32872, z = 9}, -- liberty bay quaras
	[13425] = {x = 32272, y = 32872, z = 8}, -- liberty bay quaras
	[13426] = {x = 31376, y = 32776, z = 7}, -- treiners
	[13427] = {x = 31247, y = 32787, z = 7}, -- treiners
	[13428] = {x = 33545, y = 31861, z = 7}, -- oramond sea   
	[13429] = {x = 32803, y = 31658, z = 8}, -- Preto Ida   
	[13430] = {x = 32325, y = 32088, z = 7}, -- Preto Volta   
	[13431] = {x = 32786, y = 32819, z = 13}, -- Violeta Ida   
	[13432] = {x = 32328, y = 32088, z = 7}, -- Violeta Volta   
	[13433] = {x = 32637, y = 32256, z = 7}, -- Verde Ida   
	[13434] = {x = 32331, y = 32088, z = 7}, -- Verde Volta   
	[13435] = {x = 33341, y = 31168, z = 7}, -- Laranja Ida   
	[13436] = {x = 32334, y = 32088, z = 7}, -- Laranja Volta   
	[13437] = {x = 32206, y = 31035, z = 10}, -- Azul Ida   
	[13438] = {x = 32337, y = 32088, z = 7}, -- Azul Volta   
	[13439] = {x = 32780, y = 32687, z = 14}, -- Dourado Ida   
	[13440] = {x = 32340, y = 32088, z = 7}, -- Dourado Volta  
	[13441] = {x = 32815, y = 32871, z = 13}, -- Central Ida   
	[13442] = {x = 32332, y = 32095, z = 7}, -- Central Volta   
}

function onStepIn(creature, item, position, fromPosition)
	
	local action = action_id[item.actionid]
	if action then
		local player = creature:getPlayer()
		if player == nil then
			return false
		end
		
		player:teleportTo(action)
		player:say("Slrrp!", TALKTYPE_MONSTER_SAY)
	end
	
	return true
end