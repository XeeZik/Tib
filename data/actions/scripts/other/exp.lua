local config = {
	time = 2,
	storage = 61398,
	}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(config.storage) >= os.time() then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You still have extra experience time left.")
		return true
	end

	player:setStorageValue(config.storage, os.time() + config.time * 3600)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have activated %d hour%s of double experience.", config.time, config.time ~= 1 and "s" or ""))
	item:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	item:remove(1)
	return true
end