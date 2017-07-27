function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
local LEFT_TIME = getPlayerStorageValue(cid, 25002) - os.time() -- dont change
local UID_TELEPORT = 8003 -- uid from teleport, dont change

    if item.uid == UID_TELEPORT and item.actionid == 8000 then
          if LEFT_TIME <= 1 then
            doTeleportThing(cid, {x = 33639, y = 31233, z = 11}) -- enter coord
            doSendMagicEffect({x = 33639, y = 31233, z = 11}, CONST_ME_TELEPORT)
          else
            doTeleportThing(cid, {x = 33645, y = 31263, z = 11}) -- exit coord
            doSendMagicEffect({x = 33645, y = 31263, z = 11}, CONST_ME_TELEPORT)
              doCreatureSay(cid, "Do You still need to wait " .. LEFT_TIME .. " seconds to enter.", TALKTYPE_ORANGE_1)
        end
        end
     
     --   if item.uid == UID_TELEPORT and item.actionid == 8000 then
      --          doTeleportThing(cid, {x = 33645, y = 31263, z = 11}) -- exit coord
      --  doSendMagicEffect({x = 33645, y = 31263, z = 11}, CONST_ME_TELEPORT)
      --  doCreatureSay(cid, "It can only be accessed once per day and it has been accessed today.", TALKTYPE_ORANGE_1)
   -- end

    return true
end