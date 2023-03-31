function thornsCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    --Damage
    local damage = 0
    local ratio = 0.09 + (0.01 * level)
    if level == 1 then
        damage = 20 
    elseif level == 2 then
        damage = 25 
    elseif level == 3 then
        damage = 40 
    elseif level == 4 then
        damage = 60 
    end
    damage = damage + R2I((udg_Stat_Strength_AC[id] * ratio) + (udg_Stat_Agility_AC[id] * ratio) + (udg_Stat_Intelligence_AC[id] * ratio))
    udg_Thorns_Damage[id] = damage

    --Special Effect
    AddSpecialEffectTargetUnitBJ('origin', unit, "Abilities\\Spells\\NightElf\\ThornsAura\\ThornsAura.mdl")
    udg_Thorns_SpecialEffect[id] = GetLastCreatedEffectBJ()

    UnitAddAbility(unit, FourCC('A00H'))
    BlzUnitHideAbility(unit, FourCC('A00H'), true)

    --Armor
    local armor = 0
    if level == 1 then
        armor = 12
    elseif level == 2 then
        armor = 35
    elseif level == 3 then
        armor = 65
    elseif level == 4 then
        armor = 100
    end
    armor = armor + R2I(0.8 * udg_Stat_Intelligence_AC[id])
    udg_Thorns_Armor[id] = armor
    udg_Stat_Armor[id] = udg_Stat_Armor[id] + armor
    calculateUnitStats(unit)

    setCooldownToAbility(unit, id, spell, level)

    TriggerSleepAction(3)

    DestroyEffectBJ(udg_Thorns_SpecialEffect[id])

    TriggerSleepAction(5)

    UnitRemoveAbility(unit, FourCC('A00H'))
    UnitRemoveAbility(unit, FourCC('B003'))

    --Armor
    udg_Stat_Armor[id] = udg_Stat_Armor[id] - udg_Thorns_Armor[id]
    calculateUnitStats(unit)

    unit = nil
    spell = nil
end

function thornsAttack(unit, target)

    if UnitHasBuffBJ( target, udg_Thorns_Buff) then
        local range = getUnitIsMeleeOrRange(unit)

        if range == "Melee" then
            local id = GetUnitUserData(target)
            
            UnitDamageTargetBJ(target, unit, udg_Thorns_Damage[id], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
        end
        range = nil
    end
    
end