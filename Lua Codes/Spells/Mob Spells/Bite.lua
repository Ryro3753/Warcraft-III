function mobSpellBite()
    local unit = GetTriggerUnit()
    local target = GetSpellTargetUnit()
    local id = GetUnitUserData(unit)
    local targetId = GetUnitUserData(target)
    local unitType = GetUnitTypeId(unit)

    local armor = 0
    if unitType == FourCC('h00Y') then
        armor = 8
    elseif unitType == FourCC('h00Z') then
        armor = 25
    end

    unitType = nil

    playSoundAtUnit(target, gg_snd_Wolf2)

    udg_MS_Bite_Target[id] = target
    udg_Stat_Armor_Flat[targetId] = udg_Stat_Armor_Flat[targetId] - armor
    calculateUnitStats(target)

    udg_MS_Bite_Target_Interval[targetId] = udg_MS_Bite_Target_Interval[targetId] + 10

    for i=1,10 do
        udg_MS_Bite_Target_Interval[targetId] = udg_MS_Bite_Target_Interval[targetId] - 1
        TriggerSleepAction(1)
    end

    udg_Stat_Armor_Flat[targetId] = udg_Stat_Armor_Flat[targetId] + armor
    calculateUnitStats(target)


    unit = nil
    target = nil
end