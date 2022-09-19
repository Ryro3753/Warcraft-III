function igniteCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Ignite_Target[id] = GetSpellTargetUnit()
    unit = nil
end

function igniteCastFinish()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local target = udg_Ignite_Target[id]
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)
    local player = GetOwningPlayer(unit)

    --damage
    local damage = 0
    if level == 1 then
        damage = 50
    elseif level == 2 then
        damage = 80
    elseif level == 3 then
        damage = 140
    elseif level == 4 then
        damage = 200
    end
    damage = damage + udg_Stat_Intelligence_AC[id]

    UnitDamageTargetBJ(unit, target, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    createSpecialEffectOnUnit(target, "Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl")

    --mana and repeat
    if target == udg_Ignite_Repeat_Target[id] and  udg_Ignite_Repeat_Time[id] + udg_Ignite_Repeat_Time_Limit > getCurrentTime() and udg_Ignite_Repeat_Count[id] ~= 0  then
        local manaLimit = level + 1
        local spellsMana = getAbilityMana(unit, spell, level)
        local recoverMana = 0
        if udg_Ignite_Repeat_Count[id] > manaLimit then
            recoverMana = R2I((0.25 * manaLimit) * spellsMana)
        else
            recoverMana = R2I((0.25 * udg_Ignite_Repeat_Count[id]) * spellsMana)
        end
        gainManaToUnit(unit, recoverMana)
        udg_Ignite_Repeat_Count[id] = udg_Ignite_Repeat_Count[id] + 1

        --floatingText
        ForceAddPlayer(udg_FloatingText_PlayerGroup, player)
        local str = "+" .. tostring(recoverMana)
        creatingFloatingTextTimed(str, unit, 10, 20, 20, 70)
        str = nil

        --special effect
        createSpecialEffectOnUnit(unit, "Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl")
    else
        udg_Ignite_Repeat_Target[id] = target
        udg_Ignite_Repeat_Count[id] = 1
    end
    udg_Ignite_Repeat_Time[id] = getCurrentTime()

    setCooldownToAbility(unit, id, spell, level)

    unit = nil
    target = nil
    spell = nil
    player = nil
end