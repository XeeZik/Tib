function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.GravediggerOfDrefia.Mission59) == 1 and player:getStorageValue(Storage.GravediggerOfDrefia.Mission60) < 1 and player:removeItem(21464, 1) then
		player:setStorageValue(Storage.GravediggerOfDrefia.Mission60, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You now look like a Necromancer.')
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
