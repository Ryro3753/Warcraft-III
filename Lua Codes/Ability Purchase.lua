function abilityPurchaseInit()
    for i=1,5 do
        udg_AbilityQ[i] = 'AEEE'
        udg_AbilityW[i] = 'AEEE'
        udg_AbilityE[i] = 'AEEE'
        udg_AbilityR[i] = 'AEEE'
        udg_AbilityF[i] = 'AEEE'
        udg_AbilityG[i] = 'AEEE'
    end
    udg_Ability_Nil = 'AEEE'

    udg_Ability_Forget_Item_Type[1] = FourCC('IQQQ')
    udg_Ability_Forget_Item_Type[2] = FourCC('IWWW')
    udg_Ability_Forget_Item_Type[3] = FourCC('IEEE')
    udg_Ability_Forget_Item_Type[4] = FourCC('IRRR')
    udg_Ability_Forget_Item_Type[5] = FourCC('IFFF')
    udg_Ability_Forget_Item_Type[6] = FourCC('IGGG')
    udg_Ability_Forget_Item_Type[7] = FourCC('IAAA')
end


function getSpellIdByItemType(itemType)
    for i=1,udg_Ability_Purchase_Limit do
        if udg_Ability_Purchase_ItemType[i * 20 + 1] == itemType then
            return i * 20 + 1
        end
    end

    return 0
end

function getSpellIdBySpell(spell)
    for i=1,udg_Ability_Purchase_Limit do
        if udg_Ability_Purchase_AbilityQ[i * 20 + 1] == spell or
        udg_Ability_Purchase_AbilityW[i * 20 + 1] == spell or
        udg_Ability_Purchase_AbilityE[i * 20 + 1] == spell or
        udg_Ability_Purchase_AbilityR[i * 20 + 1] == spell or
        udg_Ability_Purchase_AbilityF[i * 20 + 1] == spell or
        udg_Ability_Purchase_AbilityG[i * 20 + 1] == spell
        then
            return i * 20 + 1
        end
    end
end

function getCurrentSpellLevel(unit, spellId)
    if GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityQ[spellId]) > 0 then
        return GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityQ[spellId])
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityW[spellId]) > 0 then
        return GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityW[spellId])
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityE[spellId]) > 0 then
        return GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityE[spellId])
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityR[spellId]) > 0 then
        return GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityR[spellId])
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityF[spellId]) > 0 then
        return GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityF[spellId])
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityG[spellId]) > 0 then
        return GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityG[spellId])
    end
    return 0
end


function getCurrentSpell(unit, spellId)
    if GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityQ[spellId]) > 0 then
        return udg_Ability_Purchase_AbilityQ[spellId]
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityW[spellId]) > 0 then
        return udg_Ability_Purchase_AbilityW[spellId]
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityE[spellId]) > 0 then
        return udg_Ability_Purchase_AbilityE[spellId]
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityR[spellId]) > 0 then
        return udg_Ability_Purchase_AbilityR[spellId]
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityF[spellId]) > 0 then
        return udg_Ability_Purchase_AbilityF[spellId]
    elseif GetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityG[spellId]) > 0 then
        return udg_Ability_Purchase_AbilityG[spellId]
    end
    return nil
end

function getFirstEmptySpellSlot(player)
    local playerId = GetPlayerId(player) + 1
    if udg_AbilityQ[playerId] == udg_Ability_Nil then
        return 0;
    elseif udg_AbilityW[playerId] == udg_Ability_Nil  then
        return 1;
    elseif udg_AbilityE[playerId] == udg_Ability_Nil  then
        return 2;
    elseif udg_AbilityR[playerId] == udg_Ability_Nil  then
        return 3;
    elseif udg_AbilityF[playerId] == udg_Ability_Nil  then
        return 4;
    elseif udg_AbilityG[playerId] == udg_Ability_Nil  then
        return 5;
    end
    return -1;
end


function checkIfAcquiredItemIsASpellRelated()
    local unit = GetTriggerUnit()
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player) + 1
    local item = GetManipulatedItem()
    local itemType = GetItemTypeId(item)

    local forget = BoughtItemIsForget(itemType)
    if forget > 0 then
        ForgetAbility(forget, player, playerId, unit, true)
        unit = nil
        item = nil
        itemType = nil
        player = nil
        return
    end

    local id = getSpellIdByItemType(itemType)
    if id == 0 then
        unit = nil
        item = nil
        itemType = nil
        player = nil
        return
    end

    --[[
    if udg_Ability_Purchase_Melee_Range[id] ~= "Both" then
        local attackType = getUnitIsMeleeOrRange(unit)
        if udg_Ability_Purchase_Melee_Range[id] == "Range" and attackType ~= "Range" then
            DisplayTextToPlayer(player, 0, 0, "This spell can only be used by 'Ranged' units")
            AdjustPlayerStateBJ(1, player, PLAYER_STATE_RESOURCE_LUMBER)
            unit = nil
            item = nil
            itemType = nil
            player = nil
            return
        elseif udg_Ability_Purchase_Melee_Range[id] == "Melee" and attackType ~= "Melee" then
            DisplayTextToPlayer(player, 0, 0, "This spell can only be used by 'Melee' units")
            AdjustPlayerStateBJ(1, player, PLAYER_STATE_RESOURCE_LUMBER)
            unit = nil
            item = nil
            itemType = nil
            player = nil
            return
        end
    end
    ]]--

    local spellLevel = getCurrentSpellLevel(unit,id)
    if udg_Ability_Purchase_MaxLevel[id] == spellLevel then
        DisplayTextToPlayer(player, 0, 0, "You reached maximum level on this spell")
        AdjustPlayerStateBJ(1, player, PLAYER_STATE_RESOURCE_LUMBER)
        unit = nil
        item = nil
        itemType = nil
        player = nil
        return
    end

    local unitLevel = GetUnitLevel(unit)
    --[[
    if udg_Ability_Purchase_LevelR[id + spellLevel] > unitLevel 
    or udg_Ability_Purchase_HolyR[id + spellLevel] > math.max(udg_BeliefOrder_Holy[playerId],0)
    or udg_Ability_Purchase_ShadowR[id + spellLevel] > math.max(udg_BeliefOrder_Shadow[playerId],0)
    or udg_Ability_Purchase_NatureR[id + spellLevel] > math.max(udg_BeliefOrder_Nature[playerId],0)
    or udg_Ability_Purchase_NecromanticR[id + spellLevel] > math.max(udg_BeliefOrder_Necromantic[playerId],0)
    or udg_Ability_Purchase_ArcaneR[id + spellLevel] > math.max(udg_BeliefOrder_Arcane[playerId],0)
    or udg_Ability_Purchase_FelR[id + spellLevel] > math.max(udg_BeliefOrder_Fel[playerId],0)
    then
        DisplayTextToPlayer(player, 0, 0, "You don't meet the requirements")
        AdjustPlayerStateBJ(1, player, PLAYER_STATE_RESOURCE_LUMBER)
        unit = nil
        item = nil
        itemType = nil
        player = nil
        return
    end
    --]]

    if spellLevel == 0 then
        local emptySlotId = getFirstEmptySpellSlot(player)
        if emptySlotId == -1 then
            DisplayTextToPlayer(player, 0, 0, "You don't have any empty spell slot")
            AdjustPlayerStateBJ(1, player, PLAYER_STATE_RESOURCE_LUMBER)
            unit = nil
            item = nil
            itemType = nil
            player = nil
            return
        end

        --Q
        if emptySlotId == 0 then
            UnitAddAbility(unit, udg_Ability_Purchase_AbilityQ[id])
            udg_AbilityQ[playerId] = udg_Ability_Purchase_AbilityQ[id]
        --W
        elseif  emptySlotId == 1 then
            UnitAddAbility(unit, udg_Ability_Purchase_AbilityW[id])
            udg_AbilityW[playerId] = udg_Ability_Purchase_AbilityW[id]
        --E
        elseif  emptySlotId == 2 then
            UnitAddAbility(unit, udg_Ability_Purchase_AbilityE[id])
            udg_AbilityE[playerId] = udg_Ability_Purchase_AbilityE[id]
        --R
        elseif  emptySlotId == 3 then
            UnitAddAbility(unit, udg_Ability_Purchase_AbilityR[id])
            udg_AbilityR[playerId] = udg_Ability_Purchase_AbilityR[id]
        --F
        elseif  emptySlotId == 4 then
            UnitAddAbility(unit, udg_Ability_Purchase_AbilityF[id])
            udg_AbilityF[playerId] = udg_Ability_Purchase_AbilityF[id]
        --G
        elseif  emptySlotId == 5 then
            UnitAddAbility(unit, udg_Ability_Purchase_AbilityG[id])
            udg_AbilityG[playerId] = udg_Ability_Purchase_AbilityG[id]
        end

        local spell = getCurrentSpell(unit, id)
        if udg_Ability_Purchase_LearnT[id] ~= nil then
            abilityPuchaseExecTrigger(id, unit, spell, true)
        end

        createSpecialEffectOnUnit(unit, "Abilities\\Spells\\Items\\AIam\\AIamTarget.mdl")

    else
        local spell = getCurrentSpell(unit, id)
        IncUnitAbilityLevel(unit, spell)
        if udg_Ability_Purchase_LearnT[id] ~= nil then
            abilityPuchaseExecTrigger(id, unit, spell, true)
        end
        spell = nil

        createSpecialEffectOnUnit(unit, "Abilities\\Spells\\Items\\AIam\\AIamTarget.mdl")
    end


    unit = nil
    item = nil
    itemType = nil
    player = nil
end


function BoughtItemIsForget(itemType)
    for i=1,7 do
        if itemType == udg_Ability_Forget_Item_Type[i] then
            return i
        end
    end
    return 0
end

function ForgetAbility(forgetId, player, playerId, unit, showText)
    --Q
    if forgetId == 1 then
        if udg_AbilityQ[playerId] == udg_Ability_Nil then
            if showText == true then
                DisplayTextToPlayer(player, 0, 0, "You don't have any spell on that slot")
            end
            return
        end
        local spellId = getSpellIdBySpell(udg_AbilityQ[playerId])
        local level = GetUnitAbilityLevel(unit, udg_AbilityQ[playerId])
        AdjustPlayerStateBJ(level, player, PLAYER_STATE_RESOURCE_LUMBER)
        for i=1,level do
            if udg_Ability_Purchase_UnlearnT[spellId] ~= nil  then
                abilityPuchaseExecTrigger(spellId, unit, udg_AbilityQ[playerId], false)
            end
            DecUnitAbilityLevel(unit, udg_AbilityQ[playerId])
        end
        UnitRemoveAbility(unit, udg_AbilityQ[playerId])
        forgetMessage(player, udg_AbilityQ[playerId], level, 'Q' )
        udg_AbilityQ[playerId] = udg_Ability_Nil

    --W
    elseif forgetId == 2 then
        if udg_AbilityW[playerId] == udg_Ability_Nil then
            if showText == true then
                DisplayTextToPlayer(player, 0, 0, "You don't have any spell on that slot")
            end
            return
        end
        local spellId = getSpellIdBySpell(udg_AbilityW[playerId])
        local level = GetUnitAbilityLevel(unit, udg_AbilityW[playerId])
        AdjustPlayerStateBJ(level, player, PLAYER_STATE_RESOURCE_LUMBER)
        for i=1,level do
            if udg_Ability_Purchase_UnlearnT[spellId] ~= nil  then
                abilityPuchaseExecTrigger(spellId, unit, udg_AbilityW[playerId], false)
            end
            DecUnitAbilityLevel(unit, udg_AbilityW[playerId])
        end
        UnitRemoveAbility(unit, udg_AbilityW[playerId])
        forgetMessage(player, udg_AbilityW[playerId], level, 'W' )
        udg_AbilityW[playerId] = udg_Ability_Nil

    --E
    elseif forgetId == 3 then
        if udg_AbilityE[playerId] == udg_Ability_Nil then
            if showText == true then
                DisplayTextToPlayer(player, 0, 0, "You don't have any spell on that slot")
            end
            return
        end
        local spellId = getSpellIdBySpell(udg_AbilityE[playerId])
        local level = GetUnitAbilityLevel(unit, udg_AbilityE[playerId])
        AdjustPlayerStateBJ(level, player, PLAYER_STATE_RESOURCE_LUMBER)
        for i=1,level do
            if udg_Ability_Purchase_UnlearnT[spellId] ~= nil  then
                abilityPuchaseExecTrigger(spellId, unit, udg_AbilityE[playerId], false)
            end
            DecUnitAbilityLevel(unit, udg_AbilityE[playerId])
        end
        UnitRemoveAbility(unit, udg_AbilityE[playerId])
        forgetMessage(player, udg_AbilityE[playerId], level, 'E' )
        udg_AbilityE[playerId] = udg_Ability_Nil

    --R
    elseif forgetId == 4 then
        if udg_AbilityR[playerId] == udg_Ability_Nil then
            if showText == true then
                DisplayTextToPlayer(player, 0, 0, "You don't have any spell on that slot")
            end
            return
        end
        local spellId = getSpellIdBySpell(udg_AbilityR[playerId])
        local level = GetUnitAbilityLevel(unit, udg_AbilityR[playerId])
        AdjustPlayerStateBJ(level, player, PLAYER_STATE_RESOURCE_LUMBER)
        for i=1,level do
            if udg_Ability_Purchase_UnlearnT[spellId] ~= nil  then
                abilityPuchaseExecTrigger(spellId, unit, udg_AbilityR[playerId], false)
            end
            DecUnitAbilityLevel(unit, udg_AbilityR[playerId])
        end

        UnitRemoveAbility(unit, udg_AbilityR[playerId])
        forgetMessage(player, udg_AbilityR[playerId], level, 'R' )
        udg_AbilityR[playerId] = udg_Ability_Nil

    --F
    elseif forgetId == 5 then
        if udg_AbilityF[playerId] == udg_Ability_Nil then
            if showText == true then
                DisplayTextToPlayer(player, 0, 0, "You don't have any spell on that slot")
            end
            return
        end
        local spellId = getSpellIdBySpell(udg_AbilityF[playerId])
        local level = GetUnitAbilityLevel(unit, udg_AbilityF[playerId])
        AdjustPlayerStateBJ(level, player, PLAYER_STATE_RESOURCE_LUMBER)
        for i=1,level do
            if udg_Ability_Purchase_UnlearnT[spellId] ~= nil  then
                abilityPuchaseExecTrigger(spellId, unit, udg_AbilityF[playerId], false)
            end
            DecUnitAbilityLevel(unit, udg_AbilityF[playerId])
        end
        UnitRemoveAbility(unit, udg_AbilityF[playerId])
        forgetMessage(player, udg_AbilityF[playerId], level, 'F' )
        udg_AbilityF[playerId] = udg_Ability_Nil

    --G
    elseif forgetId == 6 then
        if udg_AbilityG[playerId] == udg_Ability_Nil then
            if showText == true then
                DisplayTextToPlayer(player, 0, 0, "You don't have any spell on that slot")
            end
            return
        end
        local spellId = getSpellIdBySpell(udg_AbilityG[playerId])
        local level = GetUnitAbilityLevel(unit, udg_AbilityG[playerId])
        AdjustPlayerStateBJ(level, player, PLAYER_STATE_RESOURCE_LUMBER)
        for i=1,level do
            if udg_Ability_Purchase_UnlearnT[spellId] ~= nil  then
                abilityPuchaseExecTrigger(spellId, unit, udg_AbilityG[playerId], false)
            end
            DecUnitAbilityLevel(unit, udg_AbilityG[playerId])
        end
        UnitRemoveAbility(unit, udg_AbilityG[playerId])
        forgetMessage(player, udg_AbilityG[playerId], level, 'G' )
        udg_AbilityG[playerId] = udg_Ability_Nil
    elseif forgetId == 7 then
        for i=1,6 do
            ForgetAbility(i, player, playerId, unit, false)
        end
    end
    
end


function forgetMessage(player, ability, level, slot)
    DisplayTextToPlayer(player, 0, 0, "Successfully forget |cffd45e19" .. GetAbilityName(ability) .. "|r" .. " - " .. "|cffffcc00Level " .. tostring(level) .. "|r from your ".. slot .." slot and gain +" .. tostring(level) .. " Ability Point")
end

function abilityPuchaseExecTrigger(spellId, unit, spell, isLearn)
    udg_Ability_Purchase_Trigger_Spell = spell
    udg_Ability_Purchase_Trigger_Unit = unit
    if isLearn == true then
        TriggerExecute(udg_Ability_Purchase_LearnT[spellId])
    else
        TriggerExecute(udg_Ability_Purchase_UnlearnT[spellId])
    end
end