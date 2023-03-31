function thornpoonCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Thornpoon_Point[id] = GetSpellTargetLoc()
    unit = nil
end

function thornpoonCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)


    local damage = 0
    local range = 700
    if level == 1 then
        damage = 70
        range = 700
    elseif level == 2 then
        damage = 110
        range = 750
    elseif level == 3 then
        damage = 165
        range = 800
    elseif level == 4 then
        damage = 250
        range = 850
    end

    udg_Thornpoon_Damage[id] = damage + (0.40 * udg_Stat_Spell_Damage_AC[id])

    setCooldownToAbility(unit, id, spell, level)

    GroupClear(udg_Thornpoon_DamageGroup[id])
    missileToDirectionEveryEnemy(unit, udg_Thornpoon_Point[id], range, 100, "Abilities\\Weapons\\Dryadmissile\\Dryadmissile.mdl", 1, 100, 30, nil, gg_trg_Thornpoon_Each_Damage)


    RemoveLocation(udg_Thornpoon_Point[id])
    udg_Thornpoon_Point[id] = nil
    unit = nil
    spell = nil
end

function thornpoonEachLoop()
    ForGroup(udg_Missile_System_Dummy_Group, thornpooEachLoopFor)
end

function thornpooEachLoopFor()
    local id = GetUnitUserData(udg_Missile_System_Dummy_Caster)

    if IsUnitInGroup(GetEnumUnit(), udg_Thornpoon_DamageGroup[id]) then
        return
    end

    local target = GetEnumUnit()

    UnitDamageTargetBJ(udg_Missile_System_Dummy_Caster, target, udg_Thornpoon_Damage[id], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    GroupAddUnit(udg_Thornpoon_DamageGroup[id], target)

    target = nil
end