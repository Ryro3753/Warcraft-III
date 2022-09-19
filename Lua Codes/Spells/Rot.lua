function rotCast()
    local caster = GetTriggerUnit()
    local target = GetSpellTargetUnit()
    local casterId = GetUnitUserData(caster)
    local targetId = GetUnitUserData(target)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(caster, spell)

    if UnitHasBuffBJ(target, FourCC('B004')) then
        udg_Rot_Interval[targetId] = 7
    else
        local damage = 0
        if level == 1 then
            damage = 15
        elseif level == 2 then
            damage = 25
        elseif level == 3 then
            damage = 35
        elseif level == 4 then
            damage = 50
        end

        damage = damage + R2I((9 + level) / 100 * udg_Stat_Intelligence_AC[casterId])
        udg_Rot_Damage[targetId] = damage
        udg_Rot_AttackDamage[targetId] = 15
        udg_Rot_Interval[targetId] = 7
        udg_Rot_Caster[targetId] = caster
        GroupAddUnit(udg_Rot_Group, target)

        udg_Stat_Attack_Damage_Modifier[targetId] = udg_Stat_Attack_Damage_Modifier[targetId] - udg_Rot_AttackDamage[targetId]
        calculateUnitStats(target)

        UnitAddAbility(target, FourCC('A00J'))
        BlzUnitHideAbility(target, FourCC('A00J'), true)

        EnableTrigger(gg_trg_Rot_Loop)

    end

    caster = nil
    target = nil
    spell = nil
end

function rotLoop()
    ForGroup(udg_Rot_Group, rotLoopFor)
end

function rotLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_Rot_Interval[id] == 0 then

        GroupRemoveUnit(udg_Rot_Group, unit)

        udg_Stat_Attack_Damage_Modifier[id] = udg_Stat_Attack_Damage_Modifier[id] + udg_Rot_AttackDamage[id]
        calculateUnitStats(unit)

        UnitRemoveAbility(unit, FourCC('A00J'))
        UnitRemoveAbility(unit, FourCC('B004'))

        if CountUnitsInGroup(udg_Rot_Group) == 0 then
            DisableTrigger(gg_trg_Rot_Loop)
        end

    else
        udg_Rot_Interval[id] = udg_Rot_Interval[id] - 1

        UnitDamageTargetBJ(udg_Rot_Caster[id], unit, udg_Rot_Damage[id], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

        createSpecialEffectOnUnit(unit, "Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl")

    end

    unit = nil
end