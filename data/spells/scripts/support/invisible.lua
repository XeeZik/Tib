local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_INVISIBLE)
condition:setParameter(CONDITION_PARAM_TICKS, 200000)
combat:setCondition(condition)

function onCastSpell(creature, variant)
if (getPlayerStorageValue(cid, _CTF_LIB.teamssto) > 0) then
return doPlayerSendCancel(cid, "Você não pode usar invisible durante o CTF!") and doSendMagicEffect(getThingPos(cid), 2)
end
	return combat:execute(creature, variant)
end
