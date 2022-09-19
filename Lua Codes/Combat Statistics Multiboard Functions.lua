function combatStatisticsMultiboardCreate()
    local playerCount = 1
    for i=1,5 do
        local player = ConvertedPlayer(i)
        if GetPlayerController(player) == MAP_CONTROL_USER and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            playerCount = playerCount + 1
        end
    end


    CreateMultiboardBJ(4, playerCount, "Combat Statistics")
    udg_CombatStatistics_Multiboard = GetLastCreatedMultiboard()

    for i=1,playerCount do
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 1, i, true, true)
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 2, i, true, false)
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 3, i, true, false)
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 4, i, true, false)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 1, i, 9)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 2, i, 6)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 3, i, 6)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 4, i, 6)
    end
    
    udg_CombatStatistics_PlayerCount = 1
    ForForce(udg_Player_PlayerGroup, combatStatisticsMultiboardInitLoop)

    MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 1, 1, true, false)

    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 1, 1, "Player")
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 2, 1, "DPS")
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 3, 1, "HPS")
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 4, 1, "Threat")

    MultiboardDisplayBJ(false, udg_CombatStatistics_Multiboard)

end


function combatStatisticsMultiboardRefresh()
    udg_CombatStatistics_PlayerCount = 1
    ForForce(udg_Player_PlayerGroup, combatStatisticsMultiboardRefreshLoop)
end

function combatStatisticsMultiboardRefreshLoop()
    local player = GetEnumPlayer()
    local playerId = GetPlayerId(player) + 1
    MultiboardSetItemIconBJ(udg_CombatStatistics_Multiboard, 1, udg_CombatStatistics_PlayerCount + 1, udg_INV_Player_Hero_Icon[playerId])
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 2, udg_CombatStatistics_PlayerCount + 1, R2I(udg_DPSMeter_DPS_PlayerBased[playerId]))
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 3, udg_CombatStatistics_PlayerCount + 1, R2I(udg_HPSMeter_HPS_PlayerBased[playerId]))
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 4, udg_CombatStatistics_PlayerCount + 1, R2I(udg_ThreatMeter_Threat[GetUnitUserData(udg_INV_Player_Hero[playerId])]))
    udg_CombatStatistics_PlayerCount = udg_CombatStatistics_PlayerCount + 1
    player = nil
end

function combatStatisticsMultiboardInitLoop()
    local player = GetEnumPlayer()
    local playerId = GetPlayerId(player) + 1
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 1, udg_CombatStatistics_PlayerCount + 1, getPlayerNameWithColorId(playerId))
    udg_CombatStatistics_PlayerCount = udg_CombatStatistics_PlayerCount + 1
    player = nil
end

function showCombatStatisticsMultiboard(player)
    local show = false
    if GetLocalPlayer() == player then
        show = true
    end

    if show == true then
        udg_Stat_Multiboard_Show = false
        udg_BeliefOrder_Multiboard_Show = false
        udg_INV_Multiboard_Show = false
        if udg_CombatStatistics_Show == true then
            udg_CombatStatistics_Show = false
        else
            udg_CombatStatistics_Show = true
        end

        MultiboardDisplayBJ(udg_INV_Multiboard_Show, udg_INV_Multiboard)
        MultiboardDisplayBJ(udg_Stat_Multiboard_Show, udg_Stat_Multiboard)
        MultiboardDisplayBJ(udg_BeliefOrder_Multiboard_Show, udg_BeliefOrder_Multiboard)
        MultiboardDisplayBJ(udg_CombatStatistics_Show, udg_CombatStatistics_Multiboard)
    end

end