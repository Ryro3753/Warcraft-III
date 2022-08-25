function fillPlayerGroup()
    for i=1,5 do
        if GetPlayerController(ConvertedPlayer(i)) == MAP_CONTROL_USER and GetPlayerSlotState(ConvertedPlayer(i)) == PLAYER_SLOT_STATE_PLAYING then
            ForceAddPlayer(udg_Player_PlayerGroup, Player(i-1))
        end
    end
end

function creatingFloatingTextTimed(text, unit, size, red, green, blue)
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
    local ratio = 1.0 + udg_Stat_Healing_Taken_AC[healedId] - udg_Stat_Healing_Reduce_AC[healerId]
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
    
    local healText = "+" .. calculatedHeal
    if criticalHappend then
        healText = healText .. "! Crit"
    end
    creatingFloatingTextTimed(healText, healed, 10, 20, 90, 20)

    --HPS
    HPSMeter_Heal_PlayerBased[causerPlayerId] = HPSMeter_Heal_PlayerBased[causerPlayerId] + calculatedHeal

    --Threat
    local threat = calculateThreat(calculatedHeal, false, true, 0)
    addThreatToThreatMeter(healer, threat)

end


function soulDamage(causer, receiver, damage, isDodgeActive, isMissActive, isBlockActive, isParryActive, isCriticalActive)

    local causerId = GetUnitUserData(causer)
    local receiverId = GetUnitUserData(receiver)

    local dodge = udg_Stat_Dodge_AC[receiverId]
    if dodge > GetRandomReal(0, 100.00) and isDodgeActive == true then
        creatingFloatingTextTimed("Dodge!",damageReceiver,10,90,20,20)
        damage = 0
    end

    --check about Miss
    local miss = udg_Stat_Miss_AC[causerId]
    if miss > GetRandomReal(0, 100.00) and isMissActive == true then
        creatingFloatingTextTimed("Miss!",damageCauser,10,90,20,20)
        damage = 0
    end

    --check about Parry
    local parry = udg_Stat_Parry_AC[receiverId]
    if parry > GetRandomReal(0, 100.00) and isParryActive == true then
        creatingFloatingTextTimed("Parry!",damageReceiver,10,90,20,20)
        damage = 0
    end

    --check about Block
    if udg_Stat_Block_Enabled[receiverId] > 0 and isBlockActive == true then
        local block = udg_Stat_Block_AC[receiverId]
        if block > GetRandomReal(0, 100.00)  then
            creatingFloatingTextTimed("Block!",damageReceiver,10,90,20,20)
            damage = 0
        end
    end

    --check about Critical Chance
    local criticalChance = udg_Stat_Critical_Chance_AC[causerId]
    local critHappend = false
    if criticalChance > GetRandomReal(0, 100.00) and isCriticalActive == true and damage ~= 0 then
        critHappend = true
        local ciriticalDamageRate = udg_Stat_Critical_Damage_Rate_AC[causerId]
        damage = damage * (ciriticalDamageRate / 100)
    end
    if damage ~= 0 then
        local receiverHealth = GetUnitState(receiver, UNIT_STATE_LIFE)
        local remainingHealth = receiverHealth - damage
        if remainingHealth < 0 then
            damage = receiverHealth
            remainingHealth = 0
        end
        SetUnitState(receiver, UNIT_STATE_LIFE, remainingHealth)

        local damageText = damage
        if criticalHappend then
            healText = healText .. "! Crit Soul Damage"
        else
            damageText = damageText .. " Soul Damage"
        end
        creatingFloatingTextTimed(damageText, receiverId, 10, 0, 0, 0)

        addDPStoDPSMeterFromUnit(damageCauser, damage)

        --Threat
        local threat = calculateThreat(damage, true, false, 0)
        addThreatToThreatMeter(causer, threat)
    end

end

