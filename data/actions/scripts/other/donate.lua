function onUse(cid, item, fromPosition, itemEx, toPosition)
if Player(cid) then
Item(item.uid):remove(1)
		 doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE ,"Re-Login to activate your outfit or mount.")
		 end
		return true
end