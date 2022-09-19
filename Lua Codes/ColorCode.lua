function getPlayerNameWithColor(player)
    local playerId = GetPlayerId(player) + 1
    return udg_Color_Code_Player[playerId] .. getPlayerNameWithoutSharp(player) .. "|r"
end

function getPlayerNameWithColorId(playerId)
    local player = Player(playerId - 1)
    return udg_Color_Code_Player[playerId] .. getPlayerNameWithoutSharp(player) .. "|r"
end
