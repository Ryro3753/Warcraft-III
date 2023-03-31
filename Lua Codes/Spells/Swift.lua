function swiftCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    local threatReduction = 0.00
    local movementSpeed = 0
    if level == 1 then
        movementSpeed = 70
        threatReduction = 35
    elseif level == 2 then
        movementSpeed = 75
        threatReduction = 40
    elseif level == 3 then
        movementSpeed = 75
        threatReduction = 40
    elseif level == 4 then
        movementSpeed = 80
        threatReduction = 45
    end

    udg_Stat_Movement_Speed[id] = udg_Stat_Movement_Speed[id] + movementSpeed
    udg_ThreatMeter_UnitThreatModifier[id] = udg_ThreatMeter_UnitThreatModifier[id] - threatReduction

    calculateUnitStats(unit)

    setCooldownToAbility(unit, id, spell, level)

    playSoundAtUnit(unit, gg_snd_WandOfIllusionTarget1)

    UnitAddAbility(unit, FourCC('A00U'))
    BlzUnitHideAbility(unit, FourCC('A00U'), true)

    TriggerSleepAction(5 + level)

    udg_Stat_Movement_Speed[id] = udg_Stat_Movement_Speed[id] - movementSpeed
    udg_ThreatMeter_UnitThreatModifier[id] = udg_ThreatMeter_UnitThreatModifier[id] + threatReduction

    calculateUnitStats(unit)

    UnitRemoveAbility(unit, FourCC('A00U'))
    UnitRemoveAbility(unit, FourCC('B00D'))

end