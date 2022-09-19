function blackArrowCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Black_Arrow_Target[id] = GetSpellTargetUnit()
    unit = nil
end

function blackArrowCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    udg_Black_Arrow_Ability[id] = spell

    missileToUnit(unit,udg_Black_Arrow_Target[id],"Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl", 100, 40, gg_trg_Black_Arrow_Missile_Hit)

    setCooldownToAbility(unit, id, spell, level)

    unit = nil
    spell = nil
end


function blackArrowMissileHit()
    local caster = udg_Missile_System_Dummy_Caster
    local target = udg_Missile_System_Dummy_Target
    local casterId = GetUnitUserData(caster)
    local spell = udg_Black_Arrow_Ability[casterId]
    local level = GetUnitAbilityLevel(caster, spell)

    local damage = 0
    local silence = 0
    if level == 1 then
        damage = 40
        silence = 1.5
    elseif level == 2 then
        damage = 70
        silence = 2
    elseif level == 3 then
        damage = 105
        silence = 2.5
    elseif level == 4 then
        damage = 145
        silence = 3
    end

    silenceUnit(target, silence)

    UnitDamageTargetBJ(caster, target, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)


    udg_Black_Arrow_Ability[casterId] = nil
    udg_Missile_System_Dummy_Caster = nil
    udg_Missile_System_Dummy_Target = nil
    caster = nil
    target = nil
    spell = nil
end