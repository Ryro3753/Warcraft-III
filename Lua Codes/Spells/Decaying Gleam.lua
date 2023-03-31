function decayingGleamCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_DecayingGleam_Target[id] = GetSpellTargetUnit()
    unit = nil
end

function decayingGleamCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local target = udg_DecayingGleam_Target[id]
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    local baseDamage = 0
    local lifeSteal = 0
    if level == 1 then
        baseDamage = 75
        lifeSteal = 30
    elseif level == 2 then
        baseDamage = 110
        lifeSteal = 30
    elseif level == 3 then
        baseDamage = 170
        lifeSteal = 35
    elseif level == 4 then
        baseDamage = 250
        lifeSteal = 35
    end

    local damage = R2I(baseDamage + (0.5 * udg_Stat_Spell_Damage_AC[id]) + (0.25 * udg_Stat_Attack_Damage_AC[id]))

    udg_Stat_Life_Steal_AC[id] = udg_Stat_Life_Steal_AC[id] + lifeSteal
    UnitDamageTargetBJ(unit, target, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    udg_Stat_Life_Steal_AC[id] = udg_Stat_Life_Steal_AC[id] - lifeSteal

    createSpecialEffectOnUnitWithSize(target, "Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl", 2)
    createSpecialEffectOnUnitWithSize(target, "Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl", 2)
    setCooldownToAbility(unit, id, spell, level)

    unit = nil
    id = nil
    target = nil
    spell = nil
    level = nil
end