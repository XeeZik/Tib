local posdotp8 = {x=33409, y=32280, z=14}

function MoveStone8() 
    local criistal9 = getTileItemById(posdotp8, 1353)  
    if not criistal9 then       
    doCreateItem(1353,1,posdotp8)
	else 
	doCreateItem(1353,1,posdotp8)
	end 
	return true
end

function RemoveStone8()
    local cristal8 = getTileItemById(posdotp8, 1353) -- Id of the blue crystal that disappears to give place to tp
    if cristal8 then
        doRemoveItem(cristal8.uid, 1)
    end
    return true
end

function onKill(cid, target, damage, flags, corpse)
	if(isMonster(target)) then
		if(string.lower(getCreatureName(target)) == "destabilized ferumbras") then
		    addEvent(RemoveStone8, 5 * 1000)
     	    addEvent(MoveStone8, 300 * 1000)
		end
	end
	return true
end

