local config = {
	[50109] = { pos = Position(32624, 31514, 9) },
	[50245] = { pos = Position(32527, 31842, 9) },
	[50246] = { pos = Position(32559, 31852, 7) },
	[50247] = { pos = Position(32498, 31828, 9) },
	[50249] = { pos = Position(32497, 31805, 9) },
	[50250] = { pos = Position(32494, 31831, 9) },
	[50251] = { pos = Position(32517, 31830, 9) },
	[50252] = { pos = Position(32490, 31810, 9) },
	[50253] = { pos = Position(32514, 31805, 9) },
	[50254] = { pos = Position(32518, 31827, 9) },
	[50248] = { pos = Position(32517, 31806, 9) },
	str = 10050
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local v = config[item.actionid]
	local player = Player(cid)
	if not player then return false end

	if player:getStorageValue(config.str) < 1000 then
		player:teleportTo(v.pos)
		v.pos:sendMagicEffect(11)
	else
		doCreatureSay(cid, "Zzz Dont working.", TALKTYPE_ORANGE_1)
		return true
	end
end
