ITEM_TIBIA_COIN = 24774
ITEM_PREMIUM_SCROLL = 16101

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:isPlayer() then
		if item:getId() == ITEM_PREMIUM_SCROLL then
			local coins = 30
			player:addTibiaCoins(coins)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received " .. coins .. " tibia coins.")
			item:remove(1)
		elseif item:getId() == ITEM_TIBIA_COIN then
			local coins = item:getCount()
			player:addTibiaCoins(coins)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received " .. coins .. " tibia coins.")
			item:remove(coins)
		end
		
	end
	return true
end