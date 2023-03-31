function raditionOfLightCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)
    local loc = GetUnitLoc(unit)

    local armor = 0
    local strengthPercentage = 0.0
    if level == 1 then
        armor = 25
        strengthPercentage = 0.5
    elseif level == 2 then
        armor = 45
        strengthPercentage = 0.55
    elseif level == 3 then
        armor = 70
        strengthPercentage = 0.6
    elseif level == 4 then
        armor = 90
        strengthPercentage = 0.65
    end
    udg_RadiationOfLight_ArmorInt = armor + (strengthPercentage + udg_Stat_Strength_AC[id])

    local group = GetUnitsInRangeOfLocMatching(350, loc, Condition(raditionOfLightBuffGroupFilter))
    ForGroup(group, raditionOfLightBuffGroupFor)
    DestroyGroup(group)
    group = nil

    EnableTrigger(gg_trg_Radiation_Of_Light_Loop)

    setCooldownToAbility(unit, id, spell, level)

    createSpecialEffectOnLocWithSize(loc, "Abilities\\Spells\\Undead\\ReplenishHealth\\ReplenishHealthCasterOverhead.mdl", 2.4)

    RemoveLocation(loc)
    loc = nil
    unit = nil
    spell = nil
end

function raditionOfLightBuffGroupFilter()
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitAliveBJ(GetFilterUnit()) and IsUnitType(GetFilterUnit(), UNIT_TYPE_SAPPER) == false then
        return true
    else
        return false
    end
end

function raditionOfLightBuffGroupFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if IsUnitInGroup(unit, udg_RadiationOfLight_Group) then
        udg_RadiationOfLight_Duration[id] = 6
    else
        udg_Stat_Armor[id] = udg_Stat_Armor[id] + udg_RadiationOfLight_ArmorInt
        udg_RadiationOfLight_Armor[id] = udg_RadiationOfLight_ArmorInt
        udg_Stat_Healing_Taken[id] = udg_Stat_Healing_Taken[id] + 25
        udg_RadiationOfLight_Duration[id] = 6

        UnitAddAbility(unit, FourCC('A00N'))
        BlzUnitHideAbility(unit, FourCC('A00N'), true)

        GroupAddUnit(udg_RadiationOfLight_Group, unit)

        calculateUnitStats(unit)
    end

    unit = nil
end

function raditionOfLightLoop()
    ForGroup(udg_RadiationOfLight_Group, raditionOfLightLoopFor)
end

function raditionOfLightLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_RadiationOfLight_Duration[id] <= 0 then
        GroupRemoveUnit(udg_RadiationOfLight_Group, unit)
        UnitRemoveAbility(unit, FourCC('A00N'))

        udg_Stat_Armor[id] = udg_Stat_Armor[id] - udg_RadiationOfLight_Armor[id]
        udg_Stat_Healing_Taken[id] = udg_Stat_Healing_Taken[id] - 25

        calculateUnitStats(unit)

        if CountUnitsInGroup(udg_RadiationOfLight_Group) == 0 then
            DisableTrigger(gg_trg_Radiation_Of_Light_Loop)
        end
    else
        udg_RadiationOfLight_Duration[id] = udg_RadiationOfLight_Duration[id] - 1
    end

    unit = nil
end