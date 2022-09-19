function registerLoop()
    ForGroup(udg_Registered_Units, registerLoopFor)
end

function registerLoopFor()
    local unit = GetEnumUnit()
    local id = GetUnitUserData(unit)
    if IsUnitAliveBJ(unit) == false then
        GroupRemoveUnit(udg_Registered_Units, unit)
    end
    SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_LIFE) + R2I(udg_Stat_Health_Regen_AC[id] / 5))
    SetUnitState(unit, UNIT_STATE_MANA, GetUnitState(unit, UNIT_STATE_MANA) + R2I(udg_Stat_Mana_Regen_AC[id] / 5))
    unit = nil
end