local function warnEvent(i)
	Game.broadcastMessage("Battlefield event was opened, a teleport was created in the Event Room (entrance through Temple of Thais)!")
	if i > 1 then addEvent(warnEvent, 2 * 60 * 1000, i - 1) end
end

local function openBattlefield()
	Battlefield:Open()
end

local function closeBattlefield()
	Battlefield:Close()
end

function onTime(interval)
	Game.broadcastMessage("Teleport for The BattleField Event was created in Event Room, you have 10 minutes for join if you want.")
	createPortal(Battlefield.teleport.pos, 16, Battlefield.teleport.aid)
	addEvent(warnEvent, 2 * 60 * 1000, 4)
	addEvent(removePortal, 10 * 60 * 1000, Battlefield.teleport.pos, 16)
	addEvent(openBattlefield, 10 * 60 * 1000)
	addEvent(closeBattlefield, 25 * 60 * 1000)
	return true
end
