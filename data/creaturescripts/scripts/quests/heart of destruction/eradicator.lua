function onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	if targetMonster:getName():lower() ~= 'eradicator' then
		return true
	end

	Game.createMonster("Eradicatorr", target:getPosition())
	return true
end
