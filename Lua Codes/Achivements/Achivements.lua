function achivementsInit()
    local id = 1
    udg_Achivements_Title[id] = "I Didn't Fall"
    udg_Achivements_Description1[id] = "Even though Lordaeron had fallen, you haven't."
    udg_Achivements_Description2[id] = "--"
    udg_Achivements_Description3[id] = "|cffffcc00Finish the Fall of Lordaeron map without dying.|r"
    udg_Achivements_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNArthasEvil.blp"
    udg_Achivements_Map_Id[id] = 1

    udg_Achivements_Limit = id


    for i=1,udg_Achivements_Limit do
        udg_Achivements_Complete_Player1[i] = 0
        udg_Achivements_Complete_Player2[i] = 0
        udg_Achivements_Complete_Player3[i] = 0
        udg_Achivements_Complete_Player4[i] = 0
        udg_Achivements_Complete_Player5[i] = 0
    end
end

function achivementsCreate(player)
    local playerId = GetPlayerId(player) + 1
    
    for i=1,udg_Achivements_Limit do
        local description = achivementsGetDescription(i)
        CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, udg_Achivements_Title[i], description, udg_Achivements_Icon[i])
        description = ""
        achivementsSaveQuest(playerId, GetLastCreatedQuestBJ())
        if achivementsGetQuestCompletion(playerId, i) == 1 then
            QuestSetCompleted(GetLastCreatedQuestBJ(), true)
        end
    end
end


function achivementsRefresh(player)
    achivementsRemove(player)
    achivementsCreate(player)
    achivementsVisibilityRefresh(player)
end


function achivementsRemove(player)
    local playerId = GetPlayerId(player) + 1

    for i=1,udg_Achivements_Player_Id[playerId] do
        DestroyQuestBJ(achivementsGetQuest(playerId, i))
    end

    udg_Achivements_Player_Id[playerId] = 0
end


function achivementsGetQuest(playerId, index)
    if playerId == 1 then
        return udg_Achivements_Quest_Player1[index]
    elseif playerId == 2 then
        return udg_Achivements_Quest_Player2[index]
    elseif playerId == 3 then
        return udg_Achivements_Quest_Player3[index]
    elseif playerId == 4 then
        return udg_Achivements_Quest_Player4[index]
    elseif playerId == 5 then
        return udg_Achivements_Quest_Player5[index]
    end
end

function achivementsGetQuestCompletion(playerId, index)
    if playerId == 1 then
        return udg_Achivements_Complete_Player1[index]
    elseif playerId == 2 then
        return udg_Achivements_Complete_Player2[index]
    elseif playerId == 3 then
        return udg_Achivements_Complete_Player3[index]
    elseif playerId == 4 then
        return udg_Achivements_Complete_Player4[index]
    elseif playerId == 5 then
        return udg_Achivements_Complete_Player5[index]
    end
end

function achivementsSaveQuest(playerId, quest)
    udg_Achivements_Player_Id[playerId] = udg_Achivements_Player_Id[playerId] + 1

    if playerId == 1 then
        udg_Achivements_Quest_Player1[udg_Achivements_Player_Id[playerId]] = quest
    elseif playerId == 2 then
        udg_Achivements_Quest_Player2[udg_Achivements_Player_Id[playerId]] = quest
    elseif playerId == 3 then
        udg_Achivements_Quest_Player3[udg_Achivements_Player_Id[playerId]] = quest
    elseif playerId == 4 then
        udg_Achivements_Quest_Player4[udg_Achivements_Player_Id[playerId]] = quest
    elseif playerId == 5 then
        udg_Achivements_Quest_Player5[udg_Achivements_Player_Id[playerId]] = quest
    end
end

function achivementsVisibilityRefresh(player)
    local playerId = GetPlayerId(player) + 1
    
    for i=1,udg_Achivements_Player_Id[playerId] do
        QuestSetEnabledBJ(false, achivementsGetQuest(playerId, i))
    end

    local localPlayer = false
    if player == GetLocalPlayer() then
        localPlayer = true
    end

    if localPlayer then
        for i=1,udg_Achivements_Limit do
            if udg_Achivements_Map_Id[i] == udg_Map_Id or udg_Settings_ShowAllAchivements[playerId] == 1  then
                QuestSetEnabledBJ(true, achivementsGetQuest(playerId, i))
            end
        end
    end

end


function achivementsGetDescription(index)
    local str = ""
    if udg_Achivements_Description1[index] ~= "" then
        str = str .. udg_Achivements_Description1[index]
    end

    if udg_Achivements_Description2[index] ~= "" then
        str = str .. "|n" .. udg_Achivements_Description2[index]
    end

    if udg_Achivements_Description3[index] ~= "" then
        str = str .. "|n" .. udg_Achivements_Description3[index]
    end
    
    if udg_Achivements_Description4[index] ~= "" then
        str = str .. "|n" .. udg_Achivements_Description4[index]
    end

    if udg_Achivements_Description5[index] ~= "" then
        str = str .. "|n" .. udg_Achivements_Description5[index]
    end

    if udg_Achivements_Description6[index] ~= "" then
        str = str .. "|n" .. udg_Achivements_Description6[index]
    end

    if udg_Achivements_Description7[index] ~= "" then
        str = str .. "|n" .. udg_Achivements_Description7[index]
    end

    if udg_Achivements_Description8[index] ~= "" then
        str = str .. "|n" .. udg_Achivements_Description8[index]
    end

    return str
end