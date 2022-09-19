function createBeliefOrderMultiboard()
    CreateMultiboardBJ(5, 3, "Belief Orders")
    udg_BeliefOrder_Multiboard = GetLastCreatedMultiboard()


    for i=1,5 do
        for q=1,3 do
            if i == 5 or i == 1 then
                MultiboardSetItemStyleBJ(udg_BeliefOrder_Multiboard, i, q, true, true)
            else                
                MultiboardSetItemStyleBJ(udg_BeliefOrder_Multiboard, i, q, true, false)
            end
        end
    end

    for i=1,3 do
        MultiboardSetItemWidthBJ(udg_BeliefOrder_Multiboard, 1, i, 8)
        MultiboardSetItemWidthBJ(udg_BeliefOrder_Multiboard, 2, i, 4)
        MultiboardSetItemWidthBJ(udg_BeliefOrder_Multiboard, 3, i, 2)
        MultiboardSetItemWidthBJ(udg_BeliefOrder_Multiboard, 4, i, 4)
        MultiboardSetItemWidthBJ(udg_BeliefOrder_Multiboard, 5, i, 8)
    end

    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 1, 1, "Holy")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 5, 1, "Shadow")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 1, 2, "Nature")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 5, 2, "Necromantic")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 1, 3, "Arcana")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 5, 3, "Fel")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 3, 1, "|")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 3, 2, "|")
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 3, 3, "|")

    MultiboardSetItemIconBJ(udg_BeliefOrder_Multiboard, 1, 1, 'ReplaceableTextures\\CommandButtons\\BTNHolyBolt.blp')
    MultiboardSetItemIconBJ(udg_BeliefOrder_Multiboard, 5, 1, 'ReplaceableTextures\\CommandButtons\\BTNOrbOfDarkness.blp')
    MultiboardSetItemIconBJ(udg_BeliefOrder_Multiboard, 1, 2, 'ReplaceableTextures\\CommandButtons\\BTNEntanglingRoots.blp')
    MultiboardSetItemIconBJ(udg_BeliefOrder_Multiboard, 5, 2, 'ReplaceableTextures\\CommandButtons\\BTNAnimateDead.blp')
    MultiboardSetItemIconBJ(udg_BeliefOrder_Multiboard, 1, 3, 'ReplaceableTextures\\CommandButtons\\BTNDispelMagic.blp')
    MultiboardSetItemIconBJ(udg_BeliefOrder_Multiboard, 5, 3, 'ReplaceableTextures\\CommandButtons\\BTNInfernal.blp')

    MultiboardDisplayBJ(false, udg_BeliefOrder_Multiboard)
end


function refreshBeliefOrderMultiboard()
    ForForce(udg_Player_PlayerGroup, refreshBeliefOrderMultiboardPlayer)

    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 2, 1, udg_BeliefOrder_Multiboard_Holy)
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 4, 1, udg_BeliefOrder_Multiboard_Shadow)
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 2, 2, udg_BeliefOrder_Multiboard_Nature)
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 4, 2, udg_BeliefOrder_Multiboard_Necro)
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 2, 3, udg_BeliefOrder_Multiboard_Arcane)
    MultiboardSetItemValueBJ(udg_BeliefOrder_Multiboard, 4, 3, udg_BeliefOrder_Multiboard_Fel)
end

function refreshBeliefOrderMultiboardPlayer()
    local playerId = GetPlayerId(GetEnumPlayer()) + 1
    local isPlayer = false
    if GetLocalPlayer() == GetEnumPlayer() then
        isPlayer = true
    end

    if isPlayer == true then
        udg_BeliefOrder_Multiboard_Holy = udg_BeliefOrder_Holy[playerId]
        udg_BeliefOrder_Multiboard_Shadow = udg_BeliefOrder_Shadow[playerId]
        udg_BeliefOrder_Multiboard_Nature = udg_BeliefOrder_Nature[playerId]
        udg_BeliefOrder_Multiboard_Necro = udg_BeliefOrder_Necromantic[playerId]
        udg_BeliefOrder_Multiboard_Fel = udg_BeliefOrder_Fel[playerId]
        udg_BeliefOrder_Multiboard_Arcane = udg_BeliefOrder_Arcane[playerId]
    end
end


function showBeliefOrderMultiboard(player)
    local show = false
    if GetLocalPlayer() == player then
        show = true
    end

    if show == true then
        udg_CombatStatistics_Show = false
        udg_Stat_Multiboard_Show = false
        udg_INV_Multiboard_Show = false
        if udg_BeliefOrder_Multiboard_Show == true and show == true then
            udg_BeliefOrder_Multiboard_Show = false
        else
            udg_BeliefOrder_Multiboard_Show = true
        end

        MultiboardDisplayBJ(udg_INV_Multiboard_Show, udg_INV_Multiboard)
        MultiboardDisplayBJ(udg_CombatStatistics_Show, udg_CombatStatistics_Multiboard)
        MultiboardDisplayBJ(udg_Stat_Multiboard_Show, udg_Stat_Multiboard)
        MultiboardDisplayBJ(udg_BeliefOrder_Multiboard_Show, udg_BeliefOrder_Multiboard)
    end
end


function beliefOrderInit()
    for i=1,5 do
        if  GetPlayerController(ConvertedPlayer(i)) == MAP_CONTROL_USER and GetPlayerSlotState(ConvertedPlayer(i)) == PLAYER_SLOT_STATE_PLAYING then
            DialogSetMessage(udg_BeliefOrder_Dialog[i], "Belief Order")
            DialogAddButtonBJ(udg_BeliefOrder_Dialog[i], "|cffe1e100Holy|r")
            udg_BeliefOrder_Dialog_Button[(1 + (( i - 1 ) * 7))] = GetLastCreatedButtonBJ()
            DialogAddButtonBJ(udg_BeliefOrder_Dialog[i], "|cff808080Shadow|r")
            udg_BeliefOrder_Dialog_Button[(2 + (( i - 1 ) * 7))] = GetLastCreatedButtonBJ()
            DialogAddButtonBJ(udg_BeliefOrder_Dialog[i], "|cff64e100Nature|r")
            udg_BeliefOrder_Dialog_Button[(3 + (( i - 1 ) * 7))] = GetLastCreatedButtonBJ()
            DialogAddButtonBJ(udg_BeliefOrder_Dialog[i], "|cff320032Necromantic|r")
            udg_BeliefOrder_Dialog_Button[(4 + (( i - 1 ) * 7))] = GetLastCreatedButtonBJ()
            DialogAddButtonBJ(udg_BeliefOrder_Dialog[i], "|cff6f2583Arcane|r")
            udg_BeliefOrder_Dialog_Button[(5 + (( i - 1 ) * 7))] = GetLastCreatedButtonBJ()
            DialogAddButtonBJ(udg_BeliefOrder_Dialog[i], "|cff008000Fel|r")
            udg_BeliefOrder_Dialog_Button[(6 + (( i - 1 ) * 7))] = GetLastCreatedButtonBJ()
            DialogAddButtonBJ(udg_BeliefOrder_Dialog[i], "Cancel")
            udg_BeliefOrder_Dialog_Button[(7 + (( i - 1 ) * 7))] = GetLastCreatedButtonBJ()
        end
    end
end

function BeliefOrderSystemDialogButtonClicked(player)
    local playerId = GetPlayerId(player) + 1

    local clickedIndex = 0
    for i=1,35 do
        if GetClickedButtonBJ() == udg_BeliefOrder_Dialog_Button[i] then
            clickedIndex = ModuloInteger(i, 7)
        end
    end

    if clickedIndex == 0 then
        DialogDisplay(player, udg_BeliefOrder_Dialog[playerId], false)
        return
    end

    if udg_BeliefOrder_CurrentPoint[playerId] == 0  then
        DisplayTextToPlayer(player, 0, 0, "You don't have any belief point")
        return
    end

    --Holy
    if clickedIndex == 1 then
        if udg_BeliefOrder_Holy[playerId] < 0 then
            BeliefOrderSystemConfirmDialogShow(1, player)
            return
        end
        udg_BeliefOrder_Holy[playerId] = udg_BeliefOrder_Holy[playerId] + 1
        udg_BeliefOrder_Shadow[playerId] = udg_BeliefOrder_Shadow[playerId] - 1
    --Shadow
    elseif clickedIndex == 2 then
        if udg_BeliefOrder_Shadow[playerId] < 0 then
            BeliefOrderSystemConfirmDialogShow(2, player)
            return
        end
        udg_BeliefOrder_Shadow[playerId] = udg_BeliefOrder_Shadow[playerId] + 1
        udg_BeliefOrder_Holy[playerId] = udg_BeliefOrder_Holy[playerId] - 1
    --Nature
    elseif clickedIndex == 3 then
        if udg_BeliefOrder_Nature[playerId] < 0 then
            BeliefOrderSystemConfirmDialogShow(3, player)
            return
        end
        udg_BeliefOrder_Nature[playerId] = udg_BeliefOrder_Nature[playerId] + 1
        udg_BeliefOrder_Necromantic[playerId] = udg_BeliefOrder_Necromantic[playerId] - 1
    --Necromantic
    elseif clickedIndex == 4 then
        if udg_BeliefOrder_Necromantic[playerId] < 0 then
            BeliefOrderSystemConfirmDialogShow(4, player)
            return
        end
        udg_BeliefOrder_Necromantic[playerId] = udg_BeliefOrder_Necromantic[playerId] + 1
        udg_BeliefOrder_Nature[playerId] = udg_BeliefOrder_Nature[playerId] - 1
    --Arcane
    elseif clickedIndex == 5 then
        if udg_BeliefOrder_Arcane[playerId] < 0 then
            BeliefOrderSystemConfirmDialogShow(5, player)
            return
        end
        udg_BeliefOrder_Arcane[playerId] = udg_BeliefOrder_Arcane[playerId] + 1
        udg_BeliefOrder_Fel[playerId] = udg_BeliefOrder_Fel[playerId] - 1
    --Fel
    elseif clickedIndex == 6 then
        if udg_BeliefOrder_Fel[playerId] < 0 then
            BeliefOrderSystemConfirmDialogShow(6, player)
            return
        end
        udg_BeliefOrder_Fel[playerId] = udg_BeliefOrder_Fel[playerId] + 1
        udg_BeliefOrder_Arcane[playerId] = udg_BeliefOrder_Arcane[playerId] - 1
    end

    udg_BeliefOrder_GivenPoint[playerId] = udg_BeliefOrder_GivenPoint[playerId] + 1
    increaseBeliefOrderCurrentPoint(player,-1)
    DialogSetMessage(udg_BeliefOrder_Dialog[playerId], "Belief Order (" .. tostring(udg_BeliefOrder_CurrentPoint[playerId]) .. " Remaining Poins)")
    
    if udg_BeliefOrder_CurrentPoint[playerId] > 0 then
        DialogDisplay(player, udg_BeliefOrder_Dialog[playerId], true)
    end

end

function increaseBeliefOrderCurrentPoint(player,addPoint)
    local playerId = GetPlayerId(player) + 1

    udg_BeliefOrder_CurrentPoint[playerId] = udg_BeliefOrder_CurrentPoint[playerId] + addPoint
end

function BeliefOrderSystemConfirmDialogShow(index, player)
    local playerId = GetPlayerId(player) + 1
    local startId = (playerId - 1) * 3

    local orderName = ""
    local oppositeOrderName = ""
    if index == 1 then
        orderName = "|cffe1e100Holy|r"
        oppositeOrderName = "|cff808080Shadow|r"
        udg_BeliefOrder_Confirm_Clicked[playerId] = 1
    elseif index == 2 then
        orderName = "|cff808080Shadow|r"
        oppositeOrderName = "|cffe1e100Holy|r"
        udg_BeliefOrder_Confirm_Clicked[playerId] = 2
    elseif index == 3 then
        orderName = "|cff64e100Nature|r"
        oppositeOrderName = "|cff320032Necromantic|r"
        udg_BeliefOrder_Confirm_Clicked[playerId] = 3
    elseif index == 4 then
        orderName = "|cff320032Necromantic|r"
        oppositeOrderName = "|cff64e100Nature|r"
        udg_BeliefOrder_Confirm_Clicked[playerId] = 4
    elseif index == 5 then
        orderName = "|cff6f2583Arcane|r"
        oppositeOrderName = "|cff008000Fel|r"
        udg_BeliefOrder_Confirm_Clicked[playerId] = 5
    elseif index == 6 then
        orderName = "|cff008000Fel|r"
        oppositeOrderName = "|cff6f2583Arcane|r"
        udg_BeliefOrder_Confirm_Clicked[playerId] = 6
    end

    DialogClearBJ(udg_BeliefOrder_Confirm_Dialog[playerId])
    DialogSetMessageBJ(udg_BeliefOrder_Confirm_Dialog[playerId], "Are you sure to continue with " .. orderName .. " ?|n It has less than 0 value, it would|n take away a point from " .. oppositeOrderName .. ".")

    DialogAddButtonBJ(udg_BeliefOrder_Confirm_Dialog[playerId], "Yes")
    udg_BeliefOrder_Confirm_DialogB[startId + 1] = GetLastCreatedButtonBJ()
    DialogAddButtonBJ(udg_BeliefOrder_Confirm_Dialog[playerId], "No")
    udg_BeliefOrder_Confirm_DialogB[startId + 2] = GetLastCreatedButtonBJ()
    DialogAddButtonBJ(udg_BeliefOrder_Confirm_Dialog[playerId], "Cancel")
    udg_BeliefOrder_Confirm_DialogB[startId + 3] = GetLastCreatedButtonBJ()

    DialogDisplayBJ(true, udg_BeliefOrder_Confirm_Dialog[playerId], player)
end

function BeliefOrderSystemConfirmDialogClick()
    local player = GetTriggerPlayer()
    local playerId = GetPlayerId(player) + 1
    local clickedButton = GetClickedButtonBJ()
    local startId = (playerId - 1) * 2

    if udg_BeliefOrder_Confirm_DialogB[startId + 1] == clickedButton then

        if udg_BeliefOrder_Confirm_Clicked[playerId] == 1 then
            udg_BeliefOrder_Holy[playerId] = udg_BeliefOrder_Holy[playerId] + 1
            udg_BeliefOrder_Shadow[playerId] = udg_BeliefOrder_Shadow[playerId] - 1
        elseif udg_BeliefOrder_Confirm_Clicked[playerId] == 2 then
            udg_BeliefOrder_Shadow[playerId] = udg_BeliefOrder_Shadow[playerId] + 1
            udg_BeliefOrder_Holy[playerId] = udg_BeliefOrder_Holy[playerId] - 1
        elseif udg_BeliefOrder_Confirm_Clicked[playerId] == 3 then
            udg_BeliefOrder_Nature[playerId] = udg_BeliefOrder_Nature[playerId] + 1
            udg_BeliefOrder_Necromantic[playerId] = udg_BeliefOrder_Necromantic[playerId] - 1
        elseif udg_BeliefOrder_Confirm_Clicked[playerId] == 4 then
            udg_BeliefOrder_Necromantic[playerId] = udg_BeliefOrder_Necromantic[playerId] + 1
            udg_BeliefOrder_Nature[playerId] = udg_BeliefOrder_Nature[playerId] - 1
        elseif udg_BeliefOrder_Confirm_Clicked[playerId] == 5 then
            udg_BeliefOrder_Arcane[playerId] = udg_BeliefOrder_Arcane[playerId] + 1
            udg_BeliefOrder_Fel[playerId] = udg_BeliefOrder_Fel[playerId] - 1
        elseif udg_BeliefOrder_Confirm_Clicked[playerId] == 6 then
            udg_BeliefOrder_Fel[playerId] = udg_BeliefOrder_Fel[playerId] + 1
            udg_BeliefOrder_Arcane[playerId] = udg_BeliefOrder_Arcane[playerId] - 1
        end

        udg_BeliefOrder_GivenPoint[playerId] = udg_BeliefOrder_GivenPoint[playerId] + 1
        increaseBeliefOrderCurrentPoint(player,-1)
        DialogSetMessage(udg_BeliefOrder_Dialog[playerId], "Belief Order (" .. tostring(udg_BeliefOrder_CurrentPoint[playerId]) .. " Remaining Poins)")
        
        if udg_BeliefOrder_CurrentPoint[playerId] > 0 then
            DialogDisplay(player, udg_BeliefOrder_Dialog[playerId], true)
        end

    elseif udg_BeliefOrder_Confirm_DialogB[startId + 2] == clickedButton then
        DialogSetMessage(udg_BeliefOrder_Dialog[playerId], "Belief Order (" .. tostring(udg_BeliefOrder_CurrentPoint[playerId]) .. " Remaining Poins)")
        DialogDisplay(player, udg_BeliefOrder_Dialog[playerId], true)
    else
        player = nil
        clickedButton = nil
        return
    end

    player = nil
    clickedButton = nil
end
