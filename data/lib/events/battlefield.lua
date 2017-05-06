if not Battlefield then
	Battlefield = {
		open = false,

		wall = {
			id = 1353,

			pos = {
				Position(31419, 32508, 7),
				Position(31419, 32509, 7),
				Position(31419, 32510, 7),
				Position(31419, 32511, 7)
			}
		},

		rewards = {
			-- {itemid, quantity}
			{21399, 1},
		},

		minLevel = 100,
		minPlayers = 2, --min players to start event
		maxPlayers = 20, --max players in the event
		players = {},

		exit = Position(32369, 32241, 7), --temple

		teleport = {
			pos = Position(32365, 32236, 7),
			aid = 45000
		},

		teams = {
			[1] = {
				name = 'Purple',

				outfit = {
					lookType = 138,
					lookAddons = 0,
					lookHead = 109,
					lookLegs = 109,
					lookBody = 109,
					lookFeet = 109,
				},

				position = Position(31402, 32504, 7),

				players = {}, 
				kills = 0,
				size = 0,
			},

			[2] = {
				name = 'Green',

				outfit = {
					lookType = 138,
					lookAddons = 0,
					lookHead = 82,
					lookLegs = 82,
					lookBody = 82,
					lookFeet = 82,
				},

				position = Position(31436, 32504, 7),

				players = {}, 
				kills = 0,
				size = 0,
			},				
		},

		addPlayer = function (self, cid)
            local player = Player(cid)
            if player then
                self.players[player:getId()] = 1
            end
        end,

        removePlayer = function (self, cid)
            local player = Player(cid)
            if self.players[player:getId()] then
                self.players[player:getId()] = nil
            end
        end,

        getPlayers = function (self)
            return self.players
        end,

        getPlayer = function (self, cid)
            local player = Player(cid)
            if self.players[player:getId()] then
                return true
            else
                return false
            end
        end,

        getPlayersCount = function (self)
            local c = 0
            for _ in pairs(self.players) do c = c + 1 end
            return c
        end
	}

	function Battlefield:Open()
		if self.open then return false end
		self.open = true
		if Battlefield:getPlayersCount() < Battlefield.minPlayers then
			Battlefield:Close()
			return true
		end

		for i = 1, #Battlefield.wall.pos do
			local tile = Tile(Battlefield.wall.pos[i])
			if tile then
				local item = tile:getItemById(Battlefield.wall.id)
				if item then item:remove() end
			end
		end
		return true
	end

	function Battlefield:Close(winner)
		if not self.open then return false end
		self.open = false
		for i = 1, #Battlefield.wall.pos do
			local tile = Tile(Battlefield.wall.pos[i])
			if tile then
				local item = tile:getItemById(Battlefield.wall.id)
				if not item then 
					Game.createItem(Battlefield.wall.id, 1)
				end
			end
		end

		if not winner then
			if self.teams[1].kills > self.teams[2].kills then
				winner = 1
			elseif self.teams[1].kills < self.teams[2].kills then
				winner = 2
			end
		end

		if winner then
			Game.broadcastMessage(string.format("Team %s win the BattleField Event!", self.teams[winner].name))
		else
			Game.broadcastMessage("There was a tie and nobody wins reward.")
		end

		for _, team in ipairs(self.teams) do
			for name, info in pairs(team.players) do
				local player = Player(name)
				if player then
					self:onLeave(player)
					if _ == winner then
						for k, item in ipairs(self.rewards) do
							player:addItem(item[1], item[2])
						end
					end
				end
			end
		end
		self.teams[1].players = {}
		self.teams[1].size = 0
		self.teams[1].kills = 0
		self.teams[2].players = {}
		self.teams[2].size = 0
		self.teams[2].kills = 0	
		return true
	end

	function Battlefield:findPlayer(player)
		local name = player:getName()
		return self.teams[1].players[name] or self.teams[2].players[name]
	end

	function Battlefield:onJoin(player)local team
		if self.teams[1].size == self.teams[2].size then
			team = math.random(1, 2)
		elseif self.teams[1].size > self.teams[2].size then
			team = 2
		else
			team = 1
		end

		player:setOutfit(self.teams[team].outfit)
		player:teleportTo(self.teams[team].position)

		local info = {name = player:getName(), team = team}
		self.teams[team].size = self.teams[team].size + 1
		self.teams[team].players[player:getName()] = info
		Battlefield:addPlayer(player)

		Game.broadcastMessage(string.format("%s entered the BattleField Event!", info.name))

		player:registerEvent("BFPrepareDeath")
		player:registerEvent("BFHealthChange")
		player:registerEvent("BFManaChange")
		player:registerEvent("BFLogout")

		return true
	end

	function Battlefield:onLeave(player)
		local info = self:findPlayer(player)
		if not info then return false end
		player:unregisterEvent("BFHealthChange")
		player:unregisterEvent("BFPrepareDeath")
		player:unregisterEvent("BFManaChange")
		player:unregisterEvent("BFLogout")

		Game.broadcastMessage(string.format("%s left the BattleField Event!", info.name))

		player:teleportTo(self.exit)
		self.teams[info.team].size = self.teams[info.team].size - 1
		self.teams[info.team].players[info.name] = nil

		player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
		player:removeCondition(CONDITION_INFIGHT)
		Battlefield:removePlayer(player)

		if self.teams[info.team].size == 0 then
			self:Close(info.team == 1 and 2 or 1)			
		end
		return true
	end

	function Battlefield:onDeath(player, killer)
		local info = self:findPlayer(player)
		if not info then return false end
		if killer and killer.getName then
			local killerInfo = self:findPlayer(killer)
			if killerInfo and killerInfo.team ~= info.team then
				local killerTeam = self.teams[killerInfo.team]
				killerTeam.kills = killerTeam.kills + 1
			end
		end
		self:onLeave(player)
		return true
	end

	function createPortal(pos, effect, aid)
		local tile = Tile(pos)
		if tile then
			local tp = tile:getItemById(1387)
			if tp == nil then
				local t = Game.createItem(1387, 1)
				t:setAttribute(ITEM_ATTRIBUTE_ACTIONID, aid)
				pos:sendMagicEffect(effect)
			end
		end
	end

	function removePortal(pos, effect)
		local tile = Tile(pos)
		if tile then
			local tp = tile:getItemById(1387)
			if tp then
				tp:remove()
			end
		end
	end
end