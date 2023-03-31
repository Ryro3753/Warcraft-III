function addThreatToThreatMeter(unit, threat)
    local id = GetUnitUserData(unit)
    udg_ThreatMeter_Threat[id] = udg_ThreatMeter_Threat[id] + threat
end


function calculateThreat(value, isDamage, isHeal, customModifier, unitThreatModifier)
    if isDamage == true then
        return value * udg_ThreatMeter_DamageModifier * unitThreatModifier / 100
    elseif isHeal == true then
        return value * udg_ThreatMeter_HealModifier * unitThreatModifier / 100
    elseif customModifier ~= 0 then
        return value * customModifier * unitThreatModifier / 100
    end
end


function threatLoop(unit)
    local player = GetOwningPlayer(unit)
    
    --Check if unit is enemy
    if IsPlayerInForce(player, udg_Enemy_PlayerGroup) then
        getHighestThreatedEnemyUnitAndAttack(unit)
    end

    player = nil
end


function getHighestThreatedEnemyUnitAndAttack(unit)
    local id = GetUnitUserData(unit)
    if udg_IsUnitCasting[id] == true then
        return
    end

    local loc = GetUnitLoc(unit)
    local group =  GetUnitsInRangeOfLocMatching(1500, loc, Condition(getHighestThreatedEnemyUnitCondition))
    udg_ThreatMeter_Unit = GetEnumUnit()
    udg_ThreatMeter_ReturnUnit = nil
    udg_ThreatMeter_ThreatForCompare = -1
    ForGroup(group, getHighestThreatedEnemyUnitGroupFunction)
    if udg_ThreatMeter_ReturnUnit == nil then
        return
    end
    DestroyGroup(group)
    RemoveLocation(loc)
    
    --if combat starts now this got activated
    if udg_ThreatMeter_EnemyTarget[id] == nil then
        udg_ThreatMeter_EnemyTarget[id] = udg_ThreatMeter_ReturnUnit
        IssueTargetOrderBJ(unit, "smart", udg_ThreatMeter_ReturnUnit)
        return
    end

        --If nothing changed then we return as well since we don't have any action to do
    if udg_ThreatMeter_EnemyTarget[id] == udg_ThreatMeter_EnemyLastTarget[id] and udg_ThreatMeter_EnemyTarget[id] == udg_ThreatMeter_ReturnUnit then
        if udg_ThreatMeter_EnemyLastIssue[id] == "" then
            IssueTargetOrderBJ(unit, "attack", udg_ThreatMeter_EnemyTarget[id])
        end
        return
    end

    --if  targeted unit and most threated unit is different than we change the target
    if udg_ThreatMeter_EnemyTarget[id] ~= udg_ThreatMeter_ReturnUnit then
        udg_ThreatMeter_EnemyTarget[id] = udg_ThreatMeter_ReturnUnit
        IssueTargetOrderBJ(unit, "smart", udg_ThreatMeter_ReturnUnit)
        return
    end

    if IsUnitInGroup(unit, udg_BackToBase_UnitGroup) == false then
        local bool = getHighestThreatedEnemyUnitAndAttackCastSpell(unit, udg_ThreatMeter_EnemyTarget[id], id)
        if bool == false then
            if udg_ThreatMeter_EnemyLastIssue[id] == "" then
                IssueTargetOrderBJ(unit, "attack", udg_ThreatMeter_EnemyTarget[id])
            else
                IssueTargetOrderBJ(unit, "smart", udg_ThreatMeter_EnemyTarget[id])
            end
        end
        return
    end
end


function getHighestThreatedEnemyUnitCondition()
    if IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitInGroup(GetFilterUnit(), udg_CombatSystem_UnitGroup)  and IsUnitAliveBJ(GetFilterUnit()) then
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

    udg_ThreatMeter_Threat[id] = 0
end


function threatAssign()
    udg_ThreatMeter_UnitThreatModifier[udg_Register_ID] = 100.00
    local unitTypeId = getUnitTypeStatId(udg_Registered_Unit)
    local unitId = GetUnitUserData(udg_Registered_Unit)
    udg_CombatSystem_Unit_Spell1[unitId] = udg_CombatSystem_Spell1[unitTypeId]
    udg_CombatSystem_Unit_Spell2[unitId] = udg_CombatSystem_Spell2[unitTypeId]
    udg_CombatSystem_Unit_Spell3[unitId] = udg_CombatSystem_Spell3[unitTypeId]
    udg_CombatSystem_Unit_SpellRatio1[unitId] = udg_CombatSystem_SpellRatio1[unitTypeId]
    udg_CombatSystem_Unit_SpellRatio2[unitId] = udg_CombatSystem_SpellRatio2[unitTypeId]
    udg_CombatSystem_Unit_SpellRatio3[unitId] = udg_CombatSystem_SpellRatio3[unitTypeId]
end

function getHighestThreatedEnemyUnitAndAttackCastSpell(unit, target, id)
    if udg_CombatSystem_Unit_Spell1[id] == udg_Ability_Nil then
        return false
    else
        local spellRemaing = BlzGetUnitAbilityCooldownRemaining(unit, udg_CombatSystem_Unit_Spell1[id])
        if spellRemaing == 0 then
            if udg_CombatSystem_Unit_SpellRatio1[id] >= GetRandomReal(0, 100) then
                IssueTargetOrder(unit, "faeriefire", target)
                return true
            end
        end
    end


    if udg_CombatSystem_Unit_Spell2[id] == udg_Ability_Nil then
        return false
    else
        local spellRemaing = BlzGetUnitAbilityCooldownRemaining(unit, udg_CombatSystem_Unit_Spell2[id])
        if spellRemaing == 0 then
            if udg_CombatSystem_Unit_SpellRatio2[id] >= GetRandomReal(0, 100) then
                IssueTargetOrder(unit, "slow", target)
                return true
            end
        end
    end

    if udg_CombatSystem_Unit_Spell3[id] == udg_Ability_Nil then
        return false
    else
        local spellRemaing = BlzGetUnitAbilityCooldownRemaining(unit, udg_CombatSystem_Unit_Spell3[id])
        if spellRemaing == 0 then
            if udg_CombatSystem_Unit_SpellRatio3[id] >= GetRandomReal(0, 100) then
                IssueTargetOrder(unit, "innerfire", target)
                return true
            end
        end
    end
    
    return false
end