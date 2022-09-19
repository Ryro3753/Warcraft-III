function disableInterface()
    ShowInterfaceForceOff(GetPlayersAll(), 0.00)
end

function enableInterface()
    ShowInterfaceForceOn(GetPlayersAll(), 0.00)
end

function fadeOutScreen()
    CinematicFadeBJ( bj_CINEFADETYPE_FADEOUT, 0.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0 )
end

function fadeInScreen()
    CinematicFadeBJ( bj_CINEFADETYPE_FADEIN, 0.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0 )
end

function systemLoadingScreenPrepare()
    disableInterface()
    fadeOutScreen()
    DisplayTextToForce(GetPlayersAll(), "Please wait a little while until all systems load properly")
end

function systemLoadingIsOver()
    fadeInScreen()
    enableInterface()
    ForForce(udg_Player_PlayerGroup, systemLoadingIsOverLoop)
end

function systemLoadingIsOverLoop()
    DialogDisplayBJ(true, udg_saveload_or_new_dialog, GetEnumPlayer())
end