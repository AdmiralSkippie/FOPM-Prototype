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
local DECELERATION = false
local GA = false
local TAXI_IN = false
local PARKING = false

-----------------------------
---- PROCEDURES/CL COMPLETE ----
-----------------------------

local PF_DONE = false
local TO_BREAFING = false
local BS_DTL = false
local BS_CL = false
local AS_PROC_DONE = false
local AS_CL = false
local BTO_PROC_DONE = false
local BTO_DTL = false
local BTO_CL = false
local TO_PROC_DONE = false
local ACF_CLEAN = false
local ATO_CL = false
local TEN_THAUSAND_FEET_CLB_DONE = false
local CLB_CL = false
local DES_BREAFING = false
local TEN_THAUSAND_FEET_DES_DONE = false
local APP_CL = false
local LND_CL = false
local AP_DISCN_PROC = false
local GA_PROC = false
local AL_PROC = false
local AL_CL = false
local RWY_VACATED = false
local PARK_PROC = false
local PARK_CL = false
local SEC_CL = false
local FLTCTL_CHK = false
local ENT_RWY_DONE = false
local EXIT_RWY_DONE = false

-----------------------------
---- APPROACH PROCEDURES ----
-----------------------------

---- Precision Approach ----
local ILS_APP = false
local MLS_APP = false
---- Non Precision Approach ----
local RNAV_APP = false
local RNAV_LNAV = false
local RNPAR_APP = false
local VOR_APP = false
local NDB_APP = false
local LDA_APP = false

----------------------------
---- ONGOING PROCEDURES ----
----------------------------

local EXECUTING_PCP = false
local EXECUTING_ASP = false
local EXECUTING_BTP = false
local ONEENG_TAXI_DEP = false
local EXECUTING_ENRWY = false
local EXECUTING_EXRWY = false

------------------
---- COMMANDS ----
------------------

local command_GUP = false
local command_GDN = false
local command_FLPS_1UP = false
local command_FLPS_1DN = false
local response_CHECK = false

-------------------
---- VARIABLES ----
-------------------

local DELAY = 0
local DELAY_CHECK = 0
local DELAY_CLEAN = 0
local DELAY_SPEACH = 0
local DELAY_AP = 0
local STEP = 0
local STEP_FLT = 0
local STEP_CLEAN = 0
local STEP_SPEACH = 0
local STEP_AP = 0
local STEP_CHECK = 0
local PT_TO_DIRECTION = 0
local PT_TO_ANGLE = 0
local PT_TO_CONFIG = 0
local RAINING = false
local PACKS_FOR_TO = false
local APU_TO_PACKS = false
local FLAP_RETRACT_SPEED = 0
local SLAT_RETRACT_SPEED = 0
local GREENDOT = 0
local CHECK_SPEED = 0
local F_TARGET = 0
local F_ATARGET = 0

-------------------------
---- ENGINE THR MATH ----
-------------------------

local STABLE1_CHECK = 0
local STABLE2_CHECK = 0
local ENG_THR_Rating = 0
local ENG_1_THR = 0
local ENG_2_THR = 0

function engine_math()
    if ENG_MODEL == 1 then
        ENG_THR_Rating = math.floor(ENG_THRRate * 100) / 100
        ENG_1_THR = math.floor(ENG_1_POWER * 100) / 100
        ENG_2_THR = math.floor(ENG_2_POWER * 100) / 100
    else
        ENG_THR_Rating = math.floor(ENG_THRRate * 10) / 10
        ENG_1_THR = math.floor(ENG_1_POWER * 10) / 10
        ENG_2_THR = math.floor(ENG_2_POWER * 10) / 10
    end
end

do_every_frame(engine_math())


---------------------
---- FLAPS TO VOICE CHECK ----
---------------------

local FLAP_VOICE_DIR = {"P0", "P1", "P2", "P3", "FULL"}
local CONFIG_VOICE_SRCH = "P1"
local FL_VOICE_SRCH = "P0"
local FLUP_VOICE_SRCH = "P0"
local lindex = math.floor((FLAPS_LEVER_State * 4) + 1)

function flaps_voice_search()
    local index = math.floor((FLAPS_LEVER_State * 4) + 1)
    FL_VOICE_SRCH = FLAP_VOICE_DIR[index]
    FLUP_VOICE_SRCH = FLAP_VOICE_DIR[(index - 1)]
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
                    FLAP_RETRACT_SPEED = string.match(MCDU_GLINE_1, "(%d+)")
                    SLAT_RETRACT_SPEED = string.match(MCDU_GLINE_2, "(%d+)")
                    GREENDOT = string.match(MCDU_GLINE_3,"(%d+)")
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
                        ENG_Mode = 2
                        DELAY = 1.095
                        STEP = 4
                    else
                        if not speak_only_essencials then
                            play_sound(NORMAL)
                        end
                        ENG_Mode = 1
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

---- TAKE OFF PROCEDURE ----
function take_off_proc()
    if not TO_PROC_DONE then
        if STEP == 0 then
            if TIME >= DELAY then
                if ENG_1_N1 > 50 and ENG_2_N1 > 50 then
                    STABLE1_CHECK = ENG_1_THR
                    STABLE2_CHECK = ENG_2_THR
                    STEP = 1
                    DELAY = TIME + 1
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 1 then
            if TIME >= DELAY then
                if ENG_1_THR == STABLE2_CHECK and ENG_2_THR == STABLE1_CHECK then
                    play_sound(STABLE)
                    DELAY = TIME + 1
                    STEP = 2
                else
                    STABLE1_CHECK = ENG_1_THR
                    STABLE2_CHECK = ENG_2_THR
                    DELAY = TIME + 0.8
                    return
                end
            else
                return
            end
        end
        if STEP == 2 then
            if TIME >= DELAY then
                if ENG_1_THR == ENG_THR_Rating and ENG_2_THR == ENG_THR_Rating then
                    DELAY = TIME + 5
                    STEP = 2.5
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 2.5 then
            if TIME >= DELAY then
                play_sound(TRHUST_SET)
                DELAY = TIME + 1.347
                STEP = 3
            else
                return
            end
        end
        if STEP == 3 then -- speeds check --
            if TIME >= DELAY then
                if IND_AIRSPEED == 100 then
                    play_sound(N100)
                    DELAY = TIME + 1.179
                end
                if IND_AIRSPEED == V1_SPEED - 1 then
                    play_sound(V1)
                    DELAY = TIME + 0.992
                end
                if IND_AIRSPEED >= VR_SPEED - 1 then
                    play_sound(ROTATE)
                    DELAY = TIME + 1.005
                    STEP = 4
                end
                return
            else
                return
            end
        end
        if STEP == 4 then
            if VERTICAL_SPEED > 300 then
                DELAY = TIME + 2
                STEP = 5
            else
                return
            end
        end
        if STEP == 5 then
            if TIME >= DELAY then
                if GNDAIR_SW == 0 then
                    if VERTICAL_SPEED > 150 then
                        play_sound(POSITIVE_RATE)
                        DELAY = TIME + 1.521
                        STEP = 6
                    else
                        DELAY = TIME + 1
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 6 then
            if TIME >= DELAY then
                if fo_autoperform then
                    play_sound(GEAR_UP)
                    LG_Lever = 0
                    DELAY = TIME + 0.986
                    STEP = 7
                end
            else
                return
            end
        end
        if STEP == 7 then -- decide next proc --
            if TIME >= DELAY then
                if not PACKS_FOR_TO then
                    if THR_STATE == 1 then
                        DELAY = TIME + 3
                        STEP = 7.2
                    else
                        return
                    end
                elseif APU_TO_PACKS then
                    if THR_STATE == 1 then
                        DELAY = TIME + 3
                        STEP = 7.4
                    else
                        return
                    end
                else
                    if THR_STATE == 1 then
                        DELAY = TIME + 3
                        STEP = 0
                        TO_PROC_DONE = true
                        return
                    else
                        return
                    end
                end
            else
                return
            end
        end
        if STEP == 7.2 then -- PACKS OFF --
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(PACKS)
                end
                DELAY = TIME + 0.25
                STEP = 7.21
            else
                return
            end
        end
        if STEP == 7.21 then
            if TIME >= DELAY then
                command_once(PACK_1_PB)
                DELAY = TIME + 30
                STEP = 7.22
            else
                return
            end
        end
        if STEP == 7.22 then
            if TIME >= DELAY then
                command_once(PACK_2_PB)
                DELAY = TIME +0.3
                STEP = 0
                TO_PROC_DONE = true
                return
            else
                return
            end
        end
        if STEP == 7.4 then -- APU TO PACKS --
            if TIME >= DELAY then
                ENG_1_BLEED_PB = 0
                DELAY = TIME + 10
                STEP = 7.41
            else
                return
            end
        end
        if STEP == 7.41 then
            if TIME >= DELAY then
                ENG_2_BLEED_PB = 0
                DELAY = TIME + 0.7
                STEP = 7.42
            else
                return
            end
        end
        if STEP == 7.42 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(APU_BLEED)
                end
                DELAY = TIME + 1.203
                STEP = 7.43
            else
                return
            end
        end
        if STEP == 7.43 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(OFF)
                end
                command_once(APU_BLEED_PB)
                DELAY = TIME + 0.920
                STEP = 7.44
            else
                return
            end
        end
        if STEP == 7.44 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(APU_MASTER)
                end
                DELAY = TIME + 1.418
                STEP = 7.45
            else
                return
            end
        end
        if STEP == 7.45 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(OFF)
                end
                command_once(APU_MASTER_PB)
                DELAY = TIME + 0.928
                STEP = 0
                TO_PROC_DONE = true
            else
                return
            end
        end
    end
end

---- CLEAN UP PROCEDURE ----
function clean_up_auto()
    if STEP_CLEAN == 0 then
        DELAY_CLEAN = TIME + 5
        STEP_CLEAN = 1
    end
    if STEP_CLEAN == 1 then
        if TIME >= DELAY_CLEAN then
            if FLAPS_LEVER_State ~= 0.25 then
                if STEP_SPEACH == 0 then
                    if IND_AIRSPEED > FLAP_RETRACT_SPEED + 4 then
                        play_sound(SPEED_CHECK)
                        DELAY_CLEAN = TIME + 1.436
                        STEP_SPEACH = 1
                        return
                    else
                        return
                    end
                end
                if STEP_SPEACH == 1 then
                    command_once(FLAPS_1UP)
                    STEP_SPEACH = 2
                end
                if STEP_SPEACH == 2 then
                    if FLAPS_State ~= -1 then
                        play_sound(FLAP_POS[FL_VOICE_SRCH])
                        STEP_SPEACH = 3
                    else
                        return
                    end
                end
                if STEP_SPEACH == 3 then
                    if FLAPS_State == -1 then
                        DELAY_CLEAN = TIME + 1
                        STEP_SPEACH = 0
                        return
                    else
                        return
                    end
                end
            else
                play_sound(FLAP_POS[FL_VOICE_SRCH])
                STEP_CLEAN = 2
            end
        else
            return
        end
    end
    if STEP_CLEAN == 2 then
        if TIME >= DELAY_CLEAN then
            if STEP_SPEACH == 0 then
                if IND_AIRSPEED > SLAT_RETRACT_SPEED + 5 then
                    play_sound(SPEED_CHECK)
                    DELAY_CLEAN = TIME + 1.436
                    STEP_SPEACH = 1
                    return
                else
                    return
                end
            end
            if STEP_SPEACH == 1 then
                command_once(FLAPS_1UP)
                STEP_SPEACH = 2
            end
            if STEP_SPEACH == 2 then
                if FLAPS_State ~= -1 then
                    play_sound(FLAP_POS[FL_VOICE_SRCH])
                    STEP_SPEACH = 3
                else
                    return
                end
            end
            if STEP_SPEACH == 3 then
                if FLAPS_State == -1 then
                    STEP_SPEACH = 0
                    STEP_CLEAN = 0
                    DELAY = TIME + 1
                    ACF_CLEAN = true
                else
                    return
                end
            end
        else
            return
        end
    end
end

function flaps_commanded_change()
    if command_FLPS_1UP then
        if STEP_CLEAN == 0 then
            DELAY_CLEAN = TIME + 1
            STEP_CLEAN = 1
        end 
        if STEP_CLEAN == 1 then
            if TIME >= DELAY_CLEAN then
                play_sound(SPEED_CHECK)
                DELAY_CLEAN = TIME + 1.436
                STEP_CLEAN = 2
            else
                return
            end
        end
        if STEP_CLEAN == 2 then
            if TIME >= DELAY_CLEAN then
                if FLAPS_LEVER_State > 0.25 then
                    if IND_AIRSPEED > FLAP_RETRACT_SPEED + 4 then
                        command_once(FLAPS_1UP)
                        DELAY_CLEAN = TIME + 0.3
                        STEP_CLEAN = 3
                    else
                        return
                    end
                elseif FLAPS_LEVER_State == 0.25 then
                    if IND_AIRSPEED > SLAT_RETRACT_SPEED + 5 then
                        command_once(FLAPS_1UP)
                        DELAY_CLEAN = TIME + 0.3
                        STEP_CLEAN = 3
                    else
                        return
                    end
                end
            else
                return
            end
        end
        if STEP_CLEAN == 3 then
            if TIME >= DELAY_CLEAN then
                if FLAPS_State ~= -1 then
                    play_sound(FLAP_POS[FL_VOICE_SRCH])
                    DELAY_CLEAN = TIME + 0.3
                    STEP_CLEAN = 0
                    command_FLPS_1UP = false
                else
                    return
                end
            else
                return
            end
        end
    elseif command_FLPS_1DN then
        if STEP_CLEAN == 0 then
            DELAY_CLEAN = TIME + 1
            STEP_CLEAN = 1
        end
        if STEP_CLEAN == 1 then
            if TIME >= DELAY_CLEAN then
                play_sound(SPEED_CHECK)
                DELAY_CLEAN = TIME + 1.536
                STEP_CLEAN = 2
            else
                return
            end
        end
        if STEP_CLEAN == 2 then
            if TIME >= DELAY_CLEAN then
                if IND_AIRSPEED + 5 < FLAPS_LIMIT[lindex] then
                    command_once(FLAPS_1DOWN)
                    DELAY_CLEAN = TIME + 0.3
                    STEP_CLEAN = 3
                else
                    return
                end
            else
                return
            end
        end
        if STEP_CLEAN == 3 then
            if TIME >= DELAY_CLEAN then
                if FLAPS_State ~= -1 then
                    play_sound(FLAP_POS[FL_VOICE_SRCH])
                    DELAY_CLEAN = TIME + 0.3
                    STEP_CLEAN = 0
                    command_FLPS_1DN = false
                else
                    return
                end
            else
                return
            end
        end
    end
end

function gear_command()
    if command_GUP then
        DELAY_CHECK = TIME + 0.88
        if TIME >= DELAY_CHECK then
            if FLAPS_State ~= -1 then
                if IND_AIRSPEED <= GEAR_RETRACTION_LIMIT then
                    play_sound(GEAR_UP)
                    LG_Lever = 0
                    command_GUP = false
                else
                    return
                end
            else
                return
            end
        end
    elseif command_GDN then
        DELAY_CHECK = TIME + 1.052
        if STEP_FLT == 0 then
            if TIME >= DELAY_CHECK then
                if FLAPS_State ~= -1 then
                    if IND_AIRSPEED <= GEAR_EXTENTION_LIMIT then
                        play_sound(GEAR_DOWN)
                        LG_Lever = 1
                        STEP_FLT = 1
                    else
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
        if STEP_FLT == 1 then
            if LG_State == 1 then
                play_sound(GEAR_3GREENS)
                DELAY = TIME + 1
                STEP_FLT = 0
                command_GDN = false
            else
                return
            end
        end
    end
end

function ten_thausand_feet_CLB()
    if STEP == 0 then
        if fo_autoperform then
            play_sound(TEN_THAUSAND_FEET)
            DELAY = TIME + 1.2
            STEP = 1
        else
            DELAY = TIME + 1.2
            STEP = 1
        end
    end
    if STEP == 2 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(EXTERIOR_LIGHTS)
            end
            DELAY = TIME + 1.7
            STEP = 2.3
        else
            return
        end
    end
    if STEP == 2.3 then
        if TIME >= DELAY then
            RWYTOLT_SW = 0
            DELAY = TIME + 0.3
            STEP = 2.4
        else
            return
        end
    end
    if STEP == 2.4 then
        if TIME >= DELAY then
            LANDLT_L_SW = 0
            LANDLT_R_SW = 0
            DELAY = TIME + 0.4
            STEP = 2.5
        else
            return
        end
    end
    if STEP == 2.5 then
        if TIME >= DELAY then
            TAXILT_SW = 0
            if not speak_only_essencials then
                play_sound(OFF)
            end
            DELAY = TIME + 0.92
            STEP = 3
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            EFIS_RNG = 3
            DELAY = TIME + 0.5
            STEP = 4
        else
            return
        end
    end
    if STEP == 4 then
        if TIME >= DELAY then
            command_once(TERRAIN_FO_PB)
            DELAY = TIME + 1
            STEP = 5
        else
            return
        end
    end
    if STEP == 5 then
        if TIME >= DELAY then
            local lindex = math.random(5)
            play_sound(READY[lindex])
            DELAY = TIME + 2
            STEP = 0
            TEN_THAUSAND_FEET_CLB_DONE = true
        else
            return
        end
    end
end

function ten_thausand_feet_DES()
    if STEP == 0 then
        if TIME >= DELAY then
            DELAY = TIME + 1.5
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
            DELAY = TIME + 1.7
            STEP = 1.3
        else
            return
        end
    end
    if STEP == 1.3 then
        if TIME >= DELAY then
            RWYTOLT_SW = 1
            DELAY = TIME + 0.3
            STEP = 1.4
        else
            return
        end
    end
    if STEP == 1.4 then
        if TIME >= DELAY then
            LANDLT_L_SW = 2
            LANDLT_R_SW = 2
            DELAY = TIME + 0.4
            STEP = 1.5
        else
            return
        end
    end
    if STEP == 1.5 then
        if TIME >= DELAY then
            TAXILT_SW = 2
            if not speak_only_essencials then
                play_sound(ON)
            end
            DELAY = TIME + 0.92
            STEP = 2
        else
            return
        end
    end
    if STEP == 2 then
        if TIME >= DELAY then
            EFIS_RNG = 1
            DELAY = TIME + 0.5
            STEP = 3
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            command_once(TERRAIN_FO_PB)
            DELAY = TIME + 0.5
            STEP = 4
        else
            return
        end
    end
    if STEP == 4 then
        if TIME >= DELAY then
            if ILS_APP or MLS_APP or VOR_APP or NDB_APP or LDA_APP then
                if not speak_only_essencials then
                    play_sound(LS)
                end
                command_once(LS_FO_PB)
                DELAY = TIME + 1.2
                STEP = 5
            else
                STEP = 5
            end
        else
            return
        end
    end
    if STEP == 5 then
        if TIME >= DELAY then
            if RAINING and ENG_MODEL ~= 1 then
                if not speak_only_essencials then
                    play_sound(ENGINE_MODE_SELECTOR)
                end
                DELAY = TIME + 1.9
                STEP = 5.5
            else
                STEP = 6
            end
        else
            return
        end
    end
    if STEP == 5.5 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(IGNITION)
            end
            ENG_Mode = 2
            DELAY = TIME + 1.195
            STEP = 6
        else
            return
        end
    end
    if STEP == 6 then
        if TIME >= DELAY then
            local rindex = math.random(5)
            play_sound(READY[rindex])
            DELAY = TIME + 3
            STEP = 0
            TEN_THAUSAND_FEET_DES_DONE = true
        else
            return
        end
    end
end

function ap_discn_behaviour()
    if STEP_AP == 0 then
        if AP_DISCN_ALARM == 1 then
            if not ILS_APP or MLS_APP then
                DELAY_AP = TIME + 2
                STEP_AP = 1
            else
                STEP_AP = 9
            end
        else
            return
        end
    end
    if STEP_AP == 1 then
        if TIME >= DELAY_AP then
            play_sound(FLIGHT_DIRECTORS)
            DELAY_AP = TIME + 0.5
            DELAY_SPEACH = TIME + 1.2
            STEP_AP = 2
        else
            return
        end
    end
    if STEP_AP == 2 then
        if TIME >= DELAY_AP then
            command_once(FD_CAP_PB)
            DELAY_AP = TIME + 0.5
            STEP_AP = 3
        else
            return
        end
    end
    if STEP_AP == 3 then
        if TIME >= DELAY_AP then
            command_once(FD_FO_PB)
            DELAY_AP = TIME + 0.5
            STEP_AP = 4
        else
            return
        end
    end
    if STEP_AP == 4 then
        if TIME >= DELAY_SPEACH then
            play_sound(OFF)
            DELAY_AP = TIME + 0.836
            STEP_AP = 5
        else
            return
        end
    end
    if STEP_AP == 5 then
        if TIME >= DELAY_AP then
            command_once(HDGTRK_TOGGLE)
            DELAY_AP = TIME + 0.5
            STEP_AP = 0
            AP_DISCN_PROC = true
        else
            return
        end
    end
end

-- GO ARROUND PROCEDURE --
function go_arround() 
    if STEP == 0 then
        DELAY = TIME + 0.5
        STEP = 1
        ATO_CL = false
        LND_CL = false
    end
    if STEP == 1 then
        if TIME >= DELAY then
            play_sound(GO_ARROUND)
            DELAY = TIME + 1.2
            STEP = 2
        else
            return
        end
    end
    if STEP == 2 then
        if TIME >= DELAY then
            play_sound(TOGA)
            DELAY = TIME + 1.2
            STEP = 3
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            play_sound(FLAP_POS[FLUP_VOICE_SRCH])
            command_once(FLAPS_1UP)
            DELAY = TIME + 1.429
            STEP = 4
        else
            return
        end
    end
    if STEP == 4 then
        if TIME >= DELAY then
            if VERTICAL_SPEED > 500 then
                play_sound(POSITIVE_RATE)
                DELAY = TIME + 1.721
                STEP = 5
            else
                return
            end
        else
            return
        end
    end
    if STEP == 5 then
        if TIME >= DELAY then
            if fo_autoperform then
                command_GUP = true
            end
            if command_GUP then
                play_sound(GEAR_UP)
                LG_Lever = 0
                DELAY = TIME + 0.986
                STEP = 0
                GA_PROC = true
            else
                return
            end
        else
            return
        end
    end
end

-- TOUCH DOWN PROCEDURE --
function touch_down()
    if STEP == 0 then
        if TIME >= DELAY then
            if INBD_SPOILERS == 1 then
                play_sound(SPOILERS)
                DELAY = TIME + 1.376
                STEP = 1
            else
                return
            end
        else
            return
        end
    end
    if STEP == 1 then
        if TIME >= DELAY then
            if ENG_1_REV == 2 and ENG_2_REV == 2 then
                play_sound(REVERSE_GREEN)
                DELAY = TIME + 1.053
                STEP = 2
                CHECK_SPEED = IND_AIRSPEED - 10
            else
                return
            end
        else
            return
        end
    end
    if STEP == 2 then
        if TIME >= DELAY then
            if IND_AIRSPEED < CHECK_SPEED then
                play_sound(DECEL)
                DELAY = TIME + 1.034
                STEP = 3
            else
                return
            end
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            if IND_AIRSPEED < 78 then
                play_sound(N80_KNOTS)
                DELAY = TIME + 1.4
                STEP = 0
                DECELERATION = false
            end
        end
    end
end

function after_landing_proc()
    if STEP == 0 then
        if TIME >= DELAY then
            DELAY = TIME + 0.4
            STEP = 1
        else
            return
        end
    end
    if STEP == 1 then
        if TIME >= DELAY then
            play_sound(CHECK_TIME)
            command_once(CRONO_SET_PB)
            DELAY = TIME + 1.109
            STEP = 2
        else
            return
        end
    end
    if STEP == 2 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(WEATHER_RADAR)
            end
            DELAY = TIME + 1.209
            STEP = 3
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(OFF)
            end
            DELAY = TIME + 0.920
            Radar_SYS_SW = 0
            STEP = 4
        else
            return
        end
    end
    if STEP == 4 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(PWS)
            end
            DELAY = TIME + 1.286
            STEP = 5
        else
            return
        end
    end
    if STEP == 5 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(OFF)
            end
            PWS_SW = 0
            DELAY = TIME + 0.920
            STEP = 6
        else
            return
        end
    end
    if STEP == 6 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(ENGINE_MODE_SELECTOR)
            end
            DELAY = TIME + 1.885
            STEP = 7
        else
            return
        end
    end
    if STEP == 7 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(NORMAL)
            end
            ENG_Mode = 1
            DELAY = TIME + 1.129
            STEP = 8
        else
            return
        end
    end
    if STEP == 8 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(FLAPS)
            end
            if OAT >= 29 then
                F_TARGET = 0.25
            else
                F_TARGET = 0
            end
            F_ATARGET = FLAPS_LEVER_State
            DELAY = TIME + 1.112
            STEP = 9
        else
            return
        end
    end
    if STEP == 9 then
        if TIME >= DELAY then
            if FLAPS_LEVER_State ~= F_TARGET then
                if FLAPS_LEVER_State == F_ATARGET then
                    F_ATARGET = FLAPS_LEVER_State - 0.25
                    command_once(FLAPS_1UP)
                    return
                else
                    return
                end
            else
                if not speak_only_essencials then
                    play_sound(FLAP_POS[FL_VOICE_SRCH])
                end
                DELAY = 1.629
                STEP = 10
            end
        else
            return
        end
    end
    if STEP == 10 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(APU_MASTER)
            end
            command_once(APU_MASTER_PB)
            DELAY = TIME + 6
            STEP = 11
        else
            return
        end
    end
    if STEP == 12 then
        if TIME >= DELAY then
           if not speak_only_essencials then
                play_sound(STARTING_APU)
           end
           command_once(APU_START_PB)
           DELAY = TIME + 1.750
           STEP = 13
        else
            return
        end
    end
    if STEP == 13 then
        if TIME >= DELAY then
           local rindex = math.random(5)
           play_sound(READY[rindex])
           DELAY = TIME + 3
           STEP = 0
           AL_PROC = true
        else
            return
        end
    end
end

-- BRAKE TEMP CHECK PROCEDURE --
function brake_temp_check()
    if BRAKE1_TEMP > 150 or BRAKE2_TEMP > 150 or BRAKE3_TEMP > 150 or BRAKE4_TEMP > 150 then
        if not speak_only_essencials then
            play_sound(BRAKE_FAN)
        end
        command_once(BRKFAN_PB)
        DELAY = TIME + 1.173
    end
end

function vacating_rwy()
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
            DELAY = TIME + 1.74
            STEP = 2
        else
            return
        end
    end
    if STEP == 2 then
        if TIME >= DELAY then
            LANDLT_L_SW = 0
            LANDLT_R_SW = 0
            DELAY = TIME + 0.3
            STEP = 3
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            STROBE_SW = 1
            DELAY = TIME + 0.4
            STEP = 4
        else
            return
        end
    end
    if STEP == 4 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(SET)
            end
            TAXI_LIGHT = 1
            DELAY = TIME + 0.871
            STEP = 5
        else
            return
        end
    end
    if STEP == 6 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(TCAS)
            end
            DELAY = TIME + 1.218
            STEP = 7
        else
            return
        end
    end
    if STEP == 8 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(SET)
            end
            TCAS_SW = 2
            DELAY = TIME + 0.871
            STEP = 0
            RWY_VACATED = false
        else
            return
        end
    end
end

-- PARKING PROCEDURE --
function parking_proc()
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
                play_sound(APU_BLEED)
            end
            DELAY = TIME + 1.203
            STEP = 2
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(ON)
            end
            DELAY = TIME + 0.92
            STEP = 4
        else
            return
        end
    end
    if STEP == 5 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(FUEL_PUMPS)
            end
            DELAY = TIME + 1.153
            STEP = 6
        else
            return
        end
    end
    if STEP == 6 then
        if TIME >= DELAY then
            command_once(FPUMP_LTANK_1_PB)
            command_once(FPUMP_LTANK_2_PB)
            DELAY = TIME + 0.4
            STEP = 7
        else
            return
        end
    end
    if STEP == 7 then
        if TIME >= DELAY then
            command_once(FPUMP_CTANK_1_PB)
            command_once(FPUMP_CTANK_2_PB)
            DELAY = TIME + 0.4
            STEP = 8
        else
            return
        end
    end
    if STEP == 8 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(OFF)
            end
            command_once(FPUMP_RTANK_1_PB)
            command_once(FPUMP_RTANK_2_PB)
            DELAY = TIME + 0.920
            STEP = 9
        else
            return
        end
    end
    if STEP == 9 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(ATC)
            end
            DELAY = TIME + 1.039
            STEP = 10
        else
            return
        end
    end
    if STEP == 10 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(SET)
            end
            TCAS_SW = 0
            DELAY = TIME + 0.871
            STEP = 11
        else
            return
        end
    end
    if STEP == 11 then
        if TIME >= DELAY then
            local rindex = math.random(5)
            play_sound(READY[rindex])
            DELAY = TIME + 2
            STEP = 0
            PARK_PROC = true
        else
            return
        end
    end
end

-- //////////////////////
-- ///// CHECKLISTS /////
-- //////////////////////

-- BEFORE START CHECKLIST --
function checklist_before_start()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(BEFORE_START_CHECKLIST)
            DELAY_CHECK = TIME + 1.818
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(EFB_PREPARATION)
            DELAY_CHECK = TIME + 1.781
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(COMPLETED)
                DELAY_CHECK = TIME + 0.957
                STEP_CHECK = 3
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 3 then
        if TIME >= DELAY_CHECK then
            play_sound(AIRCRAFT_PBN_CAPABILITY)
            DELAY_CHECK = TIME + 2.140
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.839
                STEP_CHECK = 5
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(COCKPIT_PREPARATION)
            DELAY_CHECK = TIME + 1.609
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if PF_DONE then
                    play_sound(COMPLETED)
                    DELAY_CHECK = TIME + 0.957
                    STEP_CHECK = 7
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 7 then
        if TIME >= DELAY_CHECK then
            play_sound(GEAR_PINS_AND_COVERS)
            DELAY_CHECK = TIME + 1.781
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(REMOVED)
                DELAY_CHECK = TIME + 0.869
                STEP_CHECK = 9
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 9 then
        if TIME >= DELAY_CHECK then
            play_sound(SIGNS)
            DELAY_CHECK = TIME + 0.872
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if SEATBELTS_SW == 2 and SIGNS_STATE == 1 then
                    play_sound(COMPLETED)
                    DELAY_CHECK = TIME + 0.957
                    STEP_CHECK = 11
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 11 then
        if TIME >= DELAY_CHECK then
            play_sound(ADIRS)
            DELAY_CHECK = TIME + 0.993
            STEP_CHECK = 12
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 12 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if ADIR_1_STATE == 1 and ADIR_2_STATE == 1 and ADIR_3_STATE == 1 then
                    play_sound(NAV)
                    DELAY_CHECK = TIME + 1.094
                    STEP_CHECK = 13
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 13 then
        if TIME >= DELAY_CHECK then
            play_sound(FUEL_QUANTITY)
            DELAY_CHECK = TIME + 1.236
            STEP_CHECK = 14
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 14 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.920
                STEP_CHECK = 15
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 15 then
        if TIME >= DELAY_CHECK then
            play_sound(BARO_REFERENCE)
            DELAY_CHECK = TIME + 1.433
            STEP_CHECK = 16
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 16 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if CM_QNH == FO_QNH then
                    play_sound(SET)
                    DELAY_CHECK = TIME + 0.920
                    STEP_CHECK = 17
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 17 then
        if TIME >= DELAY_CHECK then
            play_sound(DOWN_TO_THE_LINE)
            DELAY_CHECK = TIME + 1.5
            STEP_CHECK = 0
            BS_DTL = true
        else
            return
        end
    end
end

-- BEFORE_START_CHECKLIST BELOW THE LINE --
function checklist_before_start_BTL()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(BEFORE_START_CHECKLIST_BELOW_THE_LINE)
            DELAY_CHECK = TIME + 2.188
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(EFB)
            DELAY_CHECK = TIME + 1.042
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.86
                STEP_CHECK = 3
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 3 then
        if TIME >= DELAY_CHECK then
            play_sound(ATC)
            DELAY_CHECK = TIME + 0.936
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if TCAS_STATE == 2 then
                    play_sound(SET)
                    DELAY_CHECK = TIME + 0.86
                    STEP_CHECK = 5
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(WINDOWS_AND_DOORS)
            DELAY_CHECK = TIME + 1.515
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if
                DOOR_1L == 0 and
                DOOR_1R == 0 and
                DOOR_2L == 0 and
                DOOR_2R == 0 and
                DOOR_3L == 0 and
                DOOR_3R == 0 and
                DOOR_4L == 0 and
                DOOR_4R == 0 then
                    play_sound(CLOSE)
                    DELAY_CHECK = TIME + 0.815
                    STEP_CHECK = 7
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 7 then
        if TIME >= DELAY_CHECK then
            play_sound(THRUST_LEVERS)
            DELAY_CHECK = TIME + 1.476
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(IDLE)
                DELAY_CHECK = TIME + 0.79
                STEP_CHECK = 9
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 9 then
        if TIME >= DELAY_CHECK then
            play_sound(PARKING_BRAKE)
            DELAY_CHECK = TIME + 0.836
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.82
                STEP_CHECK = 11
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 11 then
        if TIME >= DELAY_CHECK then
            play_sound(CHECKLIST_COMPLETED)
            DELAY_CHECK = TIME + 1.602
            STEP_CHECK = 0
            BS_CL = true
        else
            return
        end
    end
end

-- AFTER START CHECKLIST -- 
function checklist_after_start()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(AFTER_START_CHECKLIST)
            DELAY_CHECK = TIME + 1.758
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(ANTI_ICE)
            DELAY_CHECK = TIME + 1.227
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.920
                STEP_CHECK = 3
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 3 then
        if TIME >= DELAY_CHECK then
            play_sound(ECAM_STATUS)
            DELAY_CHECK = TIME + 1.343
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.839
                STEP_CHECK = 5
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(PITCH_TRIM)
            DELAY_CHECK = TIME + 1.328
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if PT_TO_CONFIG == PITCH_TRIM then
                    play_sound(SET)
                    DELAY_CHECK = TIME + 0.920
                    STEP_CHECK = 7
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 7 then
        if TIME >= DELAY_CHECK then
            play_sound(RUDDER_TRIM)
            DELAY_CHECK = TIME + 1.009
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if RUDDER_TRIM_POS < 0.2 and RUDDER_TRIM_POS > -0.2 then
                    play_sound(N0)
                    DELAY_CHECK = TIME + 1.116
                    STEP_CHECK = 9
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 9 then
        if TIME >= DELAY_CHECK then
            play_sound(CHECKLIST_COMPLETED)
            DELAY_CHECK = TIME + 1.602
            STEP_CHECK = 0
            AS_CL = true
        else
            return
        end
    end
end

-- BEFORE TAKEOFF CHECKLIST --
function checklist_before_takeoff()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(BEFORE_START_CHECKLIST)
            DELAY_CHECK = TIME + 1.645
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(FLIGHT_CONTROLS)
            DELAY_CHECK = TIME + 1.208
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.839
                STEP_CHECK = 3
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 3 then
        if TIME >= DELAY_CHECK then
            play_sound(FLY_INSTRUMENTS)
            DELAY_CHECK = TIME + 1.232
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.839
                STEP_CHECK = 5
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(BREAFING)
            DELAY_CHECK = TIME + 0.845
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if TO_BREAFING then
                    play_sound(COMPLETED)
                    DELAY_CHECK = TIME + 0.957
                    STEP_CHECK = 7
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 7 then
        if TIME >= DELAY_CHECK then
            play_sound(FLAPS)
            DELAY_CHECK = TIME + 1.112
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(FLAP_POS[FL_VOICE_SRCH])
                DELAY_CHECK = TIME + 1.429
                STEP_CHECK = 9
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 9 then
        if TIME >= DELAY_CHECK then
            play_sound(V1_VR_V2_FLEX_TEMP)
            DELAY_CHECK = TIME + 2.2
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.839
                STEP_CHECK = 11
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 11 then
        if TIME >= DELAY_CHECK then
            play_sound(ECAM_MEMO)
            DELAY_CHECK = TIME + 1.138
            STEP_CHECK = 12
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 12 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(TAKEOFF_NO_BLUE)
                DELAY_CHECK = TIME + 1.298
                STEP_CHECK = 13
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 13 then
        if TIME >= DELAY_CHECK then
            play_sound(DOWN_TO_THE_LINE)
            DELAY_CHECK = TIME + 1.182
            STEP_CHECK = 0
            BTO_DTL = true
        else
            return
        end
    end
end

-- BEFORE TAKEOFF CHECKLIST BELOW THE LINE --
function checklist_before_takeoff_BTL()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(BEFORE_TAKEOFF_CHECKLIST_BELOW_THE_LINE)
            DELAY_CHECK = TIME + 2.352
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(TAKEOFF_RUNWAY)
            DELAY_CHECK = TIME + 1.343
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CONFIRM)
                DELAY_CHECK = TIME + 0.991
                STEP_CHECK = 3
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 3 then
        if TIME >= DELAY_CHECK then
            play_sound(NAV_ON_FMA)
            DELAY_CHECK = TIME + 1.343
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if string.find(FMA_B_STATE, "NAV") then
                    play_sound(CHECK)
                    DELAY_CHECK = TIME + 0.839
                    STEP_CHECK = 5
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(CABIN_CREW)
            DELAY_CHECK = TIME + 1.145
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(ADVISED)
                DELAY_CHECK = TIME + 1.036
                STEP_CHECK = 7
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 7 then
        if TIME >= DELAY_CHECK then
            play_sound(TCAS)
            DELAY_CHECK = TIME + 1.218
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if TCAS_STATE == 4 then
                    play_sound(TA_RA)
                    DELAY_CHECK = TIME + 1.792
                    STEP_CHECK = 9
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 9 then
        if TIME >= DELAY_CHECK then
            play_sound(ENGINE_MODE_SELECTOR)
            DELAY_CHECK = TIME + 1.885
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if RAINING and ENG_MODEL ~= 1 then
                    if ENG_Mode_State == 2 then
                        play_sound(IGNITION)
                        DELAY_CHECK = TIME + 1.095
                        STEP_CHECK = 5
                    end
                elseif ENG_Mode_State == 1 then
                    play_sound(NORMAL)
                    DELAY_CHECK = TIME + 1.129
                    STEP_CHECK = 5
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(PACKS_AND_APU_BLEED)
            DELAY_CHECK = TIME + 1.616
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if PACKS_FOR_TO then
                    if PACK_1_STATE == 0 and PACK_2_STATE == 0 and APU_BLEED_STATE == 0 then
                        play_sound(CHECK)
                        DELAY_CHECK = TIME + 0.839
                        STEP_CHECK = 7
                    end
                elseif APU_TO_PACKS then
                    if PACK_1_STATE == 0 and PACK_2_STATE == 0 and APU_BLEED_STATE == 1 then
                        play_sound(CHECK)
                        DELAY_CHECK = TIME + 0.839
                        STEP_CHECK = 7
                    end
                else
                    if PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 0 then
                        play_sound(CHECK)
                        DELAY_CHECK = TIME + 0.839
                        STEP_CHECK = 7
                    end
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 7 then
        if TIME >= DELAY_CHECK then
            play_sound(CHECKLIST_COMPLETED)
            DELAY_CHECK = TIME + 1.602
            STEP_CHECK = 0
            BTO_CL = true
        else
            return
        end
    end
end

-- AFTER TAKEOFF CHECKLIST --
function checklist_after_takeoff()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(AFTER_TAKEOFF_CHECKLIST)
            DELAY_CHECK = TIME + 1.661
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(LANDING_GEAR)
            DELAY_CHECK = TIME + 1.046
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if LG_Lever_State == 0 then
                    play_sound(UP)
                    DELAY_CHECK = TIME + 0.878
                    STEP_CHECK = 3
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 3 then
        if TIME >= DELAY_CHECK then
            play_sound(FLAPS)
            DELAY_CHECK = TIME + 1.112
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if FLAPS_LEVER_State == 0 then
                    play_sound(RETRACTED)
                    DELAY_CHECK = TIME + 1.792
                    STEP_CHECK = 5
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(PACKS)
            DELAY_CHECK = TIME + 0.999
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if PACK_1_STATE == 0 and PACK_2_STATE == 0 then
                    play_sound(ON)
                    DELAY_CHECK = TIME + 0.920
                    STEP_CHECK = 7
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 7 then
        if TIME >= DELAY_CHECK then
            play_sound(CHECKLIST_COMPLETED)
            DELAY_CHECK = TIME + 1.602
            STEP_CHECK = 0
            ATO_CL = true
        else
            return
        end
    end
end

-- CLIMB CHECKLIST --
function checklist_climb()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(CLIMB_CHECKLIST)
            DELAY_CHECK = TIME + 1.305
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(BARO_REFERENCE)
            DELAY_CHECK = TIME + 1.433
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.920
                STEP_CHECK = 3
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 3 then
        if TIME >= DELAY_CHECK then
            play_sound(CHECKLIST_COMPLETED)
            DELAY_CHECK = TIME + 1.602
            STEP_CHECK = 0
            CLB_CL = true
        else
            return
        end
    end
end