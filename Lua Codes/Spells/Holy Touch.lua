function holyTouchFinishes()
    local caster = GetTriggerUnit()
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(caster, spell)
    local id = GetUnitUserData(caster)
    local target = udg_Holy_Touch_Target[id]

    local baseHeal = 0
    if level == 1 then
        baseHeal = 50
    elseif level == 2 then
        baseHeal = 90
    elseif level == 3 then
        baseHeal = 150
    elseif level == 4 then
        baseHeal = 225
    end

    local heal = R2I(baseHeal + (0.75 * udg_Stat_Intelligence_AC[id]))
    healUnit(caster, target, heal, true)

    setCooldownToAbility(caster, id, spell, level)
    createSpecialEffectOnUnitWithDuration(target, "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl", 0.2)

    caster = nil
    target = nil
    spell = nil
end

function holyTouchCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Holy_Touch_Target[id] = GetSpellTargetUnit()
    unit = nil
end