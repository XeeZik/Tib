local config = {
	[27090] = {changeTo = 27091},
	[27091] = {changeto = 27092,	changeTo = 27090}
	
}

function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	local coin = config[item.itemid]
	if not coin then
		return false
	end

	if coin.changeTo and item.type == 100 then
	elseif coin.changeBack then
		item:transform(item.itemid, item.type - 1)
	else
		return false
	end
	return true
end
