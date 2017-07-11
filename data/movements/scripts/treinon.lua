eventsId = {}

local function rechargeStamina(cid)
    local player = Player(cid)

    if not player then
        eventsId[cid] = nil
        return
    end

    player:setStamina(player:getStamina() + 1)

    eventsId[cid] = addEvent(rechargeStamina, 2 * 60 * 1000, cid)
end

function onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() then
        local cid = creature:getId()
        eventsId[cid] = addEvent(rechargeStamina, 2 * 60 * 1000, cid)
 		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Attack the Monk and you will win 1 of stamina every 2 minutes training here.')
    end

    return true
end

function onStepOut(creature, item, pos, fromPosition)
    if creature:isPlayer() then
        local cid = creature:getId()
        stopEvent(eventsId[cid])
        eventsId[cid] = nil
    end

    return true
end
