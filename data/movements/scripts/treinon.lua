eventsId = {}

local function rechargeStamina(cid)
    if not isPlayer(cid) then
        eventsId[cid] = nil
        return
    end

    doPlayerSetStamina(cid, getPlayerStamina(cid) + 1)

    eventsId[cid] = addEvent(rechargeStamina, 120 * 1000, cid)
end

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
    if isPlayer(cid) then
        eventsId[cid] = addEvent(rechargeStamina, 120 * 1000, cid)
 		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Attack the Monk and you will win 1 of stamina every 2 minutes training here.')
   end

    return true
end

function onStepOut(cid, item, position, lastPosition, fromPosition, toPosition, actor)
    if isPlayer(cid) then
        stopEvent(eventsId[cid])
        eventsId[cid] = nil
    end

    return true
end