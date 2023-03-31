function mapFallOfLordaeron()
    mapFallOfLordaeronBossEncounterInit()
    mapFallOfLordaeronFindBosses()
    mapFallOfLordaeronTriggerEnable()
    
end

function mapFallOfLordaeronBossEncounterInit()

    --Maggot Paw
    udg_Boss_Encounter_Unit_Type[1] = FourCC('h019')
    udg_Boss_Encounter_Region[1] = gg_rct_Boss_Maggot_Paw
    udg_Boss_Encounter_Heal_Orb_Time[1] = 10.0
    udg_Boss_Encounter_Enrage_Time[1] = 180.0
    udg_Boss_Encounter_Start_Trigger[1] = gg_trg_FOL_Maggot_Paw_Encounter_Start
    udg_Boss_Encounter_End_Trigger[1] = gg_trg_FOL_Maggot_Paw_Encounter_End

    --Skelemancer
    udg_Boss_Encounter_Unit_Type[2] = FourCC('h01A')
    udg_Boss_Encounter_Region[2] = gg_rct_Boss_Skelemancer
    udg_Boss_Encounter_Heal_Orb_Time[2] = 10.0
    udg_Boss_Encounter_Enrage_Time[2] = 180.0
    udg_Boss_Encounter_Start_Trigger[2] = gg_trg_FOL_Skelemancer_Encounter_Start
    udg_Boss_Encounter_End_Trigger[2] = gg_trg_FOL_Skelemancer_Encounter_End

    --R'servoir
    udg_Boss_Encounter_Unit_Type[3] = FourCC('h01B')
    udg_Boss_Encounter_Region[3] = gg_rct_Boss_Rservoir
    udg_Boss_Encounter_Heal_Orb_Time[3] = 10.0
    udg_Boss_Encounter_Enrage_Time[3] = 180.0
    udg_Boss_Encounter_Start_Trigger[3] = gg_trg_FOL_Rservoir_Encounter_Start
    udg_Boss_Encounter_End_Trigger[3] = gg_trg_FOL_Rservoir_Encounter_End

    udg_Boss_Encounter_Limit = 3

end

function mapFallOfLordaeronFindBosses()
    local group = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(mapFallOfLordaeronFindBossesFilter))
    ForGroup(group, mapFallOfLordaeronFindBossesFor)
    DestroyGroup(group)
    group = nil
end

function mapFallOfLordaeronFindBossesFilter()
    local unitType = GetUnitTypeId(GetFilterUnit())
    if unitType == FourCC('h019') -- Maggot Paw
    or unitType == FourCC('h01A') -- Skelemancer
    or unitType == FourCC('h01B') -- R'servoir
    then
        unitType = nil
        return true
    else
        unitType = nil
        return false
    end
end

function mapFallOfLordaeronFindBossesFor()
    local unitType = GetUnitTypeId(GetEnumUnit())
    if unitType == FourCC('h019') then -- Maggot Paw
        udg_FOL_MaggotPaw = GetEnumUnit()
    end

    if unitType == FourCC('h01A') then -- Skelemancer
        udg_FOL_Skelemancer = GetEnumUnit()
    end

    if unitType == FourCC('h01B') then -- R'servoir
        udg_FOL_Rservoir = GetEnumUnit()
    end

    unitType = nil
end

function mapFallOfLordaeronTriggerEnable()

    --Maggot Paw
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Encounter_Start)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Encounter_End)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Death_Sound)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Tornado_Cast_Start)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Tornado_Cast_End)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Tornado_Timer)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Shockwave_Cast)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Shockwave_Casting)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Shockwave_For)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Shockwave_Timer)

    --Skelemancer
    EnableTrigger(gg_trg_FOL_Skelemancer_Encounter_Start)
    EnableTrigger(gg_trg_FOL_Skelemancer_Encounter_End)
    EnableTrigger(gg_trg_FOL_Skelemancer_Scorch)
    EnableTrigger(gg_trg_FOL_Skelemancer_Death_Blast_Timer)
    EnableTrigger(gg_trg_FOL_Skelemancer_Death_Blast_Cast)
    EnableTrigger(gg_trg_FOL_Skelemancer_Death_Blast_Damage)
    EnableTrigger(gg_trg_FOL_Skelemancer_Death_Sentence)
    EnableTrigger(gg_trg_FOL_Skelemancer_Death_Sentence_Cast)
    TriggerRegisterUnitManaEvent( gg_trg_FOL_Skelemancer_Death_Sentence, udg_FOL_Skelemancer, GREATER_THAN_OR_EQUAL, 99 )

    --R'servoir
    EnableTrigger(gg_trg_FOL_Rservoir_Encounter_Start)
    EnableTrigger(gg_trg_FOL_Rservoir_Gas_Cleave)
    EnableTrigger(gg_trg_FOL_Rservoir_Charge_Timer_Runs_Out)
    EnableTrigger(gg_trg_FOL_Rservoir_Charge_Cast)
    EnableTrigger(gg_trg_FOL_Rservoir_Cure_Stone_Acquired)
    EnableTrigger(gg_trg_FOL_Rservoir_Cure_Stone_Timer_Runs_Out)
end

--Maggot Paw
function mapFallOfLordaeronMaggotPawEncounterStart()
    TimerStart(udg_FOL_MaggotPaw_Shockwave_Timer, 10, false, mapFallOfLordaeronMaggotPawShockwaveTimerRunsOut)
    TimerStart(udg_FOL_MaggotPaw_Tornado_Timer, 19, false, mapFallOfLordaeronMaggotPawTornadoTimerRunsOut)
end


function mapFallOfLordaeronMaggotPawEncounterEnd()
    PauseTimer(udg_FOL_MaggotPaw_Shockwave_Timer)
    PauseTimer(udg_FOL_MaggotPaw_Tornado_Timer)

    ForGroup(udg_FOL_MaggotPaw_TornadoG, groupKillEveryEnumUnit)
end


function mapFallOfLordaeronMaggotPawShockwaveCast()
    local unit = GetTriggerUnit()
    local loc = GetSpellTargetLoc()
    
    GroupClear(udg_FOL_MaggotPaw_DamageG)
    missileToDirectionEveryEnemy(unit, loc, 900, 125, "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl", 1, 10, 30, nil, gg_trg_FOL_Maggot_Paw_Shockwave_For)

    RemoveLocation(loc)
    unit = nil
    loc = nil
end


function mapFallOfLordaeronMaggotPawShockwaveDamage()
    ForGroup(udg_Missile_System_Dummy_Group, mapFallOfLordaeronMaggotPawShockwaveDamageFor)
end

function mapFallOfLordaeronMaggotPawShockwaveDamageFor()
    if IsUnitInGroup(GetEnumUnit(), udg_FOL_MaggotPaw_DamageG) then
        return
    end

    UnitDamageTargetBJ(udg_FOL_MaggotPaw, GetEnumUnit(), 200 * udg_AdjustmentCombat_Ratio, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    GroupAddUnit(udg_FOL_MaggotPaw_DamageG, GetEnumUnit())
end

function mapFallOfLordaeronMaggotPawTornadoCastStart()
    PlaySoundBJ(gg_snd_MaggotPawTornado)
    SetUnitAnimationByIndex(udg_FOL_MaggotPaw, 6)
    udg_FOL_MaggotPaw_Tornado_Int = 0
    SetUnitAnimationByIndex(udg_FOL_MaggotPaw, 6)
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Tornado_Cast_Spin)
    local loc = GetUnitLoc(udg_FOL_MaggotPaw)
    createSpecialEffectOnLocWithDurationAndSize(loc, "Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl", 3, 3)
    RemoveLocation(loc)
    loc = nil
end

function mapFallOfLordaeronMaggotPawTornadoSpin()
    udg_FOL_MaggotPaw_Tornado_Int = udg_FOL_MaggotPaw_Tornado_Int + 1
    local angle = GetUnitFacing(udg_FOL_MaggotPaw)
    angle = angle + 20
    SetUnitFacing(udg_FOL_MaggotPaw, angle)

    if ModuloInteger(udg_FOL_MaggotPaw_Tornado_Int, 8) == 0 then
        SetUnitAnimationByIndex(udg_FOL_MaggotPaw, 6)
    end
end

function mapFallOfLordaeronMaggotPawTornadoCastFinishes()
    DisableTrigger(gg_trg_FOL_Maggot_Paw_Tornado_Cast_Spin)

    local loc = GetUnitLoc(udg_FOL_MaggotPaw)
    CreateNUnitsAtLoc(1, FourCC('h01C'), GetOwningPlayer(udg_FOL_MaggotPaw), loc, 0)
    UnitApplyTimedLife(GetLastCreatedUnit(), FourCC('BTLF'), 40)
    GroupAddUnit(udg_FOL_MaggotPaw_TornadoG, GetLastCreatedUnit())
    EnableTrigger(gg_trg_FOL_Maggot_Paw_Tornado_Damage)

    RemoveLocation(loc)
    loc = nil
end

function mapFallOfLordaeronMaggotPawTornadoDamage()
    ForGroup(udg_FOL_MaggotPaw_TornadoG, mapFallOfLordaeronMaggotPawTornadoDamageFor)
end

function mapFallOfLordaeronMaggotPawTornadoDamageFor()
    local unit = GetEnumUnit()

    if IsUnitAliveBJ(unit) == false then
        GroupRemoveUnit(udg_FOL_MaggotPaw_TornadoG, unit)

        if CountUnitsInGroup(udg_FOL_MaggotPaw_TornadoG) == 0 then
            DisableTrigger(gg_trg_FOL_Maggot_Paw_Tornado_Damage)
        end
    else
        local loc = GetUnitLoc(unit)
        local group = GetUnitsInRangeOfLocMatching(190, loc, Condition(mapFallOfLordaeronMaggotPawTornadoDamageForFilter))
        ForGroup(group, mapFallOfLordaeronMaggotPawTornadoDamageForDamage)
        RemoveLocation(loc)
        DestroyGroup(group)
        loc = nil
        group = nil
    end

    unit = nil
end

function mapFallOfLordaeronMaggotPawTornadoDamageForFilter()
    if IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), udg_Player_PlayerGroup) then
        return true
    else
        return false
    end
end

function mapFallOfLordaeronMaggotPawTornadoDamageForDamage()
    UnitDamageTargetBJ(udg_FOL_MaggotPaw, GetEnumUnit(), 25 * udg_AdjustmentCombat_Ratio, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
end


function mapFallOfLordaeronMaggotPawShockwaveTimerRunsOut()
    local currentTimerTime = TimerGetTimeout(udg_FOL_MaggotPaw_Shockwave_Timer)

    if currentTimerTime == 10 then
        StartTimerBJ(udg_FOL_MaggotPaw_Shockwave_Timer, true, 16)
    end

    if udg_Boss_Encounter_IsBoss_Busy == true then
        return
    end

    udg_Boss_Encounter_IsBoss_Busy = true
    for i=1,3 do
        local group = GetUnitsInRectMatching(udg_Boss_Encounter_Current_Region, Condition(BossEncounterTargetAPlayerUnitFilter))
        if CountUnitsInGroup(group) == 0 then
            DestroyGroup(group)
            group = nil
            udg_Boss_Encounter_IsBoss_Busy = false
            return
        end
    
        local target = GroupPickRandomUnit(group)
        local targetLoc = GetUnitLoc(target)
    
        if i == 1 then
            IssuePointOrderLoc(udg_FOL_MaggotPaw, "shockwave", targetLoc)
        else
            IssuePointOrderLoc(udg_FOL_MaggotPaw, "carrionswarm", targetLoc)
        end
        target = nil
        RemoveLocation(targetLoc)
        targetLoc = nil
        DestroyGroup(group)
        group = nil
        if i == 1 then
            TriggerSleepAction(3.3)
        else
            TriggerSleepAction(1.8)
        end

    end
    udg_Boss_Encounter_IsBoss_Busy = false

end

function mapFallOfLordaeronMaggotPawTornadoTimerRunsOut()
    local currentTimerTime = TimerGetTimeout(udg_FOL_MaggotPaw_Tornado_Timer)

    if currentTimerTime == 19 then
        TimerStart(udg_FOL_MaggotPaw_Tornado_Timer, 21, true, mapFallOfLordaeronMaggotPawTornadoTimerRunsOut)
    end

    if udg_Boss_Encounter_IsBoss_Busy == true then
        return
    end

    udg_Boss_Encounter_IsBoss_Busy = true

    IssueImmediateOrder(udg_FOL_MaggotPaw, "thunderclap")

    TriggerSleepAction(3.1)

    udg_Boss_Encounter_IsBoss_Busy = false
end


--Skelemancer


function mapFallOfLordaeronSkelemancerEncounterStart()
    udg_Stat_Mana[GetUnitUserData(udg_FOL_Skelemancer)] = 100
    BlzSetUnitMaxMana(udg_FOL_Skelemancer, 100)
    SetUnitManaPercentBJ(udg_FOL_Skelemancer, 0)

    udg_FOL_Skelemancer_DS_Count = 0
    CreateLeaderboardBJ(bj_FORCE_ALL_PLAYERS, 'Death Sentence')
    udg_FOL_Skelemancer_DS_Leaderboard = GetLastCreatedLeaderboard()
    LeaderboardAddItemBJ(Player(0), udg_FOL_Skelemancer_DS_Leaderboard, "Cast Count", udg_FOL_Skelemancer_DS_Count)

    StartTimerBJ(udg_FOL_Skelemancer_Blast_Timer, true, 9)
end

function mapFallOfLordaeronSkelemancerEncounterEnd()
    DestroyLeaderboard(udg_FOL_Skelemancer_DS_Leaderboard)
    udg_FOL_Skelemancer_DS_Leaderboard = nil
end

function mapFallOfLordaeronSkelemancerScorchCast()
    local damage = 55 * udg_AdjustmentCombat_Ratio

    UnitDamageTargetBJ(GetTriggerUnit(), GetSpellTargetUnit(), damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

    createSpecialEffectOnUnit(GetSpellTargetUnit(), 'Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl')
end

function mapFallOfLordaeronSkelemancerDeathBlastTimerRunsOut()
    
    stopUnitCasting(udg_FOL_Skelemancer)

    local group = GetUnitsInRectMatching(udg_Boss_Encounter_Current_Region, Condition(BossEncounterTargetAPlayerUnitFilter))
    if CountUnitsInGroup(group) == 0 then
        DestroyGroup(group)
        group = nil
        return
    end

    ForForce(udg_Player_PlayerGroup, function ()
        ForceAddPlayer(udg_FloatingText_PlayerGroup, GetEnumPlayer())
    end)
    creatingFloatingTextTimed('Be careful!',udg_FOL_Skelemancer, 10, 100, 0, 0 )

    local unit = GroupPickRandomUnit(group)
    udg_FOL_Skelemancer_Point = GetUnitLoc(unit)
    IssueTargetOrderBJ(udg_FOL_Skelemancer, "thunderbolt", unit)

    unit = nil
    DestroyGroup(group)
    group = nil
end

function mapFallOfLordaeronSkelemancerDeathBlastCast()
    missileToPoint(udg_FOL_Skelemancer, udg_FOL_Skelemancer_Point, 'Abilities\\Weapons\\GreenDragonMissile\\GreenDragonMissile.mdl', 1, 100, 25, gg_trg_FOL_Skelemancer_Death_Blast_Damage)

    RemoveLocation(udg_FOL_Skelemancer_Point)
    udg_FOL_Skelemancer_Point = nil
end

function mapFallOfLordaeronSkelemancerDeathBlastCastDamage()

    createSpecialEffectOnLocWithSize(udg_Missile_System_Dummy_Point, 'Objects\\Spawnmodels\\NightElf\\EntBirthTarget\\EntBirthTarget.mdl', 1.5)

    local group = GetUnitsInRangeOfLocMatching(200, udg_Missile_System_Dummy_Point, Condition(BossEncounterTargetAPlayerUnitFilter))
    if CountUnitsInGroup(group) > 0 then
        gainManaToUnit(udg_FOL_Skelemancer, 25)
        ForGroup(group, mapFallOfLordaeronSkelemancerDeathBlastCastDamageFor)
    end
    DestroyGroup(group)
    group = nil

    RemoveLocation(udg_Missile_System_Dummy_Point)
    udg_Missile_System_Dummy_Point = nil
end

function mapFallOfLordaeronSkelemancerDeathBlastCastDamageFor()
    UnitDamageTargetBJ(udg_FOL_Skelemancer, GetEnumUnit(), 100 * udg_AdjustmentCombat_Ratio, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
end


function mapFallOfLordaeronSkelemancerDeathSentenceManaFull()
    stopUnitCasting(udg_FOL_Skelemancer)

    PauseTimer(udg_FOL_Skelemancer_Blast_Timer)
    IssueImmediateOrder(udg_FOL_Skelemancer, "thunderclap")
end

function mapFallOfLordaeronSkelemancerDeathSentenceCast()
    udg_FOL_Skelemancer_DS_Count = udg_FOL_Skelemancer_DS_Count + 1
    LeaderboardSetPlayerItemValueBJ(Player(0), udg_FOL_Skelemancer_DS_Leaderboard, udg_FOL_Skelemancer_DS_Count)
    ResumeTimer(udg_FOL_Skelemancer_Blast_Timer)

    SetUnitManaPercentBJ(udg_FOL_Skelemancer, 0)

    local group = GetUnitsInRectMatching(udg_Boss_Encounter_Current_Region, Condition(BossEncounterTargetAPlayerUnitFilter))
    ForGroup(group, mapFallOfLordaeronSkelemancerDeathSentenceCastFor)
    if udg_FOL_Skelemancer_DS_Count == 3 then
        ForGroup(group, groupKillEveryEnumUnit)
    end

    DestroyGroup(group)
    group = nil
end

function mapFallOfLordaeronSkelemancerDeathSentenceCastFor()
    UnitDamageTargetBJ(udg_FOL_Skelemancer, GetEnumUnit(), 150 * udg_AdjustmentCombat_Ratio, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

    createSpecialEffectOnUnit(GetEnumUnit(), "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl")
end

--R'servoir

function mapFallOfLordaeronRservoirEncounterStart()
    EnableTrigger(gg_trg_FOL_Rservoir_Gas_Loop)

    CreateLeaderboardBJ(bj_FORCE_ALL_PLAYERS, 'Toxic Buildup')
    udg_FOL_Rservoir_Gas_Leaderbord = GetLastCreatedLeaderboard()
    ForForce(udg_Player_PlayerGroup, function ()
        LeaderboardAddItemBJ(GetEnumPlayer(), udg_FOL_Rservoir_Gas_Leaderbord, getPlayerNameWithoutSharp(GetEnumPlayer()), 0)
    end)

    StartTimerBJ(udg_FOL_Rservoir_Charge_Timer, true, 8)
    StartTimerBJ(udg_FOL_Rservoir_Cure_Timer, true, 30)
end

function mapFallOfLordaeronRservoirEncounterEnd()
    DestroyLeaderboard(udg_FOL_Rservoir_Gas_Leaderbord)
    DisableTrigger(gg_trg_FOL_Rservoir_Gas_Loop)
end

function mapFallOfLordaeronRservoirGasCreate(unit)
    local loc = GetUnitLoc(unit)
    CreateNUnitsAtLoc(1, FourCC('h01D'), GetOwningPlayer(udg_FOL_Rservoir), loc, 0)
    local unit = GetLastCreatedUnit()

    GroupAddUnit(udg_FOL_Rservoir_GasG, unit)
    UnitApplyTimedLife(unit, FourCC('BTLF'), 15)

    RemoveLocation(loc)
    loc = nil
    unit = nil

end

function mapFallOfLordaeronRservoirGasLoop()
    local group = GetUnitsInRectAll(udg_Boss_Encounter_Current_Region)
    ForGroup(group, function ()
        udg_FOL_Rservoir_Gas_Control[GetUnitUserData(GetEnumUnit())] = false
    end)
    DestroyGroup(group)
    group = nil

    ForGroup(udg_FOL_Rservoir_GasG, mapFallOfLordaeronRservoirGasLoopGasFor)

    local group = GetUnitsInRectMatching(udg_Boss_Encounter_Current_Region, Condition(BossEncounterTargetAPlayerUnitFilter))
    ForGroup(group, mapFallOfLordaeronRservoirGasLoopUnitFor)
    DestroyGroup(group)
    group = nil


    ForForce(udg_Player_PlayerGroup, function ()
        local id = GetUnitUserData(udg_INV_Player_Hero[GetPlayerId(GetEnumPlayer()) + 1])
        LeaderboardSetPlayerItemValueBJ(GetEnumPlayer(), udg_FOL_Rservoir_Gas_Leaderbord, udg_FOL_Rservoir_Gas_Count[id])
    end)
end

function mapFallOfLordaeronRservoirGasLoopGasFor()
    local unit = GetEnumUnit()

    if IsUnitAliveBJ(unit) == false then
        RemoveUnit(unit)
        GroupRemoveUnit(udg_FOL_Rservoir_GasG, unit)
        unit = nil
        return
    end

    local loc = GetUnitLoc(unit)
    local group = GetUnitsInRangeOfLocMatching(100, loc, Condition(BossEncounterTargetAPlayerUnitFilter))
    ForGroup(group, function ()
        udg_FOL_Rservoir_Gas_Control[GetUnitUserData(GetEnumUnit())] = true
    end)

    DestroyGroup(group)
    RemoveLocation(loc)
    loc = nil
    group = nil
    
    unit = nil
end

function mapFallOfLordaeronRservoirGasLoopUnitFor()
    local unit = GetEnumUnit()
    local loc = GetUnitLoc(unit)
    local id = GetUnitUserData(unit)

    if udg_FOL_Rservoir_Gas_Control[id] == true then
        udg_FOL_Rservoir_Gas_Count[id] = udg_FOL_Rservoir_Gas_Count[id] + 1
    end

    local damage = 18 * udg_FOL_Rservoir_Gas_Count[id] * udg_AdjustmentCombat_Ratio
    if damage > 0 then
        UnitDamageTargetBJ(udg_FOL_Rservoir, unit, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    end

    RemoveLocation(loc)
    unit = nil
    loc = nil
    gasGroup = nil
end

function mapFallOfLordaeronRservoirGasCleave()
    if GetRandomReal(0, 100) <= 5 then
        mapFallOfLordaeronRservoirGasCreate(GetTriggerUnit())
        PlaySound(gg_snd_AbominationAlternateDeath1)
    end
end

function mapFallOfLordaeronRservoirChargeTimesRunsOut()
    local currentTimerTime = TimerGetTimeout(udg_FOL_Rservoir_Charge_Timer)

    if currentTimerTime == 8 then
        StartTimerBJ(udg_FOL_Rservoir_Charge_Timer, true, 18)
    end

    local group = GetUnitsInRectMatching(udg_Boss_Encounter_Current_Region, Condition(BossEncounterTargetAPlayerUnitFilter))
    if CountUnitsInGroup(group) == 0 then
        DestroyGroup(group)
        group = nil
        return
    end

    local unit = GroupPickRandomUnit(group)
    IssueTargetOrderBJ(udg_FOL_Rservoir, "thunderbolt", unit)

    unit = nil
    DestroyGroup(group)
    group = nil
end

function mapFallOfLordaeronRservoirChargeCast()
    udg_Boss_Encounter_IsBoss_Busy = true
    PauseUnitBJ(true, udg_FOL_Rservoir)
    EnableTrigger(gg_trg_FOL_Rservoir_Charge_Cast_Loop)
    SetUnitPathing(udg_FOL_Rservoir, false)
end

function mapFallOfLordaeronRservoirChargeCastLoop()
    local id = GetUnitUserData(udg_FOL_Rservoir)
    udg_IsUnitCasting[id] = true
    local loc = GetUnitLoc(udg_FOL_Rservoir)
    local nextLoc = PolarProjectionBJ(loc, 40, GetUnitFacing(udg_FOL_Rservoir))
    local controlLoc = PolarProjectionBJ(loc, 150, GetUnitFacing(udg_FOL_Rservoir))
    if RectContainsLoc(udg_Boss_Encounter_Current_Region, controlLoc) then
        SetUnitPositionLoc(udg_FOL_Rservoir, nextLoc)
        SetUnitAnimationByIndex(udg_FOL_Rservoir, 1)
        if 90 > GetRandomReal(0, 100) then
            mapFallOfLordaeronRservoirGasCreate(udg_FOL_Rservoir)
        end
    else
        udg_Boss_Encounter_IsBoss_Busy = false
        udg_IsUnitCasting[id] = false
        PauseUnitBJ(false, udg_FOL_Rservoir)
        DisableTrigger(gg_trg_FOL_Rservoir_Charge_Cast_Loop)
        SetUnitPathing(udg_FOL_Rservoir, true)
    end

    RemoveLocation(loc)
    RemoveLocation(nextLoc)
    RemoveLocation(controlLoc)
    loc = nil
    nextLoc = nil
    controlLoc = nil
end

function mapFallOfLordaeronRservoirCureStoneCreate()
    local bossLoc = GetUnitLoc(udg_FOL_Rservoir)
    local createBool = true
    while createBool do
        local createLoc = PolarProjectionBJ(bossLoc, GetRandomReal(200, 600), GetRandomReal(0, 360))
        if RectContainsLoc(udg_Boss_Encounter_Current_Region, createLoc) then
            createBool = false
            CreateItemLoc(FourCC('I00S'), createLoc)
        end
        RemoveLocation(createLoc)
        createLoc = nil
    end
    RemoveLocation(bossLoc)
    bossLoc = nil
end

function mapFallOfLordaeronRservoirCureStoneAcquire()
    local group = GetUnitsInRectMatching(udg_Boss_Encounter_Current_Region, Condition(BossEncounterTargetAPlayerUnitFilter))
    ForGroup(group, mapFallOfLordaeronRservoirCureStoneFor)

    DestroyGroup(group)
    group = nil
end

function mapFallOfLordaeronRservoirCureStoneFor()
    local unit = GetEnumUnit()
    healUnit(unit, unit, 100 * udg_AdjustmentCombat_Ratio, false)

    local id = GetUnitUserData(unit)
    udg_FOL_Rservoir_Gas_Count[id] = udg_FOL_Rservoir_Gas_Count[id] - 3
    if udg_FOL_Rservoir_Gas_Count[id] < 0 then
        udg_FOL_Rservoir_Gas_Count[id] = 0
    end

    createSpecialEffectOnUnit(unit, 'Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl')

    unit = nil
end