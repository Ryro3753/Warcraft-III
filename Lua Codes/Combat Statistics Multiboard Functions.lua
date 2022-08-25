function combatStatisticsMultiboardCreate()
    local playerCount = 1
    for i=1,5 do
        local player = ConvertedPlayer(i)
        if GetPlayerController(player) == MAP_CONTROL_USER and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            playerCount = playerCount + 1
        end
    end

    udg_CombatStatistics_PlayerCount = playerCount

    CreateMultiboardBJ(4, playerCount, "Combat Statistics")
    udg_CombatStatistics_Multiboard = GetLastCreatedMultiboard()

    print(playerCount)
    for i=1,playerCount do
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 1, i, true, true)
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 2, i, true, false)
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 3, i, true, false)
        MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 4, i, true, false)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 1, i, 9)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 2, i, 6)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 3, i, 6)
        MultiboardSetItemWidthBJ(udg_CombatStatistics_Multiboard, 4, i, 6)
        if i > 1 then
            print("anan")
            print(getPlayerNameWithColorId(i - 1))
            MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 1, i, getPlayerNameWithColorId(i - 1))
        end
    end

    MultiboardSetItemStyleBJ(udg_CombatStatistics_Multiboard, 1, 1, true, false)

    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 1, 1, "Player")
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 2, 1, "DPS")
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 3, 1, "HPS")
    MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 4, 1, "Threat")

    MultiboardDisplayBJ(false, udg_CombatStatistics_Multiboard)

end


function combatStatisticsMultiboardRefresh()
    for i=2,udg_CombatStatistics_PlayerCount do
        MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 2, i, R2I(udg_DPSMeter_DPS_PlayerBased[i - 1]))
        MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 3, i, R2I(udg_HPSMeter_HPS_PlayerBased[i - 1]))
        MultiboardSetItemValueBJ(udg_CombatStatistics_Multiboard, 4, i, R2I(udg_ThreatMeter_Threat[GetUnitUserData(udg_INV_Player_Hero[i - 1])]))
    end
end

function showCombatStatisticsMultiboard(player)
    local show = false
    if GetLocalPlayer() == player then
        show = true
    end

    if show == true then
        udg_Stat_Multiboard_Show = false
        udg_BeliefOrder_Multiboard_Show = false
        if udg_CombatStatistics_Show == true then
            udg_CombatStatistics_Show = false
        else
            udg_CombatStatistics_Show = true
        end
    end

    MultiboardDisplayBJ(udg_Stat_Multiboard_Show, udg_Stat_Multiboard)
    MultiboardDisplayBJ(udg_BeliefOrder_Multiboard_Show, udg_BeliefOrder_Multiboard)
    MultiboardDisplayBJ(udg_CombatStatistics_Show, udg_CombatStatistics_Multiboard)
end