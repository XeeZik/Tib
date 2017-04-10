local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local Topic, Town = {}, {}
function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)    npcHandler:onCreatureSay(cid, type, msg) end

function creatureSayCallback(cid, type, msg)
    if (msgcontains(msg, "hello") or msgcontains(msg, "hi")) and (not npcHandler:isFocused(cid)) then
        local player = Player(cid)
        local v, k = player:getVocation(), getCreatureName(cid)
        if v == 0 then
            npcHandler:say(getPlayerSex(cid) == 0 and "Well hello there, lovely lady! Can't sail you anywhere without a {vocation}, though. Y'should talk to the four vocation {masters} first, " .. k .. "." or "How cute, a freshly hatched newcomer. Harr. Can't leave this island without a {vocation}, y'know? Y'should talk to the four vocation {masters} first, " .. k.. ".", cid)
            Topic[cid] = 0
        else
            npcHandler:say("Harrr, a new " .. v:getName() .. "! Can't wait to get off this lousy island and head for adventure, eh? Want me to bring ya somewhere nice, I rlly recomend you thais cuz the king lives ther an also if u wanna hav' lot f fun, " .. k .. "?", cid)
            Topic[cid] = 1
        end
        Town[cid] = nil
        npcHandler:addFocus(cid)
    elseif(not npcHandler:isFocused(cid)) then
        return false
    elseif msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
        npcHandler:say("Hrrrm. Better y'stay here for a bit, aight.", cid, TRUE)
        Topic[cid] = nil
        Town[cid] = nil
        npcHandler:releaseFocus(cid)
    elseif Topic[cid] == 1 then
        if msgcontains(msg, "yes") then
            npcHandler:say("Take a hint from old Cap'n Kurt. Make sure y'dun leave here before yer equipped well. Ya went for rob- err, shopping and got stuff like rope, armor, and weap'n?", cid)
            Topic[cid] = 2
        elseif msgcontains(msg, "no") then
            npcHandler:say("Then what'd ya want? Learn about the main avalian city?", cid)
            Topic[cid] = 3
        else
            npcHandler:say("Kid, one thing y'should learn. Answer with {yes} or {no} and ya'll get much farther than with random babbling.", cid)
            Topic[cid] = 1
        end
    elseif Topic[cid] == 2 then
        if msgcontains(msg, "yes") then
            npcHandler:say("Harrharr. Good answer. Wanna know somethin' about the main Tibian cities before you choose yer new home?", cid)
            Topic[cid] = 3
        elseif msgcontains(msg, "no") then
            npcHandler:say("Then prepare yourself and come back later, eh?", cid)
            npcHandler:releaseFocus(cid)
            Topic[cid] = nil
        end
    elseif Topic[cid] == 3 then
        if msgcontains(msg, "yes") then
            npcHandler:say("Aye. Wanna know about {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Kazordoon}, {Liberty} {Bay}, {Port} {Hope}, {Svargrond}, {Thais}, {Venore} or {Yalahar}?", cid)
            Topic[cid] = 0
        elseif msgcontains(msg, "no") then
            npcHandler:say(isPremium(cid) and "So ya know it all, eh? Where'd ya want me to bring ya then, kid? {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} or {Venore}?" or "So ya know it all, eh? Where'd ya want me to bring ya then, kid? {Ab'Dendriel}, {Carlin}, {Thais} or {Venore}?", cid)
            Topic[cid] = 4
        end
    elseif Topic[cid] == 4 then
        if msgcontains(msg, "ab'Dendriel") then
            npcHandler:say("So it's Ab'Dendriel y'wanna live in? What y'say, {yes} or {no}?", cid)
            Topic[cid] = 5
            Town[cid] = "Ab'Dendriel"
        elseif msgcontains(msg, "Ankrahmun") then
            if isPremium(cid) then
                npcHandler:say("So it's Ankrahmun y'wanna live in? What y'say, {yes} or {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Ankrahmun'
            else
                npcHandler:say("Nope, can't bring y'there without a premium account. Y'should be glad you get to travel by ship, usually a premium service, too, y'know.", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "carlin") then
            npcHandler:say("So it's Carlin y'wanna live in? What y'say, {yes} or {no}?", cid)
            Topic[cid] = 5
            Town[cid] = 'Carlin'
        elseif msgcontains(msg, "darashia") then
            if isPremium(cid) then
                npcHandler:say("So it's Darashia y'wanna live in? What y'say, {yes} or {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Darashia'
            else
                npcHandler:say("Nope, can't bring y'there without a premium account. Y'should be glad you get to travel by ship, usually a premium service, too, y'know.", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "edron") then
            if isPremium(cid) then
                npcHandler:say("So it's Edron y'wanna live in? What y'say, {yes} or {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Edron'
            else
                npcHandler:say("Nope, can't bring y'there without a premium account. Y'should be glad you get to travel by ship, usually a premium service, too, y'know.", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "liberty bay") and msgcontains(msg, "sdfds") then
            if isPremium(cid) then
                npcHandler:say("So it's Liberty Bay y'wanna live in? What y'say, {yes} or {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Liberty Bay'
            else
                npcHandler:say("Nope, can't bring y'there without a premium account. Y'should be glad you get to travel by ship, usually a premium service, too, y'know.", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "port hope") and msgcontains(msg, "dasads") then
            if isPremium(cid) then
                npcHandler:say("So it's Port Hope y'wanna live in? What y'say, {yes} or {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Port Hope'
            else
                npcHandler:say("Nope, can't bring y'there without a premium account. Y'should be glad you get to travel by ship, usually a premium service, too, y'know.", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "thais") then
            npcHandler:say("So it's Thais y'wanna live in? What y'say, {yes} or {no}?", cid)
            Topic[cid] = 5
            Town[cid] = 'Thais'
        elseif msgcontains(msg, "venore") then
            npcHandler:say("So it's Venore y'wanna live in? What y'say, {yes} or {no}?", cid)
            Topic[cid] = 5
            Town[cid] = 'Venore'
        else
            npcHandler:say("Nope, wha'ever that is, I dun sail there. ".. isPremium(cid) and "{Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} or {Venore}" or "{Ab'Dendriel}, {Carlin}, {Thais} or {Venore}" .."?", cid)
            Topic[cid] = 5
        end
    elseif msgcontains(msg, "passage") or msgcontains(msg, "sail") or msgcontains(msg, "travel") then
        if getPlayerVocation(cid) == 0 then
            npcHandler:say("Nope, yer not going anywhere. Can't transport ya without a {vocation}, y'know?", cid)
            Topic[cid] = 0
        else
            npcHandler:say("So, y'chose your new home city? Which one's it gonna be?", cid)
            Topic[cid] = 4
        end
    elseif Topic[cid] == 5 then
        if msgcontains(msg, 'yes') then
            npcHandler:say("And off we go! If yer lost, dun forget t'talk to the guide on the ship!", cid)
            local v = getTownId(Town[cid])
            npcHandler:releaseFocus(cid)
            doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
            doTeleportThing(cid, getTownTemplePosition(v))
            doSendMagicEffect(getTownTemplePosition(v), CONST_ME_TELEPORT)
            doPlayerSetTown(cid, v)
            Topic[cid] = nil
        else
            npcHandler:say("Changed yer mind? What city d'ya wanna head to, {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} or {Venore}?", cid)
        end
 
        Topic[cid] = 0
    elseif msgcontains(msg, "venore") then
        npcHandler:say("Old-school city. Actually the oldest main city in Tibia. Be careful on those streets, there're bandits everywhere. I can {sail} there if ya like.", cid)
   
    end
    return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_WALKAWAY, "Hrrrrm. And a good day to you, too!")
