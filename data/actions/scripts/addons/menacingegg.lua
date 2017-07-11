function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
local player = Player(cid)
if not player:hasMount(99) then
player:addMount(99)
player:getPosition():sendMagicEffect(15)
item:remove(1)
doCreatureSay(cid, "You receive the permission to ride a Vortexion.", TALKTYPE_ORANGE_1)
else
player:getPosition():sendMagicEffect(3)
player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this mount.")
end
return true
end