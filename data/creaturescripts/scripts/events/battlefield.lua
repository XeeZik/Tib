function onLogin(cid)
registerCreatureEvent(cid, "BattleTeam")
registerCreatureEvent(cid, "BattleDeath")
if getGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage) == -1 then
setGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage, 0)
setGlobalStorageValue(_Lib_Battle_Info.TeamTwo.storage, 0)
setGlobalStorageValue(_Lib_Battle_Info.storage_count, 0)
end
if getPlayerStorageValue(cid,_Lib_Battle_Info.TeamOne.storage) >= 1 or getPlayerStorageValue(cid,_Lib_Battle_Info.TeamTwo.storage) >= 1 then
setPlayerStorageValue(cid, _Lib_Battle_Info.TeamOne.storage, -1)
setPlayerStorageValue(cid, _Lib_Battle_Info.TeamTwo.storage, -1)
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
end
return true
end
function onCombat(cid, target)
if isPlayer(cid) and isPlayer(target) then
if getPlayerStorageValue(cid,_Lib_Battle_Info.TeamOne.storage) >= 1 and getPlayerStorageValue(target,_Lib_Battle_Info.TeamOne.storage) >= 1 or getPlayerStorageValue(cid,_Lib_Battle_Info.TeamTwo.storage) >= 1 and getPlayerStorageValue(target,_Lib_Battle_Info.TeamTwo.storage) >= 1 then 
return false
end
return true
end
return true
end
function onPrepareDeath(cid, deathList, lastHitKiller, mostDamageKiller)
if isPlayer(cid) and getPlayerStorageValue(cid,_Lib_Battle_Info.TeamOne.storage) >= 1 or getPlayerStorageValue(cid,_Lib_Battle_Info.TeamTwo.storage) >= 1 then
local MyTeam = getPlayerStorageValue(cid,_Lib_Battle_Info.TeamOne.storage) >= 1 and _Lib_Battle_Info.TeamOne.storage or _Lib_Battle_Info.TeamTwo.storage
local EnemyTeam = getPlayerStorageValue(cid,_Lib_Battle_Info.TeamOne.storage) >= 1 and _Lib_Battle_Info.TeamTwo.storage or _Lib_Battle_Info.TeamOne.storage
setGlobalStorageValue(MyTeam, (getGlobalStorageValue(MyTeam)-1))
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "[Battle Field] You Are Dead!")
setPlayerStorageValue(cid, MyTeam, -1)
doRemoveCondition(cid, CONDITION_OUTFIT)
if getGlobalStorageValue(MyTeam) == 0 then
getWinnersBattle(EnemyTeam)
else
doBroadCastBattle(23,"[BattleField Information] ".._Lib_Battle_Info.TeamOne.name.." "..getGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage).." VS "..getGlobalStorageValue(_Lib_Battle_Info.TeamTwo.storage).." " .._Lib_Battle_Info.TeamTwo.name)
end
end
return true
end