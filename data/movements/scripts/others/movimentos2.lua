-- <movevent event="StepIn" fromaid="73400" toaid="73403" script="others/oramond_movements.lua"/>

local action_id = {
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
	end
	
	return true
end