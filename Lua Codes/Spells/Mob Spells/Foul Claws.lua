function mobSpellFoulClawsPassive()
    if 5 >= GetRandomReal(0, 100) then
        UnitDamageTargetBJ(GetAttacker(), GetTriggerUnit(), 60 * udg_AdjustmentCombat_Ratio, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
        createSpecialEffectOnUnit(GetTriggerUnit(), "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodPeasant.mdl ")
    end
end