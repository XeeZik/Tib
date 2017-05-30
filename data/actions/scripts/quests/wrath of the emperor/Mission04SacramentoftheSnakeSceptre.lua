function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.WrathoftheEmperor.Questline) == 10 then
		if player:removeItem(12324, 1) and player:removeItem(12325, 1) and player:removeItem(12326, 1) then
			player:addItem(12327, 1)
			player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			player:setStorageValue(Storage.WrathoftheEmperor.Questline, 11)
			player:setStorageValue(Storage.WrathoftheEmperor.Mission04, 2) --Questlog, Wrath of the Emperor "Mission 04: Sacrament of the Snake"
		end
	end
	item:transform(item.itemid == 1945 and 1946 or 1945)
	return true
end
