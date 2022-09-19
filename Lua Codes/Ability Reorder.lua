function abilityReOrderCast()
    local unit = GetTriggerUnit()
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player) + 1
    local dialogButtonId = (playerId - 1) * 7

    local abilityExists = abilityReOrderCheckIfAnyAbilityExists(playerId)

    if abilityExists == false then
        DisplayTextToPlayer(player, 0, 0, "You don't have any ability to re-order.")
        unit = nil
        player = nil
        return
    end


    DialogClearBJ(udg_AbilityReorder_Ability_Dialog[playerId])
    DialogSetMessageBJ(udg_AbilityReorder_Ability_Dialog[playerId], "Choose your ability")

    if udg_AbilityQ[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Ability_Dialog[playerId], "Q - |cffd45e19" .. GetAbilityName(udg_AbilityQ[playerId]) .. "|r")
        udg_AbilityReorder_Ability_DialogB[dialogButtonId + 1] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityW[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Ability_Dialog[playerId], "W - |cffd45e19" .. GetAbilityName(udg_AbilityW[playerId]) .. "|r")
        udg_AbilityReorder_Ability_DialogB[dialogButtonId + 2] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityE[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Ability_Dialog[playerId], "E - |cffd45e19" .. GetAbilityName(udg_AbilityE[playerId]) .. "|r")
        udg_AbilityReorder_Ability_DialogB[dialogButtonId + 3] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityR[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Ability_Dialog[playerId], "R - |cffd45e19" .. GetAbilityName(udg_AbilityR[playerId]) .. "|r")
        udg_AbilityReorder_Ability_DialogB[dialogButtonId + 4] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityF[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Ability_Dialog[playerId], "F - |cffd45e19" .. GetAbilityName(udg_AbilityF[playerId]) .. "|r")
        udg_AbilityReorder_Ability_DialogB[dialogButtonId + 5] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityG[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Ability_Dialog[playerId], "G - |cffd45e19" .. GetAbilityName(udg_AbilityG[playerId]) .. "|r")
        udg_AbilityReorder_Ability_DialogB[dialogButtonId + 6] = GetLastCreatedButtonBJ()
    end

    DialogAddButtonBJ(udg_AbilityReorder_Ability_Dialog[playerId], "Cancel")
    udg_AbilityReorder_Ability_DialogB[dialogButtonId + 7] = GetLastCreatedButtonBJ()

    DialogDisplayBJ(true, udg_AbilityReorder_Ability_Dialog[playerId], player)

    unit = nil
    player = nil
end

function abilityReOrderCheckIfAnyAbilityExists(playerId)
    if udg_AbilityQ[playerId] ~= udg_Ability_Nil or udg_AbilityW[playerId] ~= udg_Ability_Nil or udg_AbilityE[playerId] ~= udg_Ability_Nil or
     udg_AbilityR[playerId] ~= udg_Ability_Nil or udg_AbilityF[playerId] ~= udg_Ability_Nil or udg_AbilityG[playerId] ~= udg_Ability_Nil then
        return true
    else
        return false
    end
end


function abilityReOrderAbilityDialogClicked()
    local player = GetTriggerPlayer()
    local playerId = GetPlayerId(player) + 1
    local clickedButton = GetClickedButtonBJ()

    for i=1,42 do
        if udg_AbilityReorder_Ability_DialogB[i] == clickedButton then
            udg_AbilityReorder_Ability_Index[playerId] = ModuloInteger(i, 7)
        end
    end

    if udg_AbilityReorder_Ability_Index[playerId] == 0 then
        player = nil
        clickedButton = nil
        return
    end

    abilityReOrderCreateSlotDialog(player)
    DialogDisplayBJ(true, udg_AbilityReorder_Slot_Dialog[playerId], player)
    
    player = nil
    clickedButton = nil
end

function abilityReOrderCreateSlotDialog(player)
    local playerId = GetPlayerId(player) + 1
    local dialogButtonId = (playerId - 1) * 7


    DialogClearBJ(udg_AbilityReorder_Slot_Dialog[playerId])
    DialogSetMessageBJ(udg_AbilityReorder_Slot_Dialog[playerId], "Choose your slot")

    if udg_AbilityQ[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "Q - |cffd45e19" .. GetAbilityName(udg_AbilityQ[playerId]) .. "|r")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 1] = GetLastCreatedButtonBJ()
    else
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "Q - Empty Slot")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 1] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityW[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "W - |cffd45e19" .. GetAbilityName(udg_AbilityW[playerId]) .. "|r")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 2] = GetLastCreatedButtonBJ()
    else
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "W - Empty Slot")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 2] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityE[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "E - |cffd45e19" .. GetAbilityName(udg_AbilityE[playerId]) .. "|r")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 3] = GetLastCreatedButtonBJ()
    else
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "E - Empty Slot")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 3] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityR[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "R - |cffd45e19" .. GetAbilityName(udg_AbilityR[playerId]) .. "|r")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 4] = GetLastCreatedButtonBJ()
    else
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "R - Empty Slot")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 4] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityF[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "F - |cffd45e19" .. GetAbilityName(udg_AbilityF[playerId]) .. "|r")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 5] = GetLastCreatedButtonBJ()
    else
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "F - Empty Slot")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 5] = GetLastCreatedButtonBJ()
    end

    if udg_AbilityG[playerId] ~= udg_Ability_Nil then
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "G - |cffd45e19" .. GetAbilityName(udg_AbilityG[playerId]) .. "|r")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 6] = GetLastCreatedButtonBJ()
    else
        DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "G - Empty Slot")
        udg_AbilityReorder_Slot_DialogB[dialogButtonId + 6] = GetLastCreatedButtonBJ()
    end
    
    DialogAddButtonBJ(udg_AbilityReorder_Slot_Dialog[playerId], "Cancel")
    udg_AbilityReorder_Slot_DialogB[dialogButtonId + 7] = GetLastCreatedButtonBJ()


end

function abilityReOrderSlotDialogClicked()
    local player = GetTriggerPlayer()
    local playerId = GetPlayerId(player) + 1
    local clickedButton = GetClickedButtonBJ()
    local unit = udg_INV_Player_Hero[playerId]

    local clickedIndex = 0
    for i=1,42 do
        if udg_AbilityReorder_Slot_DialogB[i] == clickedButton then
            clickedIndex = ModuloInteger(i, 7)
        end
    end

    if udg_AbilityReorder_Ability_Index[playerId] == 0 or udg_AbilityReorder_Ability_Index[playerId] == clickedIndex then
        player = nil
        clickedButton = nil
        unit = nil
        return
    end

    local spell, level = abilityReOrderRemoveSpellAndReturnIdAndLevel(playerId, udg_AbilityReorder_Ability_Index[playerId])
    local spellId = getSpellIdBySpell(spell)

    local targetSpell, targetLevel = abilityReOrderRemoveSpellAndReturnIdAndLevel(playerId, clickedIndex)
    if targetSpell ~= udg_Ability_Nil then
        local targetSpellId = getSpellIdBySpell(targetSpell)
        abilityReOrderAddSpell(udg_AbilityReorder_Ability_Index[playerId], unit, playerId, targetSpellId, targetLevel)
    end

    abilityReOrderAddSpell(clickedIndex, unit, playerId, spellId, level)


    player = nil
    clickedButton = nil
    unit = nil
end

function abilityReOrderRemoveSpellAndReturnIdAndLevel(playerId, index)
    
    if index == 1 then
        if udg_AbilityQ[playerId] == udg_Ability_Nil then
            return udg_Ability_Nil, 0
        end
        local spell = udg_AbilityQ[playerId]
        local level = GetUnitAbilityLevel(udg_INV_Player_Hero[playerId], udg_AbilityQ[playerId])
        UnitRemoveAbility(udg_INV_Player_Hero[playerId], udg_AbilityQ[playerId])
        udg_AbilityQ[playerId] = udg_Ability_Nil
        return spell,level
    end

    if index == 2 then
        if udg_AbilityW[playerId] == udg_Ability_Nil then
            return udg_Ability_Nil, 0
        end
        local spell = udg_AbilityW[playerId]
        local level = GetUnitAbilityLevel(udg_INV_Player_Hero[playerId], udg_AbilityW[playerId])
        UnitRemoveAbility(udg_INV_Player_Hero[playerId], udg_AbilityW[playerId])
        udg_AbilityW[playerId] = udg_Ability_Nil
        return spell,level
    end

    if index == 3 then
        if udg_AbilityE[playerId] == udg_Ability_Nil then
            return udg_Ability_Nil, 0
        end
        local spell = udg_AbilityE[playerId]
        local level = GetUnitAbilityLevel(udg_INV_Player_Hero[playerId], udg_AbilityE[playerId])
        UnitRemoveAbility(udg_INV_Player_Hero[playerId], udg_AbilityE[playerId])
        udg_AbilityE[playerId] = udg_Ability_Nil
        return spell,level
    end

    if index == 4 then
        if udg_AbilityR[playerId] == udg_Ability_Nil then
            return udg_Ability_Nil, 0
        end
        local spell = udg_AbilityR[playerId]
        local level = GetUnitAbilityLevel(udg_INV_Player_Hero[playerId], udg_AbilityR[playerId])
        UnitRemoveAbility(udg_INV_Player_Hero[playerId], udg_AbilityR[playerId])
        udg_AbilityR[playerId] = udg_Ability_Nil
        return spell,level
    end

    if index == 5 then
        if udg_AbilityF[playerId] == udg_Ability_Nil then
            return udg_Ability_Nil, 0
        end
        local spell = udg_AbilityF[playerId]
        local level = GetUnitAbilityLevel(udg_INV_Player_Hero[playerId], udg_AbilityF[playerId])
        UnitRemoveAbility(udg_INV_Player_Hero[playerId], udg_AbilityF[playerId])
        udg_AbilityF[playerId] = udg_Ability_Nil
        return spell,level
    end

    if index == 6 then
        if udg_AbilityG[playerId] == udg_Ability_Nil then
            return udg_Ability_Nil, 0
        end
        local spell = udg_AbilityG[playerId]
        local level = GetUnitAbilityLevel(udg_INV_Player_Hero[playerId], udg_AbilityG[playerId])
        UnitRemoveAbility(udg_INV_Player_Hero[playerId], udg_AbilityG[playerId])
        udg_AbilityG[playerId] = udg_Ability_Nil
        return spell,level
    end
end


function abilityReOrderAddSpell(index, unit, playerId, spellId, level)

    if index == 1 then
        UnitAddAbility(unit, udg_Ability_Purchase_AbilityQ[spellId])
        udg_AbilityQ[playerId] = udg_Ability_Purchase_AbilityQ[spellId]
        SetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityQ[spellId], level)

    elseif index == 2 then
        UnitAddAbility(unit, udg_Ability_Purchase_AbilityW[spellId])
        udg_AbilityW[playerId] = udg_Ability_Purchase_AbilityW[spellId]
        SetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityW[spellId], level)

    elseif index == 3 then
        UnitAddAbility(unit, udg_Ability_Purchase_AbilityE[spellId])
        udg_AbilityE[playerId] = udg_Ability_Purchase_AbilityE[spellId]
        SetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityE[spellId], level)

    elseif index == 4 then
        UnitAddAbility(unit, udg_Ability_Purchase_AbilityR[spellId])
        udg_AbilityR[playerId] = udg_Ability_Purchase_AbilityR[spellId]
        SetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityR[spellId], level)

    elseif index == 5 then
        UnitAddAbility(unit, udg_Ability_Purchase_AbilityF[spellId])
        udg_AbilityF[playerId] = udg_Ability_Purchase_AbilityF[spellId]
        SetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityF[spellId], level)

    elseif index == 6 then
        UnitAddAbility(unit, udg_Ability_Purchase_AbilityG[spellId])
        udg_AbilityG[playerId] = udg_Ability_Purchase_AbilityG[spellId]
        SetUnitAbilityLevel(unit, udg_Ability_Purchase_AbilityG[spellId], level)
    end

end