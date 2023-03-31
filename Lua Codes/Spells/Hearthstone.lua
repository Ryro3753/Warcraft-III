function hearthstoneCast()
    local unit = GetTriggerUnit()
    UnitAddAbility(unit, FourCC('A011'))
    BlzUnitHideAbility(unit, FourCC('A011'), true)
    unit = nil
end

function hearthstoneCastFinishes()
    local unit = GetTriggerUnit()
    UnitRemoveAbility(unit, FourCC('A011'))
    UnitRemoveAbility(unit, FourCC('B00F'))
    local mrBossLoc = GetUnitLoc(udg_Map_MrBoss)
    SetUnitPositionLoc(unit, mrBossLoc)

    createSpecialEffectOnLocWithDurationAndSize(mrBossLoc, 'Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl', 1, 1)

    RemoveLocation(mrBossLoc)
    mrBossLoc = nil
    unit = nil
end

function hearthstoneCastStopped()
    local unit = GetTriggerUnit()
    UnitRemoveAbility(unit, FourCC('A011'))
    UnitRemoveAbility(unit, FourCC('B00F'))
    unit = nil
end

function hearthstoneDamageControl(receiver)
    if UnitHasBuffBJ(receiver, udg_Hearthstone_Buff) then
        PauseUnit(receiver, true)
        IssueImmediateOrder(receiver, "stop")
        PauseUnit(receiver, false)
        UnitRemoveAbility(receiver, FourCC('A011'))
        UnitRemoveAbility(receiver, FourCC('B00F'))
    end
end