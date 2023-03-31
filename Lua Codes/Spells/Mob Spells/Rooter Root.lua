function mobSpellRooterRootCast()
    local unit = GetTriggerUnit()
    local target = GetSpellTargetUnit()

    UnitDamageTargetBJ(unit, target, 50 * udg_AdjustmentCombat_Ratio, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    snareUnit(target, 6, 'A01I' , 'Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl')

    unit = nil
    target = nil
end