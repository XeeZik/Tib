function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target:getId()
	local itemId = item:getId()
	local charges = (target:getActionId() - 1000)
local house = player:getTile():getHouse()
	
	if house and house:canEditAccessList(SUBOWNER_LIST, player) and house:canEditAccessList(doorId, player) then
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, enter on house first.')
		return false
	end
	
	if item:getCount() <= charges or target:getActionId() == 0 then
		set = false
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Sorry, only Remaining %s charges.', charges))
		return false
	end
--health potions casks
		if targetId == 28553 or targetId == 28577 and itemId == 7636 then
		set = item:transform(7618)
		end
		if targetId == 28554 or targetId == 28578 and itemId == 7634 then
		set = item:transform(7588)
		end
		if targetId == 28555 or targetId == 28579 and itemId == 7635 then
		set = item:transform(7591)
		end
		if targetId == 28556 or targetId == 28580 and itemId == 7635 then
		set = item:transform(8473)
		end
		if targetId == 28557 or targetId == 28581 and itemId == 7635 then
		set = item:transform(26031)
		end
--mana potions casks
		if targetId == 28563 or targetId == 28582 and itemId == 7636 then
		set = item:transform(7620)
		end
		if targetId == 28564 or targetId == 28583 and itemId == 7634 then
		set = item:transform(7589)
		end
		if targetId == 28565 or targetId == 28584 and itemId == 7635 then
		set = item:transform(7590)
		end
		if targetId == 28566 or targetId == 28585 and itemId == 7635 then
		set = item:transform(26029)
		end
--spirit potions caks
		if targetId == 28573 or targetId == 28587 and itemId == 7635 then
		set = item:transform(8472)
		end
		if targetId == 28574 or targetId == 28588 and itemId == 7635 then
		set = item:transform(26030)
		end
--end
	if set then
		if target:getActionId() == 0 then
		if target.itemid >= 28553 and target.itemid <= 28557 or target.itemid >= 28563 and target.itemid <= 28566 or target.itemid >= 28573 and target.itemid <= 28574 then
		target:setActionId(2000 - item:getCount())
		else
		target:setActionId(1250 - item:getCount())
		end
		else
		target:setActionId(target:getActionId() - item:getCount())
		end
		charges = (target:getActionId() - 1000)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Remaining %s charges.', charges))
		if target:getActionId() == 1000 then
		target:remove()
		end
	end
	return true
	end