function debugEnable()
    if udg_Debug == true then
        return
    end

    if GetPlayerName(GetTriggerPlayer()) == "Craterisus#2775" or GetPlayerName(GetTriggerPlayer()) == "Ryro#2566" or GetPlayerName(GetTriggerPlayer()) == "WorldEdit" then
        print("Debug Commands Enabled")
        udg_Debug = true
        return
    end
end

function debugCommandEXP()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 4)
    if string.lower(sub) ~= "-exp" then
        return
    end

    local strLength = string.len(str)
    local expSub = string.sub(str,5, strLength)
    local expNumber = tonumber(expSub)

    if expNumber == nil then
        return
    end

    local playerId = GetPlayerId(GetTriggerPlayer()) + 1
    giveEXPToUnit(udg_INV_Player_Hero[playerId], expNumber, GetUnitLevel(udg_INV_Player_Hero[playerId]))

end


function debugCommandNewHero()
    DialogDisplayBJ(true, udg_Hero_Selection_Dialog_Race, GetTriggerPlayer())
end

function debugCommandLevel()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 6)
    if string.lower(sub) ~= "-level" then
        return
    end

    local strLength = string.len(str)
    local levelSub = string.sub(str,7, strLength)
    local levelNumber = tonumber(levelSub)

    if levelNumber == nil then
        return
    end

    local playerId = GetPlayerId(GetTriggerPlayer()) + 1
    local unit = udg_INV_Player_Hero[playerId]
    local currentLevel = GetUnitLevel(unit)

    for i=1,levelNumber - currentLevel do
        unitLevelsUp(unit)
    end

    SetHeroLevel(unit, levelNumber, false)
end


function debugCommandRemoveTarget()
    local selectedUnit = GetUnitsSelectedAll(GetTriggerPlayer())
    ForGroup(selectedUnit, debugCommandRemoveTargetLoop)

end

function debugCommandRemoveTargetLoop()
    if IsPlayerInForce(GetOwningPlayer(GetEnumUnit()), udg_Enemy_PlayerGroup) then
        RemoveUnit(GetEnumUnit())
    end
    
end

function debugCommandCreateKnight()
    CreateNUnitsAtLoc(1, FourCC('hkni'), Player(8), GetRectCenter(udg_Hero_Selection_Create_Region), 0)
end

function debugCommandRefresh()
    local playerId = GetPlayerId(GetTriggerPlayer()) + 1
    SetUnitLifePercentBJ(udg_INV_Player_Hero[playerId], 100)
    SetUnitManaPercentBJ(udg_INV_Player_Hero[playerId], 100)
    UnitResetCooldown(udg_INV_Player_Hero[playerId])
end


function debugCommandAddGold()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 9)
    if string.lower(sub) ~= "-add gold" then
        return
    end

    local strLength = string.len(str)
    local goldSub = string.sub(str,10, strLength)
    local goldNumber = tonumber(goldSub)

    if goldNumber == nil then
        return
    end

    AdjustPlayerStateBJ(goldNumber, GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD)

end

function debugCommandAddAbilityPoint()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 18)
    if string.lower(sub) ~= "-add ability point" then
        return
    end

    local strLength = string.len(str)
    local abilitySub = string.sub(str,19, strLength)
    local abilityNumber = tonumber(abilitySub)

    if abilityNumber == nil then
        return
    end

    AdjustPlayerStateBJ(abilityNumber, GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER)

end

function debugCommandAddBeliefPoint()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 17)
    if string.lower(sub) ~= "-add belief point" then
        return
    end

    local strLength = string.len(str)
    local beliefSub = string.sub(str,18, strLength)
    local beliefNumber = tonumber(beliefSub)

    if beliefNumber == nil then
        return
    end

    increaseBeliefOrderCurrentPoint(GetTriggerPlayer(), beliefNumber)
end

function debugCommandAddStatPoint()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 15)
    if string.lower(sub) ~= "-add stat point" then
        return
    end

    local strLength = string.len(str)
    local statSub = string.sub(str,16, strLength)
    local statNumber = tonumber(statSub)

    if statNumber == nil then
        return
    end

    increaseLevelStatCurrentPoint(GetTriggerPlayer(), statNumber)
end

function debugCommandCreateItem()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 13)
    if string.lower(sub) ~= "-create item " then
        return
    end

    local strLength = string.len(str)
    local itemName = string.sub(str,14, strLength)

    CreateItemLoc(FourCC(itemName), GetRectCenter(udg_Hero_Selection_Create_Region))

end

function debugCommandCreateUnit()
    local str = GetEventPlayerChatString()
    local sub = string.sub(str, 0, 13)
    if string.lower(sub) ~= "-create unit " then
        return
    end

    local strLength = string.len(str)
    local unitName = string.sub(str,14, strLength)

    CreateNUnitsAtLoc(1, FourCC(unitName), Player(8), GetRectCenter(udg_Hero_Selection_Create_Region), 0)
end


function debugCommandDeneme()
    local name = GetItemName(udg_Item)
    local description = BlzGetItemExtendedTooltip(udg_Item)
    --DisplayTextToPlayer(Player(0), 60, 60, name)
    --DisplayTextToPlayer(Player(0), 60, 60, description)

    print(GetRandomReal(0, 100))
end