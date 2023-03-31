function rapidFireCast()
    local unit = GetTriggerUnit()
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)
    local attackSpeed = 0.00
    if level == 1 then
        attackSpeed = 12
    elseif level == 2 then
        attackSpeed = 15
    elseif level == 3 then
        attackSpeed = 18
    elseif level == 4 then
        attackSpeed = 18
    end

    if IsUnitInGroup(unit, udg_Rapid_Fire_UnitGroup) then
        udg_Rapid_Fire_Countdown[id] = 7;
    else
        GroupAddUnit(udg_Rapid_Fire_UnitGroup, unit)
        udg_Rapid_Fire_Countdown[id] = 7;
        udg_Stat_Attack_Speed[id] =  udg_Stat_Attack_Speed[id] + attackSpeed
        udg_Rapid_Fire_IncreasedSpeed[id] = attackSpeed
        UnitAddAbility(unit, FourCC('A00E'))
        BlzUnitHideAbility(unit, FourCC('A00E'), true)
        calculateUnitStats(unit)
        EnableTrigger(gg_trg_Rapid_Fire_Loop)

        --Special Effect
        AddSpecialEffectTargetUnitBJ("origin", unit, "Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
        udg_Rapid_Fire_SpecialEffect[id] = GetLastCreatedEffectBJ()
    end

    setCooldownToAbility(unit, id, spell, level)

    spell = nil
    unit = nil
end

function rapidFireLoop()
    ForGroup(udg_Rapid_Fire_UnitGroup, rapidFireLoopFor)
end

function rapidFireLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_Rapid_Fire_Countdown[id] == 0 then
        GroupRemoveUnit(udg_Rapid_Fire_UnitGroup, unit)
        udg_Stat_Attack_Speed[id] = udg_Stat_Attack_Speed[id] - udg_Rapid_Fire_IncreasedSpeed[id]
        UnitRemoveAbility(unit, FourCC('A00E'))
        UnitRemoveAbility(unit, FourCC('B000'))
        calculateUnitStats(unit)
        DestroyEffectBJ(udg_Rapid_Fire_SpecialEffect[id])
        if CountUnitsInGroup(udg_Rapid_Fire_UnitGroup) == 0  then
            DisableTrigger(gg_trg_Rapid_Fire_Loop)
        end
    else
        udg_Rapid_Fire_Countdown[id] = udg_Rapid_Fire_Countdown[id] - 1
    end

    unit = nil
end


function rapidFireLearn()
    
    local unit = udg_Ability_Purchase_Trigger_Unit
    local spell = udg_Ability_Purchase_Trigger_Spell
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)
    
    if level == 4 then
        udg_Stat_Attack_Speed[id] = udg_Stat_Attack_Speed[id] + 5
        calculateUnitStats(unit)
    end

    unit = nil
    spell = nil
    level = nil
    id = nil
end


function rapidFireUnlearn()
    local unit = udg_Ability_Purchase_Trigger_Unit
    local spell = udg_Ability_Purchase_Trigger_Spell
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)
    
    if level == 4 then
        udg_Stat_Attack_Speed[id] = udg_Stat_Attack_Speed[id] - 5
        calculateUnitStats(unit)
    end

    unit = nil
    spell = nil
    level = nil
    id = nil
end
