function purificationCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    if udg_Purification_Interval[id] > 0 then
        udg_Purification_Interval[id] = 6

        setCooldownToAbility(unit, id, spell, level)

        unit = nil
        spell = nil
    end


    local damage = 0
    local attackDamagePercentage = 0
    local spellDamagePercentage = 0
    if level == 1 then
        damage = 30
        attackDamagePercentage = 0.10
        spellDamagePercentage = 0.05
    elseif level == 2 then
        damage = 40
        attackDamagePercentage = 0.11
        spellDamagePercentage = 0.05
    elseif level == 3 then
        damage = 55
        attackDamagePercentage = 0.12
        spellDamagePercentage = 0.06
    elseif level == 4 then
        damage = 75
        attackDamagePercentage = 0.13
        spellDamagePercentage = 0.06
    end

    udg_Purification_Damage[id] = damage + (attackDamagePercentage * udg_Stat_Attack_Damage_AC[id]) + (spellDamagePercentage * udg_Stat_Spell_Damage_AC[id])

    UnitAddAbility(unit, FourCC('A00R'))
    BlzUnitHideAbility(unit, FourCC('A00R'), true)

    udg_Purification_Interval[id] = 6

    GroupAddUnit(udg_Purification_Group, unit)
    EnableTrigger(gg_trg_Purification_Loop)

    setCooldownToAbility(unit, id, spell, level)

    unit = nil
    spell = nil
end

function purificationLoop()
    ForGroup(udg_Purification_Group, purificationLoopFor)
end

function purificationLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_Purification_Interval[id] > 0 then
        udg_Purification_Interval[id] = udg_Purification_Interval[id] - 1
    else
        UnitRemoveAbility(unit, FourCC('A00R'))
        UnitRemoveAbility(unit, FourCC('B00A'))

        GroupRemoveUnit(udg_Purification_Group, unit)
        if CountUnitsInGroup(udg_Purification_Group) == 0 then
            DisableTrigger(gg_trg_Purification_Loop)
        end
    end
end


function purificationHit(causer, receiver)
    if UnitHasBuffBJ(causer, udg_Purification_Buff) == false then
        return
    end

    local id = GetUnitUserData(causer)

    if IsUnitType(receiver, UNIT_TYPE_UNDEAD) then
        UnitDamageTargetBJ(causer, receiver, udg_Purification_Damage[id] * 1.5, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    else
        UnitDamageTargetBJ(causer, receiver, udg_Purification_Damage[id], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    end

    createSpecialEffectOnUnit(receiver, "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
end