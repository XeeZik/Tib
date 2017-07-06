function getAccountNumberByPlayerName(name)
	local player = Player(name)
	if player ~= nil then
		return player:getAccountId()
	end

	local resultId = db.storeQuery("SELECT `account_id` FROM `players` WHERE `name` = " .. db.escapeString(name))
	if resultId ~= false then
		local accountId = result.getNumber(resultId, "account_id")
		result.free(resultId)
		return accountId
	end
	return 0
end

function getMoneyCount(string)
	local b, e = string:find("%d+")
	local money = b and e and tonumber(string:sub(b, e)) or -1
	if isValidMoney(money) then
		return money
	end
	return -1
end

function getMoneyWeight(money)
	local gold = money
	local crystal = math.floor(gold / 10000)
	gold = gold - crystal * 10000
	local platinum = math.floor(gold / 100)
	gold = gold - platinum * 100
	return (ItemType(2160):getWeight() * crystal) + (ItemType(2152):getWeight() * platinum) + (ItemType(2148):getWeight() * gold)
end

function getRealDate()
	local month = tonumber(os.date("%m", os.time()))
	local day = tonumber(os.date("%d", os.time()))

	if month < 10 then
		month = '0' .. month
	end
	if day < 10 then
		day = '0' .. day
	end
	return day .. '/' .. month
end

function getRealTime()
	local hours = tonumber(os.date("%H", os.time()))
	local minutes = tonumber(os.date("%M", os.time()))

	if hours < 10 then
		hours = '0' .. hours
	end
	if minutes < 10 then
		minutes = '0' .. minutes
	end
	return hours .. ':' .. minutes
end

function isValidMoney(money)
	return isNumber(money) and money > 0 and money < 4294967296
end

function iterateArea(func, from, to)
	for z = from.z, to.z do
		for y = from.y, to.y do
			for x = from.x, to.x do
				func(Position(x, y, z))
			end
		end
	end
end

function playerExists(name)
	local resultId = db.storeQuery('SELECT `name` FROM `players` WHERE `name` = ' .. db.escapeString(name))
	if resultId then
		result.free(resultId)
		return true
	end
	return false
end

WAR_TYPE_STORAGE = 22222

function isGuildLeader(cid)
	return getPlayerGuildLevel(cid) == GUILDLEVEL_LEADER
end

function isInAnyArray(array, value)
	if not type(array) == 'table' then
		return false
	end
	for k, v in pairs(array) do
		if type(v) == 'table' then
			ret = isInAnyArray(v, value)
			if ret ~= false then
				return true, k
			end
		else
			if v == value then
				return true, k
			end
		end
	end
	return false
end

function setPlayerWarType(cid, value)
	return doCreatureSetStorage(cid, WAR_TYPE_STORAGE, value)
end

function getPlayerWarType(cid)
	return getCreatureStorage(cid, WAR_TYPE_STORAGE)
end

function isGuildAntiEntrosa(guildId)
if not type(guildId) == 'number' then
	return false
end
	for _, v in pairs(Wars) do
		if type(v) == "table" then
			if v:isGuildOnWar(guildId) then
				return true
			end
		end
	end
	return false
end

function table.elements(tabela)
local i = 0
	for _,v in pairs(tabela) do
		if v ~= nil then
			i = i + 1
		end
	end
	return i
end