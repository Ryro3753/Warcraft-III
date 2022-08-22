function heroSelectionRaceDialogClicked()
    local player = GetTriggerPlayer()
    local playerId = GetPlayerId(player) + 1
    local clickedButton = GetClickedButton()

    for i=1,9 do
        if clickedButton == udg_Hero_Selection_Dialog_Race_B[i] then
            udg_Hero_Selection_Race_Clicked[playerId] = i
        end
    end

    heroSelectionRefreshDialogNames()
    DialogDisplayBJ(true, udg_Hero_Selection_Dialog_Range, player)
end


function heroSelectionRangeDialogClicked()
    local player = GetTriggerPlayer()
    local playerId = GetPlayerId(player) + 1
    local clickedButton = GetClickedButton()
    for i=1,2 do
        if clickedButton == udg_Hero_Selection_Dialog_Range_B[i] then
            udg_Hero_Selection_Range_Clicked[playerId] = i
        end
    end

    local sumIndex = (udg_Hero_Selection_Race_Clicked[playerId] * 10) + udg_Hero_Selection_Range_Clicked[playerId]
    local createPoint = GetRectCenter(udg_Hero_Selection_Create_Region)
    CreateNUnitsAtLoc(1, udg_Hero_Selection_UnitType[sumIndex], player, createPoint, 0)
    GroupAddUnit(udg_Heroes, GetLastCreatedUnit())
    udg_INV_Player_Hero[playerId] = GetLastCreatedUnit()
    BlzSetHeroProperName(GetLastCreatedUnit(), GetPlayerName(player))
    RemoveLocation(createPoint)

    heroSelectionRefreshDialogNames()
    print(getPlayerNameWithColor(player) .. " selected " .. GetUnitName(GetLastCreatedUnit()))
end

function heroSelectionRefreshDialogNames()
    DialogSetMessageBJ(udg_Hero_Selection_Dialog_Range, "Character Range")
    DialogSetMessageBJ(udg_Hero_Selection_Dialog_Race, "Character Race")
end

function heroSelectionFindHeroFromUnit(unit)
    local unitType = GetUnitTypeId(unit)

    for i=1,udg_Hero_Selection_UnitType_Limit do
        if unitType == udg_Hero_Selection_UnitType[i] then
            return i
        end
    end

    return 0
end
