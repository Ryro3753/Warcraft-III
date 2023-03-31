function frostBlastCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Frost_Blast_Point[id] = GetSpellTargetLoc()
    unit = nil
end

function frostBlastCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    local damage = 0
    local spellDamagePercentage = 0
    local rootDuration = 0
    if level == 1 then
        damage = 30
        spellDamagePercentage = 0.25
        rootDuration = 3
    elseif level == 2 then
        damage = 45
        spellDamagePercentage = 0.27
        rootDuration = 3
    elseif level == 3 then
        damage = 70
        spellDamagePercentage = 0.28
        rootDuration = 3
    elseif level == 4 then
        damage = 100
        spellDamagePercentage = 0.30
        rootDuration = 4
    end

    udg_Frost_Blast_Root[id] = rootDuration
    udg_Frost_Blast_Damage[id] = damage + (spellDamagePercentage * udg_Stat_Spell_Damage_AC[id])
    local group = GetUnitsInRangeOfLocMatching(300, udg_Frost_Blast_Point[id], Condition(frostBlastGroupFilter))
    ForGroup(group, frostBlastGroupFor)

    DestroyGroup(group)

    setCooldownToAbility(unit, id, spell, level)

    createSpecialEffectOnLocWithDurationAndSize(udg_Frost_Blast_Point[id], "Doodads\\Cinematic\\Campaign_Human09\\FrostShockwave.mdl", 0.5, 1)

    RemoveLocation(udg_Frost_Blast_Point[id])
    group = nil
    unit = nil
    spell = nil
end


function frostBlastGroupFilter()
    if IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitAliveBJ(GetFilterUnit()) and BlzIsUnitInvulnerable(GetFilterUnit()) == false then
        return true
    else
        return false
    end
end

function frostBlastGroupFor()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local target = GetEnumUnit()

    UnitDamageTargetBJ(unit, target, udg_Frost_Blast_Damage[id], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    if IsUnitType(target, UNIT_TYPE_ANCIENT) then
        snareUnit(target,udg_Frost_Blast_Root[id] / 2,'A00L', nil)
    else
        snareUnit(target,udg_Frost_Blast_Root[id],'A00L', nil)
    end
    
    unit = nil
    target = nil
end