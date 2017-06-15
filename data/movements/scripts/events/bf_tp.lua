local conditionBlack = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionBlack, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionBlack, {lookType = 134, lookHead = 114, lookBody = 114, lookLegs = 114, lookFeet = 114})
local conditionRed = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionRed, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionRed, {lookType = 143, lookHead = 94, lookBody = 94, lookLegs = 94, lookFeet = 94})
function onStepIn(cid, item, position, fromPosition)
if not isPlayer(cid) then return true end
if getPlayerAccess(cid) > 3 then
return doTeleportThing(cid, _Lib_Battle_Info.TeamOne.pos)
end
if getGlobalStorageValue(_Lib_Battle_Info.storage_count) > 0 then
local getMyTeam = getGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage) < getGlobalStorageValue(_Lib_Battle_Info.TeamTwo.storage) and {_Lib_Battle_Info.TeamOne.storage,_Lib_Battle_Info.TeamOne.pos,_Lib_Battle_Info.TeamOne.name,conditionBlack}  or {_Lib_Battle_Info.TeamTwo.storage,_Lib_Battle_Info.TeamTwo.pos, _Lib_Battle_Info.TeamTwo.name, conditionRed}
doAddCondition(cid, getMyTeam[4])
setPlayerStorageValue(cid,getMyTeam[1], 1)
setGlobalStorageValue(getMyTeam[1], getGlobalStorageValue(getMyTeam[1])+1)
doTeleportThing(cid, getMyTeam[2])
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You will join the team " .. getMyTeam[3] .. "!")
setGlobalStorageValue(_Lib_Battle_Info.storage_count, getGlobalStorageValue(_Lib_Battle_Info.storage_count)-1)
end
if getGlobalStorageValue(_Lib_Battle_Info.storage_count) == 0 then
removeBattleTp()
doBroadcastMessage("Battlefield will start in 2 minutes, please create your strategy!")
addEvent(doBroadcastMessage, 2*60*1000-500, "BattleField will begin now!")
addEvent(OpenWallBattle, 2*60*1000)
end
return true
end