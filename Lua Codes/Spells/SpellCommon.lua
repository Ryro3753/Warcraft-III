function spellAttackTrigger(causer, receiver, isBasicAttack, damageAmount)

    --Radiation of Shadow
    radiationOfShadowCount(causer, damageAmount)

    --Basic Attack Functions Below this
    if isBasicAttack == false then
        return
    end

    --Curse Strike
    cursedStrikeAttack(causer, receiver)

    --Thorns
    thornsAttack(causer, receiver)
end


function spellVariablesInit()
    for i=1,25 do
        udg_Renewal_HealGroup[i] = GetUnitsOfPlayerAll(Player(i - 1))
        GroupClear(udg_Renewal_HealGroup[i])
    end
end
