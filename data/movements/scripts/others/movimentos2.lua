local action_id = {
	[13430] = {x = 32325, y = 32088, z = 7}, -- Preto Volta   
	[13432] = {x = 32328, y = 32088, z = 7}, -- Violeta Volta   
	[13434] = {x = 32331, y = 32088, z = 7}, -- Verde Volta   
	[13436] = {x = 32334, y = 32088, z = 7}, -- Laranja Volta   
	[13438] = {x = 32337, y = 32088, z = 7}, -- Azul Volta   
	[13440] = {x = 32340, y = 32088, z = 7}, -- Dourado Volta  
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