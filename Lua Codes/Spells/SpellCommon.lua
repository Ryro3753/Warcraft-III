function spellAttackTrigger(causer, receiver, isBasicAttack, damageAmount)

    --Hearthstone
    hearthstoneDamageControl(receiver)

    --Radiation of Shadow
    radiationOfShadowCount(causer, damageAmount)

    --Deadly Linkage
    deadlyLinkageDamageTaken(receiver)

    --Basic Attack Functions Below this
    if isBasicAttack == false then
        return
    end

    --Curse Strike
    cursedStrikeAttack(causer, receiver)

    --Thorns
    thornsAttack(causer, receiver)

    --Purification
    purificationHit(causer, receiver)

    causer = nil
    receiver = nil
end


function spellVariablesInit(id)
        udg_Renewal_HealGroup[id] = GetUnitsOfPlayerAll(Player(0))
        GroupClear(udg_Renewal_HealGroup[id])

        udg_Thornpoon_DamageGroup[id] = GetUnitsOfPlayerAll(Player(0))
        GroupClear(udg_Thornpoon_DamageGroup[id])
end


function spellVariablesInitWillDeleted()
    for i=1,1000 do
        spellVariablesInit(i)
    end
end