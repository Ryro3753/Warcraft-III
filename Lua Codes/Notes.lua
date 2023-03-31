function notesInit()
    local id = 1
    udg_Notes_Title[id] = "Human Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNLordNicholasBuzan.blp"

    id = id + 1
    udg_Notes_Title[id] = "Human Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNBanditSpearThrower.blp"

    id = id + 1
    udg_Notes_Title[id] = "Orc Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNHeroBlademaster.blp"

    id = id + 1
    udg_Notes_Title[id] = "Orc Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNChaosWarlockGreen.blp"

    id = id + 1
    udg_Notes_Title[id] = "Dwarf Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNHeroMountainKing.blp"

    id = id + 1
    udg_Notes_Title[id] = "Dwarf Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNRifleman.blp"

    id = id + 1
    udg_Notes_Title[id] = "Troll Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNForestTrollWarlord.blp"

    id = id + 1
    udg_Notes_Title[id] = "Troll Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNHeadHunterBerserker.blp"

    id = id + 1
    udg_Notes_Title[id] = "Night Elf Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNHeroWarden.blp"

    id = id + 1
    udg_Notes_Title[id] = "Night Elf Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNArcher.blp"

    id = id + 1
    udg_Notes_Title[id] = "Blood Elf Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNThalorienDawnseeker.blp"

    id = id + 1
    udg_Notes_Title[id] = "Blood Elf Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNJennallaDeemspring.blp"

    id = id + 1
    udg_Notes_Title[id] = "Tauren Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNHeroTaurenChieftain.blp"

    id = id + 1
    udg_Notes_Title[id] = "Tauren Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNSpiritWalker.blp"

    id = id + 1
    udg_Notes_Title[id] = "Naga Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNNagaMyrmidon.blp"

    id = id + 1
    udg_Notes_Title[id] = "Naga Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNNagaSeaWitch.blp"

    id = id + 1
    udg_Notes_Title[id] = "Panderen Melee"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNPandarenBrewmaster.blp"

    id = id + 1
    udg_Notes_Title[id] = "Panderen Range"
    udg_Notes_Description1[id] = ""
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNStormBrewmaster.blp"

    id = 20
    udg_Notes_Title[id] = "Info Line"
    udg_Notes_Description1[id] = "Items above this line are Infos, and below are Achivements."
    udg_Notes_Icon[id] = "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp"

    udg_Notes_Limit = id
end


function notesCreateUnitInfoNote(player)
    local playerId = GetPlayerId(player) + 1
    if udg_INV_Player_Hero[playerId] == nil then
        return
    end
    
    local heroName = GetUnitName(udg_INV_Player_Hero[playerId])
    local noteId = 0
    for i=1,20 do
        if heroName == udg_Notes_Title[i] then
            noteId = i
        end
    end
    heroName = nil

    if noteId == 0 then
        return
    end

    local description = udg_Notes_Description1[noteId] .. "|n" .. udg_Notes_Description2[noteId] .. "|n" .. udg_Notes_Description3[noteId] .. "|n" .. udg_Notes_Description4[noteId]
    CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, getPlayerNameWithoutSharp(player), description, udg_Notes_Icon[noteId])
    description = nil
    notesQuestSave(GetLastCreatedQuestBJ(), playerId)

end


function notesRefresh(player)
    local playerId = GetPlayerId(player) + 1
    
    if udg_Settings_ShowNotes[playerId] == 1 then
        notesCreate(player)
        notesRefreshPlayerSpecific(player)
    else
        notesRemove(player)
    end
end


function notesRemove(player)
    local playerId = GetPlayerId(player) + 1

    for i=1,udg_Notes_Id[playerId] do
        DestroyQuestBJ(notesGetQuest(playerId, i))
    end

    udg_Notes_Id[playerId] = 0
end

function notesCreate(player)
    local playerId = GetPlayerId(player) + 1
    notesCreateUnitInfoNote(player)

    for i=20,udg_Notes_Limit do
        local description = udg_Notes_Description1[i] .. "|n" .. udg_Notes_Description2[i] .. "|n" .. udg_Notes_Description3[i] .. "|n" .. udg_Notes_Description4[i]
        CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, udg_Notes_Title[i], description, udg_Notes_Icon[i])
        description = nil
        notesQuestSave(GetLastCreatedQuestBJ(), playerId)
    end

end


function notesQuestSave(quest, playerId)
    udg_Notes_Id[playerId] = udg_Notes_Id[playerId] + 1
    if playerId == 1 then
        udg_Notes_Quest_Player1[udg_Notes_Id[playerId]] = quest
    elseif playerId == 2 then
        udg_Notes_Quest_Player2[udg_Notes_Id[playerId]] = quest
    elseif playerId == 3 then
        udg_Notes_Quest_Player3[udg_Notes_Id[playerId]] = quest
    elseif playerId == 4 then
        udg_Notes_Quest_Player4[udg_Notes_Id[playerId]] = quest
    elseif playerId == 5 then
        udg_Notes_Quest_Player5[udg_Notes_Id[playerId]] = quest
    end
end

function notesGetQuest(playerId, index)
    if playerId == 1 then
        return udg_Notes_Quest_Player1[index]
    elseif playerId == 2 then
        return udg_Notes_Quest_Player2[index]
    elseif playerId == 3 then
        return udg_Notes_Quest_Player3[index]
    elseif playerId == 4 then
        return udg_Notes_Quest_Player4[index]
    elseif playerId == 5 then
        return udg_Notes_Quest_Player5[index]
    end
end

function notesRefreshPlayerSpecific(player)
    local playerId = GetPlayerId(player) + 1

    for i=1,udg_Notes_Id[playerId] do
        QuestSetEnabledBJ(false, notesGetQuest(playerId, i))
    end


    local localPlayer = false
    if player == GetLocalPlayer() then
        localPlayer = true
    end

    if localPlayer then
        for i=1,udg_Notes_Id[playerId] do
            QuestSetEnabledBJ(true, notesGetQuest(playerId, i))
        end
    end
end