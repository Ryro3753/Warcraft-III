
function combatSystemDamage()
    local damager = GetEventDamageSource()
    local receiver = GetTriggerUnit()

    combatSystemDamageAddGroup(damager)
    combatSystemDamageAddGroup(receiver)

    --Auto Pull
    local loc = GetUnitLoc(receiver)
    local group = GetUnitsInRangeOfLocMatching(udg_CombatSystem_AutoPull_Radius, loc, Condition(combatSystemAutoPullCondition))
    ForGroup(group, combatSystemAutoPullFor)
    RemoveLocation(loc)
    DestroyGroup(group)
    loc = nil
    group = nil

    if IsTriggerEnabled(gg_trg_Combat_System_Control) == false then
        TriggerExecute(gg_trg_Combat_System_Control)
        EnableTrigger(gg_trg_Combat_System_Control)
    end

    damager = nil
    receiver = nil
end

function combatSystemDamageAddGroup(unit)
    local id = GetUnitUserData(unit)
    udg_CombatSystem_Elapsed_Second[id] = udg_Elapsed_Second

    if IsUnitInGroup(unit, udg_CombatSystem_UnitGroup) == false then
        udg_CombatSystem_IsActive[id] = true
        GroupAddUnit(udg_CombatSystem_UnitGroup, unit)

        ForceAddPlayer(udg_FloatingText_PlayerGroup, GetOwningPlayer(unit))
        creatingFloatingTextTimed('Combat Mode On', unit, 6, 100, 10, 10)

        addUnitToEnemyCombatGroup(unit)

        if IsUnitType(unit, UNIT_TYPE_ANCIENT) == true and udg_Boss_Encounter_Active == false then
            bossEncounterStart(unit)
        end
    end
    
    
end

function combatSystemRepeat()
    ForGroup(udg_CombatSystem_UnitGroup, combatSystemRepeatLoop)
    
    if CountUnitsInGroup(udg_CombatSystem_UnitGroup) == 0 then
        DisableTrigger(gg_trg_Combat_System_Control)
    end
end

function combatSystemRepeatLoopCloseBool()
    if IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitInGroup(GetFilterUnit(), udg_CombatSystem_UnitGroup)  and IsUnitAliveBJ(GetFilterUnit()) and IsUnitAliveBJ(GetEnumUnit()) then
       return true
    else
        return false
    end
end

function combatSystemRepeatLoop()
    local unit = GetEnumUnit()
    local player = GetOwningPlayer(unit)
    local id = GetUnitUserData(unit)
    local playerId = GetPlayerId(player) + 1

    if IsUnitType(unit, UNIT_TYPE_DEAD) then
        GroupRemoveUnit(udg_CombatSystem_UnitGroup, unit)
        udg_CombatSystem_IsActive[id] = false
        removeUnitFromEnemyCombatGroup(unit)
        threatClear(unit)
        bossEncounterEnd(unit)
        return
    end

    --Check close enemy units that exists
    local point = GetUnitLoc(unit)
    local closeEnemyGroup = GetUnitsInRangeOfLocMatching(800, point, Condition(combatSystemRepeatLoopCloseBool))
    if udg_Elapsed_Second - udg_CombatSystem_Elapsed_Second[id] > udg_CombatSystem_Time_Limit and CountUnitsInGroup(closeEnemyGroup) < 1 then
        GroupRemoveUnit(udg_CombatSystem_UnitGroup, unit)
        udg_CombatSystem_IsActive[id] = false
        if IsPlayerInForce(player, udg_Player_PlayerGroup) then
            ForceAddPlayer(udg_FloatingText_PlayerGroup, GetOwningPlayer(unit))
            creatingFloatingTextTimed('Combat Mode Off', unit, 6, 100, 10, 10)

            --threat clearer
            threatClear(unit)

            if IsUnitInGroup(unit, udg_Heroes) then
                udg_DPSMeter_Damage_PlayerBased[playerId] = 0
                udg_DPSMeter_DPS_PlayerBased[playerId] = 0
                udg_DPSMeter_Timer_PlayerBased[playerId] = 0
    
                udg_HPSMeter_Heal_PlayerBased[playerId] = 0
                udg_HPSMeter_HPS_PlayerBased[playerId] = 0
                udg_HPSMeter_Timer_PlayerBased[playerId] = 0
            end
        else
            --Unit return his base
            if checkIfUnitInBackToBaseSystem(unit) == true then
                unitReturnToBase(unit)
            end

            removeUnitFromEnemyCombatGroup(unit)
            bossEncounterEnd(unit)
        end
    else
        if IsUnitInGroup(unit, udg_Heroes) then
            udg_DPSMeter_Timer_PlayerBased[playerId] = udg_DPSMeter_Timer_PlayerBased[playerId] + 1
            udg_DPSMeter_DPS_PlayerBased[playerId] = udg_DPSMeter_Damage_PlayerBased[playerId] / udg_DPSMeter_Timer_PlayerBased[playerId]
            udg_HPSMeter_Timer_PlayerBased[playerId] = udg_HPSMeter_Timer_PlayerBased[playerId] + 1
            udg_HPSMeter_HPS_PlayerBased[playerId] = udg_HPSMeter_Heal_PlayerBased[playerId] / udg_HPSMeter_Timer_PlayerBased[playerId]
        end
        if IsPlayerInForce(player, udg_Enemy_PlayerGroup) then
            threatLoop(unit)
                if checkIfUnitInBackToBaseSystem(unit) == true then
                checkIfUnitIsFarAway(unit)
            end
        end
    end
    RemoveLocation(point)
    DestroyGroup(closeEnemyGroup)
end


function removeUnitFromEnemyCombatGroup(unit)
    if IsUnitInGroup(unit, udg_CombatSystem_Enemy_UnitGroup) then
        
        GroupRemoveUnit(udg_CombatSystem_Enemy_UnitGroup, unit)


        local heal = GetUnitState(unit, UNIT_STATE_MAX_LIFE) * 0.1
        healUnit(unit, unit, heal, false)

        if CountUnitsInGroup(udg_CombatSystem_Enemy_UnitGroup) == 0 then
            DisableTrigger(gg_trg_Threat_System_Enemy_Attack_Target_Retreive)
        end
    end
end

function addUnitToEnemyCombatGroup(unit)
    if IsPlayerInForce(GetOwningPlayer(unit), udg_Enemy_PlayerGroup) then
        local id = GetUnitUserData(unit)
        GroupAddUnit(udg_CombatSystem_Enemy_UnitGroup, unit)
        EnableTrigger(gg_trg_Threat_System_Enemy_Attack_Target_Retreive)
        udg_ThreatMeter_EnemyTarget[id] = nil
        udg_ThreatMeter_EnemyLastTarget[id] = nil
    end
end

function combatSystemAutoPullFor()
    combatSystemDamageAddGroup(GetEnumUnit())
end

function combatSystemAutoPullCondition()
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_ANCIENT) or IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    else
        return true
    end
end