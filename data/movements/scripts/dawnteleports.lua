function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	local action = Tile(position):getGround():getActionId()
	if player then
		if action == 2010 then
			player:teleportTo(Position(32070, 31900, 6), true)
		elseif action == 2011 then
			if player:getStorageValue(54) < 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Welcome to Dawnport! Walk around and explore on your own, or talk to Inigo if you need directions.')
				player:setStorageValue(54, 1)
			end
		elseif action == 2012 then
			player:teleportTo(Position(32075, 31899, 5), true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<krrk> <krrrrrk> You move away hurriedly.')
		end
	end
	return true
end
