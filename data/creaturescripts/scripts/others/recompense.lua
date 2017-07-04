local table =
{
	[8] = {type = "bank", id = 2000, msg = "You have received 2000 gold in your bank for advancing to Level 8."},
	[40] = {type = "bank", id = 10000, msg = "You have received 10000 gold in your bank for advancing to Level 40."},
	[50] = {type = "bank", id = 10000, msg = "You have received 10000 gold in your bank for advancing to Level 50."},
	[75] = {type = "bank", id = 10000, msg = "You have received 10000 gold in your bank for advancing to Level 75."},
	[100] = {type = "bank", id = 40000, msg = "You have received 40000 gold in your bank for advancing to Level 100."},
	[150] = {type = "item", id = 5942, msg = "You have received one blessed wooden stake because you reached level 150."},
	[200] = {type = "item", id = 2195, msg = "You have been awarded with 1 boots of haste for reaching level 200."},
}

local storage = 99963

function onAdvance(player, skill, oldLevel, newLevel)

	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	for level, _ in pairs(table) do
		if newLevel >= level and player:getStorageValue(storage) < level then
			if table[level].type == "item" then
				player:addItem(table[level].id, 1)
			elseif table[level].type == "bank" then
				player:setBankBalance(player:getBankBalance() + table[level].id)
			else
				return false
			end

			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, table[level].msg)
			player:setStorageValue(storage, level)
		end
	end

	player:save()

	return true
end
