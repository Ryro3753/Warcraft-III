function bossEncounterStart(unit)
    local bossId = bossEncounterFindBossTypeId(unit)
    if bossId == 0 then
        return
    end

    --StartTimerBJ(udg_Boss_Encounter_Enrage_Timer, true, udg_Boss_Encounter_Enrage_Time[bossId])
    udg_Boss_Encounter_Current_Boss = unit
    udg_Boss_Encounter_Active = true
    udg_Boss_Encounter_Current_Region = udg_Boss_Encounter_Region[bossId]

    --EnableTrigger(gg_trg_Boss_Encounter_Enrage_Timer)
    EnableTrigger(gg_trg_Boss_Encounter_Combat_Loop)

    --Heal Orb Part
    if udg_Heal_Orb_Enable == true then
        udg_Heal_Orb_Region = udg_Boss_Encounter_Region[bossId]
        StartTimerBJ(udg_Heal_Orb_Timer, true, udg_Boss_Encounter_Heal_Orb_Time[bossId])
        healOrbActive()
    end
    
    BossEncounterRegionPathingBlockersCreate()
    TriggerExecute(udg_Boss_Encounter_Start_Trigger[bossId])
end

function bossEncounterEnd(unit)
    if udg_Boss_Encounter_Active == false or IsUnitType(unit, UNIT_TYPE_ANCIENT) == false then
        return
    end

    local bossId = bossEncounterFindBossTypeId(unit)
    if bossId == 0 then
        return
    end

    udg_Boss_Encounter_Active = false

    if udg_Heal_Orb_Enable == true then
        healOrbDeactive()
    end

    enrageUnitOff(udg_Boss_Encounter_Current_Boss)
    SetUnitLifePercentBJ(udg_Boss_Encounter_Current_Boss, 100)
    SetUnitManaPercentBJ(udg_Boss_Encounter_Current_Boss, 100)

    PauseTimer(udg_Boss_Encounter_Enrage_Timer)

    DisableTrigger(gg_trg_Boss_Encounter_Enrage_Timer)
    DisableTrigger(gg_trg_Boss_Encounter_Combat_Loop)

    udg_Boss_Encounter_IsBoss_Busy = false
    
    TriggerExecute(udg_Boss_Encounter_End_Trigger[bossId])
    BossEncounterRegionPathingBlockersRemove()
end

function bossEncounterFindBossTypeId(unit)
    local unitType = GetUnitTypeId(unit)
    for i=1,udg_Boss_Encounter_Limit do
        if udg_Boss_Encounter_Unit_Type[i] == unitType then
            unitType = nil
            return i
        end
    end
    unitType = nil
    return 0;
end


function bossEncounterCombatLoop()
    udg_Boss_Encounter_Integer = 0
    local group = GetUnitsInRectAll(udg_Boss_Encounter_Current_Region)
    ForGroup(group, bossEncounterCombatLoopFor)
    DestroyGroup(group)

    group = GetUnitsInRectMatching(udg_Boss_Encounter_Current_Region, Condition(bossEncounterCombatLoopFilter))
    if CountUnitsInGroup(group) == 0 then
        DisableTrigger(gg_trg_Boss_Encounter_Combat_Loop)
    end

    DestroyGroup(group)
    group = nil
end

function bossEncounterCombatLoopFor()
    combatSystemDamageAddGroup(GetEnumUnit())
end


function bossEncounterCombatLoopFilter()
    if IsUnitAliveBJ(GetFilterUnit()) and IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), udg_Player_PlayerGroup) then
        return true
    else
        return false
    end
end

function BossEncounterTargetAPlayerUnitFilter()
    if IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), udg_Player_PlayerGroup) then
        return true
    else
        return false
    end
end


function BossEncounterRegionPathingBlockersCreate()
    local p1 = GetRectCenter(udg_Boss_Encounter_Current_Region)
    local p2 = GetRectCenter(udg_Boss_Encounter_Current_Region)
    local index = 1;
    local totalCounter = 0
    local topSideCounter = 0
    local rightSideCounter = 0
    local reachCounter = 0

    --First Step
    local boolFirst = true;
    local lastPoint = GetRectCenter(udg_Boss_Encounter_Current_Region);
    while boolFirst do
        if ModuloInteger(index, 2) == 1 then
            RemoveLocation(p2)
            p2 = PolarProjectionBJ(p1, 10, 90)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p2) == false then
                p2 = PolarProjectionBJ(p2, 10, 270)
                boolFirst = false
            end
        else
            RemoveLocation(p1)
            p1 = PolarProjectionBJ(p2, 10, 90)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p1) == false then
                p1 = PolarProjectionBJ(p1, 10, 270)
                boolFirst = false
            end
        end
        index = index + 1
    end


    --Second Step, Top Right Side
    local boolSecond = true
    while boolSecond do
        if ModuloInteger(index, 2) == 1 then
            RemoveLocation(p2)
            p2 = PolarProjectionBJ(p1, 10, 0)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p2) == false then
                p2 = PolarProjectionBJ(p2, 10, 180)
                boolSecond = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p2, 0, 1, GetRandomInt(0, 9))
            end
        else
            RemoveLocation(p1)
            p1 = PolarProjectionBJ(p2, 10, 0)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p1) == false then
                p1 = PolarProjectionBJ(p1, 10, 180)
                boolSecond = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p1, 0, 1, GetRandomInt(0, 9))
            end
        end
        index = index + 1
        totalCounter = totalCounter + 1
        topSideCounter = topSideCounter + 1
    end
    topSideCounter = topSideCounter * 2


    --Third Step, Right Side
    local boolThird = true
    while boolThird do
        if ModuloInteger(index, 2) == 1 then
            RemoveLocation(p2)
            p2 = PolarProjectionBJ(p1, 10, 270)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p2) == false then
                p2 = PolarProjectionBJ(p2, 10, 90)
                boolThird = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p2, 0, 1, GetRandomInt(0, 9))
            end
        else
            RemoveLocation(p1)
            p1 = PolarProjectionBJ(p2, 10, 270)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p1) == false then
                p1 = PolarProjectionBJ(p1, 10, 90)
                boolThird = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p1, 0, 1, GetRandomInt(0, 9))
            end
        end
        index = index + 1
        totalCounter = totalCounter + 1
        rightSideCounter = rightSideCounter + 1
    end

    reachCounter = (topSideCounter + rightSideCounter) * 2

    --Fourth Step, Bottom Side
    local boolFourth = true
    while boolFourth do
        if ModuloInteger(index, 2) == 1 then
            RemoveLocation(p2)
            p2 = PolarProjectionBJ(p1, 10, 180)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p2) == false then
                p2 = PolarProjectionBJ(p2, 10, 0)
                boolFourth = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p2, 0, 1, GetRandomInt(0, 9))
            end
        else
            RemoveLocation(p1)
            p1 = PolarProjectionBJ(p2, 10, 180)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p1) == false then
                p1 = PolarProjectionBJ(p1, 10, 0)
                boolFourth = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p1, 0, 1, GetRandomInt(0, 9))
            end
        end
        index = index + 1
        totalCounter = totalCounter + 1
    end


    --Fifth Step, Left Side
    local boolFifth = true
    while boolFifth do
        if ModuloInteger(index, 2) == 1 then
            RemoveLocation(p2)
            p2 = PolarProjectionBJ(p1, 10, 90)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p2) == false then
                p2 = PolarProjectionBJ(p2, 10, 270)
                boolFifth = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p2, 0, 1, GetRandomInt(0, 9))
            end
        else
            RemoveLocation(p1)
            p1 = PolarProjectionBJ(p2, 10, 90)
            if RectContainsLoc(udg_Boss_Encounter_Current_Region, p1) == false then
                p1 = PolarProjectionBJ(p1, 10, 270)
                boolFifth = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p1, 0, 1, GetRandomInt(0, 9))
            end
        end
        index = index + 1
        totalCounter = totalCounter + 1
    end

    --Sixth Step, Top Left Side
    local boolSixth = true
    while boolSixth do
        if ModuloInteger(index, 2) == 1 then
            RemoveLocation(p2)
            p2 = PolarProjectionBJ(p1, 10, 0)
            if totalCounter >= reachCounter then
                boolSixth = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p2, 0, 1, GetRandomInt(0, 9))
            end
        else
            RemoveLocation(p1)
            p1 = PolarProjectionBJ(p2, 10, 0)
            if totalCounter >= reachCounter then
                boolFifth = false
            else
                CreateDestructableLoc(FourCC('BEBD'), p1, 0, 1, GetRandomInt(0, 9))
            end
        end
        index = index + 1
        totalCounter = totalCounter + 1
    end

    RemoveLocation(p1)
    RemoveLocation(p2)
    RemoveLocation(lastPoint)

    p1 = nil
    p2 = nil
    lastPoint = nil
end

function BossEncounterRegionPathingBlockersRemove()
    local loc = GetRectCenter(udg_Boss_Encounter_Current_Region)
    EnumDestructablesInCircleBJ(6000, loc, function ()
        if GetDestructableTypeId(GetEnumDestructable()) == FourCC('BEBD') then
            RemoveDestructable(GetEnumDestructable())
        end
    end)

    RemoveLocation(loc)
    loc = nil
end

function BossEncounterSpellSystem_Init()
    udg_BESS_SystemTimer = 0
    udg_BESS_StackCurrentIndex = 0
    udg_BESS_StackLastIndex = 0
    
end

function BossEncounterSpellSystem_Tick()
    udg_BESS_SystemTimer = udg_BESS_SystemTimer + 1

end