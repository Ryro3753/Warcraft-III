function settingSystemInit()
    for playerId=1,5 do
        udg_Settings_ShowGold[playerId] = 1
        udg_Settings_ShowEXP[playerId] = 1
        udg_Settings_ShowHealTaken[playerId] = 1
        udg_Settings_ShowHealGive[playerId] = 1
        udg_Settings_ShowDamageTaken[playerId] = 1
        udg_Settings_ShowDamageDealt[playerId] = 1
    end
end

function settingSystemCast()
    local unit = GetTriggerUnit()
    local player = GetOwningPlayer(unit)
    local playerId = GetPlayerId(player) + 1
    local idStart = (playerId - 1) * 7

    settingSystemRefresh(idStart, playerId)
    DialogDisplayBJ(true, udg_Settings_Dialog[playerId], player)

    unit = nil
end

function settingSystemRefresh(idStart, playerId)
    DialogClearBJ(udg_Settings_Dialog[playerId])
    DialogSetMessageBJ(udg_Settings_Dialog[playerId], "Map Settings (|cffc03232Current|r)")

    local goldText = ""
    if udg_Settings_ShowGold[playerId] == 0 then
        goldText = "Hide"
    elseif udg_Settings_ShowGold[playerId] == 1 then
        goldText = "Show"
    elseif udg_Settings_ShowGold[playerId] == 2 then
        goldText = "Show as Game Text"
    end
    DialogAddButtonBJ(udg_Settings_Dialog[playerId], "Show Gold (|cffc03232" .. goldText .. "|r)")
    udg_Settings_Dialog_Button[idStart + 1] = GetLastCreatedButtonBJ()

    local expText = ""
    if udg_Settings_ShowEXP[playerId] == 0 then
        expText = "Hide"
    elseif udg_Settings_ShowEXP[playerId] == 1 then
        expText = "Show"
    elseif udg_Settings_ShowEXP[playerId] == 2 then
        expText = "Show as Game Text"
    end
    DialogAddButtonBJ(udg_Settings_Dialog[playerId], "Show EXP (|cffc03232" .. expText .. "|r)")
    udg_Settings_Dialog_Button[idStart + 2] = GetLastCreatedButtonBJ()

    local healTaken = ""
    if udg_Settings_ShowHealTaken[playerId] == 0 then
        healTaken = "Hide"
    elseif udg_Settings_ShowHealTaken[playerId] == 1 then
        healTaken = "Show"
    end
    DialogAddButtonBJ(udg_Settings_Dialog[playerId], "Show Healing Taken (|cffc03232" .. healTaken .. "|r)")
    udg_Settings_Dialog_Button[idStart + 3] = GetLastCreatedButtonBJ()

    local healGive = ""
    if udg_Settings_ShowHealGive[playerId] == 0 then
        healGive = "Hide"
    elseif udg_Settings_ShowHealGive[playerId] == 1 then
        healGive = "Show"
    end
    DialogAddButtonBJ(udg_Settings_Dialog[playerId], "Show Healing Given (|cffc03232" .. healGive .. "|r)")
    udg_Settings_Dialog_Button[idStart + 4] = GetLastCreatedButtonBJ()

    local damageTaken = ""
    if udg_Settings_ShowDamageTaken[playerId] == 0 then
        damageTaken = "Hide"
    elseif udg_Settings_ShowDamageTaken[playerId] == 1 then
        damageTaken = "Show"
    end
    DialogAddButtonBJ(udg_Settings_Dialog[playerId], "Show Damage Taken (|cffc03232" .. damageTaken .. "|r)")
    udg_Settings_Dialog_Button[idStart + 5] = GetLastCreatedButtonBJ()

    local damageDealt = ""
    if udg_Settings_ShowDamageDealt[playerId] == 0 then
        damageDealt = "Hide"
    elseif udg_Settings_ShowDamageDealt[playerId] == 1 then
        damageDealt = "Show"
    end
    DialogAddButtonBJ(udg_Settings_Dialog[playerId], "Show Damage Dealt (|cffc03232" .. damageDealt .. "|r)")
    udg_Settings_Dialog_Button[idStart + 6] = GetLastCreatedButtonBJ()

    DialogAddButtonBJ(udg_Settings_Dialog[playerId], "Close")
    udg_Settings_Dialog_Button[idStart + 7] = GetLastCreatedButtonBJ()

    goldText = nil
    expText = nil
    healTaken = nil
    healGive = nil
    damageTaken = nil
    damageDealt = nil
end


function settingSystemDialogClicked()
    local player = GetTriggerPlayer()
    local playerId = GetPlayerId(player) + 1
    local clickedButton = GetClickedButtonBJ()
    local idStart = (playerId - 1) * 7

    --Finding Button Index
    local index = -1
    for i=idStart + 1, idStart + 7 do
        if udg_Settings_Dialog_Button[i] == clickedButton then
            index = ModuloInteger(i, 7)
        end
    end

    if index < 1 then
        player = nil
        clickedButton = nil
        return
    end

    if index == 1 then
        if udg_Settings_ShowGold[playerId] == 0 then
            udg_Settings_ShowGold[playerId] = 1
        elseif udg_Settings_ShowGold[playerId] == 1 then
            udg_Settings_ShowGold[playerId] = 2
        else
            udg_Settings_ShowGold[playerId] = 0
        end
    elseif index == 2 then
        if udg_Settings_ShowEXP[playerId] == 0 then
            udg_Settings_ShowEXP[playerId] = 1
        elseif udg_Settings_ShowEXP[playerId] == 1 then
            udg_Settings_ShowEXP[playerId] = 2
        else
            udg_Settings_ShowEXP[playerId] = 0
        end
    elseif index == 3 then
        if udg_Settings_ShowHealTaken[playerId] == 0 then
            udg_Settings_ShowHealTaken[playerId] = 1
        else
            udg_Settings_ShowHealTaken[playerId] = 0
        end
    elseif index == 4 then
        if udg_Settings_ShowHealGive[playerId] == 0 then
            udg_Settings_ShowHealGive[playerId] = 1
        else
            udg_Settings_ShowHealGive[playerId] = 0
        end
    elseif index == 5 then
        if udg_Settings_ShowDamageTaken[playerId] == 0 then
            udg_Settings_ShowDamageTaken[playerId] = 1
        else
            udg_Settings_ShowDamageTaken[playerId] = 0
        end
    elseif index == 6 then
        if udg_Settings_ShowDamageDealt[playerId] == 0 then
            udg_Settings_ShowDamageDealt[playerId] = 1
        else
            udg_Settings_ShowDamageDealt[playerId] = 0
        end
    end

    settingSystemRefresh(idStart, playerId)
    DialogDisplayBJ(true, udg_Settings_Dialog[playerId], player)

    player = nil
    clickedButton = nil
end