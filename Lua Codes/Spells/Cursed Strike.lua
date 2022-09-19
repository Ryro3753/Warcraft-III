function cursedStrikeCast()
    local unit = GetTriggerUnit()
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)

    if UnitHasBuffBJ(unit, FourCC('B001')) == false then
        local buffSpell = FourCC('A00F')
        UnitAddAbility(unit, buffSpell)
        BlzUnitHideAbility(unit, buffSpell, true)
        AddSpecialEffectTargetUnitBJ('weapon', unit, 'Abilities\\Spells\\Items\\OrbDarkness\\OrbDarkness.mdl')
        udg_CursedStrike_SpecialEffect[id] = GetLastCreatedEffectBJ()
        udg_CursedStrike_Ability[id] = spell
        buffSpell = nil
    else
        local mana = getAbilityMana(unit, spell, level)
        gainManaToUnit(unit, mana)
    end

    BlzEndUnitAbilityCooldown(unit, spell)
    unit = nil
    spell = nil
end

function cursedStrikeAttack(unit, target)

    if UnitHasBuffBJ(unit, FourCC('B001')) == false then
        return
    end

    local id = GetUnitUserData(unit)
    local level = GetUnitAbilityLevel(unit, udg_CursedStrike_Ability[id])

    DestroyEffectBJ(udg_CursedStrike_SpecialEffect[id])
    DestroyEffectBJ(udg_CursedStrike_SpecialEffect2[id])
    UnitRemoveAbility(unit, FourCC('A00F'))
    UnitRemoveAbility(unit, FourCC('B001'))

    --Cooldown
    setCooldownToAbility(unit, id, udg_CursedStrike_Ability[id], level)

    --Damage
    local baseDamage = 0
    if level == 1 then
        baseDamage = 15
    elseif level == 2 then
        baseDamage = 45
    elseif level == 3 then
        baseDamage = 105
    elseif level == 4 then
        baseDamage = 150
    end
    local statDamage = R2I((0.5 * udg_Stat_Strength_AC[id])) + (udg_Stat_Agility_AC[id])
    local damage = baseDamage + statDamage

    UnitDamageTargetBJ(unit, target, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)


    --Attack Speed Reduction
    local targetId = GetUnitUserData(target)
    --Check if unit has already debuff if so just reset the timer
    if UnitHasBuffBJ(unit, FourCC('B002')) == true then
        udg_CursedStrike_Countdown[targetId] = 5
    else

        if IsUnitType(target, UNIT_TYPE_ANCIENT) == false then
            local buffSpell = FourCC('A00G')
            UnitAddAbility(target, buffSpell)
            BlzUnitHideAbility(target, buffSpell, true)
            buffSpell = nil

            AddSpecialEffectTargetUnitBJ('overhead', target, 'Abilities\\Spells\\Undead\\Curse\\CurseTarget.mdl')
            udg_CursedStrike_SpecialEffect2[targetId] = GetLastCreatedEffectBJ()
    
            local attackSpeed = 0.12 + (0.03 * level)
            udg_Stat_Attack_Speed[targetId] = udg_Stat_Attack_Speed[targetId] - attackSpeed
            calculateUnitStats(target)
    
            udg_CursedStrike_Countdown[targetId] = 5
            udg_CursedStrike_AttackSpeed[targetId] = attackSpeed
            GroupAddUnit(udg_CursedStrike_UnitGroup, target)
            EnableTrigger(gg_trg_Cursed_Strike_Loop)
        end

    end

end


function cursedStrikeLoop()
    ForGroup(udg_CursedStrike_UnitGroup, cursedStrikeLoopFor)
end

function cursedStrikeLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_CursedStrike_Countdown[id] == 0 then

        GroupRemoveUnit(udg_CursedStrike_UnitGroup, unit)

        udg_Stat_Attack_Speed[id] = udg_Stat_Attack_Speed[id] + udg_CursedStrike_AttackSpeed[id]
        calculateUnitStats(unit)

        UnitRemoveAbility(unit, FourCC('A00G'))
        UnitRemoveAbility(unit, FourCC('B002'))

        DestroyEffectBJ(udg_CursedStrike_SpecialEffect2[id])

        if CountUnitsInGroup(udg_CursedStrike_UnitGroup) == 0 then
            DisableTrigger(gg_trg_Cursed_Strike_Loop)
        end

    else
        udg_CursedStrike_Countdown[id] = udg_CursedStrike_Countdown[id] - 1
    end

    unit = nil

end