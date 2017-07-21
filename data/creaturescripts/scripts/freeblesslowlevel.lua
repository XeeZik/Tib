local freeBlessMaxLevel = 0

function onLogin(cid)
    local player = Player(cid)
    if player:getLevel() <= freeBlessMaxLevel then
    
	if player:hasBlessing(1) then
	else
    player:addBlessing(1, 1)
	end
	
	if player:hasBlessing(2) then
	else
    player:addBlessing(2, 1)
	end
	
	if player:hasBlessing(3) then
	else
    player:addBlessing(3, 1)
	end
	
	if player:hasBlessing(4) then
	else
    player:addBlessing(4, 1)
	end
	if player:hasBlessing(5) then
	else
    player:addBlessing(5, 1)
	end
	if player:hasBlessing(6) then
	else
    player:addBlessing(6, 1)
	end
	if player:hasBlessing(7) then
	else
    player:addBlessing(7, 1)
	end
	if player:hasBlessing(8) then
	else
    player:addBlessing(8, 1)
	end
	
    	player:sendTextMessage(MESSAGE_EVENT_ADVANCE,'You received all blessing for you to be level less than ' .. freeBlessMaxLevel .. '!')
        player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
    end
    return true
end