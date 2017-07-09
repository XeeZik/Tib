function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target:getId()
	local itemId = item:getId()
	local charges = target:getCharges()
	local house = player:getTile():getHouse()
	local pot = false
	if house and house:canEditAccessList(SUBOWNER_LIST, player) and house:canEditAccessList(doorId, player) or targetId >= 28577 then 
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, casks only can be useds inside house.')
		return false
	end

	if item:getCount() <= charges then
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Sorry, only Remaining %s charges.', charges))
		return false
	end
--health potions casks
		if itemId == 7636 and targetId == 28553 or targetId == 28577 then
		pot = 7618
		end
		if itemId == 7634 and targetId == 28554 or targetId == 28578 then
		pot = 7588
		end
		if itemId == 7635 and targetId == 28555 or targetId == 28579 then
		pot = 7591
		end
		if itemId == 7635 and targetId == 28556 or targetId == 28580 then
		pot = 8473
		end
		if itemId == 7635 and targetId == 28557 or targetId == 28581 then
		pot = 26031
		end
--mana potions casks
		if itemId == 7636 and targetId == 28563 or targetId == 28582 then
		pot = 7620
		end
		if itemId == 7634 and targetId == 28564 or targetId == 28583 then
		pot = 7589
		end
		if itemId == 7635 and targetId == 28565 or targetId == 28584 then
		pot = 7590
		end
		if itemId == 7635 and targetId == 28566 or targetId == 28585 then
		pot = 26029
		end
--spirit potions caks
		if itemId == 7635 and targetId == 28573 or targetId == 28587 then
		pot = 8472
		end
		if itemId == 7635 and targetId == 28574 or targetId == 28588 then
		pot = 26030
		end
		if pot then
		item:transform(pot)
		charges = charges - item:getCount()
		target:transform(targetId, charges)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Remaining %s charges.', charges)) 
		
		if charges == 0 then
		target:remove()
		end
		end
	
	return true
	end
