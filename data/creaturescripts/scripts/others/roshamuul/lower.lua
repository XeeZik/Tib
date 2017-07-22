local table = {
	["Frazzlemaw"] = ROSHAMUUL_KILLED_FRAZZLEMAWS,
	["Silencer"] = ROSHAMUUL_KILLED_SILENCERS
}

function onKill(creature, target)
	local monster = table[target:getName()]
	if monster then
		creature:setStorageValue(monster, math.max(0, creature:getStorageValue(monster)) + 1)
	end

	return true
end
