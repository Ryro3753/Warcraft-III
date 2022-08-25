function addDPStoDPSMeter(player, damage)
    local playerId = GetPlayerId(player) + 1
    udg_DPSMeter_Damage_PlayerBased[playerId] = udg_DPSMeter_Damage_PlayerBased[playerId] + damage
end


function addDPStoDPSMeterFromUnit(unit, damage)
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player) + 1
    udg_DPSMeter_Damage_PlayerBased[playerId] = udg_DPSMeter_Damage_PlayerBased[playerId] + damage
end
