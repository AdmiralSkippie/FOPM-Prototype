------------------------------------------
----- //// TOLISS FO / PM PROTO //// -----
------------------------------------------

-- RANDOMIZER --
math.randomseed(os.clock())

-- CONFIG LOAD --
dofile(SCRIPT_DIRECTORY .. "/FO PM/FO Config.lua")

-- DATAREFS LOAD --
dofile(SCRIPT_DIRECTORY .. "/FO PM/Datarefs Reading.lua")

----------------
---- PHASES ----
----------------
local PREFLIGHT = false
local PUSHBACK = false
local ENG_START = false
local TAXI_OUT = false
local ON_RWY = false
local TAKEOFF = false
local CLIMB = false
local CRUISE = false
local DESCEND = false
local APPROACH = false
local DECEL = false
local GO_ARROUND = false
local TAXI_OUT = false
local PARKING = false

-----------------------------
---- PROCEDURES/CL COMPLETE ----
-----------------------------

local PF_DONE = false
local BS_DTL = false
local BS_CL = false
local AS_PROC_DONE = false
local AS_CL = false
local BTO_PROC_DONE = false
local BTO_DTL = false
local BTO_CL = false
local ATO_CL = false
local CLB_CL = false
local DES_BREAFING_DONE = false
local APP_CL = false
local LND_CL = false
local AL_CL = false
local PARK_CL = false
local SEC_CL = false
local FLTCTL_CHK = false
local ENT_RWY_DONE = false
local EXIT_RWY_DONE = false

----------------------------
---- ONGOING PROCEDURES ----
----------------------------

local EXECUTING_PCP = false
local EXECUTING_ASP = false
local EXECUTING_BTP = false
local ONEENG_TAXI_DEP = false
local EXECUTING_ENRWY = false
local EXECUTING_EXRWY = false

-------------------
---- VARIABLES ----
-------------------

local DELAY = 0
local DELAY_CHECK = 0
local STEP = 0
local STEP_FLT = 0
local PT_TO_DIRECTION = 0
local PT_TO_ANGLE = 0
local PT_TO_CONFIG = 0
local RAINING = false
local PACKS_FOR_TO = false

---------------------
---- FLAPS TO VOICE CHECK ----
---------------------

local FLAP_VOICE_DIR = {"P0", "P1", "P2", "P3", "FULL"}
local CONFIG_VOICE_SRCH = "P1"
local FL_VOICE_SRCH = "P0"

function flaps_voice_search()
    local index = math.floor((FLAPS_LEVER_State * 4) + 1)
    FL_VOICE_SRCH = FLAP_VOICE_DIR[index]
    CONFIG_VOICE_SRCH = FLAP_VOICE_DIR[index]
end

do_every_frame(flaps_voice_search())

----------------------
----- PROCEDURES -----
----------------------

---- Flight Controls Check ----
function flt_ctl_chk()
    if STEP_FLT == 0 then
        if TIME >= DELAY then
            play_sound(FLIGHT_CONTROLS_CHECK)
            DELAY = TIME + 1.814
            STEP_FLT = 1
        else
            return
        end
    end
    if STEP_FLT == 1 then
        if TIME >= DELAY then
            play_sound(ELEVATOR)
            STEP_FLT = 1.25
        else
            return
        end
    end
    if STEP_FLT == 1.25 then
        if ELEVATORS == -30 then
            play_sound(FULL_UP)
            STEP_FLT = 1.5
        else
            return
        end
    end
    if STEP_FLT == 1.5 then
        if ELEVATORS == 15 then
            play_sound(FULL_DOWN)
            STEP_FLT = 1.75
        else
            return
        end
    end
    if STEP_FLT == 1.75 then
        if ELEVATORS == 0 then
            play_sound(NEUTRAL)
            DELAY = TIME + 0.955
            STEP_FLT = 2
        else
            return
        end
    end
    if STEP_FLT == 2 then
        if TIME >= DELAY then
            play_sound(AILERONS)
            DELAY = TIME + 1.107
            STEP_FLT = 2.25
        else
            return
        end
    end
    if STEP_FLT == 2.25 then
        if LALERONS == -25 and RALERONS == 25 then
            play_sound(FULL_LEFT)
            STEP_FLT = 2.5
        else
            return
        end
    end
    if STEP_FLT == 2.5 then
        if LALERONS == 25 and RALERONS == -25 then
            play_sound(FULL_RIGHT)
            STEP_FLT = 2.75
        else
            return
        end
    end
    if STEP_FLT == 2.75 then
        if LALERONS == 0 and RALERONS == 0 then
            play_sound(NEUTRAL)
            DELAY = TIME + 0.955
            STEP_FLT = 3
        else
            return
        end
    end
    if STEP_FLT == 3 then
        if TIME >= DELAY then
            play_sound(RUDDER)
            DELAY = TIME + 1
            STEP_FLT = 3.25
        else
            return
        end
    end
    if STEP_FLT == 3.25 then
        if RUDDER == -25 then
            play_sound(FULL_LEFT)
            STEP_FLT = 3.5
        else
            return
        end
    end
    if STEP_FLT == 3.5 then
        if RUDDER == 25 then
            play_sound(FULL_RIGHT)
            STEP_FLT = 3.75
        else
            return
        end
    end
    if STEP_FLT == 3.75 then
        if RUDDER == 0 then
            play_sound(NEUTRAL)
            DELAY = TIME + 0.955
            STEP_FLT = 4
        else
            return
        end
    end
    if STEP_FLT == 4 then
        if TIME >= DELAY then
            FLTCTL_CHK = true
            STEP_FLT = 0
        else
            return
        end
    end
end

---- PRELIMINARY COCKPIT PREPARATION ----
function pre_cockpit_pre()
    if not PF_DONE then
        if STEP == 0 then
            DELAY = TIME + 0.25
            STEP = 1
        end
        if STEP == 1 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(ENGINE_MASTERS)
                end
                DELAY = TIME + 1.750
                STEP = 1.5
            else
                return
            end
        end
        if STEP == 1.5 then
            if TIME >= DELAY then
                if ENG_1_Master_State == 0 and ENG_2_Master_State == 0 then
                    if not speak_only_essencials then
                        play_sound(OFF)
                    end
                    DELAY = TIME + 1
                    STEP = 2
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(ENGINE_MASTERS)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 2 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(ENGINE_MODE_SELECTOR)
                end
                DELAY = TIME + 2
                DELAY_CHECK = 0
                STEP = 2.5
            else
                return
            end
        end
        if STEP == 2.5 then
            if TIME >= DELAY then
                if ENG_Mode_State == 1 then
                    if not speak_only_essencials then
                        play_sound(NORMAL)
                    end
                    DELAY = TIME + 1
                    STEP = 3
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(ENGINE_MODE_SELECTOR)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 3 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(WEATHER_RADAR)
                end
                DELAY = TIME + 1.25
                DELAY_CHECK = 0
                STEP = 3.5
            else
                return
            end
        end
        if STEP == 3.5 then
            if TIME >= DELAY then
                if RADAR_SYS_SW_State == 1 then
                    if not speak_only_essencials then
                        play_sound(OFF)
                    end
                    DELAY = TIME + 1
                    STEP = 4
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(WEATHER_RADAR)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 4 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(LANDING_GEAR)
                end
                DELAY = TIME + 0.95
                DELAY_CHECK = 0
                STEP = 4.5
            else
                return
            end
        end
        if STEP == 4.5 then
            if TIME >= DELAY then
                if LG_Lever_State == 1 then
                    if not speak_only_essencials then
                        play_sound(DOWN)
                    end
                    DELAY = TIME + 0.95
                    STEP = 5
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(LANDING_GEAR)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 5 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(WIPERS)
                end
                DELAY = TIME + 1.25
                DELAY_CHECK = 0
                STEP = 5.5
            else
                return
            end
        end
        if STEP == 5.5 then
            if TIME >= DELAY then
                if LWipers_State == 0 and RWipers_State == 0 then
                    if not speak_only_essencials then
                        play_sound(OFF)
                    end
                    DELAY = TIME + 0.82
                    STEP = 6
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(WIPERS)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 6 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(BATTERIES)
                end
                DELAY = TIME + 1.062
                DELAY_CHECK = 0
                STEP = 6.5
            else
                return
            end
        end
        if STEP == 6.5 then
            if TIME >= DELAY then
                if BAT_1_State == 1 and BAT_2_State == 1 then
                    if not speak_only_essencials then
                        play_sound(ON)
                    end
                    DELAY = TIME + 0.870
                    STEP = 7
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(BATTERIES)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 7 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(EXTERNAL_POWER)
                end
                DELAY = TIME + 1.486
                DELAY_CHECK = 0
                STEP = 7.5
            else
                return
            end
        end
        if STEP == 7.5 then
            if TIME >= DELAY then
                if EXTPWR_State == 1 then
                    if not speak_only_essencials then
                        play_sound(ON)
                    end
                    DELAY = TIME + 0.870
                    STEP = 8
                else
                    -- possible future change --
                    if TIME >= DELAY_CHECK then
                        play_sound(EXTERNAL_POWER)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
                if STEP == 8 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(ECAM_RCLL)
                end
                DELAY = TIME + 1.5
                STEP = 8.3
            else
                return
            end
        end
        if STEP == 8.3 then
            if TIME >= DELAY then
                command_once(ECAM_Recall_PB)
                DELAY = TIME + 0.25
                STEP = 8.6
            else
                return
            end
        end
        if STEP == 8.6 then
            if TIME >= DELAY then
                if string.find(ECAM_MSG_A, "NORMAL") then
                    if not speak_only_essencials then
                        play_sound(NORMAL)
                    end
                    DELAY = TIME + 1.129
                    STEP = 9
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 9 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(SYSTEMS_CHECK)
                end
                DELAY = TIME + 1.244
                STEP = 9.2
            else
                return
            end
        end
        if STEP == 9.2 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(OXYGEN)
                end
                command_once(ECAM_DOOR_PB)
                DELAY = TIME + 1.213
                STEP = 9.21
            else
                return
            end
        end
        if STEP == 9.21 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(CHECK)
                end
                DELAY = TIME + 0.839
                STEP = 9.4
            else
                return
            end
        end
        if STEP == 9.4 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(HYDRAULICS)
                end
                command_once(ECAM_HYD_PB)
                DELAY = TIME + 1.424
                STEP = 9.41
            else
                return
            end
        end
        if STEP == 9.41 then
            if TIME >= DELAY then
                if Y_HYD_RESVR >= 0.8 and G_HYD_RESVR >= 0.8 and B_HYD_RESVR >= 0.75 then
                    if not speak_only_essencials then
                        play_sound(CHECK)
                    end
                    DELAY = TIME + 0.839
                    STEP = 9.6
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 9.6 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(OIL_QUANTITY)
                end
                command_once(ECAM_ENG_PB)
                DELAY = TIME + 1.411
                STEP = 9.61
            else
                return
            end
        end
        if STEP == 9.61 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                        play_sound(CHECK)
                end
                command_once(ECAM_ENG_PB)
                DELAY = TIME + 0.839
                STEP = 10
            else
                return
            end
        end
        if STEP == 10 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(FLAPS)
                end
                DELAY = TIME + 1.12
                DELAY_CHECK = 0
                STEP = 10.5
            else
                return
            end
        end
        if STEP == 10.5 then
            if TIME >= DELAY then
                if FLAPS_LEVER_State <= 0.25 then
                    if not speak_only_essencials then
                        play_sound(FLAP_POS[FL_VOICE_SRCH])
                    end
                    DELAY = TIME + 1.3
                    STEP = 11
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(FLAPS)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 11 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(SPEED_BRAKE)
                end
                DELAY = TIME + 1.263
                DELAY_CHECK = 0
                STEP = 11.5
            else
                return
            end
        end
        if STEP == 11.5 then
            if TIME >= DELAY then
                if SPDBRK_Lever == 0 then
                    if not speak_only_essencials then
                        play_sound(RETRACT_AND_DISARM)
                    end
                    DELAY = TIME + 1.728
                    STEP = 12
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(SPEED_BRAKE)
                        DELAY_CHECK = TIME + 10
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 12 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(PARKING_BRAKE)
                end
                DELAY = TIME + 1.213
                STEP = 12.5
            else
                return
            end
        end
        if STEP == 12.5 then
            if TIME >= DELAY then
                if PRKBRK_State == 1 then
                    if not speak_only_essencials then
                        play_sound(ON)
                    end
                    DELAY = TIME + 0.920
                    STEP = 13
                else
                    PRKBRK_SW = 1
                    DELAY = TIME + 0.25
                    return
                end
            else
                return
            end
        end
        if STEP == 13 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(BRAKE_ACCUMULATOR)
                end
                DELAY = TIME + 1.623
                STEP = 13.5
            else
                return
            end
        end
        if STEP == 13.5 then
            if TIME >= DELAY then
                if BRK_ACCU_Press >= 0.93 then
                    if not speak_only_essencials then
                        play_sound(CHECK)
                    end
                    DELAY = TIME + 0.839
                    STEP = 14
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 14 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(ALTERNATE_BRAKES)
                end
                DELAY = TIME + 1.459
                STEP = 14.5
            else
                return
            end
        end
        if STEP == 14.5 then
            if TIME >= DELAY then
                if LBRAKE_Press == 0.7 and RBRAKE_Press == 0.7 then
                    if not speak_only_essencials then
                        play_sound(CHECK)
                    end
                    DELAY = TIME + 0.9
                    STEP = 15
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 15 then
            if TIME >= DELAY then
                local rindex = math.random(5)
                play_sound(READY[rindex])
                DELAY = TIME + 3
                STEP = 0
                PF_DONE = true
            end
        end
    else
        local rindex = math.random(5)
        play_sound(READY[rindex])
        DELAY = TIME + 3
    end
end

---- AFTER START PROCEDURES ----
function after_start_proc()
    if not AS_PROC_DONE then
        if EXECUTING_ASP then
            if STEP == 0 then
                STEP = 1
                DELAY = TIME + 1
            end
            if STEP == 1 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(GROUND_SPOILERS)
                    end
                    DELAY = TIME + 1.614
                    STEP = 1.5
                else
                    return
                end
            end
            if STEP == 1.5 then
                if TIME >= DELAY then
                    SPDBRK_Lever = -0.5
                    if not speak_only_essencials then
                        play_sound(ARM)
                    end
                    DELAY = TIME + 1
                    STEP = 2
                else
                    return
                end
            end
            if STEP == 2 then
                if  TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(RUDDER_TRIM)
                    end
                    DELAY = TIME + 1.009
                    STEP = 2.5
                else
                    return
                end
            end
            if STEP == 2.5 then
                if TIME >= DELAY then
                    command_once(RUDDER_TRIM_RESET)
                    if not speak_only_essencials then
                        play_sound(N0)
                    end
                    DELAY = TIME + 1.116
                    STEP = 3
                else
                    return
                end
            end
            if STEP == 3 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(FLAPS)
                    end
                    DELAY = 1.112
                    STEP = 3.5
                else
                    return
                end
            end
            if STEP == 3.5 then
                if TIME >= DELAY then
                    if FLAPS_LEVER_State == FLAPS_TO_CONFIG then
                        if not speak_only_essencials then
                            play_sound(FLAP_CONFIG[CONFIG_VOICE_SRCH])
                        end
                        DELAY = 1.488
                        STEP = 4
                    else
                        command_once(FLAPS_1UP)
                        DELAY = 0.8
                        return
                    end
                else
                    return
                end
            end
            if STEP == 4 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(PITCH_TRIM)
                    end
                    command_once(MCDU_FO_KEY_Perf)
                    DELAY = TIME + 0.3
                    STEP = 4.3
                else
                    return
                end
            end
            if STEP == 4.3 then
                if TIME >= DELAY then
                    PT_TO_DIRECTION = string.match(MCDU_BLINE_3, "([UPDN]+)")
                    PT_TO_ANGLE = string.match(MCDU_BLINE_3, "/.-[UPDN]+(%d+%.%d+)")
                    if PT_TO_DIRECTION == "UP" then
                        PT_TO_CONFIG = PT_TO_ANGLE * 1
                    elseif PT_TO_DIRECTION == "DN" then
                        PT_TO_CONFIG = PT_TO_ANGLE * -1
                    end
                    DELAY = TIME + 1.093
                    STEP = 4.6
                end
            end
            if STEP == 4.6 then
                if TIME >= DELAY then
                    if PT_TO_CONFIG == PITCH_TRIM then
                        if not speak_only_essencials then
                            play_sound(SET)
                        end
                        DELAY = TIME + 1
                        STEP = 5
                    else
                        if PT_TO_CONFIG < 0 then
                            command_once(PITCH_TRIM_DN)
                            return
                        elseif PT_TO_CONFIG > 0 then
                            command_once(PITCH_TRIM_UP)
                            return
                        end
                    end
                else
                    return
                end
            end
            if not ONEENG_TAXI_DEP then
                if STEP == 5 then
                    if TIME >= DELAY then
                        if not speak_only_essencials then
                            play_sound(ECAM_STATUS)
                        end
                        DELAY = TIME + 1.522
                        STEP = 5.5
                    else
                        return
                    end
                end
                if STEP == 5.5 then
                    if TIME >= DELAY then
                        if not speak_only_essencials then
                            play_sound(CHECK)
                        end
                        DELAY = TIME + 0.839
                        STEP = 6
                    else
                        return
                    end
                end
            else
                STEP = 6
            end
            if STEP == 6 then
                if TIME >= DELAY then
                    if FLAPS_State ~= -1 then
                        return
                    else
                        if speak_only_essencials then
                            play_sound(FLAP_CONFIG[CONFIG_VOICE_SRCH])
                        end
                        DELAY = TIME + 1.5
                        STEP = 7
                    end
                else
                    return
                end
            end
            if not ONEENG_TAXI_DEP then
                if STEP == 7 then
                    if TIME >= DELAY then
                        if not FLTCTL_CHK then
                            flt_ctl_chk()
                        else
                            STEP = 8
                            DELAY = TIME + 1
                        end
                    else
                        return
                    end
                end
            else
                STEP = 8
            end
            if STEP == 8 then
                if TIME >= DELAY then
                    local rindex = math.random(5)
                    play_sound(READY[rindex])
                    DELAY = TIME + 3
                    STEP = 0
                    AS_PROC_DONE = true
                    EXECUTING_ASP = false
                else
                    return
                end
            end
        end
    else
        local rindex = math.random(5)
        play_sound(READY[rindex])
        DELAY = TIME + 3
        EXECUTING_ASP = false
    end
end

function before_takeoff_proc()
    if not BTO_PROC_DONE then
        if EXECUTING_BTP then
             if STEP == 0 then
                STEP = 1
                DELAY = TIME + 0.5
             end
             if STEP == 1 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(WEATHER_RADAR)
                    end
                    STEP = 1.5
                    DELAY = TIME + 1.209
                else
                    return
                end
            end
            if STEP == 1.5 then
                if TIME >= DELAY then
                    local radar = {0,2}
                    local radar_pos = math.random(#radar)
                    Radar_SYS_SW = radar_pos
                    if not speak_only_essencials then
                        play_sound(ON)
                    end
                    DELAY = TIME + 0.950
                    STEP = 2
                else
                    return
                end
            end
            if STEP == 2 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(PWS)
                    end
                    DELAY = TIME + 1.286
                    STEP = 2.5
                else
                    return
                end
            end
            if STEP == 2.5 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(ON)
                    end
                    PWS_SW = 2
                    DELAY = TIME + 0.950
                    STEP = 3
                else
                    return
                end
            end
            if STEP == 3 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(TERRAIN)
                    end
                    DELAY = TIME + 1.025
                    STEP = 3.5
                else
                    return
                end
            end
            if STEP == 3.5 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(ON)
                    end
                    command_once(TERRAIN_FO_PB)
                    DELAY = TIME + 0.905
                    STEP = 4
                else
                    return
                end
            end
            if STEP == 4 then
                if TIEM >= DELAY then
                    if not speak_only_essencials then
                        play_sound(BRAKE_TEMP)
                    end
                    DELAY = TIME + 1.204
                    STEP = 4.5
                else
                    return
                end
            end
            if STEP == 4.5 then
                if TIME >= DELAY then
                    if BRAKE1_TEMP < 150 and BRAKE2_TEMP < 150 and BRAKE3_TEMP < 150 and BRAKE4_TEMP < 150 then
                        if BRKFAN_State == 1 then
                            command_once(BRKFAN_PB)
                        end
                        if not speak_only_essencials then
                            play_sound(CHECK)
                        end
                        DELAY = TIME + 0.839
                        STEP = 5
                    else
                        local rindex = math.random(3)
                        play_sound(BRAKE_WARNINGS[rindex])
                        DELAY = TIME + 5
                        STEP = 4.6
                    end
                else
                    return
                end
            end
            if STEP == 4.6 then
                if TIME >= DELAY then
                    if BRAKE1_TEMP < 150 and BRAKE2_TEMP < 150 and BRAKE3_TEMP < 150 and BRAKE4_TEMP < 150 then
                        local rindex = math.random(5)
                        play_sound(READY[rindex])
                        DELAY = TIME + 2
                        STEP = 4.7
                    else
                        return
                    end
                else
                    return
                end
            end
            if STEP == 4.7 then
                if TIME >= DELAY then
                    play_sound(BRAKE_TEMP)
                    DELAY = TIME + 1.204
                    STEP = 4.8
                else
                    return
                end
            end
            if STEP == 4.8 then
                if TIME >= DELAY then
                    play_sound(CHECK)
                    if BRKFAN_State == 1 then
                        command_once(BRKFAN_PB)
                    end
                    DELAY = TIME + 0.839
                    STEP = 5
                else
                    return
                end
            end
            if STEP == 5 then
                if TIME >= DELAY then
                    local rindex = math.random(5)
                    play_sound(READY[rindex])
                    DELAY = TIME + 2
                    STEP = 0
                    EXECUTING_BTP = false
                    BTO_PROC_DONE = true
                else
                    return
                end
            end
        end
    else
        local rindex = math.random(5)
        play_sound(READY[rindex])
        EXECUTING_BTP = false
    end
end

---- ENTER RWY ----
function enter_rwy()
    if ON_RWY then
        if not ENT_RWY_DONE then
            if STEP == 0 then
                if TIME >= DELAY then
                    DELAY = TIME + 1
                    STEP = 1
                else
                    return
                end
            end
            if STEP == 1 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(EXTERIOR_LIGHTS)
                    end
                    DELAY = TIME + 1.740
                    STEP = 1.2
                else
                    return
                end
            end
            if STEP == 1.2 then
                if TIME >= DELAY then
                    STROBE_SW = 2
                    DELAY = TIME + 0.3
                    STEP = 1.3
                else
                    return
                end
            end
            if STEP == 1.3 then
                if TIME >= DELAY then
                    LANDLT_L_SW = 2
                    LANDLT_R_SW = 2
                    DELAY = TIME + 0.3
                    STEP = 1.4
                else
                    return
                end
            end
            if STEP == 1.4 then
                if TIME >= DELAY then
                    TAXILT_SW = 2
                    DELAY = TIME + 1.3
                    STEP = 1.5
                else
                    return
                end
            end
            if STEP == 1.5 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(SET)
                    end
                    DELAY = TIME + 1
                    STEP = 2
                else
                    return
                end
            end
            if STEP == 2 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(TCAS)
                    end
                    DELAY = TIME + 1.218
                    STEP = 2.5
                else
                    return
                end
            end
            if STEP == 2.5 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(TA_RA)
                    end
                    TCAS_SW = 4
                    DELAY = TIME + 1.792
                    STEP = 3
                else
                    return
                end
            end
            if STEP == 3 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(ENGINE_MODE_SELECTOR)
                    end
                    DELAY = TIME + 1.865
                    STEP = 3.5
                else
                    return
                end
            end
            if STEP == 3.5 then
                if TIME >= DELAY then
                    if RAINING and ENG_MODEL ~= 1 then
                        play_sound(IGNITION)
                        ENG_MODE = 2
                        DELAY = 1.095
                        STEP = 4
                    else
                        if not speak_only_essencials then
                            play_sound(NORMAL)
                        end
                        ENG_MODE = 1
                        DELAY = 1.129
                        STEP = 4
                    end
                else
                    return
                end
            end
            if STEP == 4 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(PACKS)
                    end
                    DELAY = TIME + 1
                    STEP = 4.5
                else
                    return
                end
            end
            if STEP == 4.5 then
                if TIME >= DELAY then
                    if not PACKS_FOR_TO then
                        command_once(PACK_1_PB)
                        DELAY = TIME + 0.3
                        STEP = 4.6
                    else
                        if not speak_only_essencials then
                            play_sound(ON)
                        end
                        DELAY = TIME + 0.920
                        STEP = 5
                    end
                else
                    return
                end
            end
            if STEP == 4.6 then
                if TIME >= DELAY then
                    command_once(PACK_2_PB)
                    DELAY = TIME + 0.3
                    STEP = 4.7
                else
                    return
                end
            end
            if STEP == 4.7 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(OFF)
                    end
                    DELAY = TIME + 0.920
                    STEP = 5
                end
            end
            if STEP == 5 then
                if TIME >= DELAY then
                    local rindex = math.random(5)
                    play_sound(READY[rindex])
                    DELAY = TIME + 2
                    STEP = 0
                    EXECUTING_ENRWY = false
                    ENT_RWY_DONE = true
                else
                    return
                end
            end
        else
            EXECUTING_ENRWY = false
        end
    end
end