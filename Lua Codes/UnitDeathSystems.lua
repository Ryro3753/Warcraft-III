function unitDiesAssign()
    local id = getUnitTypeStatId(udg_Registered_Unit)
    udg_Gold_System_Unit_Gold[udg_Register_ID] = udg_Gold_System_Units_Gold[id]
    udg_EXP_System_Unit_EXP[udg_Register_ID] = udg_EXP_System_Units_EXP[id]
    udg_EXP_System_Unit_Current_EXP[udg_Register_ID] = 0

    local lootTableId = getUnitLootTableId(udg_Registered_Unit)
    if lootTableId ~= 0 then
        udg_LootTable_AssignedId[udg_Register_ID] = lootTableId
    end

end

function getUnitLootTableId(unit)
    local unitType = GetUnitTypeId(unit)

    for i=1,udg_LootTable_Limit do
        if udg_LootTable_UnitType[i * 20 + 1] == unitType then
            unitType = nil
            return i * 20 + 1
        end
    end

    unitType = nil
    return 0
end

function unitDies()
    local killerUnit = GetKillingUnit()
    local killerPlayer = GetOwningPlayer(killerUnit)

    --Revive
    local reviveHappend = unitDiesHeroRevive()
    if reviveHappend then
        killerUnit = nil
        killerPlayer = nil
        return
    end

    if IsPlayerInForce(killerPlayer, udg_Player_PlayerGroup) == false then
        killerUnit = nil
        killerPlayer = nil
        return
    end

    --Experience
    unitDiesExperience()

    --Gold
    unitDiesGold()

    --Loot Table
    unitDiesLootTable()
    
end

function unitDiesHeroRevive()
    local unit = GetTriggerUnit()
    local player = GetOwningPlayer(unit)
    local rbool = false;

    if IsUnitType(unit, UNIT_TYPE_HERO) and IsPlayerInForce(player, udg_Player_PlayerGroup) then
        DisplayTextToPlayer(player, 0, 0, "You will be revived in 10 second")
        TriggerSleepAction(10)
        local loc = GetRectCenter(udg_Hero_Selection_Create_Region)
        ReviveHeroLoc(unit, loc, true)
        PanCameraToTimedLocForPlayer(player, loc, 0.5)
        RemoveLocation(loc)
        loc = nil
        rbool = true;
    end

    unit = nil
    player = nil
    return rbool
end


function unitDiesExperience()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)

    if udg_EXP_System_Unit_EXP[id] == 0 then
        unit = nil
        return
    end

    local loc = GetUnitLoc(unit)
    local group = GetUnitsInRangeOfLocMatching(udg_EXP_System_Share_Area, loc, Condition(unitDiesCondition))

    udg_EXP_System_Unit = unit
    ForGroup(group, unitDiesExperienceLoop)
    udg_EXP_System_Unit = nil
    DestroyGroup(group)
    RemoveLocation(loc)

    unit = nil
    group = nil
    loc = nil
end

function unitDiesCondition()
    if IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), udg_Player_PlayerGroup) == true and 
    IsUnitAliveBJ(GetFilterUnit()) == true and
    IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and
    IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit()))
    then
        return true 
     else
         return false
     end
end

function unitDiesExperienceLoop()
    local unit = GetEnumUnit()
    local targetId = GetUnitUserData(udg_EXP_System_Unit)
    local targetLevel = GetUnitLevel(udg_EXP_System_Unit)
    local exp = udg_EXP_System_Unit_EXP[targetId]

    giveEXPToUnit(unit,exp, targetLevel)
    
    unit = nil
end

function unitDiesGold()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)

    if udg_Gold_System_Unit_Gold[id] == 0 then
        unit = nil
        return
    end
    
    local loc = GetUnitLoc(unit)
    local group = GetUnitsInRangeOfLocMatching(udg_Gold_System_Share_Area, loc, Condition(unitDiesCondition))

    PlaySoundAtPointBJ(gg_snd_ReceiveGold, 30.00, loc, 0)

    udg_Gold_System_Gold = udg_Gold_System_Unit_Gold[id]
    ForGroup(group, unitDiesGoldLoop)
    udg_Gold_System_Gold = nil
    DestroyGroup(group)
    RemoveLocation(loc)

    unit = nil
    group = nil
    loc = nil
end

function unitDiesGoldLoop()
    local unit = GetEnumUnit()
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player) + 1

    AdjustPlayerStateBJ(udg_Gold_System_Gold, player, PLAYER_STATE_RESOURCE_GOLD)

    if udg_Settings_ShowGold[playerId] == 1 then
        ForceAddPlayer(udg_FloatingText_PlayerGroup, player)
        creatingFloatingTextTimed("+" .. tostring(udg_Gold_System_Gold) .. "G", unit, 6.5, 90, 90, 30)
    elseif udg_Settings_ShowGold[playerId] == 2 then
        DisplayTextToPlayer(player, 0, 0, "|cffE6E64D+" .. tostring(udg_Gold_System_Gold) .. "|r Gold Earned")
    end

    unit = nil
    player = nil
end


function giveEXPToUnit(unit, exp, targetLevel)
    local level = GetUnitLevel(unit)
    if level >= udg_EXP_System_Max_Level then
        unit = nil
        return
    end
    local ratio = 1.0 + ((targetLevel - level) * udg_EXP_System_Level_Diff_Ratio)
    if ratio > udg_EXP_System_Level_Ratio_Max then
        ratio = udg_EXP_System_Level_Ratio_Max
    elseif 0 > ratio then
        ratio = 0
    end

    exp = R2I(exp * ratio)

    local player = GetOwningPlayer(unit)
    local id = GetUnitUserData(unit)

    udg_EXP_System_Unit_Current_EXP[id] = udg_EXP_System_Unit_Current_EXP[id] + exp
    local showText = true

    --Check if unit leveled up with new exp
    if udg_EXP_System_Unit_Current_EXP[id] >= udg_EXP_System_Required_Values[level] then
        udg_EXP_System_Unit_Current_EXP[id] = udg_EXP_System_Unit_Current_EXP[id] - udg_EXP_System_Required_Values[level]
        level = level + 1
        createSpecialEffectOnUnit(unit, 'Abilities\\Spells\\Other\\Levelup\\Levelupcaster.mdx')
        unitLevelsUp(unit)
        showText = false
    end

    local percentage = udg_EXP_System_Unit_Current_EXP[id] / udg_EXP_System_Required_Values[level] * 100
    local total = R2I(((level- 1) * 100) + percentage)
    SetHeroXP(unit, total, false)

    
    if showText == true then
        local playerId = GetPlayerId(player) + 1
        if udg_Settings_ShowEXP[playerId] == 1 then
            ForceAddPlayer(udg_FloatingText_PlayerGroup, player)
            creatingFloatingTextTimed("+" .. tostring(exp) .. " Exp", unit, 6.5, 60, 60, 100)
        elseif udg_Settings_ShowEXP[playerId] == 2 then
            DisplayTextToPlayer(player, 0, 0, "|cff9999FF+" .. tostring(exp) .. "|r Exp Earned")
        end
    else
        for i=1,5 do
            ForceAddPlayer(udg_FloatingText_PlayerGroup, Player(i - 1))
        end
        creatingFloatingTextTimed('Ding!', unit, 20, 90, 90, 0)
    end

    player = nil
end

function unitDiesLootTable()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local lootTableId = udg_LootTable_AssignedId[id]

    if lootTableId == 0 or lootTableId == nil then
        unit = nil
        id = nil
        lootTableId = nil
        return
    end

    --Type 1
    if udg_LootTable_LootType[lootTableId] == 1 then
        local rand = GetRandomReal(0, 100)
        local sumPercentage = 0

        for i=1,20 do
            if udg_LootTable_Detail_Percentage[lootTableId + i - 1] == 0 or udg_LootTable_Detail_Percentage[lootTableId + i - 1] == nil then
                unit = nil
                return
            end

            sumPercentage = sumPercentage + udg_LootTable_Detail_Percentage[lootTableId + i - 1]
            if sumPercentage > rand then
                unitDiesLootTableCreateItem(lootTableId + i - 1, unit)

                return
            end
        end

    --Type 2
    elseif udg_LootTable_LootType[lootTableId] == 2 then
        for i=1,20 do
            if udg_LootTable_Detail_Percentage[lootTableId + i - 1] == 0 or udg_LootTable_Detail_Percentage[lootTableId + i - 1] == nil then
                unit = nil
                return
            end
            local rand = GetRandomReal(0, 100)
            if udg_LootTable_Detail_Percentage[lootTableId + i - 1] > rand then
                unitDiesLootTableCreateItem(lootTableId + i - 1, unit)
            end
            rand = nil
        end
        return

    --Type 3
    elseif udg_LootTable_LootType[lootTableId] == 3 then
        local dropCount = GetRandomInt(udg_LootTable_DropMin[lootTableId], udg_LootTable_DropMax[lootTableId])
        local maxReal = 100
        local droppedItems = {}
        for q=1,dropCount do
            local rand = GetRandomReal(0, maxReal)
            local sumPercentage = 0
            local isDropped = false

            for i=1,20 do
                if isDropped == false and udg_LootTable_Detail_Percentage[lootTableId + i - 1] ~= 0 and udg_LootTable_Detail_Percentage[lootTableId + i - 1] ~= nil then
                    if arrayHasValue(droppedItems, i) == false then
                        sumPercentage = sumPercentage + udg_LootTable_Detail_Percentage[lootTableId + i - 1]
                        if sumPercentage > rand then
                            unitDiesLootTableCreateItem(lootTableId + i - 1, unit)
                            maxReal = maxReal - udg_LootTable_Detail_Percentage[lootTableId + i - 1]
                            isDropped = true
                            droppedItems[q] = i
                        end
                    end
                end
            end
        end
        droppedItems = nil


    --Type 4
    elseif udg_LootTable_LootType[lootTableId] == 4 then
        local groupCount = 0
        for i=1,20 do
            if udg_LootTable_Detail_Percentage[lootTableId + i - 1] ~= 0 and udg_LootTable_Detail_Percentage[lootTableId + i - 1] ~= nil then
                groupCount = math.max(groupCount, udg_LootTable_Detail_Group[lootTableId + i - 1])
            end
        end

        for g=1,groupCount do
            local rand = GetRandomReal(0, 100)
            local sumPercentage = 0
            local isDropped = false
            
            for i=1,20 do
                if udg_LootTable_Detail_Group[lootTableId + i - 1] == g and
                isDropped ~= true and
                udg_LootTable_Detail_Percentage[lootTableId + i - 1] ~= 0 and
                udg_LootTable_Detail_Percentage[lootTableId + i - 1] ~= nil then

                    sumPercentage = sumPercentage + udg_LootTable_Detail_Percentage[lootTableId + i - 1]
                    if sumPercentage > rand then
                        unitDiesLootTableCreateItem(lootTableId + i - 1, unit)
                        isDropped = true
                    end
                end
            end

        end

    end

end

function unitDiesLootTableCreateItem(id, unit)
    local loc = GetUnitLoc(unit)
    local itemLoc = PolarProjectionBJ(loc, GetRandomReal(0, 100), GetRandomReal(0, 360))
    CreateItemLoc(udg_LootTable_Detail_ItemType[id], itemLoc)
    RemoveLocation(loc)
    RemoveLocation(itemLoc)

    local itemId = getItemId(udg_LootTable_Detail_ItemType[id])
    if udg_ITEM_Rarity[itemId] == "Uncommon" or  udg_ITEM_Rarity[itemId] == "Rare" or udg_ITEM_Rarity[itemId] == "Epic" then
        DisplayTextToForce(udg_Player_PlayerGroup, GetItemName(GetLastCreatedItem()) .. " dropped from " .. GetUnitName(unit))
    end

    itemId = nil
    loc = nil
    itemLoc = nil
end