function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local player = Player(cid)
	if not player then return true end

	if item then
		item:transform( ((item.itemid == 22614) and 22615 or 22614) )
	end
	return true
end