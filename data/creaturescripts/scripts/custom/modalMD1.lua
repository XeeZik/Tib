local mounts = {
	[1] = {name = "Rift Runner", ID = 87},
}

function onModalWindow(player, modalWindowId, buttonId, choiceId)
	player:unregisterEvent("VibrantEgg")

	if modalWindowId == 1001 and  buttonId == 100 then
		if choiceId == 0 then
			return false
		end
		
		if not player:removeItem(24763, 1) then 
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must have a Mysterious Scroll in your backpack!")
			return false
		end

		player:addMount(mounts[choiceId].ID)
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	end
end
