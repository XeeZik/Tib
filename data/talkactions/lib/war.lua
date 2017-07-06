War = {
	
	numero = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 },	-- quantidade de jogadores (0=infinito)
	tempo = { quinze_min = 15,	 	 trinta_min = 30, 	  	 sessenta_min = 60 },			--	colocar o nome das variaveis iguais
	preco = { quinze_min = 75000, 	 trinta_min = 100000,	 sessenta_min = 150000},		--  caso fizer alguma alteração
	
	modo = { tradicional = 1, semUe = 2, soSd = 3},
	modo_string = {
					[1] = {'tradicional', 'padrao', 'normal', '1'},
					[2] = {'sem ue', 'semue', 'semUe', '2'},
					[3] = {'apenas sd', 'só sd', 'so sd' , 'soh sd', '3'}
	},	
	
	--[[		
			você pode colocar quantos mapas quiser de uma mesma cidade		
			na tabela referente ao mapa, cada vetor da matriz é composto da Posição do Time A e do B
			
			exemplo:			
			[0] = { {posA, posB}, {posA2, posB2}, {posA3, posA4}  }	-- aqui vc tem 3 mapas configurado para Edron
						
			posA = local da cidade em que os jogadores da guild A será teleportados
			posB = local para a guild B
			
			você é livre para escolher quais e quantas copias da cidade
			
			preste atenção! o valor da string e da position deve ser o mesmo!
]]
	
	cidade_string = {
						  [0] = {'edron', "Edron", 'EDRON'},
						  [1] = {'lb', 'liberty bay', 'Liberty Bay', 'LIBERTY BAY'},
						  [2] = {'dara', 'darashia', 'Darashia', 'DARASHIA'},
						  [3] = {'yalahar', 'Yalahar', 'YALAHAR'}
--[[					  [4] = {'carlin', 'Carlin', 'CARLIN'},
						  [5] = {'cormaya', 'Cormaya', 'CORMAYA'},
						  [6] = {'ank', 'ankrahmun', 'Ankrahmun', 'ANKRAHMUN'}, ]]--

	},
	mapas = {	
						  [0] = {     {{x=30974,y=32641,z=7},{x=30909,y=32519,z=7}}     },		-- exemplo de apenas um mapa Edron configurado
						  [1] = {     {{x=30740,y=32734,z=7},{x=30767,y=32567,z=7}}     },
						  [2] = {     {{x=31217,y=32552,z=7},{x=31295,y=32639,z=7}}     },
						  [3] = {     {{x=30925,y=32825,z=7},{x=30982,y=32827,z=7}}     },
						  [4] = {},
						  [5] = {},
						  [6] = {},
						  [7] = {}	
	},
}

for city, v in pairs(War.mapas) do
	for _, mapa in pairs(v) do
		Instances(city, mapa)
	end
end

Wars = {}

function War:new(id, param)
	
	 return setmetatable({
	 
			-- config
			id = id,
			desafiante = param.desafiante,
			aceito = false,
			numero_jogadores = param.numero,
			modo = param.modo,
			tempo = param.tempo,
			instanceid = param.instanceid,
			valor = param.valor,
			positions = {[param.guildA] = param.positionA, [param.guildB] = param.positionB},
			
			-- uso real
			players = {[param.guildA] = {}, [param.guildB] = {}},
			frags = {[param.guildA] = 0, [param.guildB] = 0},
			name = {}
			
			
	 }, { __index = self }), addEvent(function (id, param) 
													if Wars[id] and Wars[id].aceito == false then 
														doPlayerDepositMoney(self.desafiante, valor)
														Wars[id]:broadcastToGuilds(22, "O convite nao foi aceito.")
														Wars[id] = false
														Instances[param.instanceid]:unregister()
													end
												end, 5 * 60 * 1000, id, param)
 end
 
setmetatable(Wars, { __call = 	function(self, param) 
										local id = #Wars+1
										Instances[param.instanceid]:register()
										param.positionA = Instances[param.instanceid].posA
										param.positionB = Instances[param.instanceid].posB
										
										Wars[id] = War:new(id, param)
										
										Wars[id].name = {{param.guildA, param.nomeA}, {param.guildB, param.nomeB}}
										
										local text = "[City War] "..param.nomeA .. " invitou a guild " .. param.nomeB .. " para uma war!\n"
										text = text .. "A war sera na cidade " .. War.cidade_string[param.cidade][1]
										if (param.numero == 0) then										
											text = text .. " sem limite de jogadores para cada time"
										else
											text = text .. " com no maximo " .. param.numero .. " jogadores para cada time"
										end																				
										text = text .. " por " .. param.tempo .. " minutos"
										text = text .. " no modo " .. War.modo_string[param.modo][1]
										text = text .. "\nO lider da guild " .. param.nomeB .. " tem cinco minutos para aceitar o convite. Digite: /citywar accept, " .. param.nomeA
										
										Wars[id]:broadcastToGuilds(22, text)
								end })
																
								
function War:start()
	self.aceito = true	
	self:broadcastToGuilds(22, "[City War] A War entre " .. self.name[1][2] .. " e " .. self.name[2][2] .. "  foi iniciada! Para entrar digite: /citywar go" )
	
	addEvent(War.broadcast, (self.tempo * 60 * 1000) - (5 * 60 * 1000), self, 22, "[City War] Faltam 5 minutos para a War acabar.")
	addEvent(War.broadcast, (self.tempo * 60 * 1000) - (3 * 60 * 1000), self, 22, "[City War] Faltam 3 minutos para a War acabar.")
	addEvent(War.broadcast, (self.tempo * 60 * 1000) - (1 * 60 * 1000), self, 22, "[City War] Falta 1 minuto para a War acabar.")
	addEvent(War.finish, self.tempo * 60 * 1000, self)
end

function War:finish()
	
	local text = "A war entre as guilds " .. self.name[1][2] .. " e " .. self.name[2][2] .. " acabou!\n"
	text = text .. self:getPlacarString()
	self:broadcastToGuilds(22, text)
	
	for guild, teams in pairs(self.players) do
		for k, cid in pairs(teams) do
			if type(cid) == 'number' and isPlayer(cid) then
				local pos = getTownTemplePosition(getPlayerTown(cid))			
				doTeleportThing(cid, pos)			
				
				setPlayerWarType(cid, 0)
				unregisterCreatureEvent(cid, "morte")	
				
				doRemoveCondition(cid, CONDITION_INFIGHT)
				if getCreatureSkullType(cid) == SKULL_WHITE then
					doCreatureSetSkullType(cid, 0)
				end
				
				self.players[guild][k] = nil
			end
		end
	end	
	Instances[self.instanceid]:unregister()
	
	db.executeQuery("INSERT INTO `city_war` (`frags_guild1`, `frags_guild2`, `guild1`, `guild2`, `tempo`, `modo`) VALUES ('" .. self.frags[self.name[1][1]] .. "', '" .. self.frags[self.name[2][1]] .. "', '" .. self.name[1][2] .. "', '" .. self.name[2][2] .. "', '" .. self.tempo .. "', '" .. self.modo .. "' );")
	Wars[self.id] = true
end

local condition_infight = createConditionObject(CONDITION_INFIGHT, -1)

function War:newPlayer(cid)
	if self.aceito == false then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "The war was not accepted yet.")
		return true
	end

	local guildId = getPlayerGuildId(cid)
		if (self.numero_jogadores == 0 or table.elements(self.players[guildId]) < self.numero_jogadores) then
			doTeleportThing(cid, self.positions[guildId])
			table.insert(self.players[guildId], cid)
		else
			return false
		end
	doAddCondition(cid, condition_infight)
	setPlayerWarType(cid, self.modo)
	registerCreatureEvent(cid, "citywar")
	return true
end

function War:removePlayer(cid)
	--town = getPlayerTown(cid)
	--pos = getTownTemplePosition(town)		
			
	--doTeleportThing(cid, pos)
	
	setPlayerWarType(cid, 0)	
	unregisterCreatureEvent(cid, "citywar")

	tmp = false
	for guild, teams in pairs(self.players) do
		for k, v in pairs(teams) do
			if v == cid then
				self.players[guild][k] = nil
				tmp = true
				break
			end
		end
		if tmp == true then
			break
		end
	end
	doRemoveCondition(cid, CONDITION_INFIGHT)
	if getCreatureSkullType(cid) == SKULL_WHITE then
		doCreatureSetSkullType(cid, 0)
	end
end

function War:isGuildOnWar(guildId)
	if self.name[1][1] == guildId or self.name[2][1] == guildId then
		return true	
	end
		return false
end

function War:kill(killer, cid)
	self.frags[getPlayerGuildId(killer)] = self.frags[getPlayerGuildId(killer)] + 1
	self:broadcast(22, "[City War] \n".. getPlayerName(killer) .. " matou " .. getPlayerName(cid) .. ".\n" .. self:getPlacarString())
end

function War:getPlacarString()
	local text = "Placar: " .. self.name[1][2] .. " " .. self.frags[self.name[1][1]] .. " x "
	text = text .. self.frags[self.name[2][1]] .. " " .. self.name[2][2].."."	
	return text
end

function War:broadcast(messagetype, text)
	for k, v in pairs(self.players) do
		for _, cid in pairs(v) do
			if isPlayer(cid) then
				doPlayerSendTextMessage(cid, messagetype, text)
			end
		end
	end
end

function War:broadcastToGuilds(messagetype, text)
	local guilds = {self.name[1][1], self.name[2][1]}
	local isinarray, sendmessage, getguildid = isInArray, doPlayerSendTextMessage, getPlayerGuildId
	
	for k, v in pairs(getPlayersOnline()) do
		if isinarray(guilds, getguildid(v)) then
			sendmessage(v, messagetype, text)
		end
	end
end

-- função static, callback entre creaturescripts e o evento
function War.morte(cid, killer)
	for k,v in pairs(Wars) do
		if type(v) == 'table' then
			if v:isGuildOnWar(getPlayerGuildId(cid)) then
				v:kill(killer, cid)
				v:removePlayer(cid)
			end
		end
	end
	return true
end