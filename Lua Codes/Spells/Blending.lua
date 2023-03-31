function blendingCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    local dodge = 0
    local miss = 0
    if level == 1 then
        dodge = 70
        miss = 70
    elseif level == 2 then
        dodge = 70
        miss = 65
    elseif level == 3 then
        dodge = 75
        miss = 60
    elseif level == 4 then
        dodge = 75
        miss = 55
    end

    UnitAddAbility(unit, FourCC('A00S'))
    BlzUnitHideAbility(unit, FourCC('A00S'), true)

    udg_Stat_Dodge[id] = udg_Stat_Dodge[id] + dodge
    udg_Stat_Miss[id] = udg_Stat_Miss[id] + miss

    calculateUnitStats(unit)

    setCooldownToAbility(unit, id, spell, level)

    TriggerSleepAction(6)

    udg_Stat_Dodge[id] = udg_Stat_Dodge[id] - dodge
    udg_Stat_Miss[id] = udg_Stat_Miss[id] - miss

    calculateUnitStats(unit)

    UnitRemoveAbility(unit, FourCC('A00S'))
    UnitRemoveAbility(unit, FourCC('B00B'))

    unit = nil
    spell = nil
end