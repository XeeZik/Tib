local mounts = {
	[1] = {name = "Rift Runner", ID = 87},
}

function onModalWindow(player, modalWindowId, buttonId, choiceId)
	player:unregisterEvent("VibrantEgg")
	if modalWindowId == 1001 and  buttonId == 100 then
		if choiceId == 0 then
			return false
		end

		if player:removeItem(24763, 1) then 
			player:addMount(mounts[choiceId].ID)
			player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must have a Mysterious Scroll in your backpack!")
			return false
		end
	end
end
