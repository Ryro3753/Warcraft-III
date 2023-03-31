function healOrbEnable()
    if CountPlayersInForceBJ(udg_Player_PlayerGroup) == 1 then
        udg_Heal_Orb_Enable = true
    else
        udg_Heal_Orb_Enable = false
    end
end

function healOrbUnitFind()
    local player = ForcePickRandomPlayer(udg_Player_PlayerGroup)
    local playerId = GetPlayerId(player) + 1
    udg_Heal_Orb_Hero = udg_INV_Player_Hero[playerId]
    player = nil
end

function healOrbSpawn()
    local spawnLoc = GetRandomLocInRect(udg_Heal_Orb_Region)
    CreateNUnitsAtLoc(1, udg_Heal_Orb_UnitType, Player(1), spawnLoc, 0)
    GroupAddUnit(udg_Heal_Orb_UnitGroup, GetLastCreatedUnit())
    UnitApplyTimedLife(GetLastCreatedUnit(), FourCC('BTLF'), 60)

    RemoveLocation(spawnLoc)
    spawnLoc = nil
end

function healOrbActive()
    if udg_Heal_Orb_Enable == false then
        return
    end

    healOrbUnitFind()
    EnableTrigger(gg_trg_Heal_Orb_Spawn)
    EnableTrigger(gg_trg_Heal_Orb_Control)
end

function healOrbDeactive()
    if udg_Heal_Orb_Enable == false then
        return
    end

    DisableTrigger(gg_trg_Heal_Orb_Spawn)
    DisableTrigger(gg_trg_Heal_Orb_Control)

    PauseTimer(udg_Heal_Orb_Timer)
end

function healOrbGroup()
    ForGroup(udg_Heal_Orb_UnitGroup, healOrbGroupFor)
end

function healOrbGroupFor()
    local unit = GetEnumUnit()

    if IsUnitAliveBJ(unit) == false then
        GroupRemoveUnit(udg_Heal_Orb_UnitGroup, unit)
        unit = nil
        return
    end

    local loc = GetUnitLoc(unit)
    local heroLoc = GetUnitLoc(udg_Heal_Orb_Hero)

    if DistanceBetweenPoints(loc, heroLoc) < 125 then
        local health = GetUnitState(unit, UNIT_STATE_MAX_LIFE) * 0.2
        healUnit(udg_Heal_Orb_Hero,udg_Heal_Orb_Hero,health,false)
        GroupRemoveUnit(udg_Heal_Orb_UnitGroup, unit)
        RemoveUnit(unit)
        createSpecialEffectOnLoc(heroLoc, "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
    end

    RemoveLocation(loc)
    RemoveLocation(heroLoc)
    loc = nil
    heroLoc = nil
end