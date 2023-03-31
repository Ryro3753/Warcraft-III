function mapSpecificSettingsInit()
    mapSpecificFindUniqueUnits() -- Every map I didn't want to assign unique units with hardcode so I wrote a code that auto assign the variables to those units.
    mapSpecificAntiCheatRegion()
    mapSpecificInvulnerableRegion()
    mapSpecificHeroCreateRegion()
    mapSpecificBaseTeleportRegions()
    
    --Map Ids
    -- 0 = Base Map
    -- 1 = Fall of Lordaeron
    udg_Map_Id = 1


    mapSpecificMobSpellsActivate()


    --Map Code init
    if udg_Map_Id == 1 then
        mapFallOfLordaeron()
    end
end

function mapSpecificFindUniqueUnits()
    local group = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(mapSpecificFindUniqueUnitsFilter))
    ForGroup(group, mapSpecificFindUniqueUnitsFor)
    DestroyGroup(group)
    group = nil
end


function mapSpecificFindUniqueUnitsFilter()
    local unitType = GetUnitTypeId(GetFilterUnit())
    if unitType == FourCC('hmrb') -- Mr Boss
    or unitType == FourCC('hmsb') -- Ms Boss
    or unitType == FourCC('hsdm') -- Spell Dummy
    then
        unitType = nil
        return true
    else
        unitType = nil
        return false
    end
end

function mapSpecificFindUniqueUnitsFor()
    local unitType = GetUnitTypeId(GetEnumUnit())
    if unitType == FourCC('hmrb') then -- Mr Boss
        udg_Map_MrBoss = GetEnumUnit()
    end

    if unitType == FourCC('hmsb') then -- Ms Boss
        udg_Map_MsBoss = GetEnumUnit()
    end

    if unitType == FourCC('hsdm') then -- Spell Dummy
        udg_Dummy_Unit = GetEnumUnit()
    end

    unitType = nil
end

function mapSpecificAntiCheatRegion()
    udg_AntiCheat_Region = gg_rct_Anti_Cheat_Region
end

function mapSpecificInvulnerableRegion()
    udg_Map_Invulnerable_Region = gg_rct_Invulnerable_Region

    TriggerRegisterEnterRectSimple(gg_trg_Invulnerable_Region_Enter, udg_Map_Invulnerable_Region)
    TriggerRegisterLeaveRectSimple(gg_trg_Invulnerable_Region_Leave, udg_Map_Invulnerable_Region)
end

function mapSpecificHeroCreateRegion()
    udg_Hero_Selection_Create_Region = gg_rct_Hero_Create_Region
end

function mapSpecificMobSpellsActivate()
    if udg_Map_Id == 1 then
        EnableTrigger(gg_trg_Bite_Cast)
        EnableTrigger(gg_trg_Bandit_Ringleader_Slam_Cast)
        EnableTrigger(gg_trg_Foul_Claws_Attack)
        EnableTrigger(gg_trg_Rooter_Root_Cast)
    end
end

function mapSpecificBaseTeleportRegions()
    udg_Map_Base_Regions[1] = gg_rct_Base_Teleport_Region_1
    udg_Map_Base_Regions[2] = gg_rct_Base_Teleport_Region_2
    udg_Map_Base_Regions[3] = gg_rct_Base_Teleport_Region_3
    udg_Map_Base_Regions[4] = gg_rct_Base_Teleport_Region_4

    TriggerRegisterEnterRectSimple(gg_trg_Base_Teleport_Region_Enter_Going, udg_Map_Base_Regions[1])
    TriggerRegisterEnterRectSimple(gg_trg_Base_Teleport_Region_Enter_Come_Back, udg_Map_Base_Regions[3])
end

function mapSpecificBaseTeleportGoing()
    local loc = GetRectCenter(udg_Map_Base_Regions[2])
    SetUnitPositionLoc(GetTriggerUnit(), loc)
    PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), loc, 0)
    RemoveLocation(loc)
    loc = nil
end

function mapSpecificBaseTeleportComeBack()
    local loc = GetRectCenter(udg_Map_Base_Regions[4])
    SetUnitPositionLoc(GetTriggerUnit(), loc)
    PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), loc, 0)
    RemoveLocation(loc)
    loc = nil
end