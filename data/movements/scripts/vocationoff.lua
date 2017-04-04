function onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() then
        local player = Player(creature)
        local toVocation = Tile(position):getGround():getActionId() - 2005
        local fromVocation = player:getVocation():getId()
        if fromVocation ~= toVocation and (centerPosition:getDistance(fromPosition) < centerPosition:getDistance(position)) then
            getFirstItems(player)
			changeVocation(player, fromVocation, toVocation)
			player:setVocation(toVocation)
            player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
        end
    end
    return true
end