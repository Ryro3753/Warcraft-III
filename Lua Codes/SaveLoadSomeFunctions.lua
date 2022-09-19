function saveloadFirstDialogInt()
    DialogClearBJ(udg_saveload_or_new_dialog)

    DialogSetMessageBJ(udg_saveload_or_new_dialog, "Character Select")

    DialogAddButtonBJ(udg_saveload_or_new_dialog, "New")
    udg_saveload_or_new_dialog_button[1] = GetLastCreatedButtonBJ()
    DialogAddButtonBJ(udg_saveload_or_new_dialog, "Load")
    udg_saveload_or_new_dialog_button[2] = GetLastCreatedButtonBJ()
end


function saveloadFirstDialogClicked()
    local player = GetTriggerPlayer()
    local clickedButton = GetClickedButtonBJ()

    if clickedButton == udg_saveload_or_new_dialog_button[1] then
        DialogDisplayBJ(true, udg_Hero_Selection_Dialog_Race, player)
    else
        saveloadFirstDialogLoadClicked(player)
    end

    player = nil
    clickedButton = nil
end

function saveloadFirstDialogLoadClicked(player)
    if checkIfPlayerHasAnySaveData(player) == false then
        DisplayTextToPlayer(player, 0, 0, "You don't have any saved character")
        DialogDisplayBJ(true, udg_saveload_or_new_dialog, player)
        return
    end

    local playerId = GetPlayerId(player) + 1
    udg_save_load_player = player
    udg_save_load_player_process_name[playerId] = "Load"
    TriggerExecuteBJ(gg_trg_Save_Load_Dialog_Create, false)
end

function checkIfPlayerHasAnySaveData(player)
    local playerId = GetPlayerId(player) + 1
    local startIndex = (playerId - 1) * 5

    for i=startIndex,startIndex + 5 do
        if udg_save_load_player_unit_type[i] ~= 0 then
            return true
        end
    end

    return false
end

function checkIfUnitHasSavePreventBuffs(unit)
    local bool = false
    local player = GetOwningPlayer(unit)
    for i=1,udg_saveload_prevent_buff_codes_li do
        if UnitHasBuffBJ(unit, udg_saveload_prevent_buff_codes[i]) then
            DisplayTextToPlayer(player, 0, 0, "|cffc0c0c0Please wait until |cffd45e19" .. udg_saveload_prevent_buff_codes_n[i] .. "|r|cffc0c0c0 buff duration is over, then try again to save.|r")
            bool = true
        end
    end
    player = nil
    return bool
end

function saveFunction()
    local player = GetTriggerPlayer()
    local playerId = GetPlayerId(player) + 1
    if udg_save_enabled == true then
        if checkIfUnitHasSavePreventBuffs(udg_INV_Player_Hero[playerId]) == true then
            player = nil
            return
        end
        udg_save_load_player = player
        udg_save_load_player_process_name[playerId] = "Save"
        TriggerExecuteBJ(gg_trg_Save_Load_Dialog_Create, false)
    else
        DisplayTextToPlayer(player, 0, 0, "Save system currently is deactive")
    end
    player = nil
end