local sr_exhaust = {}
local sr_exhaust_time = 1 -- em segundos
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  local name = player:getName()
  if isHotkey or fromPosition.x == CONTAINER_POSITION and fromPosition.y == 9 then
  if not sr_exhaust[name] or sr_exhaust[name] <= os.time() then
	local position = player:getPosition()
		position:sendMagicEffect(CONST_ME_HEARTS)
	end
	 sr_exhaust[name] = os.time() + sr_exhaust_time
  end

	return true
end
