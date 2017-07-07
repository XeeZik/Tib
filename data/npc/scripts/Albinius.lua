local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Walk in the light of Shaper wisdom!'},
	{ text = 'Welcome, my child.' },
	{ text = 'Our ways are the ways of the Shapers.' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)

       if msgcontains(msg, "shaper") then
				npcHandler:say({
				"The {Shapers} were an advanced civilisation, well versed in art, construction, language and exploration of our world in their time. ...",
				"The foundations of this temple are testament to their genius and advanced understanding of complex problems. They were master craftsmen and excelled in magic."
			}, cid)
			end

if msgcontains(msg, "tomes") then
	  npcHandler:say("I you have some old shaper tomes I would {buy} them.", cid)
end

	if msgcontains(msg, "temple") then
		npcHandler:say(" The temple has been restored to its former glory, yet we strife to live and praise in the {Shaper} ways. Do you still need me to take some old {tomes} from you my child?", cid)
		npcHandler.topic[cid] = 10
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 10 then
		if player:removeItem(26642,5) then
			npcHandler:say("Thank you very much for your contributions, child. Your first step in the ways of the {Shapers} has been taken.", cid)
		else
			npcHandler:say("Oh, well I am sorry but without any {Shaper} wisdom to contribute to our community, there is not much you can do to help us. To support us, aquire some {tomes} the Shapers left behind.", cid)
		end
		npcHandler.topic[cid] = 0
	   end
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I find ways to unveil the secrets of the stars. Judging by this question, I doubt you follow my weekly publications concerning this research."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Greetings, pilgrim. Welcome to the halls of hope. We are the keepers of this {temple} and welcome everyone willing to contribute.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, my child")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, my child")
npcHandler:addModule(FocusModule:new())
