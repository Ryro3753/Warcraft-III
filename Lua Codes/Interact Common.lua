function interactCast()
    local point = GetSpellTargetLoc()

    for i=1,udg_Interact_Limit do
        if (udg_Interact_Repeatable[i] == false and udg_Interact_Executed[i] == true) == false then
            local controlPoint = GetRectCenter(udg_Interact_Region[i])
            if DistanceBetweenPoints(point, controlPoint) < 300 then
                udg_Interact_Executed[i] = true
                udg_Interact_Unit = GetTriggerUnit()
                TriggerExecute(udg_Interact_Trigger[i])
            end
            RemoveLocation(controlPoint)
            controlPoint = nil
        end
    end

    createSpecialEffectOnLocWithDurationAndSize(point, "Objects\\InventoryItems\\QuestionMark\\QuestionMark.mdl", 5, 0.75)

    RemoveLocation(point)
    point = nil
end