function foulSacrificeCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    udg_FoulSacrifice_Target[id] = GetSpellTargetUnit()
    unit = nil
end

function foulSacrificeCastFinishes()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)
    local target = udg_FoulSacrifice_Target[id]

    local missingManaPercentage = 0.0
    local damageSpellDamageRatio = 0.5
    local manaSpellDamageRatio = 0.5
    local damage = 0
    if level == 1 then
        damage = 20
        missingManaPercentage = 0.2
    elseif level == 2 then
        damage = 40
        missingManaPercentage = 0.3
    elseif level == 3 then
        damage = 65
        missingManaPercentage = 0.4
    elseif level == 4 then
        damage = 100
        missingManaPercentage = 0.5
    end

    local currentMana = GetUnitState(unit, UNIT_STATE_MANA)
    local maxMana = GetUnitState(unit, UNIT_STATE_MAX_MANA)
    local missingMana = maxMana - currentMana

    udg_FoulSacrifice_Damage[id] = damage + (damageSpellDamageRatio * udg_Stat_Spell_Damage_AC[id])
    udg_FoulSacrifice_Mana[id] = (missingMana * missingManaPercentage) + (manaSpellDamageRatio * udg_Stat_Spell_Damage_AC[id])

    missileToUnit(unit, target, "Abilities\\Weapons\\GreenDragonMissile\\GreenDragonMissile.mdl", 0.4, 100, 40, gg_trg_Foul_Sacrifice_Enemy_Hit)

    setCooldownToAbility(unit, id, spell, level)

    unit = nil
    spell = nil
    target = nil
    udg_FoulSacrifice_Target[id] = nil
end

function foulSacrificeMissileEnemyHit()
    local caster = udg_Missile_System_Dummy_Caster
    local target = udg_Missile_System_Dummy_Target
    local casterId = GetUnitUserData(caster)

    UnitDamageTargetBJ(caster, target, udg_FoulSacrifice_Damage[casterId], ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

    missileToUnit(target, caster, "Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", 0.7, 100, 40, gg_trg_Foul_Sacrifice_Return_Hit)

    udg_Missile_System_Dummy_Caster = nil
    udg_Missile_System_Dummy_Target = nil
    caster = nil
    target = nil
end

function foulSacrificeMissileReturnHit()
    local target = udg_Missile_System_Dummy_Target
    local targetId = GetUnitUserData(target)
    local player = GetOwningPlayer(target)

    local gainedMana = gainManaToUnit(target, udg_FoulSacrifice_Mana[targetId])

    manaFloatingText(gainedMana, player, target)

    target = nil
    player = nil
    udg_Missile_System_Dummy_Target = nil
end