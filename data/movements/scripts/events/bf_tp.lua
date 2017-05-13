function onStepIn(creature, item, position, fromPosition)
	local player = Player(creature)
	if not player then return false end

	if player:getLevel() < Battlefield.minLevel then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_INFO_DESCR, "YOU NEED LEVEL "..Battlefield.minLevel.."+ TO ENTER.")
		return false
	end
	
	if Battlefield.maxPlayers <= Battlefield:getPlayersCount() then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_INFO_DESCR, "Battlefield event is full.")
		return false
	end
	
	Battlefield:onJoin(creature)
	return true
end