function stunUnit(unit, duration)
    local loc = GetUnitLoc(unit)
    CreateNUnitsAtLoc(1, udg_Dummy_UnitType, Player(PLAYER_NEUTRAL_AGGRESSIVE), loc, 0)
    local dummy = GetLastCreatedUnit()
    UnitApplyTimedLife(dummy, FourCC('BTLF'), 5)

    local stunLevel = math.floor(duration / 0.1)
    UnitAddAbility(dummy, FourCC('ASTN'))
    SetUnitAbilityLevel(dummy, FourCC('ASTN'), stunLevel)

    IssueTargetOrder(dummy, "thunderbolt", unit)

    RemoveLocation(loc)
    loc = nil
    dummy = nil
end

function knockbackUnit(unit, duration, distance, angle)
    if IsUnitInGroup(unit, udg_Knockback_Group) == false then
        GroupAddUnit(udg_Knockback_Group, unit)
    end

    local id = GetUnitUserData(unit)

    udg_Knockback_Duration[id] = duration
    udg_Knockback_Distance[id] = distance
    udg_Knockback_Angle[id] = angle

    EnableTrigger(gg_trg_Knockback_Loop)
    stunUnit(unit, duration)
    id = nil
end

function knockbackUnitLoop()
    ForGroup(udg_Knockback_Group, knockbackUnitLoopFor)
end

function knockbackUnitLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_Knockback_Duration[id] > 0 then
        local loc = GetUnitLoc(unit)
        local locNext = PolarProjectionBJ(loc, udg_Knockback_Distance[id], udg_Knockback_Angle[id])
        SetUnitPositionLoc(unit, locNext)

        udg_Knockback_Duration[id] = udg_Knockback_Duration[id] - 0.10
        if ModuloInteger(R2I(udg_Knockback_Duration[id] * 10), 5) == 0 then
            createSpecialEffectOnUnit(unit, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
        end
        
        RemoveLocation(loc)
        RemoveLocation(locNext)

        loc = nil
        locNext = nil
    else
        GroupRemoveUnit(udg_Knockback_Group, unit)
        if CountUnitsInGroup(udg_Knockback_Group) == 0 then
            DisableTrigger(gg_trg_Knockback_Loop)
        end
    end

    unit = nil
    id = nil
end

function silenceUnit(unit, duration)
    local loc = GetUnitLoc(unit)
    CreateNUnitsAtLoc(1, udg_Dummy_UnitType, Player(PLAYER_NEUTRAL_AGGRESSIVE), loc, 0)
    local dummy = GetLastCreatedUnit()
    UnitApplyTimedLife(dummy, FourCC('BTLF'), 5)

    local silenceLevel = math.floor(duration / 0.1)
    UnitAddAbility(dummy, FourCC('ASLN'))
    SetUnitAbilityLevel(dummy, FourCC('ASLN'), silenceLevel)

    IssueTargetOrder(dummy, "soulburn", unit)

    RemoveLocation(loc)
    loc = nil
    dummy = nil
end

function fearUnit(unit, duration)
    local id = GetUnitUserData(unit)

    if UnitHasBuffBJ(unit, FourCC('BFER')) == true then
        if duration > udg_Fear_Duration[id] then
            udg_Fear_Duration[id] = duration
            return
        end
    else
        UnitAddAbility(unit, FourCC('AFER'))
        BlzUnitHideAbility(unit, FourCC('AFER'), true)
        udg_Fear_Duration[id] = duration
        GroupAddUnit(udg_Fear_UnitGroup, unit)

        EnableTrigger(gg_trg_Fear_Loop)
    end

end

function fearUnitLoop()
    ForGroup(udg_Fear_UnitGroup, fearUnitLoopFor)
end

function fearUnitLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    local player = GetOwningPlayer(unit)
    SelectUnitRemoveForPlayer(unit, player)
    player = nil

    if udg_Fear_Duration[id] > 0 then
        if ModuloInteger(R2I(udg_Fear_Duration[id] * 10), 5) == 0 then
            local loc = GetUnitLoc(unit)
            local locNext = PolarProjectionBJ(loc, GetRandomReal(0, 400), GetRandomDirectionDeg())

            IssuePointOrderLoc(unit, "move", locNext)

            RemoveLocation(loc)
            RemoveLocation(locNext)
            loc = nil
            locNext = nil
        end

        udg_Fear_Duration[id] = udg_Fear_Duration[id] - 0.10
    else
        GroupRemoveUnit(udg_Fear_UnitGroup, unit)
        if CountUnitsInGroup(udg_Fear_UnitGroup) == 0 then
            DisableTrigger(gg_trg_Fear_Loop)
        end

        UnitRemoveAbility(unit, FourCC('AFER'))
        UnitRemoveAbility(unit, FourCC('BFER'))

        IssueImmediateOrder(unit, "stop")
    end

    unit = nil
end


function sleepUnit(unit, duration)
    local loc = GetUnitLoc(unit)
    CreateNUnitsAtLoc(1, udg_Dummy_UnitType, Player(PLAYER_NEUTRAL_AGGRESSIVE), loc, 0)
    local dummy = GetLastCreatedUnit()
    UnitApplyTimedLife(dummy, FourCC('BTLF'), 5)

    local sleepLevel = math.floor(duration / 0.1)
    UnitAddAbility(dummy, FourCC('ASLP'))
    SetUnitAbilityLevel(dummy, FourCC('ASLP'), sleepLevel)

    IssueTargetOrder(dummy, "sleep", unit)

    RemoveLocation(loc)
    loc = nil
    dummy = nil
end

function snareUnit(unit, duration, abilityCode, effect)
    local id = GetUnitUserData(unit)

    if IsUnitInGroup(unit, udg_Snare_UnitGroup) then
        if duration > udg_Snare_Duration[id] then
            udg_Snare_Duration[id] = duration
        end

        UnitRemoveAbility(unit, udg_Snare_Ability_Code[id])
        DestroyEffect(udg_Snare_Effect[id])

    else
        udg_Stat_IsSnared[id] = udg_Stat_IsSnared[id] + 1
        calculateUnitStats(unit)

        udg_Snare_Duration[id] = duration

        GroupAddUnit(udg_Snare_UnitGroup, unit)
        EnableTrigger(gg_trg_Snare_Loop)
    end

    udg_Snare_Ability_Code[id] = FourCC(abilityCode)

    UnitAddAbility(unit, udg_Snare_Ability_Code[id])
    BlzUnitHideAbility(unit, udg_Snare_Ability_Code[id], true)


    if effect ~= "" and effect ~= nil then
        AddSpecialEffectTargetUnitBJ("origin", unit, effect)
        udg_Snare_Effect[id] = GetLastCreatedEffectBJ()
    end

end


function snareUnitFor()
    ForGroup(udg_Snare_UnitGroup, snareUnitForLoop)
end

function snareUnitForLoop()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_Snare_Duration[id] > 0 then

        udg_Snare_Duration[id] = udg_Snare_Duration[id] - 1
        
    else
        GroupRemoveUnit(udg_Snare_UnitGroup, unit)
        if CountUnitsInGroup(udg_Snare_UnitGroup) == 0 then
            DisableTrigger(gg_trg_Snare_Loop)
        end

        udg_Stat_IsSnared[id] = udg_Stat_IsSnared[id] - 1
        calculateUnitStats(unit)

        UnitRemoveAbility(unit, udg_Snare_Ability_Code[id])

        DestroyEffect(udg_Snare_Effect[id])

    end

    unit = nil
end

function soulDamage(causer, receiver, damage, isDodgeActive, isMissActive, isBlockActive, isParryActive, isCriticalActive)

    local causerId = GetUnitUserData(causer)
    local receiverId = GetUnitUserData(receiver)

    local causerPlayer = GetOwningPlayer(causer)
    local causerPlayerId = GetPlayerId(causerPlayer) + 1
    if udg_Settings_ShowDamageDealt[causerPlayerId] == 1 then
        ForceAddPlayer(udg_FloatingText_PlayerGroup, causerPlayer)
    end

    local receiverPlayer = GetOwningPlayer(receiver)
    local receiverPlayerId = GetPlayerId(receiverPlayer) + 1
    if udg_Settings_ShowDamageTaken[receiverPlayerId] == 1 then
        ForceAddPlayer(udg_FloatingText_PlayerGroup, receiverPlayer)
    end

    local dodge = udg_Stat_Dodge_AC[receiverId]
    if dodge > GetRandomReal(0, 100.00) and isDodgeActive == true then
        creatingFloatingTextTimed("Dodge!",damageReceiver,10,90,20,20)
        damage = 0
    end

    --check about Miss
    local miss = udg_Stat_Miss_AC[causerId]
    if miss > GetRandomReal(0, 100.00) and isMissActive == true then
        creatingFloatingTextTimed("Miss!",damageCauser,10,90,20,20)
        damage = 0
    end

    --check about Parry
    local parry = udg_Stat_Parry_AC[receiverId]
    if parry > GetRandomReal(0, 100.00) and isParryActive == true then
        creatingFloatingTextTimed("Parry!",damageReceiver,10,90,20,20)
        damage = 0
    end

    --check about Block
    if udg_Stat_Block_Enabled[receiverId] > 0 and isBlockActive == true then
        local block = udg_Stat_Block_AC[receiverId]
        if block > GetRandomReal(0, 100.00)  then
            creatingFloatingTextTimed("Block!",damageReceiver,10,90,20,20)
            damage = 0
        end
    end

    --check about Critical Chance
    local criticalChance = udg_Stat_Critical_Chance_AC[causerId]
    local critHappend = false
    if criticalChance > GetRandomReal(0, 100.00) and isCriticalActive == true and damage ~= 0 then
        critHappend = true
        local ciriticalDamageRate = udg_Stat_Critical_Damage_Rate_AC[causerId]
        damage = damage * (ciriticalDamageRate / 100)
    end
    if damage ~= 0 then
        local receiverHealth = GetUnitState(receiver, UNIT_STATE_LIFE)
        local remainingHealth = receiverHealth - damage
        if remainingHealth < 0 then
            damage = receiverHealth
            remainingHealth = 0
        end
        SetUnitState(receiver, UNIT_STATE_LIFE, remainingHealth)

        local damageText = damage
        if critHappend then
            healText = healText .. "! Crit Soul Damage"
        else
            damageText = damageText .. " Soul Damage"
        end

        creatingFloatingTextTimed(damageText, receiverId, 10, 0, 0, 0)

        causerPlayer = nil
        receiverPlayer = nil

        addDPStoDPSMeterFromUnit(causer, damage)

        --Life Steal
        lifestealCalculate(causer, damage)

        --Threat
        local threat = calculateThreat(damage, true, false, 0, udg_ThreatMeter_UnitThreatModifier[causerId])
        addThreatToThreatMeter(causer, threat)
    end

end


function cooldownCalculate(cooldown, id)
    return cooldown - (cooldown * (udg_Stat_Cooldown_AC[id] / 100))
end


function setCooldownToAbility(unit, id, spell, level)
    local cooldown = BlzGetAbilityCooldown(spell, level - 1)
    cooldown = cooldownCalculate(cooldown, id)
    BlzStartUnitAbilityCooldown(unit, spell, cooldown)
end

function missileCreate(loc, angle, player)
    udg_Missile_System_Register_ID = udg_Missile_System_Register_ID + 1
    CreateNUnitsAtLoc(1, udg_Missile_System_Dummy_Type, player, loc, angle)
    SetUnitUserData(GetLastCreatedUnit(), udg_Missile_System_Register_ID)

    return GetLastCreatedUnit()
end


function missileToPoint(unit, loc, missileEffect, missileEffectSize, height, leapDistance, trigger)
    local player = GetOwningPlayer(unit)
    local unitLoc = GetUnitLoc(unit)
    local angle = AngleBetweenPoints(unitLoc, loc)

    local dummy = missileCreate(unitLoc, angle, player)
    local id = GetUnitUserData(dummy)

    AddSpecialEffectTargetUnitBJ("origin", dummy, missileEffect)
    udg_Missile_System_Effect[id] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_Missile_System_Effect[id], missileEffectSize)
    SetUnitFlyHeight(dummy, height, 0)

    udg_Missile_System_LeapDistance[id] = leapDistance
    udg_Missile_System_Trigger[id] = trigger
    udg_Missile_System_Caster[id] = unit
    udg_Missile_System_ElapsedDistance[id] = 0.00
    udg_Missile_System_Type[id] = 1 -- Type 1 is a missile to go directly to point

    local distance = DistanceBetweenPoints(unitLoc, loc)
    udg_Missile_System_Distance[id] = distance

    local time = (distance / leapDistance * udg_Missile_System_Loop_Time) + 0.5
    UnitApplyTimedLife(dummy, FourCC('BTLF'), time)

    GroupAddUnit(udg_Missile_System_Group, dummy)
    EnableTrigger(gg_trg_Missile_System_Loop)
    
    player = nil
    RemoveLocation(unitLoc)
    unitLoc = nil
    dummy = nil
end


function missileToUnit(unit, target, missileEffect, missileEffectSize, height, leapDistance, trigger)
    local player = GetOwningPlayer(unit)
    local unitLoc = GetUnitLoc(unit)
    local angle = AngleBetweenPoints(unitLoc, loc)

    local dummy = missileCreate(unitLoc, angle, player)
    local id = GetUnitUserData(dummy)

    AddSpecialEffectTargetUnitBJ("origin", dummy, missileEffect)
    udg_Missile_System_Effect[id] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_Missile_System_Effect[id], missileEffectSize)
    SetUnitFlyHeight(dummy, height, 0)

    udg_Missile_System_LeapDistance[id] = leapDistance
    udg_Missile_System_Trigger[id] = trigger
    udg_Missile_System_Caster[id] = unit
    udg_Missile_System_ElapsedDistance[id] = 0.00
    udg_Missile_System_Type[id] = 2 -- Type 2 is a missile try to catch a target unit

    udg_Missile_System_Target[id] = target
    local targetLoc = GetUnitLoc(target)
    local distance = DistanceBetweenPoints(targetLoc, unitLoc)

    local time = (distance / leapDistance * udg_Missile_System_Loop_Time) * 2
    UnitApplyTimedLife(dummy, FourCC('BTLF'), math.min(10, time))

    GroupAddUnit(udg_Missile_System_Group, dummy)
    EnableTrigger(gg_trg_Missile_System_Loop)
    
    player = nil
    RemoveLocation(unitLoc)
    RemoveLocation(targetLoc)
    unitLoc = nil
    targetLoc = nil
    dummy = nil
end

function missileToDirectionFirstEnemy(unit, loc, maxDistance, area, missileEffect, missileEffectSize, height, leapDistance, trigger)
    local player = GetOwningPlayer(unit)
    local unitLoc = GetUnitLoc(unit)
    local angle = AngleBetweenPoints(unitLoc, loc)

    local dummy = missileCreate(unitLoc, angle, player)
    local id = GetUnitUserData(dummy)

    AddSpecialEffectTargetUnitBJ("origin", dummy, missileEffect)
    udg_Missile_System_Effect[id] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_Missile_System_Effect[id], missileEffectSize)
    SetUnitFlyHeight(dummy, height, 0)

    udg_Missile_System_LeapDistance[id] = leapDistance
    udg_Missile_System_Area[id] = area
    udg_Missile_System_Trigger[id] = trigger
    udg_Missile_System_Caster[id] = unit
    udg_Missile_System_ElapsedDistance[id] = 0.00
    udg_Missile_System_Type[id] = 3 -- Type 3 is a missile try to catch first enemy unit

    local time = maxDistance / leapDistance * udg_Missile_System_Loop_Time
    UnitApplyTimedLife(dummy, FourCC('BTLF'), time)

    GroupAddUnit(udg_Missile_System_Group, dummy)
    EnableTrigger(gg_trg_Missile_System_Loop)
    
    player = nil
    RemoveLocation(unitLoc)
    RemoveLocation(targetLoc)
    unitLoc = nil
    targetLoc = nil
    dummy = nil
end

function missileToDirectionFirstAlly(unit, loc, maxDistance, area, missileEffect, missileEffectSize, height, leapDistance, trigger)
    local player = GetOwningPlayer(unit)
    local unitLoc = GetUnitLoc(unit)
    local angle = AngleBetweenPoints(unitLoc, loc)

    local dummy = missileCreate(unitLoc, angle, player)
    local id = GetUnitUserData(dummy)

    AddSpecialEffectTargetUnitBJ("origin", dummy, missileEffect)
    udg_Missile_System_Effect[id] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_Missile_System_Effect[id], missileEffectSize)
    SetUnitFlyHeight(dummy, height, 0)

    udg_Missile_System_LeapDistance[id] = leapDistance
    udg_Missile_System_Area[id] = area
    udg_Missile_System_Trigger[id] = trigger
    udg_Missile_System_Caster[id] = unit
    udg_Missile_System_ElapsedDistance[id] = 0.00
    udg_Missile_System_Type[id] = 4 -- Type 4 is a missile try to catch first ally unit

    local time = maxDistance / leapDistance * udg_Missile_System_Loop_Time
    UnitApplyTimedLife(dummy, FourCC('BTLF'), time)

    GroupAddUnit(udg_Missile_System_Group, dummy)
    EnableTrigger(gg_trg_Missile_System_Loop)
    
    player = nil
    RemoveLocation(unitLoc)
    RemoveLocation(targetLoc)
    unitLoc = nil
    targetLoc = nil
    dummy = nil
end

function missileToDirectionEveryEnemy(unit, loc, distance, area, missileEffect, missileEffectSize, height, leapDistance, triggerFinishes, triggerEach)
    local player = GetOwningPlayer(unit)
    local unitLoc = GetUnitLoc(unit)
    local angle = AngleBetweenPoints(unitLoc, loc)

    local dummy = missileCreate(unitLoc, angle, player)
    local id = GetUnitUserData(dummy)

    AddSpecialEffectTargetUnitBJ("origin", dummy, missileEffect)
    udg_Missile_System_Effect[id] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_Missile_System_Effect[id], missileEffectSize)
    SetUnitFlyHeight(dummy, height, 0)

    udg_Missile_System_LeapDistance[id] = leapDistance
    udg_Missile_System_Area[id] = area
    udg_Missile_System_Trigger[id] = triggerFinishes
    udg_Missile_System_Trigger_Each[id] = triggerEach
    udg_Missile_System_Caster[id] = unit
    udg_Missile_System_ElapsedDistance[id] = 0.00
    udg_Missile_System_Type[id] = 5 -- Type 5 is a missile try to catch every enemy

    udg_Missile_System_Distance[id] = distance

    local time = distance / leapDistance * udg_Missile_System_Loop_Time
    UnitApplyTimedLife(dummy, FourCC('BTLF'), time)

    GroupAddUnit(udg_Missile_System_Group, dummy)
    EnableTrigger(gg_trg_Missile_System_Loop)
    
    player = nil
    RemoveLocation(unitLoc)
    RemoveLocation(targetLoc)
    unitLoc = nil
    targetLoc = nil
    dummy = nil
end

function missileLoop()
    ForGroup(udg_Missile_System_Group, missileLoopFor)
end

function missileLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    --Type 1
    if udg_Missile_System_Type[id] == 1 then

        local loc = GetUnitLoc(unit)
        local nextLoc = PolarProjectionBJ(loc, udg_Missile_System_LeapDistance[id], GetUnitFacing(unit))
    
        SetUnitPositionLoc(unit, nextLoc)
        udg_Missile_System_ElapsedDistance[id] = udg_Missile_System_ElapsedDistance[id] + udg_Missile_System_LeapDistance[id]

        if udg_Missile_System_ElapsedDistance[id] >= udg_Missile_System_Distance[id] then
            udg_Missile_System_Dummy_Point = GetUnitLoc(unit)
            udg_Missile_System_Dummy_Caster = udg_Missile_System_Caster[id]
            udg_Missile_System_Dummy_Angle = GetUnitFacing(unit)

            DestroyEffect(udg_Missile_System_Effect[id])

            GroupRemoveUnit(udg_Missile_System_Group, unit)
            if CountUnitsInGroup(udg_Missile_System_Group) == 0 then
                DisableTrigger(gg_trg_Missile_System_Loop)
            end

            RemoveUnit(unit)

            TriggerExecute(udg_Missile_System_Trigger[id])
        end

        RemoveLocation(loc)
        RemoveLocation(nextLoc)
        loc = nil
        nextLoc = nil

    --Type 2
    elseif udg_Missile_System_Type[id] == 2 then
        if IsUnitAliveBJ(unit) == false then

            DestroyEffect(udg_Missile_System_Effect[id])

            GroupRemoveUnit(udg_Missile_System_Group, unit)
            if CountUnitsInGroup(udg_Missile_System_Group) == 0 then
                DisableTrigger(gg_trg_Missile_System_Loop)
            end

            RemoveUnit(unit)
        else
            local loc = GetUnitLoc(unit)
            local targetLoc = GetUnitLoc(udg_Missile_System_Target[id])
            local angle = AngleBetweenPoints(loc, targetLoc)
            local nextLoc = PolarProjectionBJ(loc, udg_Missile_System_LeapDistance[id], angle)
            
            SetUnitPositionLoc(unit, nextLoc)
            udg_Missile_System_ElapsedDistance[id] = udg_Missile_System_ElapsedDistance[id] + udg_Missile_System_LeapDistance[id]
    
            local distanceDifference = DistanceBetweenPoints(nextLoc, targetLoc)
            if distanceDifference < 100 then
                udg_Missile_System_Dummy_Target = udg_Missile_System_Target[id]
                udg_Missile_System_Dummy_Caster = udg_Missile_System_Caster[id]
                udg_Missile_System_Dummy_Angle = angle * -1
    
                DestroyEffect(udg_Missile_System_Effect[id])
    
                GroupRemoveUnit(udg_Missile_System_Group, unit)
                if CountUnitsInGroup(udg_Missile_System_Group) == 0 then
                    DisableTrigger(gg_trg_Missile_System_Loop)
                end
    
                RemoveUnit(unit)

                TriggerExecute(udg_Missile_System_Trigger[id])
            end
    
            RemoveLocation(loc)
            RemoveLocation(targetLoc)
            RemoveLocation(nextLoc)
            loc = nil
            targetLoc = nil
            nextLoc = nil
        end

    --Type 3 - 4
    elseif udg_Missile_System_Type[id] == 3 or udg_Missile_System_Type[id] == 4 then
        if IsUnitAliveBJ(unit) == false then

            DestroyEffect(udg_Missile_System_Effect[id])

            GroupRemoveUnit(udg_Missile_System_Group, unit)
            if CountUnitsInGroup(udg_Missile_System_Group) == 0 then
                DisableTrigger(gg_trg_Missile_System_Loop)
            end

            RemoveUnit(unit)
        else
            local loc = GetUnitLoc(unit)
            local nextLoc = PolarProjectionBJ(loc, udg_Missile_System_LeapDistance[id], GetUnitFacing(unit))

            SetUnitPositionLoc(unit, nextLoc)
            udg_Missile_System_ElapsedDistance[id] = udg_Missile_System_ElapsedDistance[id] + udg_Missile_System_LeapDistance[id]

            local group = nil
            if udg_Missile_System_Type[id] == 3 then
                group = GetUnitsInRangeOfLocMatching(udg_Missile_System_Area[id], nextLoc, Condition(missileSystemEnemyFilter))
            else
                group = GetUnitsInRangeOfLocMatching(udg_Missile_System_Area[id], nextLoc, Condition(missileSystemAllyFilter))
            end

            if CountUnitsInGroup(group) > 0 then
                udg_Missile_System_Dummy_Group = group
                udg_Missile_System_Dummy_Caster = udg_Missile_System_Caster[id]
                udg_Missile_System_Dummy_Point = GetUnitLoc(unit)
                udg_Missile_System_Dummy_Angle = GetUnitFacing(unit)

                DestroyEffect(udg_Missile_System_Effect[id])
    
                GroupRemoveUnit(udg_Missile_System_Group, unit)
                if CountUnitsInGroup(udg_Missile_System_Group) == 0 then
                    DisableTrigger(gg_trg_Missile_System_Loop)
                end

                RemoveUnit(unit)

                TriggerExecute(udg_Missile_System_Trigger[id])
            else
                DestroyGroup(group)
                group = nil
            end

            RemoveLocation(loc)
            RemoveLocation(nextLoc)
            loc = nil
            nextLoc = nil
        end


        --Type 5
    elseif udg_Missile_System_Type[id] == 5 then
        if IsUnitAliveBJ(unit) == false or udg_Missile_System_ElapsedDistance[id] >= udg_Missile_System_Distance[id] then

            if udg_Missile_System_Trigger[id] ~= nil then

                udg_Missile_System_Dummy_Group = GetUnitsInRangeOfLocMatching(udg_Missile_System_Area[id], nextLoc, Condition(missileSystemEnemyFilter))
                udg_Missile_System_Dummy_Caster = udg_Missile_System_Caster[id]
                udg_Missile_System_Dummy_Point = GetUnitLoc(unit)
                udg_Missile_System_Dummy_Angle = GetUnitFacing(unit)
                
                TriggerExecute(udg_Missile_System_Trigger[id])
            end

            DestroyEffect(udg_Missile_System_Effect[id])

            GroupRemoveUnit(udg_Missile_System_Group, unit)
            if CountUnitsInGroup(udg_Missile_System_Group) == 0 then
                DisableTrigger(gg_trg_Missile_System_Loop)
            end

            RemoveUnit(unit)
        else
            local loc = GetUnitLoc(unit)
            local nextLoc = PolarProjectionBJ(loc, udg_Missile_System_LeapDistance[id], GetUnitFacing(unit))

            SetUnitPositionLoc(unit, nextLoc)
            udg_Missile_System_ElapsedDistance[id] = udg_Missile_System_ElapsedDistance[id] + udg_Missile_System_LeapDistance[id]

            local group = GetUnitsInRangeOfLocMatching(udg_Missile_System_Area[id], nextLoc, Condition(missileSystemEnemyFilter))

            if CountUnitsInGroup(group) > 0 and udg_Missile_System_Trigger_Each[id] ~= nil then
                udg_Missile_System_Dummy_Group = group
                udg_Missile_System_Dummy_Caster = udg_Missile_System_Caster[id]
                udg_Missile_System_Dummy_Point = GetUnitLoc(unit)
                udg_Missile_System_Dummy_Angle = GetUnitFacing(unit)

                TriggerExecute(udg_Missile_System_Trigger_Each[id])

                RemoveLocation(udg_Missile_System_Dummy_Point)
                udg_Missile_System_Dummy_Point = nil
                udg_Missile_System_Dummy_Caster = nil
            else

            DestroyGroup(group)
            group = nil
            RemoveLocation(loc)
            RemoveLocation(nextLoc)
            loc = nil
            nextLoc = nil
            end

        end
    end
    

    unit = nil
end

function missileSystemAllyFilter()
    if IsUnitAlly(GetEnumUnit(), GetOwningPlayer(GetFilterUnit())) 
    and IsUnitAliveBJ(GetFilterUnit()) 
    and IsUnitType(GetFilterUnit(), UNIT_TYPE_SAPPER) == false
    and GetFilterUnit() ~= udg_Missile_System_Caster[GetUnitUserData(GetEnumUnit())] then
        return true
    else
        return false
    end
end

function missileSystemEnemyFilter()
    if IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitAliveBJ(GetFilterUnit()) 
    and BlzIsUnitInvulnerable(GetFilterUnit()) == false 
    and IsUnitType(GetFilterUnit(), UNIT_TYPE_SAPPER) == false then
        return true
    else
        return false
    end
end

function absorbAdd(unit, amount)
    local id = GetUnitUserData(unit)
    if udg_Stat_Absorb[id] == 0 and amount > 0 then
        UnitAddAbility(unit, FourCC('ABSB'))
        BlzUnitHideAbility(unit, FourCC('ABSB'), true)
    end

    udg_Stat_Absorb[id] = udg_Stat_Absorb[id] + amount
    
    if udg_Stat_Absorb[id] <= 0 then
        udg_Stat_Absorb[id] = 0
        UnitRemoveAbility(unit, FourCC('ABSB'))
    end
end


function deneme()
    missileToDirectionEveryEnemy(GetTriggerUnit(), GetSpellTargetLoc(), 1000, 100, "Abilities\\Weapons\\GreenDragonMissile\\GreenDragonMissile.mdl", 100, 30, nil, nil)
end