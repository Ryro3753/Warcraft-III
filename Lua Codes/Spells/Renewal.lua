function renewalLearn()
    local unit = udg_Ability_Purchase_Trigger_Unit
    local spell = udg_Ability_Purchase_Trigger_Spell
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)

    if level == 1 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] + 2
    elseif level == 2 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] + 3
    elseif level == 3 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] + 2
    elseif level == 4 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] + 3
    end

    calculateUnitStats(unit)

    unit = nil
    spell = nil
end

function renewalUnlearn()
    local unit = udg_Ability_Purchase_Trigger_Unit
    local spell = udg_Ability_Purchase_Trigger_Spell
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)

    if level == 1 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] - 2
    elseif level == 2 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] - 3
    elseif level == 3 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] - 2
    elseif level == 4 then
        udg_Stat_Health_Regen[id] = udg_Stat_Health_Regen[id] - 3
    end

    calculateUnitStats(unit)

    unit = nil
    spell = nil
end

function renewalCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Renewal_Point[id] = GetSpellTargetLoc()
    unit = nil
end

function renewalCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    local heal = 0
    if level == 1 then
        heal = 30
    elseif level == 2 then
        heal = 50
    elseif level == 3 then
        heal = 75
    elseif level == 4 then
        heal = 100
    end
    heal = heal + (0.1 * udg_Stat_Spell_Damage_AC[id]) + (0.1 * udg_Stat_Agility_AC[id])
    udg_Renewal_Heal[id] = heal

    if IsUnitInGroup(unit, udg_Renewal_Group) == false then
        GroupAddUnit(udg_Renewal_Group, unit)
    end

    udg_Renewal_HealGroup[id] = GetUnitsInRangeOfLocMatching(300, udg_Renewal_Point[id], Condition(renewalHealGroupFilter))
    ForGroup(udg_Renewal_HealGroup[id], renewalHealGroupAddFor)

    udg_Renewal_Interval[id] = 6

    EnableTrigger(gg_trg_Renewal_Loop)

    createSpecialEffectOnLocWithSize(udg_Renewal_Point[id], "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", 2)

    setCooldownToAbility(unit, id, spell, level)

    RemoveLocation(udg_Renewal_Point[id])
    udg_Renewal_Point[id] = nil
    unit = nil
    spell = nil
end

function renewalHealGroupFilter()
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitAliveBJ(GetFilterUnit()) then
        return true
    else
        return false
    end
end

function renewalHealGroupAddFor()
    local unit = GetEnumUnit()
    UnitAddAbility(unit, FourCC('A00M'))
    BlzUnitHideAbility(unit, FourCC('A00M'), true)
    unit = nil
end

function renewalHealGroupRemoveFor()
    local unit = GetEnumUnit()
    UnitRemoveAbility(unit, FourCC('A00M'))
    unit = nil
end

function renewalGroupLoop()
    ForGroup(udg_Renewal_Group, renewalGroupLoopFor)
end

function renewalGroupLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    udg_Renewal_Unit = unit
    ForGroup(udg_Renewal_HealGroup[id], renewalGroupLoopHealFor)
    udg_Renewal_Unit = nil

    udg_Renewal_Interval[id] = udg_Renewal_Interval[id] - 1

    if udg_Renewal_Interval[id] <= 0 then
        ForGroup(udg_Renewal_HealGroup[id], renewalHealGroupRemoveFor)
        GroupClear(udg_Renewal_HealGroup[id])
        GroupRemoveUnit(udg_Renewal_Group, unit)

        if CountUnitsInGroup(udg_Renewal_Group) == 0 then
            DisableTrigger(gg_trg_Renewal_Loop)
        end
    end

    unit = nil
end

function renewalGroupLoopHealFor()
    local healer = udg_Renewal_Unit
    local healed = GetEnumUnit()
    local healerId = GetUnitUserData(healer)

    healUnit(healer, healed, udg_Renewal_Heal[healerId], true)

    createSpecialEffectOnUnit(healed, "Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl")

    healer = nil
    healed = nil
end