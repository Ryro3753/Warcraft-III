function enrageUnit(unit)
    if UnitHasBuffBJ(unit, udg_Enrage_Buff) then
        return
    end
    
    local id = GetUnitUserData(unit)
    local loc = GetUnitLoc(unit)
    local player = GetOwningPlayer(unit)

    CreateNUnitsAtLoc(1, udg_Dummy_UnitType, player, loc, 0)
    local dummy = GetLastCreatedUnit()
    UnitApplyTimedLife(dummy, FourCC('BTLF'), 5)

    UnitAddAbility(dummy, FourCC('A012'))
    IssueTargetOrder(dummy, "bloodlust", unit)

    RemoveLocation(loc)
    loc = nil
    dummy = nil
    player = nil

    udg_Stat_Attack_Damage_Modifier[id] = udg_Stat_Attack_Damage_Modifier[id] + 400
    udg_Stat_Spell_Damage_Modifier[id] = udg_Stat_Spell_Damage_Modifier[id] + 400
    udg_Stat_Attack_Speed[id] = udg_Stat_Attack_Speed[id] + 400
    udg_Stat_Armor_Modifier[id] = udg_Stat_Armor_Modifier[id] + 400

    calculateUnitStats(unit)
end

function enrageUnitOff(unit)
    if UnitHasBuffBJ(unit, FourCC('B00G')) == false then
        return
    end

    local id = GetUnitUserData(unit)

    UnitRemoveAbility(unit, udg_Enrage_Buff)

    udg_Stat_Attack_Damage_Modifier[id] = udg_Stat_Attack_Damage_Modifier[id] - 400
    udg_Stat_Spell_Damage_Modifier[id] = udg_Stat_Spell_Damage_Modifier[id] - 400
    udg_Stat_Attack_Speed[id] = udg_Stat_Attack_Speed[id] - 400
    udg_Stat_Armor_Modifier[id] = udg_Stat_Armor_Modifier[id] - 400

    calculateUnitStats(unit)

end