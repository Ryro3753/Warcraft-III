function assignBackToBaseSystem()
    local id = getUnitTypeStatId(udg_Registered_Unit)
    if udg_BackToBase_UnitTypeEnable[id] == true then
        udg_BackToBase_UnitLoc[udg_Register_ID] = GetUnitLoc(udg_Registered_Unit)
        if udg_BackToBase_UnitTypeDistance[id] == 0.0 or udg_BackToBase_UnitTypeDistance[id] == nil then
            udg_BackToBase_UnitDistance[udg_Register_ID] = udg_BackToBase_DefaultDistance
        else
            udg_BackToBase_UnitDistance[udg_Register_ID] = udg_BackToBase_UnitTypeDistance[id]
        end
    else
        return
    end
end


function checkIfUnitInBackToBaseSystem(unit)
    local id = GetUnitUserData(unit)
    if udg_BackToBase_UnitDistance[id] == nil or udg_BackToBase_UnitDistance[id] == 0 then
        return false
    else
        return true
    end
end

function checkIfUnitIsFarAway(unit)
    local id = GetUnitUserData(unit)
    local unitLoc = GetUnitLoc(unit)

    if DistanceBetweenPoints(unitLoc, udg_BackToBase_UnitLoc[id]) > 1500 then
        GroupRemoveUnit(udg_CombatSystem_UnitGroup, unit)
        udg_CombatSystem_IsActive[id] = false
        removeUnitFromEnemyCombatGroup(unit)
        unitReturnToBase(unit)
    end

    RemoveLocation(unitLoc)
end

function unitReturnToBase(unit)
    local id = GetUnitUserData(unit)
    SetUnitInvulnerable(unit, true)
    SetUnitPathing(unit, false)
    IssuePointOrderLocBJ(unit, "move", udg_BackToBase_UnitLoc[id])
    GroupAddUnit(udg_BackToBase_UnitGroup, unit)
    EnableTrigger(gg_trg_Back_To_Base_System_Control)
end


function returnBaseUnitGroup()
    ForGroup(udg_BackToBase_UnitGroup, returnBaseUnitGroupLoop)
end

function returnBaseUnitGroupLoop()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)
    local currentLoc = GetUnitLoc(unit)

    IssuePointOrderLocBJ(unit, "move", udg_BackToBase_UnitLoc[id])
    if DistanceBetweenPoints(currentLoc, udg_BackToBase_UnitLoc[id]) < 300 then

        SetUnitInvulnerable(unit, false)
        SetUnitPathing(unit, true)
        GroupRemoveUnit(udg_BackToBase_UnitGroup, unit)

        if CountUnitsInGroup(udg_BackToBase_UnitGroup) <= 0 then
            DisableTrigger(gg_trg_Back_To_Base_System_Control)
        end
    end

    RemoveLocation(currentLoc)
    unit = nil
end