function felBlastCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_FelBlast_TargetPoint[id] = GetSpellTargetLoc()
    unit = nil
end

function felBlastFinish()
    local unit = GetTriggerUnit()
    local spell = GetSpellAbilityId()
    local id = GetUnitUserData(unit)
    local level = GetUnitAbilityLevel(unit, spell)
    local group = GetUnitsInRangeOfLocMatching(300, udg_FelBlast_TargetPoint[id], Condition(felBlastGroupFilter))

    local damage = 0
    if level == 1 then
        damage = 120
    elseif level == 2 then
        damage = 200
    elseif level == 3 then
        damage = 320
    elseif level == 4 then
        damage = 450
    end
    damage = damage + (2 * udg_Stat_Intelligence_AC[id])

    udg_FelBlast_Damage[id] = damage

    ForGroup(group, felBlastGroupFor)
    DestroyGroup(group)

    setCooldownToAbility(unit,id, spell, level)

    createSpecialEffectOnLocWithDurationAndSize(udg_FelBlast_TargetPoint[id], "Abilities\\Spells\\NightElf\\Immolation\\ImmolationTarget.mdl", 0.5, 3)

    unit = nil
    spell = nil
    group = nil
    RemoveLocation(udg_FelBlast_TargetPoint[id])
end

function felBlastGroupFilter()
    if IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitAliveBJ(GetFilterUnit()) and BlzIsUnitInvulnerable(GetFilterUnit()) == false then
        return true
    else
        return false
    end
end

function felBlastGroupFor()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local target = GetEnumUnit()

    UnitDamageTargetBJ(unit, target, udg_FelBlast_Damage[id], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

    unit = nil
    target = nil
end