function tauntCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local player = GetOwningPlayer(unit)
    local ability = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, ability)

    --Check if unit is in Combat, if not return
    if udg_CombatSystem_IsActive[id] == false then
        local mana = getAbilityMana(unit, ability, level)
        gainManaToUnit(unit, mana)

        BlzEndUnitAbilityCooldown(unit, ability)
        ForceAddPlayer(udg_FloatingText_PlayerGroup, player)
        creatingFloatingTextTimed("You cannot use Taunt out of combat.", unit, 10, 70, 20, 20)
        unit = nil
        player = nil
        ability = nil
        return
    end

    local flatThreat = 0
    local remainingHealthPercentage = 0
    if level == 1 then
        flatThreat = 20
        remainingHealthPercentage = 10
    elseif level == 2 then
        flatThreat = 50
        remainingHealthPercentage = 10
    elseif level == 3 then
        flatThreat = 100
        remainingHealthPercentage = 15
    elseif level == 4 then
        flatThreat = 200
        remainingHealthPercentage = 15
    end

    --Special Effect
    createSpecialEffectOnUnit(unit, 'Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl')

    --Threat calculation
    local threat = flatThreat + (remainingHealthPercentage * GetUnitState(unit, UNIT_STATE_LIFE) / 100)
    local calculatedThreat = calculateThreat(threat, false, false, 1, udg_ThreatMeter_UnitThreatModifier[id])
    addThreatToThreatMeter(unit, calculatedThreat)


    unit = nil
    player = nil
    ability = nil
end


function tauntLearn()
    local unit = udg_Ability_Purchase_Trigger_Unit
    local spell = udg_Ability_Purchase_Trigger_Spell
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)

    if level == 4 then
        udg_ThreatMeter_UnitThreatModifier[id] = udg_ThreatMeter_UnitThreatModifier[id] + 0.10
    end

    unit = nil
    spell = nil
    level = nil
    id = nil
end

function tauntUnlearn()
    local unit = udg_Ability_Purchase_Trigger_Unit
    local spell = udg_Ability_Purchase_Trigger_Spell
    local level = GetUnitAbilityLevel(unit, spell)
    local id = GetUnitUserData(unit)
    
    if level == 4 then
        udg_ThreatMeter_UnitThreatModifier[id] = udg_ThreatMeter_UnitThreatModifier[id] - 0.10
    end

    unit = nil
    spell = nil
    level = nil
    id = nil
end
