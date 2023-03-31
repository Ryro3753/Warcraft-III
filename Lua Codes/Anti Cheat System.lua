function activeAntiCheatSystem()
    local playerCount = CountPlayersInForceBJ(udg_Player_PlayerGroup)
    if playerCount < 2 and udg_Debug == false then
        udg_AntiCheat_IsActive = true
        EnableTrigger(gg_trg_Anti_Cheat_System_Control_Loop)


        --Who Is Your Daddy
        local loc = GetRectCenter(udg_AntiCheat_Region)
        CreateNUnitsAtLoc(1, udg_AntiCheat_DummyType, ForcePickRandomPlayer(udg_Player_PlayerGroup), loc, 0)
        udg_AntiCheat_WhosYourDaddyAlly = GetLastCreatedUnit()
        CreateNUnitsAtLoc(1, udg_AntiCheat_DummyType, Player(23), loc, 0)
        udg_AntiCheat_WhosYourDaddyEnemy = GetLastCreatedUnit()
        RemoveLocation(loc)
        loc = nil

        --I See Dead People
        TriggerRegisterUnitEvent(gg_trg_Anti_Cheat_IseeDeadPeople, udg_AntiCheat_WhosYourDaddyAlly, EVENT_UNIT_ACQUIRED_TARGET)
    end
end

function antiCheatControl()
    if udg_AntiCheat_IsActive == false then
        return
    end

    --Cast Anti Cheat ability for there is no spoon
    IssueImmediateOrder(udg_AntiCheat_WhosYourDaddyAlly, "thunderclap")

    local greedIsGood = antiCheatGreedIsGoodControl()
    local whoIsYourDaddy = antiCheatWhoIsYourDaddyControl()
    if greedIsGood or whoIsYourDaddy then
        antiCheatDetected()
    end
end

function antiCheatGreedIsGoodControl()
    local lastPlayerGold = GetPlayerState(Player(23), PLAYER_STATE_RESOURCE_GOLD)
    local lastPlayerLumber = GetPlayerState(Player(23), PLAYER_STATE_RESOURCE_LUMBER)
    if lastPlayerGold > 0 or lastPlayerLumber > 0 then
        return true
    end
end

function antiCheatWhoIsYourDaddyControl()
    UnitDamageTargetBJ(udg_AntiCheat_WhosYourDaddyAlly, udg_AntiCheat_WhosYourDaddyEnemy, 2, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
    if IsUnitAliveBJ(udg_AntiCheat_WhosYourDaddyEnemy) == false then
        return true
    end
end

function antiCheatDetected()
    print("Cheat detected, save function is disabled")
    udg_AntiCheat_IsActive = false
    udg_save_enabled = false
end