function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if target.itemid == 5465 then
		target:transform(5464)
		target:decay()
		Game.createItem(5467, 1, toPosition)
		return true
	end
	end
	
local SUGARCANE = {5464, 5467}
function onUse(cid, item, fromPosition, itemEx, toPosition)
if (isInArray(SUGARCANE, itemEx.itemid)) then
		doTransformItem(itemEx.uid, itemEx.itemid +3)
		doDecayItem(itemEx.uid)
		return true
else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "You can not cut this cane.")
end
		return destroyItem(cid, itemEx, toPosition)
end