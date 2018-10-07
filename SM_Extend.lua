---------------------------- General Stuff ---------------------------------------

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

-------------------------General Stuff END ------------------------------------------

--------------------------- Hunter Specified Stuff ------------------------------------------
function AllinOne()
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

--------------------------- Hunter Specified Stuff END ------------------------------------------