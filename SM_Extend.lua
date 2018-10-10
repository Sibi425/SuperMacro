---------------------------- General stuff ---------------------------------------
function hallo()
    critChance = GetCritChance() 
    Print(critChance)
end

function CheckDebuffs()
    for i=1,2 do 
        D=UnitDebuff("target",i); 
        if D 
        then 
            Print(i.."="..D) 
        end 
    end 
end

function AutoAttack()
    if not IsAutoRepeatAction(72)
    then 
        CastSpellByName("Auto Shot"); 
    end
end

function AutoAttackMelee()
    if not IsAutoRepeatAction(72)
    then 
        CastSpellByName("d")
    end
end



function reportActionButtons()
    lActionSlot = 0;
    for lActionSlot = 1, 120 
    do
        lActionText = GetActionText(lActionSlot);
        lActionTexture = GetActionTexture(lActionSlot);
        if lActionTexture 
        then
            lMessage = "Slot " .. lActionSlot .. ": [" .. lActionTexture .. "]";
            if lActionText 
            then
                    lMessage = lMessage .. " \"" .. lActionText .. "\"";
            end
                DEFAULT_CHAT_FRAME:AddMessage(lMessage);
        end
    end
end

-------------------------General stuff END ------------------------------------------

--------------------------- Rogue specified stuff --------------------------------------

function AllinOneRogue()
    if GetComboPoints() < 5
    then
        cast("Sinister Strike")
    else 
        cast("Eviscerate")
    end

end

------------------------------Rogue specified stuff END-----------------------------------

---------------------------------Paladin specified stuff -------------------
function AllinOnePaladin()
    if not buffed("Blessing of Might") and UnitMana("player")>200
    then
        cast("Blessing of Might")
    elseif not buffed("Blessing of Wisdom") and UnitMana("player")<200
    then
        cast("Blessing of Wisdom")
    end

    if not buffed("Seal of the Crusader") and not buffed("Judgement of the Crusader", "target")
    then
        cast("Seal of the Crusader")
    elseif not buffed("Judgement of the Crusader", "target")
    then 
        cast("Judgement")
    elseif not buffed("Seal of Righteousness")
    then
        cast("Seal of Righteousness")
    elseif buffed("Seal of Righteousness")
    then
        cast("Judgement")
    end
end

-------------------------------Paladin specified stuff END --------------------------------------

--------------------------- Hunter specified stuff ------------------------------------------
function AllinOneHunter()
    class = UnitClass("target")
    UIErrorsFrame:Hide()
        if (not PlayerFrame.inCombat)
        then
            if GetUnitName("target")==nil
            then
                cast("Aspect of the Pack")
            end

            if UnitIsFriend("player", "target")
            then
                cast("Aspect of the Pack")
            elseif UnitIsEnemy("player", "target")
            then
                HunterRota()
            end

        elseif PlayerFrame.inCombat
        then
                HunterRota()
            
        else
            cast("Aspect of the Cheetah")
            Print(UnitIsFriend("player", "target"))
            Print(not PlayerFrame.inCombat)
        end
        UIErrorsFrame:Show()
end

function HunterRota()
    if not buffed("Aspect of the Hawk")
    then
        cast("Aspect of the Hawk")
    end
    
    if not buffed("Hunter's Mark", "target") 
    then
        cast("Hunter's Mark") 
    end

    if not buffed("Serpent Sting", "target") and (not buffed("Viper Sting", "target"))
    then
        if ((class == "Mage") or (class == "Priest")) or (class=="Warlock") 
        then
            cast("Viper Sting"); 
        else 
            cast("Serpent Sting")
        end
    elseif UnitMana("player") > 500
    then
        CastSpellByName("Bestial Wrath")
    end
    if UnitMana("player") > 225
    then
        ArcaneShot()
    end
    AutoAttack()
end 

function ArcaneShot()
    if GetActionCooldown(70) == 0
    then
        Print("Cast AS")
        cast("Arcane Shot")
    end
end

--------------------------- Hunter specified stuff END ------------------------------------------