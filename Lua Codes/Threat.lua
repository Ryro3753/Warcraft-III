function addThreatToThreatMeter(unit, threat)
    local id = GetUnitUserData(unit)
    udg_ThreatMeter_Threat[id] = udg_ThreatMeter_Threat[id] + threat
end


function calculateThreat(value, isDamage, isHeal, customModifier)
    if isDamage == true then
        return value * udg_ThreatMeter_DamageModifier
    elseif isHeal == true then
        return value * udg_ThreatMeter_HealModifier
    elseif customModifier ~= 0 then
        return value * customModifier
    end
end


function threatLoop(unit)
    local id = GetUnitUserData(unit)
    local player = GetOwningPlayer(unit) 
    
    --Blacklist countdown
    if IsUnitInGroup(unit, udg_ThreatMeter_Blacklist) then
        udg_ThreatMeter_Blacklist_Counter[id] = udg_ThreatMeter_Blacklist_Counter[id] - 1
        if udg_ThreatMeter_Blacklist_Counter[id] == 0 then
            GroupRemoveUnit(udg_ThreatMeter_Blacklist, unit)
        end
    end

    --Check if unit is enemy
    if IsPlayerInForce(player, udg_Enemy_PlayerGroup) then
        getHighestThreatedEnemyUnitAndAttack(unit)
    end
end


function getHighestThreatedEnemyUnitAndAttack(unit)
    local id = GetUnitUserData(unit)
    local loc = GetUnitLoc(unit)
    local group =  GetUnitsInRangeOfLocMatching(1500, loc, Condition(getHighestThreatedEnemyUnitCondition))
    udg_ThreatMeter_Unit = GetEnumUnit()
    udg_ThreatMeter_ReturnUnit = nil
    udg_ThreatMeter_ThreatForCompare = 0
    ForGroup(group, getHighestThreatedEnemyUnitGroupFunction)
    if udg_ThreatMeter_ReturnUnit == nil then
        return
    end
    DestroyGroup(group)
    RemoveLocation(loc)

    --if combat starts now this got activated
    if udg_ThreatMeter_EnemyTarget[id] == nil then
        udg_ThreatMeter_EnemyTarget[id] = udg_ThreatMeter_ReturnUnit
        IssueTargetOrderBJ(unit, "attack", udg_ThreatMeter_ReturnUnit)
        return
    end

    --If nothing changed then we return as well since we don't have any action to do
    if udg_ThreatMeter_EnemyTarget[id] == udg_ThreatMeter_EnemyLastTarget[id] and udg_ThreatMeter_EnemyTarget[id] == udg_ThreatMeter_ReturnUnit then
        return
    end

    --if  targeted unit and most threated unit is different than we change the target
    if udg_ThreatMeter_EnemyTarget[id] ~= udg_ThreatMeter_ReturnUnit then
        udg_ThreatMeter_EnemyTarget[id] = udg_ThreatMeter_ReturnUnit
        IssueTargetOrderBJ(unit, "attack", udg_ThreatMeter_ReturnUnit)
        return
    end

    --If targeted unit and most threated unit is same but last hit unit is different then we have to deal with blocking way
    if udg_ThreatMeter_EnemyTarget[id] == udg_ThreatMeter_ReturnUnit and udg_ThreatMeter_EnemyLastTarget[id] ~= udg_ThreatMeter_EnemyTarget[id] then
        GroupAddUnit(udg_ThreatMeter_Blacklist, udg_ThreatMeter_EnemyTarget[id])
        local targetId = GetUnitUserData(udg_ThreatMeter_EnemyTarget[id])
        udg_ThreatMeter_Blacklist_Counter[targetId] = 7
        return
    end

end


function getHighestThreatedEnemyUnitCondition()
    if IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitInGroup(GetFilterUnit(), udg_CombatSystem_UnitGroup)  and IsUnitAliveBJ(GetFilterUnit()) and IsUnitInGroup(GetFilterUnit(), udg_ThreatMeter_Blacklist) == false then
        return true 
     else
         return false
     end
end

function getHighestThreatedEnemyUnitGroupFunction()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)
    local threat = udg_ThreatMeter_Threat[id]
    if threat >  udg_ThreatMeter_ThreatForCompare then
        udg_ThreatMeter_ThreatForCompare = threat
        udg_ThreatMeter_ReturnUnit = unit
    end
    unit = nil
end


function threatClear(unit)
    local id = GetUnitUserData(unit)


    if IsUnitInGroup(unit, udg_ThreatMeter_Blacklist) then
        GroupRemoveUnit(udg_ThreatMeter_Blacklist, unit)
        udg_ThreatMeter_Blacklist_Counter[id] = 0
    end

    udg_ThreatMeter_Threat[id] = 0
end