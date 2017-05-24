-- Only works with 11.10 Tibia Version
-- Incomplete System.

InspectionSystem = {
	Developer = "Charles (Cjaker)",
	Version = "1.0",
	LastUpdate = "24/05/2017 - 05:37 (AM)"
}

local ClientPackets = {
	InspectItem = 0xCD,
	InspectPlayer = 0xCE
}

local ServerPackets = {
	InspectList = 0x76,
	InspectState = 0x77
}

function onRecvbyte(player, msg, byte)
	if (byte == ClientPackets.InspectItem) then
		parseInspectItem(player, msg)
	elseif (byte == ClientPackets.InspectPlayer) then
		parseInspectPlayer(player, msg)
	end
end

function parseInspectItem(player, msg)
	local unknownByte = msg:getByte()
	local posX = msg:getU16()
	if (posX == 0xFFFF) then
		-- Container
		local contId = msg:getU16()
		local index = msg:getByte()
		local myItem = player:getSlotItem(contId)
		if (myItem) then
			player:say("TESTE: " ..myItem:getName(), TALKTYPE_SAY)
		end
	else
		local posY = msg:getU16()
		local posZ = msg:getByte()
		-- Inspect item from ground. :v
	end
end

function parseInspectPlayer(player, msg)
	-- Inspection States
	-- 1 = Grant player permission to inspect you.
	-- 2 = Ask to inspect player.
	-- 3 = Allow player to inspect you.
	-- 4 = Inspect player.
	-- 5 = Revoke player's permission to inspect you.
	-- 6 = "Allow All to Inspect Me" setting is enabled.
	-- 7 = "Allow All to Inspect Me" setting is disabled.
	local inspectionState = msg:getByte()
	if (inspectionState == 4) then
		local uid = msg:getU32()
		sendInspectionList(uid)
	end
end

local function getTotalItems(creature)
	local retItems = {}
	for i = 1, 10 do
		local itemSlot = creature:getSlotItem(i)
		if (itemSlot) then
			retItems[#retItems+1] = {Id = itemSlot:getId(), Name = itemSlot:getName(), isStackable = itemSlot:getType():isStackable(), Count = itemSlot:getCount(), Slot = i}
		end
	end

	return retItems
end

function sendInspectionList(uid)
	local msg = NetworkMessage()
	local object = nil
	msg:addByte(ServerPackets.InspectList)
	if (Player(uid)) then
		msg:addByte(0x01)
		object = Player(uid)
	else
		msg:addByte(0x00)
		object = Item(uid)
	end
 	
 	local totalItems = getTotalItems(object)
	msg:addByte(0x01) -- Length Loop (1 = dont need loop)
	--for i,v in pairs(totalItems) do
	    msg:addString("crystal coin")
	    msg:addItemId(2160)
	    msg:addByte(0xFF)
	    msg:addByte(10)
	--end
	 
	msg:addByte(0x01)
	for i = 1, 1 do
	    msg:addItemId(2160)
	end
	  
	msg:addByte(0x01)
	msg:addString("Testone")
	msg:addString("Testtwo")
	 
	if (object:isPlayer()) then
	    msg:addString(object:getName())
	 	
	 	local outfit = object:getOutfit()
	    msg:addU16(outfit.lookType or 21)
		msg:addByte(outfit.lookHead or 0x00) -- outfit
		msg:addByte(outfit.lookBody or 0x00) -- outfit
		msg:addByte(outfit.lookLegs or 0x00) -- outfit
		msg:addByte(outfit.lookFeet or 0x00) -- outfit
		msg:addByte(outfit.lookAddons or 0x00) -- outfit
	 
	    msg:addByte(0x04)
	    for i = 1, 4 do
	    	msg:addString("level"..i) 
	    	msg:addString("name"..i)
	    end
	end

	msg:sendToPlayer(object)
end