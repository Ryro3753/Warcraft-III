function compressedFelBoltCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_Compressed_Fel_Bolt_Target[id] = GetSpellTargetUnit()
    unit = nil
end

function compressedFelBoltCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    udg_Compressed_Fel_Bolt_Ability[id] = spell

    missileToUnit(unit,udg_Compressed_Fel_Bolt_Target[id],"Abilities\\Weapons\\GreenDragonMissile\\GreenDragonMissile.mdl", 1, 100, 35, gg_trg_Compressed_Fel_Bolt_Missile_Hit)

    setCooldownToAbility(unit, id, spell, level)

    unit = nil
    spell = nil
end

function compressedFelBoltMissileHit()
    local caster = udg_Missile_System_Dummy_Caster
    local target = udg_Missile_System_Dummy_Target
    local casterId = GetUnitUserData(caster)
    local spell = udg_Compressed_Fel_Bolt_Ability[casterId]
    local level = GetUnitAbilityLevel(caster, spell)
    local angle = udg_Missile_System_Dummy_Angle

    local damage = 0
    local duration = 0.0
    if level == 1 then
        damage = 80
        duration = 0.5
    elseif level == 2 then
        damage = 120
        duration = 0.5
    elseif level == 3 then
        damage = 170
        duration = 0.6
    elseif level == 4 then
        damage = 250
        duration = 0.6
    end

    knockbackUnit(target, duration, 20, angle)

    damage = damage + (0.5 * udg_Stat_Spell_Damage_AC[casterId])

    UnitDamageTargetBJ(caster, target, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

    udg_Compressed_Fel_Bolt_Ability[casterId] = nil
    udg_Missile_System_Dummy_Caster = nil
    udg_Missile_System_Dummy_Target = nil
    caster = nil
    target = nil
    spell = nil
end