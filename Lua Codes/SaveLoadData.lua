function saveLoadSaveData()
    local player = udg_save_load_queue_player[udg_save_load_queue_current]
    local playerId = GetPlayerId(player) + 1
    local unit = udg_INV_Player_Hero[playerId]
    local unitId = GetUnitUserData(unit)

    udg_save_data[1] = heroSelectionFindHeroFromUnit(unit)
    if udg_save_data[1] == 0 then
        return
    end

    udg_save_data[2] = GetUnitLevel(unit)
    udg_save_data[3] = GetHeroXP(unit)

    --Stats

    udg_save_data[4] = udg_Stat_Health[unitId]
    udg_save_data[5] = R2I(udg_Stat_Health_Modifier[unitId] * 100)
    udg_save_data[6] = udg_Stat_Health_Flat[unitId]

    udg_save_data[7] = udg_Stat_Mana[unitId]
    udg_save_data[8] = R2I(udg_Stat_Mana_Modifier[unitId] * 100)
    udg_save_data[9] = udg_Stat_Mana_Flat[unitId]

    udg_save_data[10] = udg_Stat_Strength[unitId]
    udg_save_data[11] = R2I(udg_Stat_Strength_Modifier[unitId] * 100)
    udg_save_data[12] = udg_Stat_Strength_Flat[unitId]

    udg_save_data[13] = udg_Stat_Agility[unitId]
    udg_save_data[14] = R2I(udg_Stat_Agility_Modifier[unitId] * 100)
    udg_save_data[15] = udg_Stat_Agility_Flat[unitId]

    udg_save_data[16] = udg_Stat_Intelligence[unitId]
    udg_save_data[17] = R2I(udg_Stat_Intelligence_Modifier[unitId] * 100)
    udg_save_data[18] = udg_Stat_Intelligence_Flat[unitId]

    udg_save_data[19] = R2I(udg_Stat_Health_Regen_Assign[unitId] * 100)

    udg_save_data[20] = R2I(udg_Stat_Mana_Regen_Assign[unitId] * 100)

    udg_save_data[21] = udg_Stat_Armor[unitId]
    udg_save_data[22] = R2I(udg_Stat_Armor_Modifier[unitId] * 100)
    udg_save_data[23] = udg_Stat_Armor_Flat[unitId]
    
    udg_save_data[24] = R2I(udg_Stat_Damage_Reduction[unitId] * 100)

    udg_save_data[25] = R2I(udg_Stat_Damage_Taken[unitId] * 100)

    udg_save_data[26] = R2I(udg_Stat_Attack_Speed[unitId] * 100)

    udg_save_data[27] = R2I(udg_Stat_Critical_Chance[unitId] * 100)

    udg_save_data[28] = R2I(udg_Stat_Critical_Damage_Rate[unitId] * 100)

    udg_save_data[29] = R2I(udg_Stat_Dodge[unitId] * 100)

    udg_save_data[30] = R2I(udg_Stat_Parry[unitId] * 100)

    udg_save_data[31] = R2I(udg_Stat_Block[unitId] * 100)
    udg_save_data[32] = udg_Stat_Block_Enabled[unitId]

    udg_save_data[33] = R2I(udg_Stat_Miss[unitId] * 100)

    udg_save_data[34] = udg_Stat_Attack_Damage[unitId]
    udg_save_data[35] = R2I(udg_Stat_Attack_Damage_Modifier[unitId] * 100)
    udg_save_data[36] = udg_Stat_Attack_Damage_Flat[unitId]

    udg_save_data[37] = udg_Stat_Spell_Damage[unitId]
    udg_save_data[38] = R2I(udg_Stat_Spell_Damage_Modifier[unitId] * 100)
    udg_save_data[39] = udg_Stat_Spell_Damage_Flat[unitId]

    udg_save_data[40] = R2I(udg_Stat_Cooldown[unitId] * 100)

    udg_save_data[41] = R2I(udg_Stat_Casting_Speed[unitId] * 100)

    udg_save_data[42] = R2I(udg_Stat_Movement_Speed[unitId] * 100)

    udg_save_data[43] = R2I(udg_Stat_Healing_Taken[unitId] * 100)

    udg_save_data[44] = R2I(udg_Stat_Healing_Reduce[unitId] * 100)

    udg_save_data[45] = R2I(udg_Stat_Life_Steal[unitId] * 100)

    udg_save_data[46] = R2I(udg_Stat_Attack_Interval[unitId] * 100)

    --Stats
    --Inventory
    local currentIndex = 46
    for i=1,udg_INV_Slot_Limit do
        udg_save_data[currentIndex + i] = LoadIntegerBJ(i, playerId, udg_INV_ItemId_Hashtable)
    end
    --Inventory
    --Inventory Charges
    local currentIndex = 153
    for i=1,udg_INV_Slot_Limit do
        udg_save_data[currentIndex + i] = LoadIntegerBJ(i, playerId, udg_INV_ItemCharges_Hashtable)
    end
    --Inventory Charges
    --Extra Stats
    local currentIndex = 260
    udg_save_data[currentIndex + 1] = udg_Level_Stat_CurrentPoint[playerId]
    udg_save_data[currentIndex + 2] = udg_Level_Stat_StrengthGiven[playerId]
    udg_save_data[currentIndex + 3] = udg_Level_Stat_AgilityGiven[playerId]
    udg_save_data[currentIndex + 4] = udg_Level_Stat_IntelligenceGiven[playerId]
    --Extra Stats

    --Belief Order
    local currentIndex = 264
    udg_save_data[currentIndex + 1] = udg_BeliefOrder_CurrentPoint[playerId]
    udg_save_data[currentIndex + 2] = udg_BeliefOrder_GivenPoint[playerId]
    udg_save_data[currentIndex + 3] = udg_BeliefOrder_Holy[playerId]
    udg_save_data[currentIndex + 4] = udg_BeliefOrder_Shadow[playerId]
    udg_save_data[currentIndex + 5] = udg_BeliefOrder_Nature[playerId]
    udg_save_data[currentIndex + 6] = udg_BeliefOrder_Necromantic[playerId]
    udg_save_data[currentIndex + 7] = udg_BeliefOrder_Arcane[playerId]
    udg_save_data[currentIndex + 8] = udg_BeliefOrder_Fel[playerId]
    --Belief Order

    -- Gold
    local currentIndex = 272
    udg_save_data[currentIndex + 1] = GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) 
    -- Gold


    --Abilities
    local currentIndex = 273
    if udg_AbilityQ[playerId] ~= udg_Ability_Nil then
        udg_save_data[currentIndex + 1] = getSpellIdBySpell(udg_AbilityQ[playerId])
        udg_save_data[currentIndex + 2] = GetUnitAbilityLevel(unit, udg_AbilityQ[playerId])
    else
        udg_save_data[currentIndex + 1] = 0
        udg_save_data[currentIndex + 2] = 0
    end

    if udg_AbilityW[playerId] ~= udg_Ability_Nil then
        udg_save_data[currentIndex + 3] = getSpellIdBySpell(udg_AbilityW[playerId])
        udg_save_data[currentIndex + 4] = GetUnitAbilityLevel(unit, udg_AbilityW[playerId])
    else
        udg_save_data[currentIndex + 3] = 0
        udg_save_data[currentIndex + 4] = 0
    end

    if udg_AbilityE[playerId] ~= udg_Ability_Nil then
        udg_save_data[currentIndex + 5] = getSpellIdBySpell(udg_AbilityE[playerId])
        udg_save_data[currentIndex + 6] = GetUnitAbilityLevel(unit, udg_AbilityE[playerId])
    else
        udg_save_data[currentIndex + 5] = 0
        udg_save_data[currentIndex + 6] = 0
    end

    if udg_AbilityR[playerId] ~= udg_Ability_Nil then
        udg_save_data[currentIndex + 7] = getSpellIdBySpell(udg_AbilityR[playerId])
        udg_save_data[currentIndex + 8] = GetUnitAbilityLevel(unit, udg_AbilityR[playerId])
    else
        udg_save_data[currentIndex + 7] = 0
        udg_save_data[currentIndex + 8] = 0
    end

    if udg_AbilityF[playerId] ~= udg_Ability_Nil then
        udg_save_data[currentIndex + 9] = getSpellIdBySpell(udg_AbilityF[playerId])
        udg_save_data[currentIndex + 10] = GetUnitAbilityLevel(unit, udg_AbilityF[playerId])
    else
        udg_save_data[currentIndex + 9] = 0
        udg_save_data[currentIndex + 10] = 0
    end

    if udg_AbilityG[playerId] ~= udg_Ability_Nil then
        udg_save_data[currentIndex + 11] = getSpellIdBySpell(udg_AbilityG[playerId])
        udg_save_data[currentIndex + 12] = GetUnitAbilityLevel(unit, udg_AbilityG[playerId])
    else
        udg_save_data[currentIndex + 11] = 0
        udg_save_data[currentIndex + 12] = 0
    end
    --Abilities

    -- Ability Point
    local currentIndex = 285
    udg_save_data[currentIndex + 1] = GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) 
    -- Ability Point

    -- Settings
    local currentIndex = 286
    udg_save_data[currentIndex + 1] = udg_Settings_ShowGold[playerId]
    udg_save_data[currentIndex + 2] = udg_Settings_ShowEXP[playerId]
    udg_save_data[currentIndex + 3] = udg_Settings_ShowHealTaken[playerId]
    udg_save_data[currentIndex + 4] = udg_Settings_ShowHealGive[playerId]
    udg_save_data[currentIndex + 5] = udg_Settings_ShowDamageTaken[playerId]
    udg_save_data[currentIndex + 6] = udg_Settings_ShowDamageDealt[playerId]
    udg_save_data[currentIndex + 7] = udg_Settings_ShowNotes[playerId]
    udg_save_data[currentIndex + 8] = udg_Settings_ShowAllAchivements[playerId]
    -- Settings

    local currentIndex = 294

end


function saveLoadLoadData()
    local player = udg_save_load_queue_player[udg_save_load_queue_current]
    local playerId = GetPlayerId(player) + 1
    local createPoint = GetRectCenter(udg_Hero_Selection_Create_Region)

    DisableTrigger(gg_trg_RegisterSystem_NewUnit)
    CreateNUnitsAtLoc(1, udg_Hero_Selection_UnitType[udg_save_read_data[1]], player, createPoint, 0)
    local unit = GetLastCreatedUnit()
    registerUnit(unit)
    local unitId = GetUnitUserData(unit)
    udg_INV_Player_Hero[playerId] = GetLastCreatedUnit()
    udg_INV_Player_Hero_Icon[playerId] = udg_Hero_Selection_UnitType_Icons[udg_save_read_data[1]]
    BlzSetHeroProperName(unit, getPlayerNameWithoutSharp(player))
    GroupAddUnit(udg_Heroes, unit)
    spellVariablesInit(unitId)
    EnableTrigger(gg_trg_RegisterSystem_NewUnit)

    SetHeroLevelBJ(unit, udg_save_read_data[2], false)
    local currentXP = GetHeroXP(unit)
    local xpDifference = udg_save_read_data[3] - currentXP
    AddHeroXP(unit, xpDifference, false)

    --For EXP System
    local remainingXP = ModuloInteger(udg_save_read_data[3], 100)
    local amount = R2I(udg_EXP_System_Required_Values[udg_save_read_data[2]] * remainingXP / 100)
    udg_EXP_System_Unit_Current_EXP[unitId] = amount

    --Stats
    udg_Stat_Health[unitId] = udg_save_read_data[4]
    udg_Stat_Health_Modifier[unitId] = I2R(udg_save_read_data[5]) / 100
    udg_Stat_Health_Flat[unitId] = udg_save_read_data[6]

    udg_Stat_Mana[unitId] = udg_save_read_data[7]
    udg_Stat_Mana_Modifier[unitId] = I2R(udg_save_read_data[8]) / 100
    udg_Stat_Mana_Flat[unitId] = udg_save_read_data[9]

    udg_Stat_Strength[unitId] = udg_save_read_data[10]
    udg_Stat_Strength_Modifier[unitId] = I2R(udg_save_read_data[11]) / 100
    udg_Stat_Strength_Flat[unitId] = udg_save_read_data[12]

    udg_Stat_Agility[unitId] = udg_save_read_data[13]
    udg_Stat_Agility_Modifier[unitId] = I2R(udg_save_read_data[14]) / 100
    udg_Stat_Agility_Flat[unitId] = udg_save_read_data[15]

    udg_Stat_Intelligence[unitId] = udg_save_read_data[16]
    udg_Stat_Intelligence_Modifier[unitId] = I2R(udg_save_read_data[17]) / 100
    udg_Stat_Intelligence_Flat[unitId] = udg_save_read_data[18]

    udg_Stat_Health_Regen_Assign[unitId] = I2R(udg_save_read_data[19]) / 100

    udg_Stat_Mana_Regen_Assign[unitId] = I2R(udg_save_read_data[20]) / 100

    udg_Stat_Armor[unitId] = udg_save_read_data[21]
    udg_Stat_Armor_Modifier[unitId] = I2R(udg_save_read_data[22]) / 100
    udg_Stat_Armor_Flat[unitId] = udg_save_read_data[23]

    udg_Stat_Damage_Reduction[unitId] = I2R(udg_save_read_data[24]) / 100

    udg_Stat_Damage_Taken[unitId] = I2R(udg_save_read_data[25]) / 100

    udg_Stat_Attack_Speed[unitId] = I2R(udg_save_read_data[26]) / 100

    udg_Stat_Critical_Chance[unitId] = I2R(udg_save_read_data[27]) / 100

    udg_Stat_Critical_Damage_Rate[unitId] = I2R(udg_save_read_data[28]) / 100

    udg_Stat_Dodge[unitId] = I2R(udg_save_read_data[29]) / 100

    udg_Stat_Parry[unitId] = I2R(udg_save_read_data[30]) / 100

    udg_Stat_Block[unitId] = I2R(udg_save_read_data[31]) / 100
    udg_Stat_Block_Enabled[unitId] = udg_save_read_data[32]

    udg_Stat_Miss[unitId] = I2R(udg_save_read_data[33]) / 100

    udg_Stat_Attack_Damage[unitId] = udg_save_read_data[34]
    udg_Stat_Attack_Damage_Modifier[unitId] = I2R(udg_save_read_data[35]) / 100
    udg_Stat_Attack_Damage_Flat[unitId] = udg_save_read_data[36]

    udg_Stat_Spell_Damage[unitId] = udg_save_read_data[37]
    udg_Stat_Spell_Damage_Modifier[unitId] = I2R(udg_save_read_data[38]) / 100
    udg_Stat_Spell_Damage_Flat[unitId] = udg_save_read_data[39]

    udg_Stat_Cooldown[unitId] = I2R(udg_save_read_data[40]) / 100

    udg_Stat_Casting_Speed[unitId] = I2R(udg_save_read_data[41]) / 100

    udg_Stat_Movement_Speed[unitId] = I2R(udg_save_read_data[42]) / 100

    udg_Stat_Healing_Taken[unitId] = I2R(udg_save_read_data[43]) / 100

    udg_Stat_Healing_Reduce[unitId] = I2R(udg_save_read_data[44]) / 100

    udg_Stat_Life_Steal[unitId] = I2R(udg_save_read_data[45]) / 100

    udg_Stat_Attack_Interval[unitId] = I2R(udg_save_read_data[46]) / 100
    --Stats
    --Inventory
    local currentIndex = 46
    for i=1,udg_INV_Slot_Limit do
        local id = udg_save_read_data[currentIndex + i]
        SaveIntegerBJ(id, i, playerId, udg_INV_ItemId_Hashtable)
        local slotPoint = LoadLocationHandleBJ(i, playerId, udg_INV_Point_Hashtable)
        RemoveDestructable(LoadDestructableHandleBJ(i, playerId, udg_INV_Destructible_Hashtable))
        if id == 0 then
            if i < 15 then
                CreateDestructableLoc(udg_INV_Equipable_EmptySlots[i], slotPoint, 270, 1.5, 0)
            elseif i > 102 then
                CreateDestructableLoc(udg_INV_Consumable_EmptySlot, slotPoint, 270, 1.5, 0)
            else
                CreateDestructableLoc(udg_INV_EmptySlot, slotPoint, 270, 1.5, 0)
            end
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), i, playerId, udg_INV_Destructible_Hashtable)
        else
            CreateDestructableLoc(udg_ITEM_Destructible[id], slotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), i, playerId, udg_INV_Destructible_Hashtable)

            if i < 15 then
                TriggerExecute(udg_ITEM_Trigger_Equipped[id])
            elseif i > 102 then
                DisableTrigger( gg_trg_Item_System_Acquire )
                UnitAddItemToSlotById(unit, udg_ITEM_Item_Type[id], i - 103)
                EnableTrigger( gg_trg_Item_System_Acquire )
            end
        end
    end
    --Inventory
    --Inventory Charges
    local currentIndex = 153
    for i=1,udg_INV_Slot_Limit do
        local id = udg_save_read_data[currentIndex + i]
        SaveIntegerBJ(id, i, playerId, udg_INV_ItemCharges_Hashtable)

        if i > 102 then
            SetItemCharges(UnitItemInSlot(unit, i - 103), id)
        end
    end
    --Inventory Charges

    --Extra Stats
    local currentIndex = 260
    udg_Level_Stat_CurrentPoint[playerId] = udg_save_read_data[currentIndex + 1]
    udg_Level_Stat_StrengthGiven[playerId] = udg_save_read_data[currentIndex + 2]
    udg_Level_Stat_AgilityGiven[playerId] = udg_save_read_data[currentIndex + 3]
    udg_Level_Stat_IntelligenceGiven[playerId] = udg_save_read_data[currentIndex + 4]
    --Extra Stats

    --Belief Order
    local currentIndex = 264
    udg_BeliefOrder_CurrentPoint[playerId] = udg_save_read_data[currentIndex + 1]
    udg_BeliefOrder_GivenPoint[playerId] = udg_save_read_data[currentIndex + 2]
    udg_BeliefOrder_Holy[playerId] = udg_save_read_data[currentIndex + 3]
    udg_BeliefOrder_Shadow[playerId] = udg_save_read_data[currentIndex + 4]
    udg_BeliefOrder_Nature[playerId] = udg_save_read_data[currentIndex + 5]
    udg_BeliefOrder_Necromantic[playerId] = udg_save_read_data[currentIndex + 6]
    udg_BeliefOrder_Arcane[playerId] = udg_save_read_data[currentIndex + 7]
    udg_BeliefOrder_Fel[playerId] = udg_save_read_data[currentIndex + 8]
    --Belief Order

    -- Gold
    local currentIndex = 272
    SetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD, udg_save_read_data[currentIndex + 1])
    -- Gold


    local currentIndex = 273
    --Abilities
    if udg_save_read_data[currentIndex + 1] == 0 then
        udg_AbilityQ[playerId] = FourCC('AEEE')
    else
        udg_AbilityQ[playerId] = udg_Ability_Purchase_AbilityQ[udg_save_read_data[currentIndex + 1]]
        UnitAddAbility(unit, udg_AbilityQ[playerId])
        SetUnitAbilityLevel(unit, udg_AbilityQ[playerId], udg_save_read_data[currentIndex + 2])
    end

    if udg_save_read_data[currentIndex + 3] == 0 then
        udg_AbilityW[playerId] = FourCC('AEEE')
    else
        udg_AbilityW[playerId] = udg_Ability_Purchase_AbilityW[udg_save_read_data[currentIndex + 3]]
        UnitAddAbility(unit, udg_AbilityW[playerId])
        SetUnitAbilityLevel(unit, udg_AbilityW[playerId], udg_save_read_data[currentIndex + 4])
    end

    if udg_save_read_data[currentIndex + 5] == 0 then
        udg_AbilityE[playerId] = FourCC('AEEE')
    else
        udg_AbilityE[playerId] = udg_Ability_Purchase_AbilityE[udg_save_read_data[currentIndex + 5]]
        UnitAddAbility(unit, udg_AbilityE[playerId])
        SetUnitAbilityLevel(unit, udg_AbilityE[playerId], udg_save_read_data[currentIndex + 6])
    end

    if udg_save_read_data[currentIndex + 7] == 0 then
        udg_AbilityR[playerId] = FourCC('AEEE')
    else
        udg_AbilityR[playerId] = udg_Ability_Purchase_AbilityQ[udg_save_read_data[currentIndex + 7]]
        UnitAddAbility(unit, udg_AbilityR[playerId])
        SetUnitAbilityLevel(unit, udg_AbilityR[playerId], udg_save_read_data[currentIndex + 8])
    end

    if udg_save_read_data[currentIndex + 9] == 0 then
        udg_AbilityF[playerId] = FourCC('AEEE')
    else
        udg_AbilityF[playerId] = udg_Ability_Purchase_AbilityQ[udg_save_read_data[currentIndex + 9]]
        UnitAddAbility(unit, udg_AbilityF[playerId])
        SetUnitAbilityLevel(unit, udg_AbilityF[playerId], udg_save_read_data[currentIndex + 10])
    end

    if udg_save_read_data[currentIndex + 11] == 0 then
        udg_AbilityG[playerId] = FourCC('AEEE')
    else
        udg_AbilityG[playerId] = udg_Ability_Purchase_AbilityG[udg_save_read_data[currentIndex + 11]]
        UnitAddAbility(unit, udg_AbilityG[playerId])
        SetUnitAbilityLevel(unit, udg_AbilityG[playerId], udg_save_read_data[currentIndex + 12])
    end
    --Abilities

    -- Ability Point
    local currentIndex = 285
    SetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER, udg_save_read_data[currentIndex + 1])
    -- Ability Point

    -- Settings
    local currentIndex = 286
    udg_Settings_ShowGold[playerId] = udg_save_read_data[currentIndex + 1]
    udg_Settings_ShowEXP[playerId] = udg_save_read_data[currentIndex + 2]
    udg_Settings_ShowHealTaken[playerId] = udg_save_read_data[currentIndex + 3]
    udg_Settings_ShowHealGive[playerId] = udg_save_read_data[currentIndex + 4]
    udg_Settings_ShowDamageTaken[playerId] = udg_save_read_data[currentIndex + 5]
    udg_Settings_ShowDamageDealt[playerId] = udg_save_read_data[currentIndex + 6]
    udg_Settings_ShowNotes[playerId] = udg_save_read_data[currentIndex + 7]
    udg_Settings_ShowAllAchivements[playerId] = udg_save_read_data[currentIndex + 8]
    -- Settings

    local currentIndex = 294

    notesRefresh(player)
    achivementsRefresh(player)
    calculateUnitStats(unit)
end