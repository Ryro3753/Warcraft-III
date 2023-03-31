function slamCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Slam_Target[id] = GetSpellTargetUnit()
    unit = nil
end

function slamCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)
    local target = udg_Slam_Target[id]
    local targetId = GetUnitUserData(target)

    local damage = 0
    local strengthModifier = 0.0
    local attackDamageModifier = 0.0
    if level == 1 then
        damage = 15
        attackDamageModifier = 0.85
        strengthModifier = 2.0
    elseif level == 2 then
        damage = 35
        attackDamageModifier = 0.85
        strengthModifier = 2.2
    elseif level == 3 then
        damage = 75
        attackDamageModifier = 0.85
        strengthModifier = 2.4
    elseif level == 4 then
        damage = 105
        attackDamageModifier = 0.85
        strengthModifier = 2.6
    end

    local armorReduction = 0
    if IsUnitType(target, UNIT_TYPE_ANCIENT) then
        armorReduction = R2I(strengthModifier * udg_Stat_Strength_AC[id] / 2)
    else
        armorReduction = R2I(strengthModifier * udg_Stat_Strength_AC[id])
    end
    damage = damage + (attackDamageModifier * udg_Stat_Attack_Damage_AC[id])

    UnitDamageTargetBJ(unit, target, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

    udg_Stat_Armor[targetId] = udg_Stat_Armor[targetId] - armorReduction

    calculateUnitStats(target)

    udg_Slam_Debuff_Count[targetId] = udg_Slam_Debuff_Count[targetId] + 1
    if udg_Slam_Debuff_Count[targetId] == 1 then
        UnitAddAbility(target, FourCC('A00T'))
        BlzUnitHideAbility(target, FourCC('A00T'), true)
    end

    setCooldownToAbility(unit, id, spell, level)

    playSoundAtUnit(target, gg_snd_AxeMissile201)

    TriggerSleepAction(10)

    udg_Stat_Armor[targetId] = udg_Stat_Armor[targetId] + armorReduction

    calculateUnitStats(target)

    udg_Slam_Debuff_Count[targetId] = udg_Slam_Debuff_Count[targetId] - 1
    
    if udg_Slam_Debuff_Count[targetId] == 0 then
        UnitRemoveAbility(target, FourCC('A00T'))
        UnitRemoveAbility(target, FourCC('B00C'))
    end

    unit = nil
    spell = nil
    target = nil
end