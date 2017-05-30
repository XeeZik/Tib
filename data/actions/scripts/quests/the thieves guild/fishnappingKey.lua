function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid ~= 12505 then
		return false
	end

	if player:getStorageValue(Storage.thievesGuild.Mission06) == 2 then
		if player:removeItem(8762, 1) then
			player:say('In your haste you break the key while slipping in.', TALKTYPE_MONSTER_SAY)
			player:teleportTo(Position(32359, 32788, 6))
		end
	end
	return true
end
