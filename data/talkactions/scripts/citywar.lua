-- /citywar invite, guild, cidade, numero, modo, tempo
local function cityWarInvite(cid, param)

local guildId = getGuildId(param[2])
	if guildId == false then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid guild name.")
		return false
	end
	if guildId == getPlayerGuildId(cid) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid guild invite.")
		return false	
	end
	if isGuildAntiEntrosa(guildId) or isGuildAntiEntrosa(getPlayerGuildId(cid)) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Guild already on war.")
		return false		
	end
local nomeB = param[2]
	
	--if not cityWarExtraRequirements(cid, guildId) then
		--return false
	--end	
local ret, instance = isInAnyArray(War.cidade_string, param[3])
	if ret then		
		instanceid = Instance:getFree(instance)
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid city name.")
		return false
	end
	
local numero = 0
	if tonumber(param[4]) and isInAnyArray(War.numero, tonumber(param[4])) then
		numero = tonumber(param[4])
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid number of players.")
		return false
	end
	
local ret, modo = isInAnyArray(War.modo_string, param[5])
	if not ret then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid type name.")
		return false
	end

local preco, tempo = 0, 0
	if tonumber(param[6]) then
		tempo = tonumber(param[6])
		ret, preco = isInAnyArray(War.tempo, tonumber(param[6]))
		if not ret then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid duration time.")
			return false
		end
		if not doPlayerWithdrawMoney(cid, War.preco[preco]) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Not enough money.")
			return false			
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid duration time.")
		return false
	end		

local config = {
	desafiante = cid,
	nomeA = getPlayerGuildName(cid),
	nomeB = nomeB,
	tempo = tempo,
	valor = War.preco[preco],
	modo = modo,
	numero = numero,
	cidade = instance,
	instanceid = instanceid,
	guildA = getPlayerGuildId(cid),
	guildB = guildId
}

	Wars(config)
end

-- /citywar accept, guild
local function cityWarAccept(cid, param)
local selfGuild = getPlayerGuildId(cid)
local invitingGuild = getGuildId(param[2])
	if selfGuild == invitingGuild then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You cannot accept your own request.")
		return
	end
	for _, v in pairs(Wars) do
		if type(v) == 'table' then
			if v:isGuildOnWar(invitingGuild) and v:isGuildOnWar(selfGuild) then
				if doPlayerWithdrawMoney(cid, v.valor) then
					v:start()
				else
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Not enough money.")
				end
			end
		end
	end
end

-- /citywar go
local function cityWarGo(cid)
selfGuild = getPlayerGuildId(cid)
	for _, v in pairs(Wars) do
		if not v == false then
			if v:isGuildOnWar(selfGuild) then
				if getTileInfo(getThingPosition(cid)).protection == false then
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Please go to a protection zone.")
					return true
				end
				return v:newPlayer(cid)
			end
		end
	end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your guild is not in a war.")
	return true
end

-- /citywar exit
local function cityWarExit(cid)
	if getPlayerWarType(cid) <= 0 then
		return false
	end
	selfGuild = getPlayerGuildId(cid)
	for _, v in pairs(Wars) do
		if type(v) == 'table' then
			if v:isGuildOnWar(selfGuild) then
				if getTileInfo(getThingPosition(cid)).protection == false then
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Please go to a protection zone.")
					return true
				end
				v:removePlayer(cid)
			end
		end
	end
end

function onSay(cid, words, param, channel)
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		return true
	end	

	local t = string.explode(param, ",")
	local ret = RETURNVALUE_NOERROR

	local comando = t[1]
	if comando == "accept" then
		if isGuildLeader(cid) then
			if getPlayerWarType(cid) < 1 then
				cityWarAccept(cid, t)
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You are already in a war.")	
			end
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You are not a guild leader.")			
		end
	elseif comando == "invite" then
		if isGuildLeader(cid) then
			if getPlayerWarType(cid) < 1 then
				cityWarInvite(cid, t)
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You are already in a war.")	
			end
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You are not a guild leader.")			
		end
	elseif comando == "go" then
		if not cityWarGo(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player number limit reached.")			
		end
	elseif comando == "exit" then
		if not cityWarExit(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You are not in war.")
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid command param.")
	end
	return true
end
