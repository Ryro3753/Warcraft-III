function radiationOfShadowCast()
    local unit = GetTriggerUnit()
    local spell = GetSpellAbilityId()
    local id = GetUnitUserData(unit)
    local level = GetUnitAbilityLevel(unit, spell)

    local damage = 0
    local strengthPercentage = 0
    local agilityPercentage = 0
    local intelligencePercentage = 0
    if level == 1 then
        damage = 25
        strengthPercentage = 0.30
        agilityPercentage = 0.30
        intelligencePercentage = 0.20
    elseif level == 2 then
        damage = 40
        strengthPercentage = 0.31
        agilityPercentage = 0.31
        intelligencePercentage = 0.21
    elseif level == 3 then
        damage = 65
        strengthPercentage = 0.33
        agilityPercentage = 0.33
        intelligencePercentage = 0.23
    elseif level == 4 then
        damage = 90
        strengthPercentage = 0.35
        agilityPercentage = 0.35
        intelligencePercentage = 0.25
    end

    udg_RadiationOfShadow_Damage = damage + (strengthPercentage * udg_Stat_Strength_AC[id]) + (agilityPercentage * udg_Stat_Agility_AC[id]) + (intelligencePercentage * udg_Stat_Intelligence_AC[id])

    local loc = GetUnitLoc(unit)
    local group = GetUnitsInRangeOfLocMatching(350, loc, Condition(radiationOfShadowFilter))

    udg_RadiationOfShadow_Sum[id] = 0

    udg_RadiationOfShadow_Count_Bool[id] = true
    udg_RadiationOfShadow_Caster = unit
    ForGroup(group, radiationOfShadowFor)
    udg_RadiationOfShadow_Count_Bool[id] = false
    udg_RadiationOfShadow_Caster = nil
    
    local absorb = R2I(udg_RadiationOfShadow_Sum[id] * 0.3)

    if absorb > 0 then
        absorbAdd(unit, absorb)

        local text = tostring(absorb) .. " absorb gained"
        local player = GetOwningPlayer(unit)

        ForceAddPlayer(udg_FloatingText_PlayerGroup, player)
        creatingFloatingTextTimed(text, unit, 10, 60, 60, 60)

        text = nil
        player = nil
    end


    DestroyGroup(group)
    group = nil

    setCooldownToAbility(unit,id, spell, level)

    createSpecialEffectOnLocWithDurationAndSize(loc, "Doodads\\Cinematic\\Campaign_Undead05\\SylvanasBirth.mdx", 0.5, 2)

    RemoveLocation(loc)
    loc = nil
    unit = nil
    spell = nil
end


function radiationOfShadowFilter()
    if IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit())) and IsUnitAliveBJ(GetFilterUnit()) and BlzIsUnitInvulnerable(GetFilterUnit()) == false then
        return true
    else
        return false
    end
end

function radiationOfShadowFor()
    local target = GetEnumUnit()

    UnitDamageTargetBJ(udg_RadiationOfShadow_Caster, target, udg_RadiationOfShadow_Damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)

    createSpecialEffectOnUnit(target, "Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl")
    
    target = nil
end


function radiationOfShadowCount(causer, damage)
    local id = GetUnitUserData(causer)
    if udg_RadiationOfShadow_Count_Bool[id] == false then
        return
    end

    udg_RadiationOfShadow_Sum[id] = udg_RadiationOfShadow_Sum[id] + damage
end