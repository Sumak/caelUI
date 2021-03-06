local Timers = unpack(select(2, ...)).GetModule("ClassTimers")

local CreateBars

do
    local function CreateBuffItem (spellId, playerOnly, unit, autoColor)
        return {spellId = spellId, unit = unit and unit or "player", playerOnly = playerOnly, autoColor = autoColor, buffType = "buff"}
    end

    local function CreateDebuffItem (spellId, playerOnly, unit, autoColor)
        return {spellId = spellId, unit = unit and unit or "target", playerOnly = playerOnly, autoColor = autoColor, buffType = "debuff"}
    end

    function CreateBars(PlayerClass)
        --[[
        local lists = {
            ["target"] = {
                ["armor"] = {
                    CreateDebuffItem(58567), -- Sunder Armor
                    CreateDebuffItem(8647),  -- Expose Armor
                    CreateDebuffItem(91565), -- Faerie Fire
                    CreateDebuffItem(35387), -- Corrosive Spit
                    CreateDebuffItem(50498)  -- Tear Armor
                },
                ["bleed"] = {
                    CreateDebuffItem(29859), -- Blood Frenzy (second?)

                    CreateDebuffItem(29836), -- Blood Frenzy
                    CreateDebuffItem(35290), -- Gore
                    CreateDebuffItem(57386), -- Stampede
                    CreateDebuffItem(50271), -- Tendon Rip
                    CreateDebuffItem(16511), -- Hemorrhage
                    CreateDebuffItem(33876), -- Mangle
                    CreateDebuffItem(46857), -- Trauma
                }
            }
        }
        --]]

        if PlayerClass == "WARRIOR" then
            Timers:CreateList({
                ["player"] = {
                    -- Shouts
                    CreateBuffItem(469),   -- Commanding Shout
                    CreateBuffItem(6673),  -- Battle Shout

                    -- Common
                    CreateBuffItem(97462), -- Rallying Cry
                    CreateBuffItem(12317), -- Enrage
                    CreateBuffItem(55694), -- Enraged Regeneration

                    CreateBuffItem(871),   -- Shield Wall

                    -- Protection
                    CreateBuffItem(87096), -- Thunderstruck
                    CreateBuffItem(2565),  -- Shield Block
                    CreateBuffItem(12976), -- Last Stand
                    CreateBuffItem(50720, true, "focus"),  -- Vigilance
                },
                ["target"] = {
                    CreateBuffItem(50720, true, "target"), -- Vigilance

                    CreateDebuffItem(1160),  -- Demoralizing Shout
                    CreateDebuffItem(52744), -- Piercing Howl
                    CreateDebuffItem(1715),  -- Hamstring
                    CreateDebuffItem(6343),  -- Thunder Clap
                    CreateDebuffItem(12294), -- Mortal Strike

                    CreateDebuffItem(86346, true), -- Colossus Smash
                    CreateDebuffItem(12834, true), -- Deep Wounds
                    CreateDebuffItem(94009, true), -- Rend


                    -- Shared targets.

                    -- Armor
                    CreateDebuffItem(58567), -- Sunder Armor
                    CreateDebuffItem(8647),  -- Expose Armor
                    CreateDebuffItem(91565), -- Faerie Fire
                    CreateDebuffItem(35387), -- Corrosive Spit
                    CreateDebuffItem(50498), -- Tear Armor

                    -- Bleed
                    CreateDebuffItem(29836), -- Blood Frenzy
                    CreateDebuffItem(35290), -- Gore
                    CreateDebuffItem(57386), -- Stampede
                    CreateDebuffItem(50271), -- Tendon Rip
                    CreateDebuffItem(16511), -- Hemorrhage
                    CreateDebuffItem(33876), -- Mangle
                    CreateDebuffItem(46857), -- Trauma
                },
            })

        elseif PlayerClass == "ROGUE" then
            Timers:CreateList({
                ["player"] = {
                    CreateBuffItem(32645), -- Envenom
                    CreateBuffItem(2983),  -- Sprint
                    CreateBuffItem(5277),  -- Evasion
                    CreateBuffItem(1776),  -- Gouge
                    CreateBuffItem(51713), -- Shadow Dance
                    CreateBuffItem(1966),  -- Feint
                    CreateBuffItem(73651), -- Recuperate
                    CreateBuffItem(5171),  -- Slice and Dice
                    CreateBuffItem(13877), -- Blade Flurry
                    CreateBuffItem(58426), CreateBuffItem(58427), -- Overkill
                    CreateBuffItem(74001), -- Combat Readiness
                    CreateBuffItem(13750), -- Adrenaline Rush
                    CreateBuffItem(51690), -- Killing Spree

                    CreateBuffItem(49016), -- Unholy Frenzy (Comes from DK and is only a temporary placement)

                    -- Procs
                    CreateBuffItem(71396), -- Rage of the Fallen
                    CreateBuffItem(84747), -- Deep Insight

                    -- Tricks of the Trade
                    -- CreateBuffItem(57934), -- Tricks has been triggered (Preparation of usage)
                    -- CreateBuffItem(59628), -- Tricks is transferring threat to the target (Tricks is active)
                    -- CreateBuffItem(57933), -- Buff on the target (This is the id for the other player having the damage bonus)

                    -- T12 2p rogue tricks bonus
                    CreateBuffItem(105864), -- Tricks of Time: Your abilities cost 20% less energy for 6 sec after triggering Tricks of the Trade.
                },
                ["target"] = {
                    CreateDebuffItem(1943, true),  -- Rupture
                    CreateDebuffItem(16511, true), -- Hemorrhage
                    CreateDebuffItem(79140, true), -- Vendetta
                    CreateDebuffItem(84617, true), -- Revealing Strike

                    -- Crowd Control
                    CreateDebuffItem(1833),  -- Cheap Shot
                    CreateDebuffItem(408),   -- Kidney Shot
                    CreateDebuffItem(1776),  -- Gouge
                    CreateDebuffItem(2094),  -- Blind
                    CreateDebuffItem(51722), -- Dismantle
                    CreateDebuffItem(6770),  -- Sap
                    CreateDebuffItem(703),   -- Garrote

                    -- Poisons
                    CreateDebuffItem(2818, true),  -- Deadly
                    CreateDebuffItem(13218, true), -- Wound
                    CreateDebuffItem(3409, true),  -- Crippling
                    CreateDebuffItem(5760, true),  -- Mind-Numbing


                    -- Shared targets.

                    -- Armor
                    CreateDebuffItem(58567), -- Sunder Armor
                    CreateDebuffItem(8647),  -- Expose Armor
                    CreateDebuffItem(91565), -- Faerie Fire
                    CreateDebuffItem(35387), -- Corrosive Spit
                    CreateDebuffItem(50498),  -- Tear Armor

                    -- Bleed
                    CreateDebuffItem(29836), -- Blood Frenzy
                    CreateDebuffItem(35290), -- Gore
                    CreateDebuffItem(57386), -- Stampede
                    CreateDebuffItem(50271), -- Tendon Rip
                    CreateDebuffItem(16511), -- Hemorrhage
                    CreateDebuffItem(33876), -- Mangle
                    CreateDebuffItem(46857), -- Trauma
                }
            })
        elseif PlayerClass == "PALADIN" then
            Timers:CreateList({
                ["player"] = {
                    CreateBuffItem(20178), -- Reckoning
                    CreateBuffItem(642),   -- Divine Shield
                    CreateBuffItem(31850), -- Ardent Defender
                    CreateBuffItem(498),   -- Divine Protection
                    CreateBuffItem(84963), -- Inquisition
                    CreateBuffItem(31884), -- Avenging Wrath
                    CreateBuffItem(85433), -- Sacred Duty
                    CreateBuffItem(85416), -- Grand Crusader
                    CreateBuffItem(85696), -- Zealotry
                    CreateBuffItem(53657), -- Judgements of the Pure
                    CreateBuffItem(53563, true, "focus"), -- Beacon of Light
                    CreateBuffItem(31821), -- Aura Mastery
                    CreateBuffItem(54428), -- Divine Plea
                    CreateBuffItem(86659), -- Guardian of Ancient Kings (Protection)
                    CreateBuffItem(86669), -- Guardian of Ancient Kings (Holy)
                    CreateBuffItem(86698), -- Guardian of Ancient Kings (Retribution)
                    CreateBuffItem(85510), -- Denounce
                    CreateBuffItem(88063), -- Guarded by the light
                    CreateBuffItem(82327), -- Holy Radiance
                    CreateBuffItem(20925), -- Holy Shield
                    CreateBuffItem(94686), -- Crusade
                    CreateBuffItem(32223, true), -- Crusader Aura

                    -- Procs
                    CreateBuffItem(59578), -- The Art of War
                    CreateBuffItem(90174), -- Hand of Light
                    CreateBuffItem(71396), -- Rage of the Fallen
                    CreateBuffItem(53672), CreateBuffItem(54149), -- Infusion of Light
                    -- CreateBuffItem(85496), -- Speed of Light
                    CreateBuffItem(88819), -- Daybreak
                    CreateBuffItem(20050), CreateBuffItem(20052), CreateBuffItem(20053), -- Conviction
                },
                ["target"] = {
                    CreateDebuffItem(31803), -- Censure
                    CreateDebuffItem(20066), -- Repentance
                    CreateDebuffItem(853),   -- Hammer of Justice
                    CreateDebuffItem(31935), -- Avenger's Shield
                    CreateDebuffItem(20170), -- Seal of Justice
                    CreateDebuffItem(26017), -- Vindication
                    CreateDebuffItem(68055), -- Judgements of the Just
                    CreateDebuffItem(86273), -- Illuminated Healing
                    CreateDebuffItem(1044),  -- Hand of Freedom
                    CreateDebuffItem(1022),  -- Hand of Protection
                    CreateDebuffItem(1038),  -- Hand of Salvation
                    CreateDebuffItem(6940),  -- Hand of Sacrifice
                }
            })
        elseif PlayerClass == "PRIEST" then
            Timers:CreateList({
                ["player"] = {
                    -- CreateBuffItem(),

                    -- Procs
                    CreateBuffItem(77487), -- Shadow Orb
                },
                ["target"] = {
                    CreateDebuffItem(34914), -- Vampiric Touch
                    CreateDebuffItem(2944), -- Devouring Plague
                    CreateDebuffItem(589), -- Shadow Word: Pain
                }
            })
        end
    end
end

Timers:RegisterEvent("PLAYER_LOGIN", function()
    CreateBars(Timers:GetPlayer("class"))
end)