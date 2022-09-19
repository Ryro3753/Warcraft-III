function assignBackToLifeSystem()
    local id = getUnitTypeStatId(udg_Registered_Unit)
    if udg_BackToLife_UnitTypeEnable[id] == true then
        udg_BackToLife_UnitLoc[udg_Register_ID] = GetUnitLoc(udg_Registered_Unit)
        udg_BackToLife_UnitFace[udg_Register_ID] = GetUnitFacing(udg_Registered_Unit)
        if udg_BackToLife_UnitTypeTime[id] == 0.0 or udg_BackToLife_UnitTypeTime[id] == nil then
            udg_BackToLife_UnitTime[udg_Register_ID] = udg_BackToLife_DefaultTime
        else
            udg_BackToLife_UnitTime[udg_Register_ID] = udg_BackToLife_UnitTypeTime[id]
        end
    else
        return
    end
end



function backToLifeUnitDies()
    local unit = GetTriggerUnit()
    
    if IsUnitType(unit, UNIT_TYPE_SAPPER) == true then
        unit = nil
        return
    end

    local id = GetUnitUserData(unit)
    if udg_BackToLife_UnitTime[id] ~= 0 and udg_BackToLife_UnitTime[id] ~= nil then
        local player = GetOwningPlayer(unit)
        local unitType = GetUnitTypeId(unit)
        TriggerSleepAction(udg_BackToLife_UnitTime[id])
        CreateNUnitsAtLoc(1, unitType, player, udg_BackToLife_UnitLoc[id], udg_BackToLife_UnitFace[id])
        player = nil
        unitType = nil
    end
    unit = nil
end