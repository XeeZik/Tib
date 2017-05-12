local function givePlayerItem(player, item, slot)
	local ret = player:addItemEx(item, false, sot)
	if not ret then
		player:addItemEx(item, false, INDEX_WHEREEVER, 0)
	end
end

local function getFirstItems(player)
	local firstItems = {
		storage = 4687,

		slots = {
			[CONST_SLOT_HEAD] = Game.createItem(2461),
			[CONST_SLOT_ARMOR] = Game.createItem(2651),
			[CONST_SLOT_LEGS] = Game.createItem(2649),
			[CONST_SLOT_FEET] = Game.createItem(2643)
			--[CONST_SLOT_BACKPACK] = Game.createItem(1988)
		}
	}

	--[[ add backpack items here
	local backpack = firstItems.slots[CONST_SLOT_BACKPACK]
	backpack:addItem(ITEM_GOLD_COIN, 25)]]

	if player:getStorageValue(firstItems.storage) < 0 then
		for slot, item in pairs(firstItems.slots) do
			givePlayerItem(player, item, slot)
		end
		player:setStorageValue(firstItems.storage, 1)
	end
end

local function changeVocation(player, fromVocation, toVocation)
    local vocationsItems = {
        -- sorcerer
        [1] = {
            [CONST_SLOT_LEFT] = {23719, 1, true}, -- the scorcher
            [CONST_SLOT_RIGHT] = {2175, 1, true}, -- spellbook
			[11] = {8704, 2, false, limitStorage = 10030, limit = 1}, -- potion
			[12] = {7620, 10, false, limitStorage = 10031, limit = 1}, -- potion
			--[13] = {id, qtd, false, limitStorage = 10032, limit = 1}, -- 2 lightest missile runes
			--[14] = {id, qtd, false, limitStorage = 10033, limit = 1} -- 2 light stone shower runes
        },
        -- druid
        [2] = {
            [CONST_SLOT_LEFT] = {23721, 1, true}, -- the chiller
            [CONST_SLOT_RIGHT] = {2175, 1, true}, -- spellbook
			[11] = {8704, 2, false, limitStorage = 10034, limit = 1}, -- potion
			[12] = {7620, 10, false, limitStorage = 10035, limit = 1}, -- potion
			--[13] = {id, qtd, false, limitStorage = 10036, limit = 1}, -- 2 lightest missile runes
			--[14] = {id, qtd, false, limitStorage = 10037, limit = 1} -- 2 light stone shower runes
        },
        -- paladin
        [3] = {
            [CONST_SLOT_LEFT] = {2456, 1, true}, -- bow
            [CONST_SLOT_AMMO] = {23839, 100, true}, -- 100 arrows
            [11] = {8704, 7, false, limitStorage = 10038, limit = 1}, -- potion
			[12] = {7620, 5, false, limitStorage = 10039, limit = 1}, -- potion
			--[13] = {id, qtd, false, limitStorage = 10040, limit = 1}, -- 1 lightest missile rune
			--[14] = {id, qtd, false, limitStorage = 10041, limit = 1} -- 1 light stone shower rune
        },
        -- knight
        [4] = {
            [CONST_SLOT_LEFT] = {2379, 1, true}, -- dagger
            [CONST_SLOT_RIGHT] = {2512, 1, true}, -- wooden shield
			[11] = {8704, 10, false, limitStorage = 10042, limit = 1}, -- potion
			[12] = {7620, 2, false, limitStorage = 10043, limit = 1}, -- potion
			--[13] = {id, qtd, false, limitStorage = 10044, limit = 1}, -- 1 lightest missile rune
			--[14] = {id, qtd, false, limitStorage = 10045, limit = 1} -- 1 light stone shower rune
        }
    }
 
    local vocationsOutfits = {
        -- sorcerer
        [1] = {
            lookBody = 109,
            lookAddons = 0,
            lookTypeName = {Mage}, -- {male, female}
            lookTypeEx = 0,
            lookHead = 95,
            lookMount = 0,
            lookLegs = 112,
            lookFeet = 128
        },
        -- druid
        [2] = {
            lookBody = 123,
            lookAddons = 0,
            lookTypeName = {Mage}, -- {male, female}
            lookTypeEx = 0,
            lookHead = 95,
            lookMount = 0,
            lookLegs = 9,
            lookFeet = 118
        },
        -- paladin
        [3] = {
            lookBody = 117,
            lookAddons = 0,
            lookTypeName = {Hunter}, -- {male, female}
            lookTypeEx = 0,
            lookHead = 95,
            lookMount = 0,
            lookLegs = 98,
            lookFeet = 78
        },
        -- knight
        [4] = {
            lookBody = 38,
            lookAddons = 0,
            lookTypeName = {Knight}, -- {male, female}
            lookTypeEx = 0,
            lookHead = 95,
            lookMount = 0,
            lookLegs = 94,
            lookFeet = 115,
        }
    }
 
    for voc = 1, 4 do
        for slot, info in pairs(vocationsItems[voc]) do
            local itemCount = player:getItemCount(info[1])
            if itemCount > 0 and info[3] then
                player:removeItem(info[1], itemCount)
            end
        end
    end
 
    local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
    for slot, info in pairs(vocationsItems[toVocation]) do
        local extra
        if slot > CONST_SLOT_AMMO then
            extra = true
        else
            local equipped = player:getSlotItem(slot)
            if equipped then
                equipped:moveTo(backpack)
            end
        end
 
        local giveItem = true
        if info.limit and info.limitStorage then
            local given = math.max(player:getStorageValue(info.limitStorage), 0)
            if given >= info.limit then
                giveItem = false
            else
                player:setStorageValue(info.limitStorage, given + 1)
            end
        end
 
        if giveItem then
            if extra then
                player:addItemEx(Game.createItem(info[1], info[2]), false, INDEX_WHEREEVER, 0)
            else
                local ret = player:addItem(info[1], info[2], false, 1, slot)
                if not ret then
                    player:addItemEx(Game.createItem(info[1], info[2]), false, slot)
                end
            end
        end
    end
 
--[[    local outfit = vocationsOutfits[toVocation]
    player:setOutfit(
        {
            lookBody = outfit.lookBody,
            lookAddons = outfit.lookAddons,
            lookTypeName = outfit.lookTypeName,
            lookTypeEx = outfit.lookTypeEx,
            lookHead = outfit.lookHead,
            lookMount = outfit.lookMount,
            lookLegs = outfit.lookLegs,
            lookFeet = outfit.lookFeet,
        }
		)]]--
end

local centerPosition = Position(32065, 31891, 5)

function onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() then
        local player = Player(creature)
        local toVocation = Tile(position):getGround():getActionId() - 2000
        local fromVocation = player:getVocation():getId()
        if fromVocation ~= toVocation and (centerPosition:getDistance(fromPosition) < centerPosition:getDistance(position)) then
            getFirstItems(player)
			changeVocation(player, fromVocation, toVocation)
            player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
        end
    end
    return true
end
