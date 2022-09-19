function addHPStoHPSMeter(player, heal)
    local playerId = GetPlayerId(player) + 1
    udg_HPSMeter_Heal_PlayerBased[playerId] = udg_DPSMeter_Heal_PlayerBased[playerId] + heal
end
