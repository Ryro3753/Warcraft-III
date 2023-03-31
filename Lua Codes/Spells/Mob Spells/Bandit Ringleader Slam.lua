function mobSpellBanditRingleaderSlamCast()
    local unit = GetTriggerUnit()
    local target = GetSpellTargetUnit()

    UnitDamageTargetBJ(unit, target, 100 * udg_AdjustmentCombat_Ratio, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    knockbackUnit(target, 1, 30, GetUnitFacing(unit))

    unit = nil
    target = nil
end