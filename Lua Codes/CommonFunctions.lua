function fillPlayerGroup()
    for i=1,5 do
        if GetPlayerController(ConvertedPlayer(i)) == MAP_CONTROL_USER and GetPlayerSlotState(ConvertedPlayer(i)) == PLAYER_SLOT_STATE_PLAYING then
            ForceAddPlayer(udg_Player_PlayerGroup, Player(i-1))
        end
    end

    ForceAddPlayer(udg_Enemy_PlayerGroup, Player(8))

    adjustmentCalculation()
    enemyGroupHoldPosition()
    healOrbEnable()
end

function adjustmentCalculation()
    local playerCount = CountPlayersInForceBJ(udg_Player_PlayerGroup)
    if playerCount == 1 then
        udg_AdjustmentGeneral_Ratio = 0.4
        udg_AdjustmentCombat_Ratio = 0.5
    elseif playerCount == 2  then
        udg_AdjustmentGeneral_Ratio = 0.75
        udg_AdjustmentCombat_Ratio = 0.8
    elseif playerCount == 3 then
        udg_AdjustmentGeneral_Ratio = 1
        udg_AdjustmentCombat_Ratio = 1
    elseif playerCount == 4 then
        udg_AdjustmentGeneral_Ratio = 1.4
        udg_AdjustmentCombat_Ratio = 1.3
    elseif playerCount == 5 then
        udg_AdjustmentGeneral_Ratio = 1.9
        udg_AdjustmentCombat_Ratio = 1.6
    end
end

function adjustmentRatioGet(unit)
    local player = GetOwningPlayer(unit)
    local adjustmentGeneralRatio = 0.0
    local adjustmentCombatRatio = 0.0
    if IsPlayerInForce(player, udg_Enemy_PlayerGroup) then
        adjustmentGeneralRatio = udg_AdjustmentGeneral_Ratio
        adjustmentCombatRatio = udg_AdjustmentCombat_Ratio
    else
        adjustmentGeneralRatio = 1
        adjustmentCombatRatio = 1
    end
    player = nil

    return adjustmentGeneralRatio, adjustmentCombatRatio
end

function enemyGroupHoldPosition()
    local group = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(enemyGroupHoldPositionFilter))
    ForGroup(group, enemyGroupHoldPositionFor)
    DestroyGroup(group)
    group = nil
end

function enemyGroupHoldPositionFilter()
    if IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), udg_Enemy_PlayerGroup)  then
       return true
    else
        return false
    end
end

function enemyGroupHoldPositionFor()
    IssueImmediateOrder(GetEnumUnit(), "holdposition")
end

function creatingFloatingTextTimed(text, unit, size, red, green, blue)
    if CountPlayersInForceBJ(udg_FloatingText_PlayerGroup) == 0 then
        return
    end

    local unitLoc = GetUnitLoc(unit)
    local textLoc = PolarProjectionBJ(unitLoc, GetRandomReal(-100, 100), GetRandomDirectionDeg())
    CreateTextTagLocBJ(text, textLoc, 0, size, red, green, blue, 0)
    ShowTextTagForceBJ( false, GetLastCreatedTextTag(), GetPlayersAll() )
    ShowTextTagForceBJ( true, GetLastCreatedTextTag(), udg_FloatingText_PlayerGroup )
    SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
    SetTextTagVelocityBJ( GetLastCreatedTextTag(), 80.00, 90 )
    SetTextTagLifespanBJ( GetLastCreatedTextTag(), 2.00 )
    SetTextTagFadepointBJ( GetLastCreatedTextTag(), 2.00 )
    ForceClear( udg_FloatingText_PlayerGroup )
    RemoveLocation(unitLoc)
    RemoveLocation(textLoc)
end


function registerUnit(unit)
    udg_Register_ID = udg_Register_ID + 1
    SetUnitUserData(unit, udg_Register_ID)
    GroupAddUnit(udg_Registered_Units, unit)
    udg_Registered_Unit = unit
    TriggerExecute(gg_trg_RegisterSystem_Other_Systems)
end

function healUnit(healer, healed, heal, critical)
    local healerId = GetUnitUserData(healer)
    local healedId = GetUnitUserData(healed)

    --Calculate Heal
    local ratio = 1.0 + (udg_Stat_Healing_Taken_AC[healedId] / 100) - (udg_Stat_Healing_Reduce_AC[healerId] / 100)
    local calculatedHeal = heal * ratio

    local criticalHappend = false
    if critical == true and udg_Stat_Critical_Chance_AC[healerId] >= GetRandomReal(0, 100) then
        criticalHappend = true
        calculatedHeal = calculatedHeal * 2
    end

    local healedHealth = GetUnitState(healed, UNIT_STATE_LIFE)
    local newHealth = healedHealth + calculatedHeal
    local maxHealth = GetUnitState(healed, UNIT_STATE_MAX_LIFE)
    if newHealth > maxHealth then
        newHealth = maxHealth
        calculatedHeal = maxHealth - healedHealth
    end

    SetUnitState(healed, UNIT_STATE_LIFE, newHealth)
    
    local healText = "+" .. R2I(calculatedHeal)
    if criticalHappend then
        healText = healText .. "! Crit"
    end

    if calculatedHeal ~= 0 then
        local healedPlayer = GetOwningPlayer(healed)
        local healedPlayerId = GetPlayerId(healedPlayer) + 1
        if udg_Settings_ShowHealTaken[healedPlayerId] == 1 then
            ForceAddPlayer(udg_FloatingText_PlayerGroup, healedPlayer)
        end

        local healerPlayer = GetOwningPlayer(healer)
        local healerPlayerId = GetPlayerId(healerPlayer) + 1
        if udg_Settings_ShowHealGive[healerPlayerId] == 1 then
            ForceAddPlayer(udg_FloatingText_PlayerGroup, healerPlayer)
        end

        creatingFloatingTextTimed(healText, healed, 10, 20, 90, 20)

        healedPlayer = nil
        healerPlayer = nil
    end

    --HPS
    local healerPlayer = GetOwningPlayer(healer)
    local healerPlayerId = GetPlayerId(healerPlayer) + 1
    udg_HPSMeter_Heal_PlayerBased[healerPlayerId] = udg_HPSMeter_Heal_PlayerBased[healerPlayerId] + calculatedHeal
    healerPlayer = nil

    --Threat
    local threat = calculateThreat(calculatedHeal, false, true, 0, udg_ThreatMeter_UnitThreatModifier[healerId])
    addThreatToThreatMeter(healer, threat)
end


function getUnitIsMeleeOrRange(unit)
    local attackRange = BlzGetUnitWeaponRealField(unit, UNIT_WEAPON_RF_ATTACK_RANGE, 0)
    if attackRange > 300 then
        return "Range"
    else
        return "Melee"
    end
end

--Special Effects

function createSpecialEffectOnUnit(unit, specialEffect)
    local loc = GetUnitLoc(unit)
    AddSpecialEffectLocBJ(loc, specialEffect)
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    RemoveLocation(loc)
end

function createSpecialEffectOnLoc(loc, specialEffect)
    AddSpecialEffectLocBJ(loc, specialEffect)
    DestroyEffectBJ(GetLastCreatedEffectBJ())
end

function createSpecialEffectOnUnitWithDuration(unit, specialEffect, duration)
    local loc = GetUnitLoc(unit)
    AddSpecialEffectLocBJ(loc, specialEffect)
    local specialEffect = GetLastCreatedEffectBJ()
    TriggerSleepAction(duration)
    DestroyEffectBJ(specialEffect)
    RemoveLocation(loc)
    specialEffect = nil
end

function createSpecialEffectOnUnitWithDurationAndSize(unit, specialEffect, duration, size)
    local loc = GetUnitLoc(unit)
    AddSpecialEffectLocBJ(loc, specialEffect)
    local specialEffect = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(specialEffect, size)
    TriggerSleepAction(duration)
    DestroyEffectBJ(specialEffect)
    RemoveLocation(loc)
    specialEffect = nil
end

function createSpecialEffectOnLocWithDurationAndSize(loc, specialEffect, duration, size)
    AddSpecialEffectLocBJ(loc, specialEffect)
    local specialEffect = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(specialEffect, size)
    TriggerSleepAction(duration)
    DestroyEffectBJ(specialEffect)
    specialEffect = nil
end

function createSpecialEffectOnLocWithSize(loc, specialEffect, size)
    AddSpecialEffectLocBJ(loc, specialEffect)
    local specialEffect = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(specialEffect, size)
    DestroyEffectBJ(specialEffect)
    specialEffect = nil
end

function createSpecialEffectOnUnitWithSize(unit, specialEffect, size)
    local loc = GetUnitLoc(unit)
    AddSpecialEffectLocBJ(loc, specialEffect)
    BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), size)
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    RemoveLocation(loc)
end

--Special Effects

function refreshCastingTimeOfAbility(unit, id, spell, level)
    local baseCastingSpeed = getAbilityBaseCastingTime(spell, level)
    local castingSpeed = calculateCastingSpeedToAbility(baseCastingSpeed, id)
    local unitSpell = BlzGetUnitAbility(unit, spell)
    print(BlzGetAbilityRealLevelField(unitSpell, ABILITY_RLF_CASTING_TIME, level - 1))
    BlzSetAbilityRealLevelFieldBJ( BlzGetUnitAbility(unit, spell), ABILITY_RLF_CASTING_TIME, level - 1, castingSpeed)
    unitSpell = nil
end

function getAbilityBaseCastingTime(spell, level)
    UnitAddAbilityBJ(spell, udg_Dummy_Unit)
    SetUnitAbilityLevel(unit, spell, level)
    local addedSpell = BlzGetUnitAbility(udg_Dummy_Unit, spell)
    local value = BlzGetAbilityRealLevelField(addedSpell, ABILITY_RLF_CASTING_TIME, level -1)
    UnitRemoveAbilityBJ(spell, udg_Dummy_Unit)

    addedSpell = nil
    return value
end

function calculateCastingSpeedToAbility(castingSpeed, id)
    udg_Stat_Casting_Speed_AC[id] = 50
    return castingSpeed - (castingSpeed * (udg_Stat_Casting_Speed_AC[id] / 100))
end


function gainManaToUnit(unit, mana)
    local unitCurrentMana = GetUnitState(unit, UNIT_STATE_MANA)
    local unitMaxMana = GetUnitState(unit, UNIT_STATE_MAX_MANA)

    if unitCurrentMana + mana > unitMaxMana then
        SetUnitState(unit, UNIT_STATE_MANA, unitMaxMana)
        return unitMaxMana - unitCurrentMana
    else
        SetUnitState(unit, UNIT_STATE_MANA, unitCurrentMana + mana)
        return mana
    end
end

function manaFloatingText(mana, player, unit)
    if mana < 1 then
        return
    end
    ForceAddPlayer(udg_FloatingText_PlayerGroup, player)
    local str = "+" .. tostring(R2I(mana))
    creatingFloatingTextTimed(str, unit, 10, 20, 20, 70)
    str = nil
end

function getAbilityMana(unit, spell, level)
    local unitSpell = BlzGetUnitAbility(unit, spell)
    local value = BlzGetAbilityIntegerLevelField(unitSpell, ABILITY_ILF_MANA_COST, level - 1)
    unitSpell = nil
    return value
end

function getCurrentTime()
    return udg_Elapsed_Second
end


function lifestealCalculate(unit, damage)
    local id = GetUnitUserData(unit)
    local heal = damage * udg_Stat_Life_Steal_AC[id] / 100
    healUnit(unit, unit, heal, false)
end

function unitLevelsUp(unit)
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player) + 1
    local id = GetUnitUserData(unit)

    udg_Stat_Strength[id] = udg_Stat_Strength[id] + 1
    udg_Stat_Agility[id] = udg_Stat_Agility[id] + 1
    udg_Stat_Intelligence[id] = udg_Stat_Intelligence[id] + 1
    
    udg_Level_Stat_CurrentPoint[playerId] = udg_Level_Stat_CurrentPoint[playerId] + 3
    udg_BeliefOrder_CurrentPoint[playerId] = udg_BeliefOrder_CurrentPoint[playerId] + 1
    AdjustPlayerStateBJ(1, player, PLAYER_STATE_RESOURCE_LUMBER)

    calculateUnitStats(unit)

    player = nil
    playerId = nil
    id = nil
end

function getPlayerNameWithoutSharp(player)
    return split(GetPlayerName(player), "#")[1]
end

function arrayHasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function playSoundAtUnit(unit, sound)
    local loc = GetUnitLoc(unit)
    PlaySoundAtPointBJ(sound, 100, loc, 0)
    RemoveLocation(loc)
    loc = nil
end

function groupKillEveryEnumUnit()
    KillUnit(GetEnumUnit())
end

function groupRemoveEveryEnumUnit()
    RemoveUnit(GetEnumUnit())
end

function stopUnitCasting(unit)
    PauseUnit(unit, true)
    IssueImmediateOrder(unit, "stop")
    PauseUnit(unit, false)
end