function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:hasMount(94) then
		player:addMount(94)
		item:remove(1)
		player:say("You receive the permission to ride a sparkion.", TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	else
		player:sendCancelMessage("You already have this mount.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
