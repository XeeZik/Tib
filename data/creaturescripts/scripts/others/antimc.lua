local config = {
        max = 3,
        text = "Not permited max of 3 players per IP.",
        group_id = 1,  -- Grupos que poderao ser kikados (1=Players, 2=tutor, 3=seniortutors, 4=Gm's, 5=Cm's and 6=God's
}
 
local accepted_ip_list = ""  -- Aqui voce poem os ips que serao aceitados a usar MC/Magebomb...
 
local function antiMC(p)
        if #getPlayersByIp(getPlayerIp(p.pid)) >= p.max then
                doRemoveCreature(p.pid)
        end
        return TRUE
end
 
function onLogin(cid)
        if getPlayerGroupId(cid) <= config.group_id then
                if isInArray(accepted_ip_list,getPlayerIp(cid)) == FALSE then
                        addEvent(antiMC, 1000, {pid = cid, max = config.max+1})
                        doPlayerPopupFYI(cid, config.text)
                end
        end
        return TRUE
end