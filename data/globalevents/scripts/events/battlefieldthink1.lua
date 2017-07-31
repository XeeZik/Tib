function onThink(interval)
	if _Lib_Battle_Days1[os.date("%A")] then
		hours1 = tostring(os.date("%X")):sub(1, 5)
		tb1 = _Lib_Battle_Days1[os.date("%A")][hours1]
		if tb1 and (tb1.players1 % 2 == 0) then
			local tp1 = Game.createItem(1387, 1, _Lib_Battle_Info1.tpPos1)
			tp1:setActionId(45550)
			CheckEvent1(_Lib_Battle_Info1.limit_Time1)
			Game.setStorageValue(_Lib_Battle_Info1.storage_count1, tb1.players1)
			broadcastMessage("[BattleField] A teleport was created in the Event Room [Temple of Thais], You have 10 minutes to enter., Only " .. tb1.players1 .. " players can enter, to be divided into " .. ((tb1.players1) / 2) .. " VS " .. ((tb1.players1) / 2) .. ".")
		end
	end
	return true
end
