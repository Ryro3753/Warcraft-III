function getFirstEmptySlot(player)
    local playerId = GetPlayerId(player) + 1
    for i=15,102 do
        local slotId = LoadIntegerBJ(i, playerId, udg_INV_ItemId_Hashtable)
        if slotId == 0 then
            return i
        end
    end
    return 0
end


function getItemId(itemType)
    for i=1,udg_ITEM_Limit do
        if itemType == udg_ITEM_Item_Type[i] then
            return i
        end
    end
    return 0
end

function checkIfChargableItemOwned(itemId, player)
    local playerId = GetPlayerId(player) + 1
    for i=1,udg_INV_Slot_Limit do
        local slotId = LoadIntegerBJ(i, playerId, udg_INV_ItemId_Hashtable)
        if itemId == slotId then
            return i
        end
    end
    return 0
end

function getFirstEmptyConsumableSlot(player)
    local playerId = GetPlayerId(player) + 1
    for i=103,107 do
        local slotId = LoadIntegerBJ(i, playerId, udg_INV_ItemId_Hashtable)
        if slotId == 0 then
            return i
        end
    end
    return 0
end

function equipItemStat(unit, itemId)
    local unitId = GetUnitUserData(unit)
    udg_Stat_Health[unitId] = udg_Stat_Health[unitId] + udg_ITEM_Health[itemId]
    udg_Stat_Health_Modifier[unitId] = udg_Stat_Health_Modifier[unitId] + udg_ITEM_Health_Modifier[itemId]
    udg_Stat_Mana[unitId] = udg_Stat_Mana[unitId] + udg_ITEM_Mana[itemId]
    udg_Stat_Mana_Modifier[unitId] = udg_Stat_Mana_Modifier[unitId] + udg_ITEM_Mana_Modifier[itemId]
    udg_Stat_Strength[unitId] = udg_Stat_Strength[unitId] + udg_ITEM_Strength[itemId]
    udg_Stat_Strength_Modifier[unitId] = udg_Stat_Strength_Modifier[unitId] + udg_ITEM_Strength_Modifier[itemId]
    udg_Stat_Agility[unitId] = udg_Stat_Agility[unitId] + udg_ITEM_Agility[itemId]
    udg_Stat_Agility_Modifier[unitId] = udg_Stat_Agility_Modifier[unitId] + udg_ITEM_Agility_Modifier[itemId]
    udg_Stat_Intelligence[unitId] = udg_Stat_Intelligence[unitId] + udg_ITEM_Intelligence[itemId]
    udg_Stat_Intelligence_Modifier[unitId] = udg_Stat_Intelligence_Modifier[unitId] + udg_ITEM_Intelligence_Modifier[itemId]
    udg_Stat_Health_Regen[unitId] = udg_Stat_Health_Regen[unitId] + udg_ITEM_Health_Regen[itemId]
    udg_Stat_Mana_Regen[unitId] = udg_Stat_Mana_Regen[unitId] + udg_ITEM_Mana_Regen[itemId]
    udg_Stat_Armor[unitId] = udg_Stat_Armor[unitId] + udg_ITEM_Armor[itemId]
    udg_Stat_Armor_Modifier[unitId] = udg_Stat_Armor_Modifier[unitId] + udg_ITEM_Armor_Modifier[itemId]
    udg_Stat_Damage_Reduction[unitId] = udg_Stat_Damage_Reduction[unitId] + udg_ITEM_Damage_Reduction[itemId]
    udg_Stat_Damage_Taken[unitId] = udg_Stat_Damage_Taken[unitId] + udg_ITEM_Damage_Taken[itemId]
    udg_Stat_Attack_Speed[unitId] = udg_Stat_Attack_Speed[unitId] + udg_ITEM_Attack_Speed[itemId]
    udg_Stat_Critical_Chance[unitId] = udg_Stat_Critical_Chance[unitId] + udg_ITEM_Critical_Chance[itemId]
    udg_Stat_Critical_Damage_Rate[unitId] = udg_Stat_Critical_Damage_Rate[unitId] + udg_ITEM_Critical_Damage_Rate[itemId]
    udg_Stat_Dodge[unitId] = udg_Stat_Dodge[unitId] + udg_ITEM_Dodge[itemId]
    udg_Stat_Parry[unitId] = udg_Stat_Parry[unitId] + udg_ITEM_Parry[itemId]
    udg_Stat_Block[unitId] = udg_Stat_Block[unitId] + udg_ITEM_Block[itemId]
    udg_Stat_Block_Enabled[unitId] = udg_Stat_Block_Enabled[unitId] + udg_ITEM_IsBlockActive[itemId]
    udg_Stat_Miss[unitId] = udg_Stat_Miss[unitId] + udg_ITEM_Miss[itemId]
    udg_Stat_Attack_Damage[unitId] = udg_Stat_Attack_Damage[unitId] + udg_ITEM_Attack_Damage[itemId]
    udg_Stat_Attack_Damage_Modifier[unitId] = udg_Stat_Attack_Damage_Modifier[unitId] + udg_ITEM_Attack_Damage_Modifier[itemId]
    udg_Stat_Spell_Damage[unitId] = udg_Stat_Spell_Damage[unitId] + udg_ITEM_Spell_Damage[itemId]
    udg_Stat_Spell_Damage_Modifier[unitId] = udg_Stat_Spell_Damage_Modifier[unitId] + udg_ITEM_Spell_Damage_Modifier[itemId]
    udg_Stat_Cooldown[unitId] = udg_Stat_Cooldown[unitId] + udg_ITEM_Cooldown[itemId]
    udg_Stat_Casting_Speed[unitId] = udg_Stat_Casting_Speed[unitId] + udg_ITEM_Casting_Speed[itemId]
    udg_Stat_Movement_Speed[unitId] = udg_Stat_Movement_Speed[unitId] + udg_ITEM_Movement_Speed[itemId]
    udg_Stat_Healing_Taken[unitId] = udg_Stat_Healing_Taken[unitId] + udg_ITEM_Healing_Taken[itemId]
    udg_Stat_Healing_Reduce[unitId] = udg_Stat_Healing_Reduce[unitId] + udg_ITEM_Healing_Reduce[itemId]
    udg_Stat_Life_Steal[unitId] = udg_Stat_Life_Steal[unitId] + udg_ITEM_Life_Steal[itemId]
end


function unEquipItemStat(unit, itemId)
    local unitId = GetUnitUserData(unit)
    udg_Stat_Health[unitId] = udg_Stat_Health[unitId] - udg_ITEM_Health[itemId]
    udg_Stat_Health_Modifier[unitId] = udg_Stat_Health_Modifier[unitId] - udg_ITEM_Health_Modifier[itemId]
    udg_Stat_Mana[unitId] = udg_Stat_Mana[unitId] - udg_ITEM_Mana[itemId]
    udg_Stat_Mana_Modifier[unitId] = udg_Stat_Mana_Modifier[unitId] - udg_ITEM_Mana_Modifier[itemId]
    udg_Stat_Strength[unitId] = udg_Stat_Strength[unitId] - udg_ITEM_Strength[itemId]
    udg_Stat_Strength_Modifier[unitId] = udg_Stat_Strength_Modifier[unitId] - udg_ITEM_Strength_Modifier[itemId]
    udg_Stat_Agility[unitId] = udg_Stat_Agility[unitId] - udg_ITEM_Agility[itemId]
    udg_Stat_Agility_Modifier[unitId] = udg_Stat_Agility_Modifier[unitId] - udg_ITEM_Agility_Modifier[itemId]
    udg_Stat_Intelligence[unitId] = udg_Stat_Intelligence[unitId] - udg_ITEM_Intelligence[itemId]
    udg_Stat_Intelligence_Modifier[unitId] = udg_Stat_Intelligence_Modifier[unitId] - udg_ITEM_Intelligence_Modifier[itemId]
    udg_Stat_Health_Regen[unitId] = udg_Stat_Health_Regen[unitId] - udg_ITEM_Health_Regen[itemId]
    udg_Stat_Mana_Regen[unitId] = udg_Stat_Mana_Regen[unitId] - udg_ITEM_Mana_Regen[itemId]
    udg_Stat_Armor[unitId] = udg_Stat_Armor[unitId] - udg_ITEM_Armor[itemId]
    udg_Stat_Armor_Modifier[unitId] = udg_Stat_Armor_Modifier[unitId] - udg_ITEM_Armor_Modifier[itemId]
    udg_Stat_Damage_Reduction[unitId] = udg_Stat_Damage_Reduction[unitId] - udg_ITEM_Damage_Reduction[itemId]
    udg_Stat_Damage_Taken[unitId] = udg_Stat_Damage_Taken[unitId] - udg_ITEM_Damage_Taken[itemId]
    udg_Stat_Attack_Speed[unitId] = udg_Stat_Attack_Speed[unitId] - udg_ITEM_Attack_Speed[itemId]
    udg_Stat_Critical_Chance[unitId] = udg_Stat_Critical_Chance[unitId] - udg_ITEM_Critical_Chance[itemId]
    udg_Stat_Critical_Damage_Rate[unitId] = udg_Stat_Critical_Damage_Rate[unitId] - udg_ITEM_Critical_Damage_Rate[itemId]
    udg_Stat_Dodge[unitId] = udg_Stat_Dodge[unitId] - udg_ITEM_Dodge[itemId]
    udg_Stat_Parry[unitId] = udg_Stat_Parry[unitId] - udg_ITEM_Parry[itemId]
    udg_Stat_Block[unitId] = udg_Stat_Block[unitId] - udg_ITEM_Block[itemId]
    udg_Stat_Block_Enabled[unitId] = udg_Stat_Block_Enabled[unitId] - udg_ITEM_IsBlockActive[itemId]
    udg_Stat_Miss[unitId] = udg_Stat_Miss[unitId] - udg_ITEM_Miss[itemId]
    udg_Stat_Attack_Damage[unitId] = udg_Stat_Attack_Damage[unitId] - udg_ITEM_Attack_Damage[itemId]
    udg_Stat_Spell_Damage[unitId] = udg_Stat_Spell_Damage[unitId] - udg_ITEM_Spell_Damage[itemId]
    udg_Stat_Spell_Damage_Modifier[unitId] = udg_Stat_Spell_Damage_Modifier[unitId] - udg_ITEM_Spell_Damage_Modifier[itemId]
    udg_Stat_Cooldown[unitId] = udg_Stat_Cooldown[unitId] - udg_ITEM_Cooldown[itemId]
    udg_Stat_Casting_Speed[unitId] = udg_Stat_Casting_Speed[unitId] - udg_ITEM_Casting_Speed[itemId]
    udg_Stat_Movement_Speed[unitId] = udg_Stat_Movement_Speed[unitId] - udg_ITEM_Movement_Speed[itemId]
    udg_Stat_Healing_Taken[unitId] = udg_Stat_Healing_Taken[unitId] - udg_ITEM_Healing_Taken[itemId]
    udg_Stat_Healing_Reduce[unitId] = udg_Stat_Healing_Reduce[unitId] - udg_ITEM_Healing_Reduce[itemId]
    udg_Stat_Life_Steal[unitId] = udg_Stat_Life_Steal[unitId] - udg_ITEM_Life_Steal[itemId]
end


function getUnitTypeStatId(unit)
    local unitType = GetUnitTypeId(unit)
    
    for i=1,udg_Stat_Assign_Limit do
        if FourCC(udg_Stat_Assign_Unit_Type[i]) == unitType then
            unitType = nil
            return i
        end
    end
    unitType = nil
    return 0
end

function assignStatsInit(unit)
    local unitId = GetUnitUserData(unit)
    local unitTypeId = getUnitTypeStatId(unit)

    if unitTypeId == 0 then
        print("There is a unit that isn't registered")
        return
    end

    local adjustmentGeneralRatio, adjustmentCombatRatio = adjustmentRatioGet(unit)

    udg_Stat_Health[unitId] = R2I(udg_Stat_Health_Assign[unitTypeId] * adjustmentGeneralRatio)
    udg_Stat_Health_Modifier[unitId] = 100
    udg_Stat_Health_Flat[unitId] = 0

    udg_Stat_Mana[unitId] = R2I(udg_Stat_Mana_Assign[unitTypeId] * adjustmentGeneralRatio)
    udg_Stat_Mana_Modifier[unitId] = 100
    udg_Stat_Mana_Flat[unitId] = 0

    if IsUnitType(unit, UNIT_TYPE_HERO) == true then
        udg_Stat_Strength[unitId] = R2I(udg_Stat_Strength_Assign[unitTypeId] * adjustmentCombatRatio)
        udg_Stat_Strength_Modifier[unitId] = 100
        udg_Stat_Strength_Flat[unitId] = 0

        udg_Stat_Agility[unitId] = R2I(udg_Stat_Agility_Assign[unitTypeId] * adjustmentCombatRatio)
        udg_Stat_Agility_Modifier[unitId] = 100
        udg_Stat_Agility_Flat[unitId] = 0

        udg_Stat_Intelligence[unitId] = R2I(udg_Stat_Intelligence_Assign[unitTypeId] * adjustmentCombatRatio)
        udg_Stat_Intelligence_Modifier[unitId] = 100
        udg_Stat_Intelligence_Flat[unitId] = 0
    end

    udg_Stat_Health_Regen[unitId] = udg_Stat_Health_Regen_Assign[unitTypeId] * adjustmentGeneralRatio

    udg_Stat_Mana_Regen[unitId] = udg_Stat_Mana_Regen_Assign[unitTypeId] * adjustmentGeneralRatio

    udg_Stat_Armor[unitId] = udg_Stat_Armor_Assign[unitTypeId] 
    udg_Stat_Armor_Modifier[unitId] = 100
    udg_Stat_Armor_Flat[unitId] = 0

    udg_Stat_Critical_Chance[unitId] = udg_Stat_Critical_Chance_Assign[unitTypeId] * adjustmentCombatRatio

    udg_Stat_Critical_Damage_Rate[unitId] = udg_Stat_Critical_Damage_Rate_As[unitTypeId]

    udg_Stat_Damage_Taken[unitId] = 0

    udg_Stat_Attack_Speed[unitId] = 0

    udg_Stat_Attack_Interval[unitId] = BlzGetUnitAttackCooldown(unit, 0)

    udg_Stat_Dodge[unitId] = udg_Stat_Dodge_Assign[unitTypeId] * adjustmentCombatRatio

    udg_Stat_Parry[unitId] = udg_Stat_Parry_Assign[unitTypeId] * adjustmentCombatRatio
    
    udg_Stat_Block[unitId] = udg_Stat_Block_Assign[unitTypeId] * adjustmentCombatRatio
    udg_Stat_Block_Enabled[unitId] = udg_Stat_Block_Enabled_Assign[unitTypeId]

    udg_Stat_Miss[unitId] = udg_Stat_Miss_Assign[unitTypeId] * adjustmentCombatRatio

    udg_Stat_Attack_Damage[unitId] = R2I(udg_Stat_Attack_Damage_Assign[unitTypeId] * adjustmentCombatRatio)
    udg_Stat_Attack_Damage_Modifier[unitId] = 100
    udg_Stat_Attack_Damage_Flat[unitId] = 0

    udg_Stat_Spell_Damage[unitId] = R2I(udg_Stat_Spell_Damage_Assign[unitTypeId] * adjustmentCombatRatio)
    udg_Stat_Spell_Damage_Modifier[unitId] = 100
    udg_Stat_Spell_Damage_Flat[unitId] = 0

    udg_Stat_Life_Steal[unitId] = udg_Stat_Life_Steal_Assign[unitTypeId] * adjustmentCombatRatio

    udg_Stat_Cooldown[unitId] = 0

    udg_Stat_Casting_Speed[unitId] = 0

    udg_Stat_Movement_Speed[unitId] = 0

    udg_Stat_Healing_Taken[unitId] = 0

    udg_Stat_Healing_Reduce[unitId] = 0

    calculateUnitStats(unit)
end


function equipItem(player)
    local playerId = GetPlayerId(player) + 1
    local currentItemIndex = udg_INV_Player_Current_Index[playerId]
    local currentItemId = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
    local itemSlot = udg_ITEM_Slot[currentItemId]

    --If unit trying to equip a consumable or not an equipable item quit the function and show error message
    if (itemSlot < 1 or itemSlot > 15) and itemSlot ~= 78 then
        DisplayTextToPlayer(player, 0, 0, "This item is not equipable")
        return
    end

    local requiredLevel = udg_ITEM_Required_Level[currentItemId]
    local unitLevel = GetUnitLevel(udg_INV_Player_Hero[playerId])
    if requiredLevel > unitLevel then
        DisplayTextToPlayer(player, 0, 0, "Hero needs higher level to wear this item")
        return
    end

    local alreadyOccupiedId = 0
    if itemSlot == 78 then
         alreadyOccupiedId = LoadIntegerBJ(7, playerId, udg_INV_ItemId_Hashtable)
         if alreadyOccupiedId == 0  then
            alreadyOccupiedId = LoadIntegerBJ(8, playerId, udg_INV_ItemId_Hashtable)
         end
    else
         alreadyOccupiedId = LoadIntegerBJ(itemSlot, playerId, udg_INV_ItemId_Hashtable)
    end
    local equippedSlot = 0
    if alreadyOccupiedId ~= 0 then
         equippedSlot = udg_ITEM_Slot[alreadyOccupiedId]
    end
    --Check if item is two handed weapon or if already equipped a two handed weapon, if so we have to handle it different since it occupy 2 slots 
    if itemSlot == 78 or equippedSlot == 78 then
        if itemSlot == 78 and equippedSlot == 78 then
            local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
            local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
            local offnHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
            RemoveDestructable(LoadDestructableHandleBJ(itemSlot, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))

            --Create item slot at backpack
            CreateDestructableLoc(udg_ITEM_Destructible[alreadyOccupiedId], currentSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(alreadyOccupiedId, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

            --Create new item on unit main and off hand
            CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], mainHandSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(currentItemId, 7, playerId, udg_INV_ItemId_Hashtable)
            CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], offnHandSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(currentItemId, 8, playerId, udg_INV_ItemId_Hashtable)

            --Stats
            unEquipItemStat(udg_INV_Player_Hero[playerId],alreadyOccupiedId);
            equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

            currentSlotPoint = nil
            mainHandSlotPoint = nil
            offnHandSlotPoint = nil
        elseif itemSlot == 78 and equippedSlot == 0 then
            --Checking if unit doesn't have any main or off hand and trying to equip two hand
            local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
            local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
            local offHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
            RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))

            --Create empty item slot at backpack
            CreateDestructableLoc(udg_INV_EmptySlot, currentSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

            --Create new item on unit main and off hand
            CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], mainHandSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(currentItemId, 7, playerId, udg_INV_ItemId_Hashtable)
            CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], offHandSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(currentItemId, 8, playerId, udg_INV_ItemId_Hashtable)

            equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

            currentSlotPoint = nil
            mainHandSlotPoint = nil
            offnHandSlotPoint = nil

        elseif itemSlot == 78 and equippedSlot ~= 78 then
            --Check if both main and off hand occupied if so we have to check if there is an empty slot
            local mainHandOccupied = LoadIntegerBJ(7, playerId, udg_INV_ItemId_Hashtable)
            local offHandOccupied = LoadIntegerBJ(8, playerId, udg_INV_ItemId_Hashtable)

            if mainHandOccupied ~= 0 and offHandOccupied ~= 0 then
                local emptySlot = getFirstEmptySlot(player)
                if emptySlot == 0 then
                    DisplayTextToPlayer(player, 0, 0, "Your inventory is full")
                    return
                end
                local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
                local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
                local offHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
                local emptySlotPoint = LoadLocationHandleBJ(emptySlot, playerId, udg_INV_Point_Hashtable)
                unEquipItemStat(udg_INV_Player_Hero[playerId],mainHandOccupied);
                unEquipItemStat(udg_INV_Player_Hero[playerId],offHandOccupied);
                equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

                --Remove all destructables including empty slot
                RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
                RemoveDestructable(LoadDestructableHandleBJ(emptySlot, playerId, udg_INV_Destructible_Hashtable))
                RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
                RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))

                --Creating desc at main and off hand slots
                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], mainHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, 7, playerId, udg_INV_ItemId_Hashtable)
                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], offHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, 8, playerId, udg_INV_ItemId_Hashtable)

                --Creating main hand on current item index
                CreateDestructableLoc(udg_ITEM_Destructible[mainHandOccupied], currentSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(mainHandOccupied, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

                --Creating off hand on empty slot
                CreateDestructableLoc(udg_ITEM_Destructible[offHandOccupied], emptySlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), emptySlot, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(offHandOccupied, emptySlot, playerId, udg_INV_ItemId_Hashtable)

                currentSlotPoint = nil
                mainHandSlotPoint = nil
                offHandSlotPoint = nil
                emptySlotPoint = nil
                elseif mainHandOccupied ~= 0 and offHandOccupied == 0 then
                local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
                local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
                local offHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
                unEquipItemStat(udg_INV_Player_Hero[playerId],mainHandOccupied);
                equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

                RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
                RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
                RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))

                --Creating desc at main and off hand slots
                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], mainHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, 7, playerId, udg_INV_ItemId_Hashtable)
                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], offHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, 8, playerId, udg_INV_ItemId_Hashtable)

                --Creating main hand on current item index
                CreateDestructableLoc(udg_ITEM_Destructible[mainHandOccupied], currentSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(mainHandOccupied, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

                currentSlotPoint = nil
                mainHandSlotPoint = nil
                offHandSlotPoint = nil
                elseif mainHandOccupied == 0 and offHandOccupied ~= 0 then

                local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
                local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
                local offHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
                unEquipItemStat(udg_INV_Player_Hero[playerId],offHandOccupied);
                equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

                RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
                RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
                RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))

                --Creating desc at main and off hand slots
                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], mainHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, 7, playerId, udg_INV_ItemId_Hashtable)
                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], offHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, 8, playerId, udg_INV_ItemId_Hashtable)

                --Creating main hand on current item index
                CreateDestructableLoc(udg_ITEM_Destructible[offHandOccupied], currentSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(offHandOccupied, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

                currentSlotPoint = nil
                mainHandSlotPoint = nil
                offHandSlotPoint = nil
            end
        elseif itemSlot ~= 78 and equippedSlot == 78 then
            local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
            local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
            local offHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
            RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))

            --Create two handed weapon on backpack again
            CreateDestructableLoc(udg_ITEM_Destructible[alreadyOccupiedId], currentSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(alreadyOccupiedId, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

            --Create empty slot on mainhand slot or off hand slot depends on current items slot
            if itemSlot == 7 then
                CreateDestructableLoc(udg_INV_Equipable_EmptySlots[8], offHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(0, 8, playerId, udg_INV_ItemId_Hashtable)

                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], mainHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), itemSlot, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, itemSlot, playerId, udg_INV_ItemId_Hashtable)
            elseif itemSlot == 8 then
                CreateDestructableLoc(udg_INV_Equipable_EmptySlots[7], mainHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(0, 7, playerId, udg_INV_ItemId_Hashtable)

                CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], offHandSlotPoint, 270, 1.5, 0)
                SaveDestructableHandleBJ(GetLastCreatedDestructable(), itemSlot, playerId, udg_INV_Destructible_Hashtable)
                SaveIntegerBJ(currentItemId, itemSlot, playerId, udg_INV_ItemId_Hashtable)
            end

            equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);
            unEquipItemStat(udg_INV_Player_Hero[playerId],alreadyOccupiedId);

            currentSlotPoint = nil
            mainHandSlotPoint = nil
            offHandSlotPoint = nil
        end
    else
        --Check if slot has already occupied with another item
        if alreadyOccupiedId ~= 0 then
            local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
            local equipSlotPoint = LoadLocationHandleBJ(itemSlot, playerId, udg_INV_Point_Hashtable)
            RemoveDestructable(LoadDestructableHandleBJ(itemSlot, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
            CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], equipSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), itemSlot, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(currentItemId, itemSlot, playerId, udg_INV_ItemId_Hashtable)
            CreateDestructableLoc(udg_ITEM_Destructible[alreadyOccupiedId], currentSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(alreadyOccupiedId, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
            unEquipItemStat(udg_INV_Player_Hero[playerId],alreadyOccupiedId);
            equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

            currentSlotPoint = nil
            equipSlotPoint = nil
        else
            local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
            local equipSlotPoint = LoadLocationHandleBJ(itemSlot, playerId, udg_INV_Point_Hashtable)
            RemoveDestructable(LoadDestructableHandleBJ(itemSlot, playerId, udg_INV_Destructible_Hashtable))
            RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
            CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], equipSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), itemSlot, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(currentItemId, itemSlot, playerId, udg_INV_ItemId_Hashtable)
            CreateDestructableLoc(udg_INV_EmptySlot, currentSlotPoint, 270, 1.5, 0)
            SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
            SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
            equipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

            currentSlotPoint = nil
            equipSlotPoint = nil
        end
    end

    calculateUnitStats(udg_INV_Player_Hero[playerId])
    inventoryItemMultiboardRefresh(player)
end

function unEquipItem(player)
    local playerId = GetPlayerId(player) + 1
    local currentItemIndex = udg_INV_Player_Current_Index[playerId]
    local currentItemId = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

    --If unit trying to equip a consumable or not an equipable item quit the function and show error message
    if currentItemIndex < 1 or currentItemIndex > 14 or currentItemId == 0 then
        DisplayTextToPlayer(player, 0, 0, "You can only unEquip already equipped item")
        return
    end

    local emptySlot = getFirstEmptySlot(player)
    if emptySlot == 0 then
        DisplayTextToPlayer(player, 0, 0, "Your inventory is full")
        return
    end

    local itemSlot = udg_ITEM_Slot[currentItemId]
    if itemSlot == 78 then
        local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
        local offHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
        local emptySlotPoint = LoadLocationHandleBJ(emptySlot, playerId, udg_INV_Point_Hashtable)

        RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
        RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))
        RemoveDestructable(LoadDestructableHandleBJ(emptySlot, playerId, udg_INV_Destructible_Hashtable))

        CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], emptySlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), emptySlot, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(currentItemId, emptySlot, playerId, udg_INV_ItemId_Hashtable)

        CreateDestructableLoc(udg_INV_Equipable_EmptySlots[7], mainHandSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, 7, playerId, udg_INV_ItemId_Hashtable)
        CreateDestructableLoc(udg_INV_Equipable_EmptySlots[8], offHandSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, 8, playerId, udg_INV_ItemId_Hashtable)
    else
        local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
        local emptySlotPoint = LoadLocationHandleBJ(emptySlot, playerId, udg_INV_Point_Hashtable)

        RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
        RemoveDestructable(LoadDestructableHandleBJ(emptySlot, playerId, udg_INV_Destructible_Hashtable))

        CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], emptySlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), emptySlot, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(currentItemId, emptySlot, playerId, udg_INV_ItemId_Hashtable)

        CreateDestructableLoc(udg_INV_Equipable_EmptySlots[itemSlot], currentSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

    end
    unEquipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

    calculateUnitStats(udg_INV_Player_Hero[playerId])
    inventoryItemMultiboardRefresh(player)
end

function dropItem(player)
    local playerId = GetPlayerId(player) + 1
    local currentItemIndex = udg_INV_Player_Current_Index[playerId]
    local currentItemId = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
    local currentCharge = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)
    local currentItemSlot = udg_ITEM_Slot[currentItemId]
    if currentItemId == 0 then
        return
    end
    local isEquipped = false
    local isConsumable = false
    local isTwoHanded = false
    --Check if item is equipped 
    if currentItemIndex < 15 or currentItemIndex > 102 then
        isEquipped = true
    end
    --Check if item is consumable 
    if currentCharge ~= 0 then
        isConsumable = true
    end
    --Check if item is two handed if so we need to remove off and main hand
    if udg_ITEM_Slot[currentItemId] == 78 then
        isTwoHanded = true
    end

     if isTwoHanded == true and isEquipped == true and isConsumable == false then
        --Creating empty slot at main and off hand slots
        local mainHandSlotPoint = LoadLocationHandleBJ(7, playerId, udg_INV_Point_Hashtable)
        local offHandSlotPoint = LoadLocationHandleBJ(8, playerId, udg_INV_Point_Hashtable)
        RemoveDestructable(LoadDestructableHandleBJ(7, playerId, udg_INV_Destructible_Hashtable))
        RemoveDestructable(LoadDestructableHandleBJ(8, playerId, udg_INV_Destructible_Hashtable))
        CreateDestructableLoc(udg_INV_Equipable_EmptySlots[7], mainHandSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), 7, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, 7, playerId, udg_INV_ItemId_Hashtable)
        CreateDestructableLoc(udg_INV_Equipable_EmptySlots[8], offHandSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), 8, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, 8, playerId, udg_INV_ItemId_Hashtable)
        unEquipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

        mainHandSlotPoint = nil
        offHandSlotPoint = nil
     elseif isConsumable == true and isEquipped == true and isTwoHanded == false then
        --Creating empty slot at quickbar
        local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
        RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
        CreateDestructableLoc(udg_INV_Consumable_EmptySlot, currentSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
        SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)

        --Remove item from the hero's real backpack
        RemoveItem(UnitItemInSlot(udg_INV_Player_Hero[playerId], currentItemIndex - 103))
        currentSlotPoint = nil
    elseif isConsumable == false and isEquipped == true and isTwoHanded == false then
        --Creating Empty Equipable slot at inventory (Helm, Necklance etc.)
        local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
        RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
        CreateDestructableLoc(udg_INV_Equipable_EmptySlots[currentItemSlot], currentSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
        unEquipItemStat(udg_INV_Player_Hero[playerId],currentItemId);

        currentSlotPoint = nil
    elseif isEquipped == false then
        --Creating Empty slot at inventory
        RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
        local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
        CreateDestructableLoc(udg_INV_EmptySlot, currentSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)

        currentSlotPoint = nil
    end


    local heroPoint = GetUnitLoc(udg_INV_Player_Hero[playerId])
    CreateItemLoc(udg_ITEM_Item_Type[currentItemId], heroPoint)
    local item = GetLastCreatedItem()
    if isConsumable == true then
        SetItemCharges(item, currentCharge)
        SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)
    end
    if udg_ITEM_Soulbind[currentItemId] == true then
        BlzSetItemIntegerField(item, ITEM_IF_LEVEL, 10 + playerId)
    end
    RemoveLocation(heroPoint)
    calculateUnitStats(udg_INV_Player_Hero[playerId])
    inventoryItemMultiboardRefresh(player)
end

function equipItemQuickbar(player)
    local playerId = GetPlayerId(player) + 1
    local emptyConsumableSlot = getFirstEmptyConsumableSlot(player)
    if emptyConsumableSlot == 0 then
        DisplayTextToPlayer(player, 0, 0, "Your quickbar is full")
        return
    end
    local currentItemIndex = udg_INV_Player_Current_Index[playerId]
    local currentItemId = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
    local charges = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)

    if currentItemIndex < 15 or currentItemIndex > 102 then
        return
    end

    if charges == 0 then
        DisplayTextToPlayer(player, 0, 0, "This item is not a consumable")
        return
    end

    local requiredLevel = udg_ITEM_Required_Level[currentItemId]
    local unitLevel = GetUnitLevel(udg_INV_Player_Hero[playerId])
    if requiredLevel > unitLevel then
        DisplayTextToPlayer(player, 0, 0, "Hero needs higher level to wear this item")
        return
    end

    local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
    local emptySlotPoint = LoadLocationHandleBJ(emptyConsumableSlot, playerId, udg_INV_Point_Hashtable)

    RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
    RemoveDestructable(LoadDestructableHandleBJ(emptyConsumableSlot, playerId, udg_INV_Destructible_Hashtable))

    CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], emptySlotPoint, 270, 1.5, 0)
    SaveDestructableHandleBJ(GetLastCreatedDestructable(), emptyConsumableSlot, playerId, udg_INV_Destructible_Hashtable)
    SaveIntegerBJ(currentItemId, emptyConsumableSlot, playerId, udg_INV_ItemId_Hashtable)
    SaveIntegerBJ(charges, emptyConsumableSlot, playerId, udg_INV_ItemCharges_Hashtable)

    CreateDestructableLoc(udg_INV_EmptySlot, currentSlotPoint, 270, 1.5, 0)
    SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
    SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
    SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)

    DisableTrigger(gg_trg_Item_System_Acquire)
    UnitAddItemByIdSwapped( udg_ITEM_Item_Type[currentItemId], udg_INV_Player_Hero[playerId] )
    SetItemCharges(GetLastCreatedItem(), charges)
    EnableTrigger(gg_trg_Item_System_Acquire)

    inventoryItemMultiboardRefresh(player)
end

function unEquipItemQuickbar(player)
    local playerId = GetPlayerId(player) + 1
    local emptySlot = getFirstEmptySlot(player)
    if emptySlot == 0 then
        DisplayTextToPlayer(player, 0, 0, "Your inventory is full")
        return
    end

    local currentItemIndex = udg_INV_Player_Current_Index[playerId]
    local currentItemId = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
    local charges = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)

    if currentItemIndex < 102 or currentItemId == 0 then
        return
    end

    local currentSlotPoint = LoadLocationHandleBJ(currentItemIndex, playerId, udg_INV_Point_Hashtable)
    local emptySlotPoint = LoadLocationHandleBJ(emptySlot, playerId, udg_INV_Point_Hashtable)

    RemoveDestructable(LoadDestructableHandleBJ(currentItemIndex, playerId, udg_INV_Destructible_Hashtable))
    RemoveDestructable(LoadDestructableHandleBJ(emptySlot, playerId, udg_INV_Destructible_Hashtable))

    CreateDestructableLoc(udg_ITEM_Destructible[currentItemId], emptySlotPoint, 270, 1.5, 0)
    SaveDestructableHandleBJ(GetLastCreatedDestructable(), emptySlot, playerId, udg_INV_Destructible_Hashtable)
    SaveIntegerBJ(currentItemId, emptySlot, playerId, udg_INV_ItemId_Hashtable)
    SaveIntegerBJ(charges, emptySlot, playerId, udg_INV_ItemCharges_Hashtable)

    CreateDestructableLoc(udg_INV_Consumable_EmptySlot, currentSlotPoint, 270, 1.5, 0)
    SaveDestructableHandleBJ(GetLastCreatedDestructable(), currentItemIndex, playerId, udg_INV_Destructible_Hashtable)
    SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
    SaveIntegerBJ(0, currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)

    RemoveItem(UnitItemInSlot(udg_INV_Player_Hero[playerId], currentItemIndex - 103))

    inventoryItemMultiboardRefresh(player)
end


function sellItem(player)
    local playerId = GetPlayerId(player) + 1
    local currentItemIndex = udg_INV_Player_Current_Index[playerId]
    local currentItemId = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemId_Hashtable)
    local charges = LoadIntegerBJ(currentItemIndex, playerId, udg_INV_ItemCharges_Hashtable)
    local itemGold = udg_ITEM_Gold[currentItemId]
    dropItem(player)
    RemoveItem(GetLastCreatedItem())
    --Check if item has charges if so multiply gold with that charge
    if charges ~= 0 then
        itemGold = itemGold * charges
    end
    local playerGold = GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD)
    SetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD, playerGold + itemGold)
end

function sellItemCheckIfMerchantNearby(player)
    local playerId = GetPlayerId(player) + 1
    local loc = GetUnitLoc(udg_INV_Player_Hero[playerId])

    local group = GetUnitsInRangeOfLocMatching(1000, loc, Condition(sellItemCheckIfMerchantNearbyFilter))
    if CountUnitsInGroup(group) > 0 then
        SetPlayerAbilityAvailable(player, FourCC('A005'), true)
    else
        SetPlayerAbilityAvailable(player, FourCC('A005'), false)
    end

    DestroyGroup(group)
    RemoveLocation(loc)

    group = nil
    loc = nil
end

function sellItemCheckIfMerchantNearbyFilter()
    if GetUnitAbilityLevel(GetFilterUnit(), FourCC('Aneu')) > 0 then
        return true
    else
        return false
    end
end


function useItem(unit, itemId)
    local usedSlot = nil
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player) + 1
    for i=0,4 do
        if itemId == GetItemTypeId(UnitItemInSlot(unit, i)) then
            usedSlot = i
        end
    end
    local backpackSlot = usedSlot + 103
    
    local currentCharge = LoadIntegerBJ(backpackSlot, playerId, udg_INV_ItemCharges_Hashtable)
    if currentCharge == 1 then
        local itemSlotPoint = LoadLocationHandleBJ(backpackSlot, playerId, udg_INV_Point_Hashtable)
        
        RemoveDestructable(LoadDestructableHandleBJ(backpackSlot, playerId, udg_INV_Destructible_Hashtable))

        CreateDestructableLoc(udg_INV_Consumable_EmptySlot, itemSlotPoint, 270, 1.5, 0)
        SaveDestructableHandleBJ(GetLastCreatedDestructable(), backpackSlot, playerId, udg_INV_Destructible_Hashtable)
        SaveIntegerBJ(0, backpackSlot, playerId, udg_INV_ItemId_Hashtable)
        SaveIntegerBJ(0, backpackSlot, playerId, udg_INV_ItemCharges_Hashtable)
    else
        SaveIntegerBJ(currentCharge - 1, backpackSlot, playerId, udg_INV_ItemCharges_Hashtable)
    end
    
    player = nil
end


function calculateUnitStats(unit)
    local unitId = GetUnitUserData(unit)

    --Strength
    udg_Stat_Strength_AC[unitId] = R2I((udg_Stat_Strength[unitId] * udg_Stat_Strength_Modifier[unitId] / 100) + udg_Stat_Strength_Flat[unitId])
    if udg_Stat_Strength_AC[unitId] ~= GetHeroStr(unit, false)  then
        SetHeroStr(unit, udg_Stat_Strength_AC[unitId], true)
    end

    --Agility
    udg_Stat_Agility_AC[unitId] = R2I((udg_Stat_Agility[unitId] * udg_Stat_Agility_Modifier[unitId] / 100) + udg_Stat_Agility_Flat[unitId])
    if udg_Stat_Agility_AC[unitId] ~= GetHeroAgi(unit, false)  then
        SetHeroAgi(unit, udg_Stat_Agility_AC[unitId], true)
    end

    --Intelligence
    udg_Stat_Intelligence_AC[unitId] = R2I((udg_Stat_Intelligence[unitId] * udg_Stat_Intelligence_Modifier[unitId] / 100) + udg_Stat_Intelligence_Flat[unitId])
    if udg_Stat_Intelligence_AC[unitId] ~= GetHeroInt(unit, false)  then
        SetHeroInt(unit, udg_Stat_Intelligence_AC[unitId], true)
    end
    
    --Health

    udg_Stat_Health_AC[unitId] = R2I((udg_Stat_Health[unitId] * udg_Stat_Health_Modifier[unitId] / 100) + udg_Stat_Health_Flat[unitId])
    local currentMaxHealth = GetUnitState(unit, UNIT_STATE_MAX_LIFE)
    if udg_Stat_Health_AC[unitId] ~= currentMaxHealth then
        BlzSetUnitMaxHP(unit, udg_Stat_Health_AC[unitId])
        if udg_Stat_Health_AC[unitId] > currentMaxHealth then
            local healthDifference = udg_Stat_Health_AC[unitId] - currentMaxHealth
            local currentHealth = GetUnitState(unit, UNIT_STATE_LIFE)
            SetUnitState(unit, UNIT_STATE_LIFE, currentHealth + healthDifference)
        end
    end

    if unitId >= 10 then
    end

    --Mana
    udg_Stat_Mana_AC[unitId] = R2I(((udg_Stat_Mana[unitId] + (udg_Constant_Int_Mana * udg_Stat_Intelligence_AC[unitId])) * udg_Stat_Mana_Modifier[unitId] / 100) + udg_Stat_Mana_Flat[unitId])

    local currentMaxMana = GetUnitState(unit, UNIT_STATE_MAX_MANA)
    if udg_Stat_Mana_AC[unitId] ~= currentMaxMana then
        BlzSetUnitMaxMana(unit, udg_Stat_Mana_AC[unitId])
        if udg_Stat_Mana_AC[unitId] > currentMaxMana then
            local manaDifference = udg_Stat_Mana_AC[unitId] - currentMaxMana
            local currentMana = GetUnitState(unit, UNIT_STATE_MANA)
            SetUnitState(unit, UNIT_STATE_MANA, currentMana + manaDifference)
        end
    end

    --Health Regen
    udg_Stat_Health_Regen_AC[unitId] = udg_Stat_Health_Regen[unitId]

    --Mana Regen
    udg_Stat_Mana_Regen_AC[unitId] = udg_Stat_Mana_Regen[unitId]

    --Armor
    udg_Stat_Armor_AC[unitId] = R2I((udg_Stat_Armor[unitId] * udg_Stat_Armor_Modifier[unitId] / 100) + udg_Stat_Armor_Flat[unitId])
    if udg_Stat_Armor_AC[unitId] < 0 then
        udg_Stat_Armor_AC[unitId] = 0
    end
    BlzSetUnitArmor(unit, udg_Stat_Armor_AC[unitId])

    --Damage Taken
    udg_Stat_Damage_Taken_AC[unitId] = udg_Stat_Damage_Taken[unitId]

    --Damage Reduction
    --Damage Reduction Formula is : Armor 
    local unitLevel = GetUnitLevel(unit)
    local armorFormula = udg_Stat_Armor_AC[unitId] * udg_Constant_Armor / 100
    udg_Stat_Damage_Reduction_AC[unitId] = udg_Stat_Damage_Reduction[unitId] + (armorFormula / (armorFormula + unitLevel) * 100) - udg_Stat_Damage_Taken_AC[unitId]

    --Attack Speed
    local attackSpeedAgility = 0
    if udg_Stat_Agility_AC[unitId] > 200 then
        local exceedAgilityRatio =  (udg_Stat_Agility_AC[unitId] - 200) / 3 * udg_Constant_Agility_Attack_Speed
        attackSpeedAgility = (200 * udg_Constant_Agility_Attack_Speed) + exceedAgilityRatio
    else
        attackSpeedAgility = udg_Stat_Agility_AC[unitId] * udg_Constant_Agility_Attack_Speed
    end
    udg_Stat_Attack_Speed_AC[unitId] = (udg_Stat_Attack_Speed[unitId] + attackSpeedAgility)
    local attackInterval = udg_Stat_Attack_Interval[unitId] / (1 + (udg_Stat_Attack_Speed_AC[unitId] / 100))
    BlzSetUnitAttackCooldown(unit, attackInterval, 0)

    --Critical Chance
    udg_Stat_Critical_Chance_AC[unitId] = udg_Stat_Critical_Chance[unitId] + (udg_Stat_Agility_AC[unitId] * udg_Constant_Agility_Crit_Chance / 100)

    --Critical Damage Rate
    udg_Stat_Critical_Damage_Rate_AC[unitId] = udg_Stat_Critical_Damage_Rate[unitId] + (udg_Stat_Strength_AC[unitId] * udg_Constant_Strength_Crit_Damage / 100) + 200

    --Dodge
    udg_Stat_Dodge_AC[unitId] = udg_Stat_Dodge[unitId] + (udg_Stat_Agility_AC[unitId] * udg_Constant_Agility_Dodge / 100)

    --Parry
    udg_Stat_Parry_AC[unitId] = udg_Stat_Parry[unitId]

    --Block
    udg_Stat_Block_AC[unitId] = udg_Stat_Block[unitId]

    --Miss
    udg_Stat_Miss_AC[unitId] = udg_Stat_Miss[unitId] + (udg_Stat_Attack_Speed_AC[unitId] * udg_Constant_Attack_Speed_Miss / 100)

    --Attack Damage
    udg_Stat_Attack_Damage_AC[unitId] = R2I(((udg_Stat_Attack_Damage[unitId] + (udg_Stat_Strength_AC[unitId] * udg_Constant_Str_Attack_Damage) + (udg_Stat_Agility_AC[unitId] * udg_Constant_Agility_Attack_Damage)) * udg_Stat_Attack_Damage_Modifier[unitId] / 100) + udg_Stat_Attack_Damage_Flat[unitId])
    BlzSetUnitBaseDamage(unit, udg_Stat_Attack_Damage_AC[unitId] - 1, 0)

    --Spell Damage
    udg_Stat_Spell_Damage_AC[unitId] = R2I(((udg_Stat_Spell_Damage[unitId] + (udg_Stat_Intelligence_AC[unitId] * udg_Constant_Int_Spell_Damage)) * udg_Stat_Spell_Damage_Modifier[unitId] / 100) + udg_Stat_Spell_Damage_Flat[unitId])

    --Cooldown
    udg_Stat_Cooldown_AC[unitId] = udg_Stat_Cooldown[unitId]
    if udg_Stat_Cooldown_AC[unitId] > 50 then
        udg_Stat_Cooldown_AC[unitId] = 50
    end

    --Casting Speed
    udg_Stat_Casting_Speed_AC[unitId] = udg_Stat_Casting_Speed[unitId] + (udg_Stat_Intelligence_AC[unitId] * udg_Constant_Int_Casting_Speed / 100)
    if udg_Stat_Casting_Speed_AC[unitId] > 75 then
        udg_Stat_Casting_Speed_AC[unitId] = 75
    end
    --Fill this when abilities created

    --Movement Speed
    
    udg_Stat_Movement_Speed_AC[unitId] = udg_Stat_Movement_Speed[unitId]
    GetUnitName(unit)
    if udg_Stat_IsSnared[unitId] > 0 then
        SetUnitMoveSpeed(unit, 0)
    else
        local currentMovementSpeed = GetUnitMoveSpeed(unit)
        local defaultMovementSpeed = GetUnitDefaultMoveSpeed(unit)
        if currentMovementSpeed ~= udg_Stat_Movement_Speed_AC[unitId] + defaultMovementSpeed then
            SetUnitMoveSpeed(unit, defaultMovementSpeed + udg_Stat_Movement_Speed_AC[unitId])
        end
    end


    --Healing Taken
    udg_Stat_Healing_Taken_AC[unitId] = udg_Stat_Healing_Taken[unitId]

    --Healing Reduce
    udg_Stat_Healing_Reduce_AC[unitId] = udg_Stat_Healing_Reduce[unitId]

    --Life Steal
    udg_Stat_Life_Steal_AC[unitId] = udg_Stat_Life_Steal[unitId]

end



function calculateDamage(damageCauser, damageReceiver, damage)
    local causerId = GetUnitUserData(damageCauser)
    local receiverId = GetUnitUserData(damageReceiver)

    local causerPlayer = GetOwningPlayer(damageCauser)
    local causerPlayerId = GetPlayerId(causerPlayer) + 1
    if udg_Settings_ShowDamageDealt[causerPlayerId] == 1 then
        ForceAddPlayer(udg_FloatingText_PlayerGroup, causerPlayer)
    end

    local receiverPlayer = GetOwningPlayer(damageReceiver)
    local receiverPlayerId = GetPlayerId(receiverPlayer) + 1
    if udg_Settings_ShowDamageTaken[receiverPlayerId] == 1 then
        ForceAddPlayer(udg_FloatingText_PlayerGroup, receiverPlayer)
    end

    --check about Dodge
    local dodge = udg_Stat_Dodge_AC[receiverId]
    if dodge > GetRandomReal(0, 100.00) then
        causerPlayer = nil
        receiverPlayer = nil
        creatingFloatingTextTimed("Dodge!",damageReceiver,10,90,20,20)
        return 0.00
    end

    --check about Miss
    local miss = udg_Stat_Miss_AC[causerId]
    if miss > GetRandomReal(0, 100.00) then
        causerPlayer = nil
        receiverPlayer = nil
        creatingFloatingTextTimed("Miss!",damageCauser,10,90,20,20)
        return 0.00
    end

    --check about Parry
    if BlzGetEventIsAttack() == true then
        local parry = udg_Stat_Parry_AC[receiverId]
        if parry > GetRandomReal(0, 100.00)  then
            causerPlayer = nil
            receiverPlayer = nil
            creatingFloatingTextTimed("Parry!",damageReceiver,10,90,20,20)
            return 0.00
        end
    end


    --check about Block
    if udg_Stat_Block_Enabled[receiverId] > 0 then
        local block = udg_Stat_Block_AC[receiverId]
        if block > GetRandomReal(0, 100.00)  then
            causerPlayer = nil
            receiverPlayer = nil
            creatingFloatingTextTimed("Block!",damageReceiver,10,90,20,20)
            return 0.00
        end
    end

    --check about Critical Chance
    local criticalChance = udg_Stat_Critical_Chance_AC[causerId]
    local critHappened = false
    if criticalChance > GetRandomReal(0, 100.00) then
        critHappened = true
        local ciriticalDamageRate = udg_Stat_Critical_Damage_Rate_AC[causerId]
        damage = damage * (ciriticalDamageRate / 100)
    end

    --calculate the damage now, ups and downs. 
    local levelOfCauser = GetUnitLevel(damageCauser)
    local levelOfReciever = GetUnitLevel(damageReceiver)
    local levelDifferenceRatio = (levelOfReciever - levelOfCauser) * 0.1
    
    local damageTaken = udg_Stat_Damage_Taken_AC[receiverId] / 100
    local damageReduce = (udg_Stat_Damage_Reduction_AC[receiverId] / 100) - damageTaken + levelDifferenceRatio
    local ratio = 1 - damageReduce

    local lastDamage = damage * ratio
    if lastDamage < 0 then
        causerPlayer = nil
        receiverPlayer = nil
        return 0
    end

    --Absorb
    local absorb = 0
    if udg_Stat_Absorb[receiverId] > 0 then
        if udg_Stat_Absorb[receiverId] > lastDamage then
            absorbAdd(damageReceiver, -1 * lastDamage)
            causerPlayer = nil
            receiverPlayer = nil
            creatingFloatingTextTimed("Absorbed!",damageReceiver,10,60,60,60)
            return 0
        else
            absorb = udg_Stat_Absorb[receiverId]
            lastDamage  = lastDamage - udg_Stat_Absorb[receiverId]
            absorbAdd(damageReceiver, -1 * udg_Stat_Absorb[receiverId])
        end
    end

    damageString = tostring(R2I(lastDamage))

    if absorb > 0 then
        damageString = damageString .. "(" .. tostring(R2I(absorb)).. " Absorbed)"
    end

    if critHappened then
        damageString = damageString .. "! Critical"
        creatingFloatingTextTimed(damageString,damageReceiver,10,90,20,20)
    else
        creatingFloatingTextTimed(damageString,damageReceiver,10,60,60,60)
    end



    causerPlayer = nil
    receiverPlayer = nil

    --Threat
    local threat = calculateThreat(lastDamage, true, false, 0, udg_ThreatMeter_UnitThreatModifier[causerId])
    addThreatToThreatMeter(damageCauser, threat)

    --DPS Meter
    addDPStoDPSMeterFromUnit(damageCauser, lastDamage)

    --Life Steal
    lifestealCalculate(damageCauser, lastDamage)

    return lastDamage
    
end

function LevelUpStatSystemDialogButtonClicked(player)
    local playerId = GetPlayerId(player) + 1
    local unit = udg_INV_Player_Hero[playerId]
    local unitId = GetUnitUserData(unit)

    local clickedIndex = 0
    for i=1,20 do
            if GetClickedButtonBJ() == udg_Level_Stat_Dialog_Button[i] then
                clickedIndex = ModuloInteger(i, 4)
        end
    end
    
    if clickedIndex == 0 then
        DialogDisplay(player, udg_Level_Stat_Dialog[playerId], false)
        return
    end

    if udg_Level_Stat_CurrentPoint[playerId] == 0  then
        DisplayTextToPlayer(player, 0, 0, "You don't have any stat point")
        return
    end

    if clickedIndex == 3 then
        udg_Stat_Intelligence[unitId] = udg_Stat_Intelligence[unitId] + 1
        increaseLevelStatCurrentPoint(player,-1)
        udg_Level_Stat_IntelligenceGiven[playerId] = udg_Level_Stat_IntelligenceGiven[playerId] + 1
    end

    if clickedIndex == 2 then
        udg_Stat_Agility[unitId] = udg_Stat_Agility[unitId] + 1
        increaseLevelStatCurrentPoint(player,-1)
        udg_Level_Stat_AgilityGiven[playerId] = udg_Level_Stat_AgilityGiven[playerId] + 1

    end

    if clickedIndex == 1 then
        udg_Stat_Strength[unitId] = udg_Stat_Strength[unitId] + 1
        increaseLevelStatCurrentPoint(player,-1)
        udg_Level_Stat_StrengthGiven[playerId] = udg_Level_Stat_StrengthGiven[playerId] + 1
    end

    DialogSetMessage(udg_Level_Stat_Dialog[playerId], "Give Stats (" .. tostring(udg_Level_Stat_CurrentPoint[playerId]) .. " Remaining Poins)")
    if udg_Level_Stat_CurrentPoint[playerId] > 0 then
        DialogDisplay(player, udg_Level_Stat_Dialog[playerId], true)
    end
    
    calculateUnitStats(unit)
    return
end

function increaseLevelStatCurrentPoint(player,addPoint)
    local playerId = GetPlayerId(player) + 1

    udg_Level_Stat_CurrentPoint[playerId] = udg_Level_Stat_CurrentPoint[playerId] + addPoint
end

function createStatMultiboard()
    CreateMultiboardBJ(2, 24, "Your Stats")
    udg_Stat_Multiboard = GetLastCreatedMultiboard()

    MultiboardSetColumnCount(udg_Stat_Multiboard, 2)
    MultiboardSetRowCount(udg_Stat_Multiboard, 24)
    for i=1,24 do
        MultiboardSetItemStyleBJ(udg_Stat_Multiboard, 1, i, true, false)
        MultiboardSetItemStyleBJ(udg_Stat_Multiboard, 2, i, true, false)

        MultiboardSetItemWidthBJ(udg_Stat_Multiboard, 1, i, 12)
        MultiboardSetItemWidthBJ(udg_Stat_Multiboard, 2, i, 10)
    end
    MultiboardSetItemStyleBJ(udg_Stat_Multiboard, 1, 1, 1, 1)

    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 2, "Experience")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 3, "Health")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 4, "Health Regen")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 5, "Mana")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 6, "Mana Regen")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 7, "Strength")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 8, "Agility")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 9, "Intelligence")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 10, "Attack Damage")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 11, "Spell Damage")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 12, "Armor")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 13, "Damage Reduction")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 14, "Attack Speed")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 15, "Attack Interval")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 16, "Crtical Strike Chance")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 17, "Critical Damage Rate")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 18, "Life Steal")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 19, "Dodge")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 20, "Parry")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 21, "Block")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 22, "Miss")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 23, "Cooldown Reduction")
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 24, "Movement Speed")

    MultiboardDisplayBJ(false, udg_Stat_Multiboard)
end


function refreshStatMultiboardValues()
    ForForce(udg_Player_PlayerGroup, refreshStatMultiboardValuesPlayer)

    MultiboardSetItemIconBJ(udg_Stat_Multiboard, 1, 1, udg_Stat_Multiboard_Icon)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 1, 1, udg_Stat_Multiboard_Name)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 1, udg_Stat_Multiboard_Level)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 2, udg_Stat_Multiboard_Experience)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 3, udg_Stat_Multiboard_Health)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 4, udg_Stat_Multiboard_Health_Regen)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 5, udg_Stat_Multiboard_Mana_Regen)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 6, udg_Stat_Multiboard_Mana)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 7, udg_Stat_Multiboard_Strength)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 8, udg_Stat_Multiboard_Agility)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 9, udg_Stat_Multiboard_Intelligence)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 10, udg_Stat_Multiboard_Attack_Damage)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 11, udg_Stat_Multiboard_Spell_Damage)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 12, udg_Stat_Multiboard_Armor)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 13, udg_Stat_Multiboard_DMG_Reduction)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 14, udg_Stat_Multiboard_Attack_Speed)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 15, udg_Stat_Multiboard_Attack_Interv)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 16, udg_Stat_Multiboard_Crit_Chance)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 17, udg_Stat_Multiboard_Crit_Damage)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 18, udg_Stat_Multiboard_Life_Steal)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 19, udg_Stat_Multiboard_Dodge)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 20, udg_Stat_Multiboard_Parry)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 21, udg_Stat_Multiboard_Block)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 22, udg_Stat_Multiboard_Miss)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 23, udg_Stat_Multiboard_CD_Reduction)
    MultiboardSetItemValueBJ(udg_Stat_Multiboard, 2, 24, udg_Stat_Multiboard_Movement_Speed)
end

function refreshStatMultiboardValuesPlayer()
    local isPlayer = false
    local playerId = GetPlayerId(GetEnumPlayer()) + 1
    local unit = udg_INV_Player_Hero[playerId]
    local unitId = GetUnitUserData(unit)
    local level = GetUnitLevel(unit)
    if GetLocalPlayer() == GetEnumPlayer() then
        isPlayer = true
    end
    if isPlayer == true then
        udg_Stat_Multiboard_Icon = udg_INV_Player_Hero_Icon[playerId]
        udg_Stat_Multiboard_Name = GetUnitName(unit)
        udg_Stat_Multiboard_Level = tostring(level)
        udg_Stat_Multiboard_Experience = tostring(R2I(udg_EXP_System_Unit_Current_EXP[unitId])) .. " / " .. tostring(udg_EXP_System_Required_Values[level]) .. " (" .. tostring(ModuloInteger(GetHeroXP(unit), 100)) .. "%%)"
        udg_Stat_Multiboard_Health = tostring(R2I(GetUnitState(unit, UNIT_STATE_LIFE))) .. " / " .. tostring(R2I(GetUnitState(unit, UNIT_STATE_MAX_LIFE)))
        udg_Stat_Multiboard_Health_Regen = tostring(udg_Stat_Health_Regen_AC[unitId]) .. " / 5s"
        udg_Stat_Multiboard_Mana = tostring(R2I(GetUnitState(unit, UNIT_STATE_MANA))) .. " / " .. tostring(R2I(GetUnitState(unit, UNIT_STATE_MAX_MANA)))
        udg_Stat_Multiboard_Mana_Regen = tostring(udg_Stat_Mana_Regen_AC[unitId]) .. " / 5s"
        udg_Stat_Multiboard_Strength = tostring(GetHeroStr(unit, true))
        udg_Stat_Multiboard_Agility = tostring(GetHeroAgi(unit, true))
        udg_Stat_Multiboard_Intelligence = tostring(GetHeroInt(unit, true))
        udg_Stat_Multiboard_Attack_Damage = tostring(udg_Stat_Attack_Damage_AC[unitId])
        udg_Stat_Multiboard_Spell_Damage = tostring(udg_Stat_Spell_Damage_AC[unitId])
        udg_Stat_Multiboard_Armor = tostring(udg_Stat_Armor_AC[unitId])
        udg_Stat_Multiboard_DMG_Reduction = tostring((udg_Stat_Damage_Reduction_AC[unitId] - udg_Stat_Damage_Taken_AC[unitId])) .. "%%"
        udg_Stat_Multiboard_Attack_Speed = tostring(udg_Stat_Attack_Speed_AC[unitId]) .. "%%"
        udg_Stat_Multiboard_Attack_Interv = tostring(udg_Stat_Attack_Interval[unitId] / (1 + (udg_Stat_Attack_Speed_AC[unitId] / 100))) .. " /s"
        udg_Stat_Multiboard_Crit_Chance = tostring(udg_Stat_Critical_Chance_AC[unitId]) .. "%%"
        udg_Stat_Multiboard_Crit_Damage = tostring(udg_Stat_Critical_Damage_Rate_AC[unitId]) .. "%%"
        udg_Stat_Multiboard_Dodge = tostring(udg_Stat_Dodge_AC[unitId]) .. "%%"
        udg_Stat_Multiboard_Parry = tostring(udg_Stat_Parry_AC[unitId]) .. "%%"
        udg_Stat_Multiboard_Miss = tostring(udg_Stat_Miss_AC[unitId]) .. "%%"
        if udg_Stat_Block_Enabled[unitId] > 0 then
            udg_Stat_Multiboard_Block = tostring(udg_Stat_Block_AC[unitId]) .. "%%"
        else
            udg_Stat_Multiboard_Block = "0%"
        end
        udg_Stat_Multiboard_CD_Reduction = tostring(R2I(udg_Stat_Cooldown_AC[unitId])) .. "%%"
        udg_Stat_Multiboard_Casting_Speed = tostring(udg_Stat_Casting_Speed_AC[unitId]) .. "%%"
        udg_Stat_Multiboard_Movement_Speed = tostring(R2I(GetUnitMoveSpeed(unit)))
        udg_Stat_Multiboard_Life_Steal = tostring(udg_Stat_Life_Steal_AC[unitId]) .. "%%"
    end
    
end


function showStats(player)
    local show = false
    if GetLocalPlayer() == player then
        show = true
    end

    if show == true then
        udg_CombatStatistics_Show = false
        udg_BeliefOrder_Multiboard_Show = false
        udg_INV_Multiboard_Show = false
        if udg_Stat_Multiboard_Show == true and show == true then
            udg_Stat_Multiboard_Show = false
        else
            udg_Stat_Multiboard_Show = true
        end

        MultiboardDisplayBJ(udg_CombatStatistics_Show, udg_CombatStatistics_Multiboard)
        MultiboardDisplayBJ(udg_BeliefOrder_Multiboard_Show, udg_BeliefOrder_Multiboard)
        MultiboardDisplayBJ(udg_INV_Multiboard_Show, udg_INV_Multiboard)
        MultiboardDisplayBJ(udg_Stat_Multiboard_Show, udg_Stat_Multiboard)
    end

end


function inventoryItemMultiboardShow(player)
    local show = false
    if GetLocalPlayer() == player then
        show = true
    end

    if show == true then
        udg_CombatStatistics_Show = false
        udg_BeliefOrder_Multiboard_Show = false
        udg_Stat_Multiboard_Show = false
        if udg_INV_Multiboard_Show == true and show == true then
            udg_INV_Multiboard_Show = false
        else
            udg_INV_Multiboard_Show = true
        end

        MultiboardDisplayBJ(udg_CombatStatistics_Show, udg_CombatStatistics_Multiboard)
        MultiboardDisplayBJ(udg_BeliefOrder_Multiboard_Show, udg_BeliefOrder_Multiboard)
        MultiboardDisplayBJ(udg_Stat_Multiboard_Show, udg_Stat_Multiboard)
        MultiboardDisplayBJ(udg_INV_Multiboard_Show, udg_INV_Multiboard)
    end

end


function inventoryItemMultiboardRefresh(player)
    local playerId = GetPlayerId(player) + 1
    local index = udg_INV_Player_Current_Index[playerId]

    local id = LoadIntegerBJ(index, playerId, udg_INV_ItemId_Hashtable)

    local isPlayer = false
    if GetLocalPlayer() == player then
        isPlayer = true
    end
    if isPlayer == true then
        if id == 0 then
            udg_INV_Multiboard_Name = "Empty Slot"
            for i=1,26 do
                udg_INV_Multiboard_Strings[i] = ""
            end
        else
            udg_INV_Multiboard_Name = udg_ITEM_Name[id]
            udg_INV_Multiboard_Strings[1] = udg_ITEM_Description1[id]
            udg_INV_Multiboard_Strings[2] = udg_ITEM_Description2[id]
            udg_INV_Multiboard_Strings[3] = udg_ITEM_Description3[id]
            udg_INV_Multiboard_Strings[4] = udg_ITEM_Description4[id]
            udg_INV_Multiboard_Strings[5] = udg_ITEM_Description5[id]
            udg_INV_Multiboard_Strings[6] = udg_ITEM_Description6[id]
            udg_INV_Multiboard_Strings[7] = udg_ITEM_Description7[id]
            udg_INV_Multiboard_Strings[8] = udg_ITEM_Description8[id]
            udg_INV_Multiboard_Strings[9] = udg_ITEM_Description9[id]
            udg_INV_Multiboard_Strings[10] = udg_ITEM_Description10[id]
            udg_INV_Multiboard_Strings[11] = udg_ITEM_Description11[id]
            udg_INV_Multiboard_Strings[12] = udg_ITEM_Description12[id]
            udg_INV_Multiboard_Strings[13] = udg_ITEM_Description13[id]
            udg_INV_Multiboard_Strings[14] = udg_ITEM_Description14[id]
            udg_INV_Multiboard_Strings[15] = udg_ITEM_Description15[id]
            udg_INV_Multiboard_Strings[16] = udg_ITEM_Description16[id]
            udg_INV_Multiboard_Strings[17] = udg_ITEM_Description17[id]
            udg_INV_Multiboard_Strings[18] = udg_ITEM_Description18[id]
            udg_INV_Multiboard_Strings[19] = udg_ITEM_Description19[id]
            udg_INV_Multiboard_Strings[20] = udg_ITEM_Description20[id]
            udg_INV_Multiboard_Strings[21] = ""
            udg_INV_Multiboard_Strings[22] = ""
            udg_INV_Multiboard_Strings[23] = ""
            udg_INV_Multiboard_Strings[24] = ""
            udg_INV_Multiboard_Strings[25] = ""
            udg_INV_Multiboard_Strings[26] = ""

            local endOfTheLine = udg_ITEM_EndOfTheLine[id] + 2

            --Slot
            udg_INV_Multiboard_Strings[endOfTheLine] = "|cffc8c8c8Slot|r: " .. udg_INV_Slot_Names[udg_ITEM_Slot[id]]
            endOfTheLine = endOfTheLine + 1

            --Required Level
            if udg_ITEM_Required_Level[id] ~= 0 then
                local level = GetUnitLevel(udg_INV_Player_Hero[playerId])
                if udg_ITEM_Required_Level[id] > level then
                    udg_INV_Multiboard_Strings[endOfTheLine] = "|cffc8c8c8Required Level|r: |cffc03232" .. tostring(udg_ITEM_Required_Level[id]) .. "|r"
                else
                    udg_INV_Multiboard_Strings[endOfTheLine] = "|cffc8c8c8Required Level|r: " .. tostring(udg_ITEM_Required_Level[id])
                end
                endOfTheLine = endOfTheLine + 1
            end

            --Soulbind
            if udg_ITEM_Soulbind[id] == true then
                udg_INV_Multiboard_Strings[endOfTheLine] = "|cffbc32bcSoulbinded|r"
                endOfTheLine = endOfTheLine + 1
            end

            --Gold
            udg_INV_Multiboard_Strings[endOfTheLine] = "|cffe1e100Gold|r: " .. tostring(udg_ITEM_Gold[id])
            endOfTheLine = endOfTheLine + 1

            --Consumable
            if udg_ITEM_IsConsumable[id] == true then
                udg_INV_Multiboard_Strings[endOfTheLine] = "|cff7d7d5aConsumable Item|r"
                endOfTheLine = endOfTheLine + 1
            end

            --Block
            if udg_ITEM_IsBlockActive[id] == true then
                udg_INV_Multiboard_Strings[endOfTheLine] = "|cff7d7d5aWith this item, unit can block.|r"
                endOfTheLine = endOfTheLine + 1
            end

        end
    end

    for i=1,26 do
        MultiboardSetItemValueBJ(udg_INV_Multiboard, 1, i, udg_INV_Multiboard_Strings[i])
    end
    MultiboardSetTitleText(udg_INV_Multiboard, udg_INV_Multiboard_Name)

end