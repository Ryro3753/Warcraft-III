function fillPlayerGroup()
    for i=1,5 do
        if GetPlayerController(ConvertedPlayer(i)) == MAP_CONTROL_USER and GetPlayerSlotState(ConvertedPlayer(i)) == PLAYER_SLOT_STATE_PLAYING then
            ForceAddPlayer(udg_Player_PlayerGroup, Player(i-1))
        end
    end
end

function creatingFloatingTextTimed(text, unit, size, red, green, blue)
    local unitLoc = GetUnitLoc(unit)
    local textLoc = PolarProjectionBJ(unitLoc, GetRandomReal(-100, 100), GetRandomDirectionDeg())
    CreateTextTagLocBJ(text, textLoc, 0, size, red, green, blue, 0)
    ShowTextTagForceBJ( false, GetLastCreatedTextTag(), GetPlayersAll() )
    ShowTextTagForceBJ( true, GetLastCreatedTextTag(), udg_FloatingText_PlayerGroup )
    SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
    SetTextTagVelocityBJ( GetLastCreatedTextTag(), 80.00, 90 )
    SetTextTagLifespanBJ( GetLastCreatedTextTag(), 2.00 )
    SetTextTagFadepointBJ( GetLastCreatedTextTag(), 2.00 )
    ForceClear( udg_FloatingText_PlayerGroup )
    RemoveLocation(unitLoc)
    RemoveLocation(textLoc)
end


function registerUnit(unit)
    udg_Register_ID = udg_Register_ID + 1
    SetUnitUserData(unit, udg_Register_ID)
    GroupAddUnit(udg_Registered_Units, unit)
    udg_Registered_Unit = unit
    TriggerExecute(gg_trg_RegisterSystem_Other_Systems)
end