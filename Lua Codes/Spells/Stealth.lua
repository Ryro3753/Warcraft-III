function stealthCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)
    local player = GetOwningPlayer(unit)

    if UnitHasBuffBJ(unit, FourCC('B008')) then
        local mana = getAbilityMana(unit, spell, level)
        gainManaToUnit(unit, mana)

        unit = nil
        spell = nil
        player = nil
        return
    end

    if udg_CombatSystem_IsActive[id] then
        local mana = getAbilityMana(unit, spell, level)
        gainManaToUnit(unit, mana)

        ForceAddPlayer(udg_FloatingText_PlayerGroup, player)
        creatingFloatingTextTimed("You cannot use Stealth in combat.", unit, 10, 70, 20, 20)

        unit = nil
        spell = nil
        player = nil
        return
    end


    local movementSpeed = 0
    local attackDamage = 0
    local criticalStrikeChance = 0
    if level == 1 then
        movementSpeed = 100
        attackDamage = 10
        criticalStrikeChance = 10
    elseif level == 2 then
        movementSpeed = 100
        attackDamage = 12
        criticalStrikeChance = 10
    elseif level == 3 then
        movementSpeed = 75
        attackDamage = 15
        criticalStrikeChance = 12
    elseif level == 4 then
        movementSpeed = 60
        attackDamage = 15
        criticalStrikeChance = 15
    end

    udg_Stealth_AttackDamage[id] = attackDamage
    udg_Stealth_CriticalStrikeChance[id] = criticalStrikeChance

    udg_Stealth_MovementSpeed[id] = movementSpeed
    udg_Stat_Movement_Speed[id] = udg_Stat_Movement_Speed[id] - movementSpeed

    calculateUnitStats(unit)

    udg_Stealth_AbilityCode[id] = spell
    BlzUnitHideAbility(unit, spell, true)

    local loc = GetUnitLoc(unit)
    CreateNUnitsAtLoc(1, udg_Dummy_UnitType, player, loc, 0)
    local dummy = GetLastCreatedUnit()
    UnitApplyTimedLife(dummy, FourCC('BTLF'), 5)

    UnitAddAbility(dummy, FourCC('A00P'))
    IssueTargetOrder(dummy, "invisibility", unit)


    TriggerSleepAction(0.1)

    GroupAddUnit(udg_Stealth_BeforeGroup, unit)
    EnableTrigger(gg_trg_Stealth_Before_Loop)


    RemoveLocation(loc)
    unit = nil
    spell = nil
    player = nil
    dummy = nil
end

function stealthBeforeLoop()
    ForGroup(udg_Stealth_BeforeGroup, stealthBeforeLoopFor)
end

function stealthBeforeLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if UnitHasBuffBJ(unit, FourCC('B008')) == false then
        
        GroupRemoveUnit(udg_Stealth_BeforeGroup, unit)
        if CountUnitsInGroup(udg_Stealth_BeforeGroup) == 0 then
            DisableTrigger(gg_trg_Stealth_Before_Loop)
        end

        BlzUnitHideAbility(unit, udg_Stealth_AbilityCode[id], false)
        BlzStartUnitAbilityCooldown(unit, udg_Stealth_AbilityCode[id], 7)
        udg_Stat_Movement_Speed[id] = udg_Stat_Movement_Speed[id] + udg_Stealth_MovementSpeed[id]
        udg_Stat_Attack_Damage_Modifier[id] = udg_Stat_Attack_Damage_Modifier[id] + udg_Stealth_AttackDamage[id]
        udg_Stat_Critical_Chance[id] = udg_Stat_Critical_Chance[id] + udg_Stealth_CriticalStrikeChance[id]

        calculateUnitStats(unit)

        GroupAddUnit(udg_Stealth_AfterGroup, unit)

        UnitAddAbility(unit, FourCC('A00Q'))
        BlzUnitHideAbility(unit, FourCC('A00Q'), true)

        udg_Stealth_Interval[id] = 5
        EnableTrigger(gg_trg_Stealth_After_Loop)
        
    end

    unit = nil
end

function stealthAfterLoop()
    ForGroup(udg_Stealth_AfterGroup, stealthAfterLoopFor)
end

function stealthAfterLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)

    if udg_Stealth_Interval[id] > 0 then
        udg_Stealth_Interval[id] = udg_Stealth_Interval[id] - 1
    else
        udg_Stat_Attack_Damage_Modifier[id] = udg_Stat_Attack_Damage_Modifier[id] - udg_Stealth_AttackDamage[id]
        udg_Stat_Critical_Chance[id] = udg_Stat_Critical_Chance[id] - udg_Stealth_CriticalStrikeChance[id]

        calculateUnitStats(unit)

        UnitRemoveAbility(unit, FourCC('A00Q'))
        UnitRemoveAbility(unit, FourCC('B009'))

        GroupRemoveUnit(udg_Stealth_AfterGroup, unit)

        if CountUnitsInGroup(udg_Stealth_AfterGroup) == 0 then
            DisableTrigger(gg_trg_Stealth_After_Loop)
        end

    end

    unit = nil
end