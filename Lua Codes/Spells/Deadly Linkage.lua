function deadlyLinkageCast()
    local unit = GetTriggerUnit()
    local id = GetUnitUserData(unit)
    local spell = GetSpellAbilityId()
    local level = GetUnitAbilityLevel(unit, spell)

    local healthPercentage = 0.0
    local manaPercentage = 0.0
    local tick = 0
    if level == 1 then
        healthPercentage = 5
        manaPercentage = 5
        tick = 20
    elseif level == 2 then
        healthPercentage = 4.5
        manaPercentage = 5.5
        tick = 20
    elseif level == 3 then
        healthPercentage = 4
        manaPercentage = 6
        tick = 18
    elseif level == 4 then
        healthPercentage = 3.5
        manaPercentage = 6.5
        tick = 16
    end

    udg_DeadlyLinkage_IsActive[id] = true
    UnitAddAbility(unit, FourCC('A00V'))
    BlzUnitHideAbility(unit, FourCC('A00V'), true)

    local loc = GetUnitLoc(unit)

    for i=1,tick do

        local currentHealthPercentage = GetUnitLifePercent(unit)
        local currentManaPercentage = GetUnitManaPercent(unit)
        if healthPercentage >= GetUnitLifePercent(unit) or currentManaPercentage == 100 then
            deadlyLinkageStopUnit(unit)
        end

        if udg_DeadlyLinkage_IsActive[id] == false then
            RemoveLocation(loc)
            loc = nil
            unit = nil
            spell = nil
            return
        end

        local newHealthPercentage = currentHealthPercentage - healthPercentage
        SetUnitLifePercentBJ(unit, newHealthPercentage)

        local newManaPercentage = currentManaPercentage + manaPercentage
        SetUnitManaPercentBJ(unit, newManaPercentage)

        createSpecialEffectOnLoc(loc, "Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")

        TriggerSleepAction(0.5)
    end

    RemoveLocation(loc)
    loc = nil
    unit = nil
    spell = nil
end


function deadlyLinkageStopUnit(unit)
    local id = GetUnitUserData(unit)
    UnitRemoveAbility(unit, FourCC('A00V'))
    UnitRemoveAbility(unit, udg_DeadlyLinkage_Buff)
    udg_DeadlyLinkage_IsActive[id] = false
    IssueImmediateOrder(unit, "stop")
end

function deadlyLinkageDamageTaken(receiver)
    if UnitHasBuffBJ(receiver, udg_DeadlyLinkage_Buff) then
        SetUnitManaPercentBJ(receiver, 0)
        deadlyLinkageStopUnit(receiver)
    end
end