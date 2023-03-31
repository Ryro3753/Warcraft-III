function decompositionCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Decomposition_Point[id] = GetSpellTargetLoc()
    unit = nil
end

function decompositionCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    local damage = 0
    local spellDamagePercentage = 0
    if level == 1 then
        damage = 170
        spellDamagePercentage = 0.5
    elseif level == 2 then
        damage = 250
        spellDamagePercentage = 0.55
    elseif level == 3 then
        damage = 350
        spellDamagePercentage = 0.6
    elseif level == 4 then
        damage = 500
        spellDamagePercentage = 0.65
    end

    udg_Decomposition_Damage[id] = (damage + (spellDamagePercentage * udg_Stat_Spell_Damage_AC[id])) / 10
    udg_Decomposition_Caster[id] = unit
    missileToPoint(unit, udg_Decomposition_Point[id], "Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilMissile.mdl", 1, 100, 30, gg_trg_Decomposition_Missile)

    setCooldownToAbility(unit, id, spell, level)

    RemoveLocation(udg_Decomposition_Point[id])
    udg_Decomposition_Point[id] = nil
    unit = nil
    spell = nil
end

function decompositionMissleHit()
    local unit = udg_Missile_System_Dummy_Caster
    local id = GetUnitUserData(unit)
    local player = GetOwningPlayer(unit)

    CreateNUnitsAtLoc(1, udg_Dummy_UnitType, player, udg_Missile_System_Dummy_Point, 0)
    local dummy = GetLastCreatedUnit()
    SetUnitUserData(dummy, id)

    AddSpecialEffectLocBJ(udg_Missile_System_Dummy_Point, "Doodads\\Cinematic\\Campaign_Undead05\\SylvanasBirth.mdx")
    udg_Decomposition_Effect[id] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_Decomposition_Effect[id], 1.5)

    udg_Decomposition_Interval[id] = 5
    GroupAddUnit(udg_Decomposition_Group, dummy)
    EnableTrigger(gg_trg_Decomposition_Loop)

    RemoveLocation(udg_Missile_System_Dummy_Point)
    udg_Missile_System_Dummy_Point = nil
    unit = nil
    player = nil
end

function decompositionLoop()
    ForGroup(udg_Decomposition_Group, decompositionLoopFor)
end

function decompositionLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)
    local loc = GetUnitLoc(unit)

    local group = GetUnitsInRangeOfLocMatching(250, loc, Condition(decompositionDamageFilter))
    if CountUnitsInGroup(group) > 0 then
        udg_Decomposition_Id = id
        ForGroup(group, decompositionDamageFor)
    end

    udg_Decomposition_Interval[id] = udg_Decomposition_Interval[id] - 0.5
    if udg_Decomposition_Interval[id] <= 0 then
        GroupRemoveUnit(udg_Decomposition_Group, unit)
        RemoveUnit(unit)

        DestroyEffect(udg_Decomposition_Effect[id])
        if CountUnitsInGroup(udg_Decomposition_Group) == 0 then
            DisableTrigger(gg_trg_Decomposition_Loop)
        end
    end

    RemoveLocation(loc)
    loc = nil
    DestroyGroup(group)
    unit = nil
    group = nil
end

function decompositionDamageFilter()
    if IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitAliveBJ(GetFilterUnit()) 
    and BlzIsUnitInvulnerable(GetFilterUnit()) == false 
    and IsUnitType(GetFilterUnit(), UNIT_TYPE_SAPPER) == false then
        return true
    else
        return false
    end
end

function decompositionDamageFor()
    UnitDamageTargetBJ(udg_Decomposition_Caster[udg_Decomposition_Id], GetEnumUnit(), udg_Decomposition_Damage[udg_Decomposition_Id], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
end