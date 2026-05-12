------------------------------------------
----- //// TOLISS FO / PM PROTO //// -----
------------------------------------------

-- PLANE CHECK
local COMPATIBLE_ACF = {
    A319 = true,
    A320 = true,
    A20N = true,
    A321 = true,
    A21N = true
}
if COMPATIBLE_ACF[PLANE_ICAO] then -- LUA START
logMsg("XXXXX   ACF Compatible")
dataref("TIME", "sim/time/total_running_time_sec", "readonly")
dataref("ENG_MODEL", "AirbusFBW/EngineType", "readonly") -- 1 IAE/2 CFM/3 PW/4 LEAP
-- RANDOMIZER --
math.randomseed(os.clock())

-- CONFIG LOAD
dofile(SCRIPT_DIRECTORY .. "/FO PM/FO Config.lua")
logMsg("XXXXX   Config Loaded")

-- DATAREFS LOAD
dofile(SCRIPT_DIRECTORY .. "/FO PM/Datarefs Reading.lua")
logMsg("XXXXX   Datarefs Readed")

-- VOICE LOAD
dofile(SCRIPT_DIRECTORY .. "/FO PM/FO Voices load.lua")
logMsg("XXXXX   Voices Loaded")

----------------
---- PHASES ----
----------------

local FLT_PHASE = {
    PREFLIGHT = true,
    PUSHBACK = false,
    ENG_START = false,
    TAXI_OUT = false,
    ON_RWY = false,
    TAKEOFF = false,
    REJECTED = false,
    REJECTED_DES = false,
    CLIMB = false,
    CRUISE = false,
    DESCEND = false,
    APPROACH = false,
    FINAL_APP = false,
    DECELERATION = false,
    GA = false,
    TAXI_IN = false,
    PARKING = false
}
--------------------------------
---- PROCEDURES COMPLETE ----
--------------------------------

local COMPLETED_PROC = {
    PF_DONE = false,
    TO_BRIEFING = false,
    AS_PROC_DONE = false,
    BTO_PROC_DONE = false,
    TO_PROC_DONE = false,
    ACF_CLEAN = false,
    TEN_THAUSAND_FEET_CLB_DONE = false,
    DES_BRIEFING = false,
    TEN_THAUSAND_FEET_DES_DONE = false,
    AP_DISCN_PROC = false,
    GA_PROC = false,
    DECEL_CALLOUTS = false,
    AL_PROC = false,
    PARK_PROC = false,
    FLTCTL_CHK = false,
    ENT_RWY_DONE = false,
    EXIT_RWY_DONE = false,
    BRKTEMP_CHK_DONE = false,
    OETA_DONE = false
}

------------------------------
---- CHECKLISTS VARIABLES ----
------------------------------

local CHECKLIST = {
    BS_DTL = false,
    EX_BS_DTL = false,
    BS_CL = false,
    EX_BS_CL = false,
    AS_CL = false,
    EX_AS_CL = false,
    BTO_DTL = false,
    EX_BTO_DTL = false,
    BTO_CL = false,
    EX_BTO_CL = false,
    ATO_CL = false,
    EX_ATO_CL = false,
    CLB_CL = false,
    EX_CLB_CL = false,
    APP_CL = false,
    EX_APP_CL = false,
    LND_CL = false,
    EX_LND_CL = false,
    AL_CL = false,
    EX_AL_CL = false,
    PARK_CL = false,
    EX_PARK_CL = false,
    SEC_CL = false,
    EX_SEC_CL = false
}

-----------------------------
---- APPROACH PROCEDURES ----
-----------------------------
local APP_TYPE = {
    ---- Especial Departure
    AR_DEP = false,
    ---- Precision APPROACH ----
    ILS_APP = false,
    MLS_APP = false,
    CAT_II_III = false,
    ---- Non Precision APPROACH ----
    RNAV_APP = false,
    RNAVAR_APP = false,
    VOR_APP = false,
    NDB_APP = false,
    LDA_APP = false,
    ---- Especial feature
    FLS = false
}
----------------------------
---- ONGOING PROCEDURES ----
----------------------------

local EXECUTE_PCP = false
local EXECUTE_ASP = false
local EXECUTE_BTP = false
local EXECUTE_10FT_CLB = false
local EXECUTE_10FT_DES = false
local ONEENG_TAXI_DEP = false
local EXECUTE_OETD = false
local START_ENG2 = false
local EXECUTE_AL_PROC = false
local EXECUTE_ENRWY = false
local EXECUTE_EXRWY = false
local ONEENG_TAXI_ARR_AVAIL = false
local EXECUTE_OETA = false
local EXECUTE_FLP = false
local EXECUTE_GEAR = false

------------------
---- COMMANDS ----
------------------

command_GUP = false
command_GDN = false
command_FLPS_1UP = false
command_FLPS_1DN = false
response_CHECK = false

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
local STEP_ONEENG = 0
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
local TXT_PHASE = nil
local MINUTE3 = false

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

do_every_frame("engine_math()")


---------------------
---- FLAPS TO VOICE CHECK ----
---------------------

local FLAP_VOICE_DIR = {"P0", "P1", "P2", "P3", "FULL"}
local CONFIG_VOICE_SRCH = "P1"
local FL_VOICE_SRCH = "P0"
local FLUP_VOICE_SRCH = "P0"
local lindex = 1

function flaps_voice_search()
    local index = math.floor((FLAPS_LEVER_State * 4) + 1)
    FL_VOICE_SRCH = FLAP_VOICE_DIR[index]
    FLUP_VOICE_SRCH = FLAP_VOICE_DIR[(index - 1)]
    CONFIG_VOICE_SRCH = FLAP_VOICE_DIR[index]
end

do_every_frame("flaps_voice_search()")

-- //////////////////////////////
-- ///////// PROCEDURES /////////
-- //////////////////////////////

---- FLIGHT_CONTROLS_CHECK
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
        if LALERONS == -20 and RALERONS == 25 then
            play_sound(FULL_LEFT)
            STEP_FLT = 2.5
        else
            return
        end
    end
    if STEP_FLT == 2.5 then
        if LALERONS == 25 and RALERONS == -20 then
            play_sound(FULL_RIGHT)
            STEP_FLT = 2.75
        else
            return
        end
    end
    if STEP_FLT == 2.75 then
        if LALERONS == 5 and RALERONS == 5 then
            play_sound(NEUTRAL)
            DELAY = TIME + 0.955
            STEP_FLT = 3
        else
            return
        end
    end
    if STEP_FLT == 3 then
        if TIME >= DELAY then
            play_sound(RDR)
            DELAY = TIME + 1
            STEP_FLT = 3.25
        else
            return
        end
    end
    if STEP_FLT == 3.25 then
        if RUDDER == -30 then
            play_sound(FULL_LEFT)
            STEP_FLT = 3.5
        else
            return
        end
    end
    if STEP_FLT == 3.5 then
        if RUDDER == 30 then
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
            COMPLETED_PROC.FLTCTL_CHK = true
            STEP_FLT = 0
        else
            return
        end
    end
end

---- PRELIMINARY COCKPIT PREPARATION
function pre_cockpit_pre()
    if not COMPLETED_PROC.PF_DONE then
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
                if ENG_1_Master == 0 and ENG_2_Master == 0 then
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
                if ENG_Mode == 1 then
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
                if RADAR_SYS_SW == 1 then
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
                DELAY = TIME + 1.125
                DELAY_CHECK = 0
                STEP = 4.5
            else
                return
            end
        end
        if STEP == 4.5 then
            if TIME >= DELAY then
                if LG_Lever == 1 then
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
                if LWipers_Mode == 0 and RWipers_Mode == 0 then
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
                    STEP = 6.6
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
        if STEP == 6.6 then
            if EXTPWR_State ~= 0 then
                STEP = 7
            else
                STEP = 7.5
            end
        end
        if STEP == 7 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(EXTERNAL_POWER)
                end
                DELAY = TIME + 1.486
                DELAY_CHECK = 0
                STEP = 7.1
            else
                return
            end
        end
        if STEP == 7.1 then
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
                        DELAY_CHECK = TIME + 15
                    end
                    return
                end
            else
                return
            end
        end
        if STEP == 7.5 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(APU)
                end
                STEP = 7.6
                DELAY = TIME + 1.187
            else
                return
            end
        end
        if  STEP == 7.6 then
            if TIME >= DELAY then
                if APU_STATE == 1 then
                    if not speak_only_essencials then
                        play_sound(AVAIL)
                    end
                    DELAY = TIME + 1.154
                    STEP = 8
                else
                    if TIME >= DELAY_CHECK then
                        play_sound(APU)
                        DELAY_CHECK = TIME + 15
                        DELAY = TIME + 0.987
                        return
                    else
                        return
                    end
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
                DELAY = TIME + 1.066
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
                    if not speak_only_essencials then
                        play_sound(NORMAL)
                    end
                    DELAY = TIME + 1.129
                    STEP = 9
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
                if PRKBRK_SW == 1 then
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
                if BRK_ACCU_Press >= 0.9 then
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
                if LBRAKE_Press > 0.65 and RBRAKE_Press > 0.65 then
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
                COMPLETED_PROC.PF_DONE = true
                EXECUTE_PCP = false
            end
        end
    else
        local rindex = math.random(5)
        play_sound(READY[rindex])
        DELAY = TIME + 3
        EXECUTE_PCP = false
    end
end

---- AFTER START PROCEDURE
function after_start_proc()
    if not COMPLETED_PROC.AS_PROC_DONE then
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
                    if (FLAPS_LEVER_State * 4) == FLAPS_TO_CONFIG then
                        if not speak_only_essencials then
                            play_sound(FLAP_CONFIG[CONFIG_VOICE_SRCH])
                        end
                        DELAY = TIME + 1.488
                        STEP = 4
                    else
                        command_once(FLAPS_1DOWN)
                        DELAY = TIME + 0.8
                        return
                    end
                else
                    return
                end
            end
            if STEP == 4 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(PITCHTRM)
                    end
                    command_once(MCDU_FO_KEY_Perf)
                    DELAY = TIME + 1
                    STEP = 4.3
                else
                    return
                end
            end
            if STEP == 4.3 then
                if TIME >= DELAY then
                    PT_TO_DIRECTION = string.match(MCDU_BLINE_3, "([UPDN]+)")
                    PT_TO_ANGLE = string.match(MCDU_BLINE_3, "/.-[UPDN]+(%d+%.%d+)")
                    FLAP_RETRACT_SPEED = tonumber(string.match(MCDU_GLINE_1, "(%d+)"))
                    SLAT_RETRACT_SPEED = tonumber(string.match(MCDU_GLINE_2, "(%d+)"))
                    GREENDOT = tonumber(string.match(MCDU_GLINE_3,"(%d+)"))
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
                    if PT_TO_CONFIG == (math.floor(PITCH_TRIM * 10) / 10) then
                        if not speak_only_essencials then
                            play_sound(SET)
                        end
                        command_end(PITCH_TRIM_DN)
                        command_end(PITCH_TRIM_UP)
                        DELAY = TIME + 1
                        STEP = 5
                    else
                        if PT_TO_CONFIG < 0 then
                            command_begin(PITCH_TRIM_DN)
                            return
                        elseif PT_TO_CONFIG > 0 then
                            command_begin(PITCH_TRIM_UP)
                            return
                        end
                    end
                else
                    return
                end
            end
            if STEP == 5 then
                if not ONEENG_TAXI_DEP then
                    if TIME >= DELAY then
                        if not speak_only_essencials then
                            play_sound(ECAM_STATUS)
                        end
                        DELAY = TIME + 1.522
                        STEP = 5.5
                    else
                        return
                    end
                else
                    STEP = 6
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
            if STEP == 6 then
                if TIME >= DELAY then
                    if FLAPS_State ~= -1 then
                        return
                    else
                        play_sound(FLAP_CONFIG[CONFIG_VOICE_SRCH])
                        DELAY = TIME + 1.5
                        STEP = 7
                    end
                else
                    return
                end
            end
            if STEP == 7 then
                if not ONEENG_TAXI_DEP then
                    if TIME >= DELAY then
                        if not COMPLETED_PROC.FLTCTL_CHK then
                            flt_ctl_chk()
                        else
                            STEP = 8
                        end
                    else
                        return
                    end
                else
                    EXECUTE_OETD = true
                    STEP = 8
                end
            end
            if STEP == 8 then
                if TIME >= DELAY then
                    local rindex = math.random(5)
                    play_sound(READY[rindex])
                    command_once(MCDU_FO_KEY_Fpln)
                    DELAY = TIME + 3
                    STEP = 0
                    COMPLETED_PROC.AS_PROC_DONE = true
                    EXECUTE_ASP = false
                else
                    return
                end
            end
    else
        local rindex = math.random(5)
        play_sound(READY[rindex])
        DELAY = TIME + 3
        EXECUTE_ASP = false
    end
end

---- BEFORE TAKEOFF PROCEDURE
function before_takeoff_proc()
    if not COMPLETED_PROC.BTO_PROC_DONE then
        if EXECUTE_BTP then
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
                    local radar_pos = math.random(2)
                    if radar_pos == 1 then
                        radar_pos = 0
                    end
                    RADAR_SYS_SW = radar_pos
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
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(ENGINE_MODE_SELECTOR)
                    end
                    DELAY = TIME + 1.885
                    STEP = 4.5
                else
                    return
                end
            end
            if STEP == 4.5 then
                if TIME >= DELAY then
                    if RAINING then
                        if not speak_only_essencials then
                            play_sound(IGNITION)
                        end
                        ENG_Mode = 2
                        DELAY = TIME + 1.095
                    else
                        if not speak_only_essencials then
                            play_sound(NORMAL)
                        end
                        ENG_Mode = 1
                        DELAY = TIME + 1.129
                    end
                    STEP = 5
                else
                    return
                end
            end
            if STEP == 5 then
                if TIME >= DELAY then
                    if not speak_only_essencials then
                        play_sound(BRAKE_TEMP)
                    end
                    DELAY = TIME + 1.204
                    STEP = 5.5
                else
                    return
                end
            end
            if STEP == 5.5 then
                if TIME >= DELAY then
                    if BRAKE1_TEMP < 150 and BRAKE2_TEMP < 150 and BRAKE3_TEMP < 150 and BRAKE4_TEMP < 150 then
                        if BRKFAN_State == 1 then
                            command_once(BRKFAN_PB)
                        end
                        if not speak_only_essencials then
                            play_sound(CHECK)
                        end
                        DELAY = TIME + 0.839
                        STEP = 6
                    else
                        local rindex = math.random(3)
                        play_sound(BRAKE_WARNINGS[rindex])
                        DELAY = TIME + 5
                        STEP = 5.6
                    end
                else
                    return
                end
            end
            if STEP == 5.6 then
                if TIME >= DELAY then
                    if BRAKE1_TEMP < 150 and BRAKE2_TEMP < 150 and BRAKE3_TEMP < 150 and BRAKE4_TEMP < 150 then
                        local rindex = math.random(5)
                        play_sound(READY[rindex])
                        DELAY = TIME + 2
                        STEP = 5.7
                    else
                        return
                    end
                else
                    return
                end
            end
            if STEP == 5.7 then
                if TIME >= DELAY then
                    play_sound(BRAKE_TEMP)
                    DELAY = TIME + 1.204
                    STEP = 5.8
                else
                    return
                end
            end
            if STEP == 5.8 then
                if TIME >= DELAY then
                    play_sound(CHECK)
                    if BRKFAN_State == 1 then
                        command_once(BRKFAN_PB)
                    end
                    DELAY = TIME + 0.839
                    STEP = 6
                else
                    return
                end
            end
            if STEP == 6 then
                if TIME >= DELAY then
                    local rindex = math.random(5)
                    play_sound(READY[rindex])
                    DELAY = TIME + 2
                    STEP = 0
                    EXECUTE_BTP = false
                    COMPLETED_PROC.BTO_PROC_DONE = true
                    COMPLETED_PROC.BRKTEMP_CHK_DONE = false
                else
                    return
                end
            end
        end
    else
        local rindex = math.random(5)
        play_sound(READY[rindex])
        EXECUTE_BTP = false
    end
end

---- ENTER RWY
function enter_rwy()
    if FLT_PHASE.ON_RWY then
        if not COMPLETED_PROC.ENT_RWY_DONE then
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
                if not FLT_PHASE.TAXI_IN then
                    if TIME >= DELAY then
                        STROBE_SW = 2
                        DELAY = TIME + 0.7
                        STEP = 1.3
                    else
                        return
                    end
                else
                    STEP = 1.3
                end
            end
            if STEP == 1.3 then
                if TIME >= DELAY then
                    LANDLT_L_SW = 2
                    LANDLT_R_SW = 2
                    DELAY = TIME + 0.7
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
                    STEP = 4
                else
                    return
                end
            end
            if STEP == 4 then
                if not FLT_PHASE.TAXI_IN then
                    if TIME >= DELAY then
                        if not speak_only_essencials then
                            play_sound(PACKS)
                        end
                        DELAY = TIME + 1
                        STEP = 4.5
                    else
                        return
                    end
                else
                    STEP = 0
                    EXECUTE_ENRWY = false
                    COMPLETED_PROC.ENT_RWY_DONE = true
                end
            end
            if STEP == 4.5 then
                if TIME >= DELAY then
                    if not PACKS_FOR_TO then
                        if PACK_1_STATE == 1 then
                            command_once(PACK_1_PB)
                        end
                        DELAY = TIME + 0.5
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
                    if PACK_2_STATE == 1 then
                        command_once(PACK_2_PB)
                    end
                    DELAY = TIME + 0.5
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
                    EXECUTE_ENRWY = false
                    COMPLETED_PROC.ENT_RWY_DONE = true
                else
                    return
                end
            end
        else
            EXECUTE_ENRWY = false
        end
    end
end

---- TAKE OFF PROCEDURE
function take_off_proc()
    if not COMPLETED_PROC.TO_PROC_DONE then
        if STEP == 0 then
            if TIME >= DELAY then
                if ENG_1_N1 > 50 and ENG_2_N1 > 50 then
                    STABLE1_CHECK = ENG_1_THR
                    STABLE2_CHECK = ENG_2_THR
                    STEP = 1
                    DELAY = TIME + 3
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 1 then
            if TIME >= DELAY then
                if ENG_1_THR == STABLE1_CHECK and ENG_2_THR == STABLE2_CHECK then
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
                    DELAY = TIME + 1
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
        if STEP == 3 then -- speeds check
            if TIME >= DELAY then
                if math.floor(IND_AIRSPEED) == 100 then
                    play_sound(N100)
                    DELAY = TIME + 1.179
                end
                if math.floor(IND_AIRSPEED) == V1_SPEED - 1 then
                    play_sound(V1)
                    DELAY = TIME + 0.992
                end
                if math.floor(IND_AIRSPEED) >= VR_SPEED then
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
                DELAY = TIME + 1.5
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
                else
                    STEP = 7
                    DELAY = TIME + 0.5
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
                        STEP = 8
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
                STEP = 8
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
                STEP = 8
            else
                return
            end
        end
        if STEP == 8 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(ENGINE_MODE_SELECTOR)
                end
                DELAY = TIME + 1.885
                STEP = 8.5
            else
                return
            end
        end
        if STEP == 8.5 then
            if TIME >= DELAY then
                if not speak_only_essencials then
                    play_sound(NORMAL)
                end
                ENG_Mode = 1
                DELAY = TIME + 1.129
                STEP = 0
                COMPLETED_PROC.TO_PROC_DONE = true
            else
                return
            end
        end
    end
end

---- CLEAN UP PROCEDURE (AUTO)
function clean_up_auto()
    if STEP_CLEAN == 0 then
        DELAY_CLEAN = TIME + 5
        STEP_CLEAN = 1
    end
    if STEP_CLEAN == 1 then
        if TIME >= DELAY_CLEAN then
            if FLAPS_LEVER_State ~= 0.25 then
                if STEP_SPEACH == 0 then
                    if math.floor(IND_AIRSPEED) > FLAP_RETRACT_SPEED + 4 then
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
                if math.floor(IND_AIRSPEED) > SLAT_RETRACT_SPEED + 5 then
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
                    COMPLETED_PROC.ACF_CLEAN = true
                else
                    return
                end
            end
        else
            return
        end
    end
end

---- FLAPS CHANGE UNDER COMMAND
function flaps_commanded_change()
    if command_FLPS_1UP then
        if STEP_CLEAN == 0 then
            EXECUTE_FLP = true  
            DELAY_CLEAN = TIME + 0.3
            STEP_CLEAN = 1
        end 
        if STEP_CLEAN == 1 then
            if TIME >= DELAY_CLEAN then
                play_sound(SPEED_CHECK)
                DELAY_CLEAN = TIME + 1
                STEP_CLEAN = 2
            else
                return
            end
        end
        if STEP_CLEAN == 2 then
            if TIME >= DELAY_CLEAN then
                if FLAPS_LEVER_State > 0.25 then
                    if math.floor(IND_AIRSPEED) > FLAP_RETRACT_SPEED then
                        command_once(FLAPS_1UP)
                        STEP_CLEAN = 3
                    else
                        return
                    end
                elseif FLAPS_LEVER_State == 0.25 then
                    if math.floor(IND_AIRSPEED) > SLAT_RETRACT_SPEED then
                        command_once(FLAPS_1UP)
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
                    EXECUTE_FLP = false
                else
                    return
                end
            else
                return
            end
        end
    elseif command_FLPS_1DN then
        if STEP_CLEAN == 0 then
            EXECUTE_FLP = true
            DELAY_CLEAN = TIME + 0.3
            STEP_CLEAN = 1
        end
        if STEP_CLEAN == 1 then
            if TIME >= DELAY_CLEAN then
                play_sound(SPEED_CHECK)
                lindex = math.floor((FLAPS_LEVER_State * 4) + 1)
                DELAY_CLEAN = TIME + 1
                STEP_CLEAN = 2
            else
                return
            end
        end
        if STEP_CLEAN == 2 then
            if TIME >= DELAY_CLEAN then
                if math.floor(IND_AIRSPEED) < FLAPS_LIMIT[lindex] then
                    command_once(FLAPS_1DOWN)
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
                    EXECUTE_FLP = false
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

---- GEAR CHANGE UNDER COMMAND
function gear_command()
    if command_GUP then
        if STEP_FLT == 0 then
            EXECUTE_GEAR = true
            DELAY_CHECK = TIME + 0.88
            STEP_FLT = 1
        end
        if STEP_FLT == 1 then
            if TIME >= DELAY_CHECK then
                if math.floor(IND_AIRSPEED) <= GEAR_RETRACTION_LIMIT then
                    play_sound(GEAR_UP)
                    LG_Lever = 0
                    command_GUP = false
                    EXECUTE_GEAR = false
                    STEP_FLT = 0
                else
                    return
                end
            else
                return
            end
        end
    elseif command_GDN then
        if STEP_FLT == 0 then
            EXECUTE_GEAR = true
            DELAY_CHECK = TIME + 1.052
            STEP_FLT = 1
        end
        if STEP_FLT == 1 then
            if TIME >= DELAY_CHECK then
                if math.floor(IND_AIRSPEED) <= GEAR_EXTENTION_LIMIT then
                    play_sound(GEAR_DOWN)
                    LG_Lever = 1
                    STEP_FLT = 2
                else
                    return
                end
            else
                return
            end
        end
        if STEP_FLT == 2 then
            if LG_NG_State == 2 and LG_RG_State == 2 and LG_LG_State == 2 then
                play_sound(GEAR_3GREENS)
                DELAY = TIME + 1.054
                DELAY_CLEAN = TIME + 1.054
                STEP_FLT = 0
                EXECUTE_GEAR = false
                command_GDN = false
            else
                return
            end
        end
    end
end

---- 10.000FT CLB PROCEDURE
function ten_thausand_feet_CLB()
    if STEP == 0 then
        if fo_autoperform then
            play_sound(TEN_THAUSAND_FEET)
            DELAY = TIME + 1.2
            STEP = 2
        else
            DELAY = TIME + 1.2
            STEP = 2
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
            DELAY = TIME + 0.5
            STEP = 2.4
        else
            return
        end
    end
    if STEP == 2.4 then
        if TIME >= DELAY then
            LANDLT_L_SW = 0
            LANDLT_R_SW = 0
            DELAY = TIME + 0.5
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
            DELAY = TIME + 0.7
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
            local rindex = math.random(5)
            play_sound(READY[rindex])
            DELAY = TIME + 2
            STEP = 0
            EXECUTE_10FT_CLB = false
            COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = true
        else
            return
        end
    end
end

---- 10.000FT DES PROCEDURE
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
            DELAY = TIME + 0.5
            STEP = 1.4
        else
            return
        end
    end
    if STEP == 1.4 then
        if TIME >= DELAY then
            LANDLT_L_SW = 2
            LANDLT_R_SW = 2
            DELAY = TIME + 0.5
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
            DELAY = TIME + 0.7
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
            if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP or APP_TYPE.LDA_APP or APP_TYPE.FLS then
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
            if RAINING then
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
            EXECUTE_10FT_DES = false
            COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = true
        else
            return
        end
    end
end

---- AP DISCONECT
function ap_discn_behaviour()
    if STEP_AP == 0 then
        if AP_DISCN_ALARM == 1 then
            if not APP_TYPE.ILS_APP and not APP_TYPE.MLS_APP then
                DELAY_AP = TIME + 2
                STEP_AP = 1
            else
                STEP_AP = 0
                COMPLETED_PROC.AP_DISCN_PROC = true
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
            DELAY_AP = TIME + 0.7
            STEP_AP = 3
        else
            return
        end
    end
    if STEP_AP == 3 then
        if TIME >= DELAY_AP then
            command_once(FD_FO_PB)
            DELAY_AP = TIME + 0.7
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
            COMPLETED_PROC.AP_DISCN_PROC = true
        else
            return
        end
    end
end

---- GO ARROUND PROCEDURE
function go_arround()
    if not COMPLETED_PROC.GA_PROC then
        if STEP == 0 then
            DELAY = TIME + 0.25
            STEP = 1
            CHECKLIST.APP_CL = false
            CHECKLIST.ATO_CL = false
            CHECKLIST.LND_CL = false
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
                if VERTICAL_SPEED > 700 then
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
                    STEP = 6
                    command_GUP = false
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 6 then
            if TIME >= DELAY then
                if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP then
                    COMPLETED_PROC.GA_PROC = true
                    STEP = 0
                else
                    play_sound(FLIGHT_DIRECTORS)
                    DELAY = TIME + 2
                    DELAY_SPEACH = TIME + 1.2
                    STEP = 7
                end
            else
                return
            end
        end
        if STEP == 7 then
            if TIME >= DELAY then
                command_once(FD_FO_PB)
                DELAY = TIME + 0.7
                STEP = 8
            else
                return
            end
        end
        if STEP == 8 then
            if TIME >= DELAY then
                command_once(FD_CAP_PB)
                DELAY = TIME + 0.7
                STEP = 9
            else
                return
            end
        end
        if STEP == 9 then
            if TIME >= DELAY then
                command_once(HDGTRK_TOGGLE)
                DELAY = TIME + 0.5
                STEP = 10
            else
                return
            end
        end
        if STEP == 10 then
            if TIME >= DELAY_SPEACH then
                play_sound(ON)
                DELAY = TIME + 0.836
                STEP = 0
                COMPLETED_PROC.GA_PROC = true
            else
                return
            end
        end
    end
end

---- TOUCH DOWN PROCEDURE
function touch_down()
    if not COMPLETED_PROC.DECEL_CALLOUTS then
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
                    CHECK_SPEED = math.floor(IND_AIRSPEED) - 10
                else
                    return
                end
            else
                return
            end
        end
        if STEP == 2 then
            if TIME >= DELAY then
                if math.floor(IND_AIRSPEED) < CHECK_SPEED then
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
                if math.floor(IND_AIRSPEED) < 60 then
                    play_sound(N60_KNOTS)
                    DELAY = TIME + 1.4
                    STEP = 0
                    COMPLETED_PROC.DECEL_CALLOUTS = true
                end
            end
        end
    end
end

---- AFTER LANDING PROCEDURE
function after_landing_proc()
    if STEP == 0 then
        if TIME >= DELAY then
            DELAY = TIME + 0.4
            STEP = 1
            EXECUTE_AL_PROC = true
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
            RADAR_SYS_SW = 1
            DELAY = TIME + 0.920
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
                DELAY = TIME + 1.629
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
    if STEP == 11 then
        if TIME >= DELAY then
           if not speak_only_essencials then
                play_sound(STARTING_APU)
           end
           command_once(APU_START_PB)
           DELAY = TIME + 1.750
           STEP = 12
        else
            return
        end
    end
    if STEP == 12 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(TERRAIN)
            end
            DELAY = TIME + 0.825
            STEP = 13
        else
            return
        end
    end
    if STEP == 13 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(OFF)
            end
            command_once(TERRAIN_FO_PB)
            DELAY = TIME + 0.92
            STEP = 14
        else
            return
        end
    end
    if STEP == 14 then
        if TIME >= DELAY then
            if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP then
                command_once(FD_FO_PB)
                DELAY = TIME + 0.5
                STEP = 15
            else
                STEP = 15
            end
        else
            return
        end
    end
    if STEP == 15 then
        if TIME >= DELAY then
            if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP or APP_TYPE.FLS then
                command_once(LS_FO_PB)
                DELAY = TIME + 0.7
                STEP = 16
            else
                STEP = 16
            end
        else
            return
        end
    end
    if  STEP == 16 then
        if TIME >= DELAY then
            if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP then
                STEP = 17
            else
                command_once(HDGTRK_TOGGLE)
                DELAY = TIME + 0.5
                STEP = 17
            end
        else
            return
        end
    end
    if STEP == 17 then
        if TIME >= DELAY then
           local rindex = math.random(5)
           play_sound(READY[rindex])
           DELAY = TIME + 3
           STEP = 0
           EXECUTE_AL_PROC = false
           COMPLETED_PROC.AL_PROC = true
        else
            return
        end
    end
end

---- BRAKE TEMP CHECK PROCEDURE
function brake_temp_check()
    if BRAKE1_TEMP > 150 or BRAKE2_TEMP > 150 or BRAKE3_TEMP > 150 or BRAKE4_TEMP > 150 then
        if not speak_only_essencials then
            play_sound(BRAKE_FAN)
        end
        command_once(BRKFAN_PB)
        DELAY = TIME + 1.173
        COMPLETED_PROC.BRKTEMP_CHK_DONE = true
    else
        COMPLETED_PROC.BRKTEMP_CHK_DONE = true
    end
end

---- VACATING RWY
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
            TAXILT_SW = 1
            DELAY = TIME + 0.871
            STEP = 5
        else
            return
        end
    end
    if STEP == 5 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(TCAS)
            end
            DELAY = TIME + 1.218
            STEP = 6
        else
            return
        end
    end
    if STEP == 6 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(SET)
            end
            TCAS_SW = 2
            DELAY = TIME + 0.871
            STEP = 0
            EXECUTE_EXRWY = false
            COMPLETED_PROC.EXIT_RWY_DONE = false
        else
            return
        end
    end
end

-- PARKING PROCEDURE
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
    if STEP == 2 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(ON)
            end
            command_once(APU_BLEED_PB)
            DELAY = TIME + 0.92
            STEP = 3
        else
            return
        end
    end
    if STEP == 3 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(FUEL_PUMPS)
            end
            DELAY = TIME + 0.5
            STEP = 4
        else
            return
        end
    end
    if STEP == 4 then
        if TIME >= DELAY then
            command_once(FPUMP_LTANK_1_PB)
            command_once(FPUMP_LTANK_2_PB)
            DELAY = TIME + 0.7
            STEP = 5
        else
            return
        end
    end
    if STEP == 5 then
        if TIME >= DELAY then
            command_once(FPUMP_CTANK_1_PB)
            command_once(FPUMP_CTANK_2_PB)
            DELAY = TIME + 0.7
            STEP = 6
        else
            return
        end
    end
    if STEP == 6 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(OFF)
            end
            command_once(FPUMP_RTANK_1_PB)
            command_once(FPUMP_RTANK_2_PB)
            DELAY = TIME + 0.920
            STEP = 7
        else
            return
        end
    end
    if STEP == 7 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(ATC)
            end
            DELAY = TIME + 1.039
            STEP = 8
        else
            return
        end
    end
    if STEP == 8 then
        if TIME >= DELAY then
            if not speak_only_essencials then
                play_sound(SET)
            end
            TCAS_SW = 0
            DELAY = TIME + 0.871
            STEP = 9
        else
            return
        end
    end
    if STEP == 9 then
        if TIME >= DELAY then
            local rindex = math.random(5)
            play_sound(READY[rindex])
            DELAY = TIME + 2
            STEP = 0
            COMPLETED_PROC.PARK_PROC = true
        else
            return
        end
    end
end

function one_engine_taxi_DEP()
    if STEP_ONEENG == 0 then
        if TAXILT_SW ~= 0 then
            play_sound(YELLOW_HYDRAULIC_PUMP)
            DELAY = TIME + 1.250
            STEP_ONEENG = 1
        else
            return
        end
    end
    if STEP_ONEENG == 1 then
        if TIME >= DELAY then
            play_sound(ON)
            Y_ELEC_PUMP_PB = 1
            DELAY = TIME + 0.920
            STEP_ONEENG = 2
        else
            return
        end
    end
    if STEP_ONEENG == 2 then
        if START_ENG2 then
            if STEARING_DEGREES <= 2 and STEARING_DEGREES >= -2 then
                DELAY = TIME + 1.2
                STEP_ONEENG = 3
            end
        else
            return
        end
    end
    if STEP_ONEENG == 3 then
        if TIME >= DELAY then
            play_sound(YELLOW_HYDRAULIC_PUMP)
            DELAY = TIME + 1.25
            STEP_ONEENG = 4
        else
            return
        end
    end
    if STEP_ONEENG == 4 then
        if TIME >= DELAY then
            play_sound(OFF)
            Y_ELEC_PUMP_PB = 0
            DELAY = TIME + 0.920
            STEP_ONEENG = 5
        else
            return
        end
    end
    if STEP_ONEENG == 5 then
        if TIME >= DELAY then
            play_sound(APU_BLEED)
            DELAY = TIME + 1.003
            STEP_ONEENG = 6
        else
            return
        end
    end
    if STEP_ONEENG == 6 then
        if TIME >= DELAY then
            if APU_BLEED_STATE == 0 then
                command_once(APU_BLEED_PB)
            end
            play_sound(ON)
            DELAY = TIME + 0.920
            STEP_ONEENG = 7
        else
            return
        end
    end
    if STEP_ONEENG == 7 then
        if TIME >= DELAY then
            play_sound(ENGINE_MODE_SELECTOR)
            DELAY = TIME + 1.685
            STEP_ONEENG = 8
        else
            return
        end
    end
    if STEP_ONEENG == 8 then
        if TIME >= DELAY then
            play_sound(IGNITION)
            ENG_Mode = 2
            DELAY = TIME + 10
            STEP_ONEENG = 9
        else
            return
        end
    end
    if STEP_ONEENG == 9 then
        if TIME >= DELAY then
            play_sound(STARTING_NUMBER_2)
            ENG_2_Master = 1
            DELAY = TIME + 1.186
            STEP_ONEENG = 10
        else
            return
        end
    end
    if STEP_ONEENG == 10 then
        if TIME >= DELAY then
            if ENG_2_AVAIL == 1 then
                play_sound(ENGINE2)
                DELAY = TIME + 0.865
                STEP_ONEENG = 11
            else
                return
            end
        else
            return
        end
    end
    if STEP_ONEENG == 11 then
        if TIME >= DELAY then
            play_sound(AVAIL)
            DELAY = TIME + 1.154
            STEP_ONEENG = 12
            START_ENG2 = false
        else
            return
        end
    end
    if STEP_ONEENG == 12 then
        if TIME >= DELAY then
            play_sound(CHECK_TIME)
            command_once(CRONO_SET_PB)
            DELAY = TIME + 1.109
            STEP_ONEENG = 13
        else
            return
        end
    end
    if STEP_ONEENG == 13 then
        if TIME >= DELAY then
            play_sound(ENGINE_MODE_SELECTOR)
            DELAY = TIME + 1.685
            STEP_ONEENG = 14
        else
            return
        end
    end
    if STEP_ONEENG == 14 then
        if TIME >= DELAY then
            play_sound(NORMAL)
            ENG_Mode = 1
            DELAY = TIME + 1.129
            STEP_ONEENG = 15
        else
            return
        end
    end
    if STEP_ONEENG == 15 then
        if TIME >= DELAY then
            play_sound(APU_BLEED)
            DELAY = TIME + 1.003
            STEP_ONEENG = 16
        else
            return
        end
    end
    if STEP_ONEENG == 16 then
        if TIME >= DELAY then
            if not APU_TO_PACKS then
                play_sound(OFF)
                command_once(APU_BLEED_PB)
                DELAY = TIME + 0.920
                STEP_ONEENG = 17
            else
                play_sound(ON)
                DELAY = TIME + 0.92
                STEP_ONEENG = 19
            end
        end
    end
    if STEP_ONEENG == 17 then
        if TIME >= DELAY then
            play_sound(APU_MASTER)
            DELAY = TIME + 1.218
            STEP_ONEENG = 18
        else
            return
        end
    end
    if STEP_ONEENG == 18 then
        if TIME >= DELAY then
            play_sound(OFF)
            command_once(APU_MASTER_PB)
            DELAY = TIME + 0.92
            STEP_ONEENG = 19
        else
            return
        end
    end
    if STEP_ONEENG == 19 then
        if TIME >= DELAY then
            play_sound(CROSS_BLEED)
            DELAY = TIME + 0.827
            STEP_ONEENG = 20
        else
            return
        end
    end
    if STEP_ONEENG == 20 then
        if TIME >= DELAY then
            play_sound(AUTO)
            XBLEED_SW = 1
            DELAY = TIME + 0.68
            STEP_ONEENG = 21
        else
            return
        end
    end
    if STEP_ONEENG == 21 then
        if TIME >= DELAY then
            play_sound(ECAM_STATUS)
            DELAY = TIME + 1.322
            STEP_ONEENG = 22
        else
            return
        end
    end
    if STEP_ONEENG == 22 then
        if TIME >= DELAY then
            play_sound(CHECK)
            DELAY = TIME + 0.839
            STEP_ONEENG = 22.1
        else
            return
        end
    end
    if STEP_ONEENG == 22.1 then
        if TIME >= DELAY then
            play_sound(ENGINE2)
            DELAY = TIME + 0.865
            STEP_ONEENG = 22.2
        else
            return
        end
    end
    if STEP_ONEENG == 22.2 then
        if TIME >= DELAY then
            play_sound(ANTI_ICE)
            DELAY = TIME + 1.227
            STEP_ONEENG = 22.3
        end
    end
    if STEP_ONEENG == 22.3 then
        if TIME >= DELAY then
            if RAINING and OAT < 10 then
                command_once(ANTI_ICE_ENG2_PB)
            end
            play_sound(SET)
            DELAY = TIME + 0.871
            STEP_ONEENG = 23
        else
            return
        end
    end
    if STEP_ONEENG == 23 then
        if TIME >= DELAY then
            CHECKLIST.EX_AS_CL = true
            STEP_ONEENG = 24
        else
            return
        end
    end
    if STEP_ONEENG == 24 then
        if CHECKLIST.AS_CL then
            if TIME >= DELAY then
                if not COMPLETED_PROC.FLTCTL_CHK then
                    flt_ctl_chk()
                else
                    STEP_ONEENG = 25
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_ONEENG == 25 then
        if TIME >= DELAY then
            play_sound(AUTOBRAKES)
            DELAY = TIME + 1.010
            STEP_ONEENG = 26
        else
            return
        end
    end
    if STEP_ONEENG == 26 then
        if TIME >= DELAY then
            play_sound(MAX)
            command_once(AUTOBRK_MAX_PB)
            DELAY = TIME + 0.5
            STEP_ONEENG = 27
        else
            return
        end
    end
    if STEP_ONEENG == 27 then
        if TIME >= DELAY then
            command_once(TO_CONFIG_PB)
            DELAY = TIME + 0.471
            STEP_ONEENG = 28
        else
            return
        end
    end
    if STEP_ONEENG == 28 then
        if TIME >= DELAY then
            local rindex = math.random(5)
            play_sound(READY[rindex])
            DELAY = TIME + 2
            STEP_ONEENG = 29
        else
            return
        end
    end
    if STEP_ONEENG == 29 then
        if TIME >= DELAY then
            if CRONO >= 180 then
                local rindex = math.random(3)
                play_sound(READY_FOR_TO[rindex])
                DELAY = TIME + 1.649
                STEP_ONEENG = 30
            else
                return
            end
        else
            return
        end
    end
    if STEP_ONEENG == 30 then
        if TIME >= DELAY then
            command_once(CRONO_SET_PB)
            DELAY = TIME + 0.5
            STEP_ONEENG = 31
        else
            return
        end
    end
    if STEP_ONEENG == 31 then
        if TIME >= DELAY then
            command_once(CRONO_RESET_PB)
            DELAY = TIME + 0.5
            STEP_ONEENG = 0
            EXECUTE_OETD = false
            ONEENG_TAXI_DEP = false
        else
            return
        end
    end
end

function one_engine_taxi_ARR()
    if STEP_ONEENG == 0 then
        if TIME >= DELAY then
            if APU_STATE == 1 then
                DELAY = TIME + 0.7
                STEP_ONEENG = 1
            else
                return
            end
        else
            return
        end
    end
    if STEP_ONEENG == 1 then
        if TIME >= DELAY then
            play_sound(ENGINE_2_SHUTDOWN)
            DELAY = TIME + 0.7
            STEP_ONEENG = 2
        else
            return
        end
    end
    if STEP_ONEENG == 2 then
        if TIME >= DELAY then
            ENG_2_Master = 0
            DELAY = TIME + 0.652
            STEP_ONEENG = 3
        else
            return
        end
    end
    if STEP_ONEENG == 3 then
        if TIME >= DELAY then
            play_sound(YELLOW_HYDRAULIC_PUMP)
            Y_ELEC_PUMP_PB = 1
            DELAY = TIME + 1.450
            STEP_ONEENG = 4
        else
            return
        end
    end
    if STEP_ONEENG == 4 then
        if TIME >= DELAY then
            play_sound(ON)
            Y_ELEC_PUMP_PB = 0
            DELAY = TIME + 0.920
            STEP_ONEENG = 0
            ONEENG_TAXI_ARR_AVAIL = false
            EXECUTE_OETA = false
        else
            return
        end
    end
end
-- //////////////////////////////
-- ///////// CHECKLISTS /////////
-- //////////////////////////////

-- BEFORE START CHECKLIST
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
                if COMPLETED_PROC.PF_DONE then
                    play_sound(COMPLETED)
                    DELAY_CHECK = TIME + 0.957
                    if APP_TYPE.AR_DEP then
                        STEP_CHECK = 6.1
                    else
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
    if STEP_CHECK == 6.1 then
        if TIME >= DELAY_CHECK then
            play_sound(NAVAIDS_DESELECTION)
            DELAY_CHECK = TIME + 1.436
            STEP_CHECK = 6.2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6.2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.839
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
                if SEATBELTS_SW == 1 and SIGNS_STATE == 1 then
                    play_sound(ON_AUTO)
                    DELAY_CHECK = TIME + 1.6
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
                play_sound(CHECK)
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
            DELAY = TIME + 1.5
            STEP_CHECK = 0
            CHECKLIST.EX_BS_DTL = false
            CHECKLIST.BS_DTL = true
            CHECKLIST.PARK_CL = false
            CHECKLIST.SEC_CL = false
        else
            return
        end
    end
end

-- BEFORE_START_CHECKLIST BELOW THE LINE
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
                if TCAS_SW == 2 then
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
            play_sound(BEACON)
            DELAY_CHECK = TIME + 0.836
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if BEACON_STATE == 1 then
                    play_sound(ON)
                    DELAY_CHECK = TIME + 0.920
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
            play_sound(THRUST_LEVERS)
            DELAY_CHECK = TIME + 1.476
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(IDLE)
                DELAY_CHECK = TIME + 0.79
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
            play_sound(PARKING_BRAKE)
            DELAY_CHECK = TIME + 0.836
            STEP_CHECK = 12
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 12 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.82
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
            play_sound(CHECKLIST_COMPLETED)
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_BS_CL = false
            CHECKLIST.BS_CL = true
        else
            return
        end
    end
end

-- AFTER START CHECKLIST
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
            play_sound(PITCHTRM)
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
                if PT_TO_CONFIG == math.floor(PITCH_TRIM * 10) / 10 then
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
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_AS_CL = false
            CHECKLIST.AS_CL = true
        else
            return
        end
    end
end

-- BEFORE TAKEOFF CHECKLIST
function checklist_before_takeoff()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(BEFORE_TAKEOFF_CHECKLIST)
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
            play_sound(BRIEFING)
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
                if COMPLETED_PROC.TO_BRIEFING then
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
                play_sound(FLAP_CONFIG[CONFIG_VOICE_SRCH])
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
            DELAY = TIME + 1.182
            STEP_CHECK = 0
            CHECKLIST.EX_BTO_DTL = false
            CHECKLIST.BTO_DTL = true
        else
            return
        end
    end
end

-- BEFORE TAKEOFF CHECKLIST BELOW THE LINE
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
                if TCAS_SW == 4 then
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
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if RAINING then
                    if ENG_Mode == 2 then
                        play_sound(IGNITION)
                        DELAY_CHECK = TIME + 1.095
                        STEP_CHECK = 11
                    end
                elseif ENG_Mode == 1 then
                    play_sound(NORMAL)
                    DELAY_CHECK = TIME + 1.129
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
            play_sound(PACKS_AND_APU_BLEED)
            DELAY_CHECK = TIME + 1.616
            STEP_CHECK = 12
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 12 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if PACKS_FOR_TO then
                    if PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 0 then
                        play_sound(CHECK)
                        DELAY_CHECK = TIME + 0.839
                        STEP_CHECK = 13
                    end
                elseif APU_TO_PACKS then
                    if PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 1 then
                        play_sound(CHECK)
                        DELAY_CHECK = TIME + 0.839
                        STEP_CHECK = 13
                    end
                else
                    if PACK_1_STATE == 0 and PACK_2_STATE == 0 and APU_BLEED_STATE == 0 then
                        play_sound(CHECK)
                        DELAY_CHECK = TIME + 0.839
                        STEP_CHECK = 13
                    end
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
            play_sound(CHECKLIST_COMPLETED)
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_BTO_CL = false
            CHECKLIST.BTO_CL = true
        else
            return
        end
    end
end

-- AFTER TAKEOFF CHECKLIST
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
                if LG_Lever == 0 then
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
                    DELAY_CHECK = TIME + 0.943
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
                if PACK_1_STATE == 1 and PACK_2_STATE == 1 then
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
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_ATO_CL = false
            CHECKLIST.ATO_CL = true
        else
            return
        end
    end
end

-- CLIMB CHECKLIST
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
            play_sound(CHECKLIST_COMPLETED)
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_CLB_CL = false
            CHECKLIST.CLB_CL = true
        else
            return
        end
    end
end

-- APPROACH CHECKLIST
function checklist_approach()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(APPROACH_CHECKLIST)
            DELAY_CHECK = TIME + 1.515
            if APP_TYPE.RNAVAR_APP then
                STEP_CHECK = 0.1
            else
                STEP_CHECK = 1
            end
        else
            return
        end
    end
    if STEP_CHECK == 0.1 then
        if TIME >= DELAY_CHECK then
            play_sound(NAVAIDS_DESELECTION)
            DELAY_CHECK = TIME + 1.436
            STEP_CHECK = 0.2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 0.2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(CHECK)
                DELAY_CHECK = TIME + 0.839
                STEP_CHECK = 0.3
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 0.3 then
        if TIME >= DELAY_CHECK then
            play_sound(GPS_NAV_MODE)
            DELAY_CHECK = TIME + 1.272
            STEP_CHECK = 0.4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 0.4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(BOTH_NAV)
                DELAY_CHECK = TIME + 0.939
                STEP_CHECK = 1
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(BRIEFING)
            DELAY_CHECK = TIME + 0.845
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if COMPLETED_PROC.DES_BRIEFING then
                    play_sound(COMPLETED)
                    DELAY_CHECK = TIME + 0.957
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
                if APP_TYPE.CAT_II_III then
                    STEP_CHECK = 4.1
                else
                    STEP_CHECK = 5
                end
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 4.1 then
        if TIME >= DELAY_CHECK then
            play_sound(SIGNS)
            DELAY_CHECK = TIME + 0.872
            STEP_CHECK = 4.2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4.2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(ON_ON)
                DELAY_CHECK = TIME + 0.97
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
            play_sound(BARO_REFERENCE)
            DELAY_CHECK = TIME + 1.433
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.920
                STEP_CHECK = 7
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 5 then
        if TIME >= DELAY_CHECK then
            play_sound(MINIMUMS)
            DELAY_CHECK = TIME + 1.067
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.920
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
            play_sound(ENGINE_MODE_SELECTOR)
            DELAY_CHECK = TIME + 1.885
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if RAINING then
                    if ENG_Mode == 2 then
                        play_sound(IGNITION)
                        DELAY_CHECK = TIME + 1.095
                        STEP_CHECK = 9
                    end
                elseif ENG_Mode == 1 then
                    play_sound(NORMAL)
                    DELAY_CHECK = TIME + 1.129
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
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_APP_CL = false
            CHECKLIST.APP_CL = true
        else
            return
        end
    end
end

-- LANDING CHECKLIST
function checklist_landing()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(LANDING_CHECKLIST)
            DELAY_CHECK = TIME + 1.375
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(CABIN_CREW)
            DELAY_CHECK = TIME + 1.145
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(ADVISED)
                DELAY_CHECK = TIME + 1.036
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
            play_sound(AUTO_TRHUST)
            DELAY_CHECK = TIME + 1.183
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
            play_sound(AUTOBRAKES)
            DELAY_CHECK = TIME + 1.212
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if AUTOBRK_LOW == 1 then
                    play_sound(LOW)
                elseif AUTOBRK_MED == 1 then
                    play_sound(MEDIUM)
                end
                DELAY_CHECK = TIME + 0.910
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
            play_sound(ECAM_MEMO)
            DELAY_CHECK = TIME + 1.138
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                DELAY_CHECK = TIME + 0.5
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
            play_sound(CHECKLIST_COMPLETED)
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_LND_CL = false
            CHECKLIST.LND_CL = true
        else
            return
        end
    end
end

-- AFTER LANDING CHECKLIST
function checklist_after_landing()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(AFTER_LANDING_CHECKLIST)
            DELAY_CHECK = TIME + 1.795
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(FLAPS)
            DELAY_CHECK = TIME + 1.112
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(FLAP_POS[FL_VOICE_SRCH])
                DELAY_CHECK = TIME + 1.429
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
            play_sound(SPOILERS)
            DELAY_CHECK = TIME + 1.276
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if SPDBRK_Lever == 0 then
                    play_sound(DISARMED)
                    DELAY_CHECK = TIME + 1.027
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
            play_sound(APU)
            DELAY_CHECK = TIME + 1.187
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if APU_STATE == 1 then
                    play_sound(AVAIL)
                    DELAY_CHECK = TIME + 1.154
                else
                    play_sound(STARTING_APU)
                    DELAY_CHECK = TIME + 1.740
                end
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
            play_sound(WEATHER_RADAR)
            DELAY_CHECK = TIME + 1.209
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if RADAR_SYS_SW == 1 then
                    play_sound(OFF)
                    DELAY_CHECK = TIME + 0.920
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
            play_sound(PWS)
            DELAY_CHECK = TIME + 1.286
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if PWS_SW == 0 then
                    play_sound(OFF)
                    DELAY_CHECK = TIME + 0.920
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
            play_sound(CHECKLIST_COMPLETED)
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_AL_CL = false
            CHECKLIST.AL_CL = true
        else
            return
        end
    end
end

-- PARKING CHECKLIST
function checklist_parking()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(PARKING_CHECKLIST)
            DELAY_CHECK = TIME + 1.251
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(APU_BLEED)
            DELAY_CHECK = TIME + 1.203
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if APU_BLEED_STATE == 1 then
                    play_sound(ON)
                    DELAY_CHECK = TIME + 0.839
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
            play_sound(ENGINES)
            DELAY_CHECK = TIME + 0.977
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if ENG_1_Master == 0 and ENG_2_Master == 0 then
                    play_sound(OFF)
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
            play_sound(SEAT_BELTS)
            DELAY_CHECK = TIME + 1.289
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if SEATBELTS_SW == 0 then
                    play_sound(OFF)
                    DELAY_CHECK = TIME + 0.839
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
            play_sound(EXTERIOR_LIGHTS)
            DELAY_CHECK = TIME + 1.740
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.871
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
            play_sound(FUEL_PUMPS)
            DELAY_CHECK = TIME + 1.153
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if FPUMP_RTANK_1_STATE == 0 and
                   FPUMP_RTANK_2_STATE == 0 and
                   FPUMP_CTANK_1_STATE == 0 and
                   FPUMP_CTANK_2_STATE == 0 and
                   FPUMP_LTANK_1_STATE == 0 and
                   FPUMP_LTANK_2_STATE == 0 then
                    play_sound(OFF)
                    DELAY_CHECK = TIME + 0.839
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
            play_sound(PARKING_BRAKE)
            DELAY_CHECK = TIME + 1.213
            STEP_CHECK = 12
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 12 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if PRKBRK_SW == 1 then
                    play_sound(ON)
                    DELAY_CHECK = TIME + 0.839
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
            play_sound(EFB)
            DELAY_CHECK = TIME + 1.042
            STEP_CHECK = 15
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 15 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(SET)
                DELAY_CHECK = TIME + 0.871
                STEP_CHECK = 16
            else
                return
            end
        else
            return
        end
    end
    if STEP_CHECK == 16 then
        if TIME >= DELAY_CHECK then
            play_sound(CHECKLIST_COMPLETED)
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_PARK_CL = false
            CHECKLIST.PARK_CL = true
            CHECKLIST.BS_DTL = false
            CHECKLIST.BS_CL = false
            CHECKLIST.AS_CL = false
            CHECKLIST.BTO_DTL = false
            CHECKLIST.BTO_CL = false
            CHECKLIST.ATO_CL = false
            COMPLETED_PROC.TO_PROC_DONE = false
            COMPLETED_PROC.DECEL_CALLOUTS = false
            CHECKLIST.CLB_CL = false
            CHECKLIST.APP_CL = false
            CHECKLIST.LND_CL = false
            CHECKLIST.AL_CL = false
            MINUTE3 = false
        else
            return
        end
    end
end

-- SECURING CHECKLIST
function checklist_securing()
    if STEP_CHECK == 0 then
        if TIME >= DELAY_CHECK then
            play_sound(SECURING_CHECKLIST)
            DELAY_CHECK = TIME + 1.533
            STEP_CHECK = 1
        else
            return
        end
    end
    if STEP_CHECK == 1 then
        if TIME >= DELAY_CHECK then
            play_sound(ADIRS)
            DELAY_CHECK = TIME + 0.993
            STEP_CHECK = 2
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 2 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if ADIR_1_STATE == 0 and ADIR_2_STATE == 0 and ADIR_3_STATE == 0 then
                    play_sound(OFF)
                    DELAY_CHECK = TIME + 0.920
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
            play_sound(OXYGEN)
            DELAY_CHECK = TIME + 1.013
            STEP_CHECK = 4
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 4 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(OFF)
                DELAY_CHECK = TIME + 0.920
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
            play_sound(APU_BLEED)
            DELAY_CHECK = TIME + 1.203
            STEP_CHECK = 6
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 6 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                if APU_BLEED_STATE == 0 then
                    play_sound(OFF)
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
            play_sound(EMERGENCY_EXIT_LIGHTS)
            DELAY_CHECK = TIME + 1.655
            STEP_CHECK = 8
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 8 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(OFF)
                DELAY_CHECK = TIME + 0.920
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
            play_sound(NO_PORTABLE_SIGNS)
            DELAY_CHECK = TIME + 1.412
            STEP_CHECK = 10
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 10 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(OFF)
                DELAY_CHECK = TIME + 0.920
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
            play_sound(APU_AND_BATTERY)
            DELAY_CHECK = TIME + 1.551
            STEP_CHECK = 12
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 12 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(OFF)
                DELAY_CHECK = TIME + 0.920
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
            play_sound(EFB)
            DELAY_CHECK = TIME + 1.042
            STEP_CHECK = 14
            response_CHECK = false
        else
            return
        end
    end
    if STEP_CHECK == 14 then
        if TIME >= DELAY_CHECK then
            if response_CHECK then
                play_sound(OFF)
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
            play_sound(CHECKLIST_COMPLETED)
            DELAY = TIME + 1.602
            STEP_CHECK = 0
            CHECKLIST.EX_SEC_CL = false
            CHECKLIST.SEC_CL = true
        else
            return
        end
    end
end

---- //////////////////////////////
---- ///////// MAIN LOGIC /////////
---- //////////////////////////////

-- ACTUAL FLIGHT PHASE
function phase_check()
    if FLT_PHASE.PREFLIGHT then
        TXT_PHASE = "Preflight"
        if CHECKLIST.BS_CL then
            FLT_PHASE.PREFLIGHT = false
            FLT_PHASE.PUSHBACK = true
            COMPLETED_PROC.PARK_PROC = false
        end
    end
    if FLT_PHASE.PUSHBACK then
        TXT_PHASE = "Pushback"
        if ENG_Mode == 2 then
            FLT_PHASE.ENG_START = true
        end
        if TAXILT_SW > 0 then
            FLT_PHASE.ENG_START = false
            FLT_PHASE.PUSHBACK = false
            FLT_PHASE.TAXI_OUT = true
        end
        if BEACON_STATE == 0 and not FLT_PHASE.ENG_START then
            FLT_PHASE.PUSHBACK = false
            FLT_PHASE.PREFLIGHT = true
        end
    end
    if EXECUTE_ENRWY then
        FLT_PHASE.ON_RWY = true
        COMPLETED_PROC.EXIT_RWY_DONE = false
    end
    if EXECUTE_EXRWY then
        FLT_PHASE.ON_RWY = false
        COMPLETED_PROC.ENT_RWY_DONE = false
    end
    if FLT_PHASE.TAXI_OUT then
        TXT_PHASE = "Taxi Out"
        if THR_LEVER >= 2 then
            FLT_PHASE.TAKEOFF = true
            FLT_PHASE.TAXI_OUT = false
            COMPLETED_PROC.AS_PROC_DONE = false
        end
        if ENG_1_Master == 0 and ENG_2_Master == 0 and BEACON_STATE == 0 then
            FLT_PHASE.PARKING = true
            FLT_PHASE.TAXI_OUT = false
        end
    end
    if FLT_PHASE.TAKEOFF then
        TXT_PHASE = "Takeoff"
        if GNDAIR_SW == 0 then
            FLT_PHASE.ON_RWY = false
        end
        if ENG_1_REV ~= 0 or ENG_2_REV ~= 0 then
            STEP = 0
            FLT_PHASE.REJECTED = true
            FLT_PHASE.TAKEOFF = false
        end
        if THR_STATE == 1 and CHECKLIST.ATO_CL then
            TXT_PHASE = "Climb"
            FLT_PHASE.CLIMB = true
            APP_TYPE.AR_DEP = false
            RAINING = false
            FLT_PHASE.TAKEOFF = false
            COMPLETED_PROC.BTO_PROC_DONE = false
            COMPLETED_PROC.ACF_CLEAN = false
            COMPLETED_PROC.AL_PROC = false
        end
    end
    if FLT_PHASE.REJECTED then
        TXT_PHASE = "Rejected"
        if ENG_1_REV == 0 and ENG_2_REV == 0 then
            FLT_PHASE.REJECTED = false
            FLT_PHASE.REJECTED_DES = true
        end
    end
    if FLT_PHASE.CLIMB or FLT_PHASE.CRUISE or FLT_PHASE.DESCEND then
        if string.find(FMA_G_STATE, "CLB") then
            TXT_PHASE = "Climb"
            FLT_PHASE.CLIMB = true
            FLT_PHASE.CRUISE = false
            FLT_PHASE.DESCEND = false
        end
        if string.find(FMA_G_STATE, "CRZ") then
            TXT_PHASE = "Cruise"
            FLT_PHASE.CLIMB = false
            FLT_PHASE.CRUISE = true
            FLT_PHASE.DESCEND = false
        end
        if string.find(FMA_G_STATE, "DES") then
            TXT_PHASE = "Descend"
            FLT_PHASE.CLIMB = false
            FLT_PHASE.CRUISE = false
            FLT_PHASE.DESCEND = true
        end
        if CHECKLIST.APP_CL then
            FLT_PHASE.CLIMB = false
            FLT_PHASE.CRUISE = false
            FLT_PHASE.DESCEND = false
            FLT_PHASE.APPROACH = true
            COMPLETED_PROC.AP_DISCN_PROC = false
        end
    end
    if FLT_PHASE.APPROACH then
        TXT_PHASE = "Approach"
        if CHECKLIST.LND_CL then
            FLT_PHASE.APPROACH = false
            FLT_PHASE.FINAL_APP = true
            COMPLETED_PROC.GA_PROC = false
        end
    end
    if FLT_PHASE.FINAL_APP then
        TXT_PHASE = "Final APP"
        if THR_LEVER == 3 then
            FLT_PHASE.FINAL_APP = false
            FLT_PHASE.GA = true
            COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = false
            COMPLETED_PROC.DES_BRIEFING = false
        end
        if ENG_1_REV > 0 or ENG_2_REV > 0 then
            FLT_PHASE.FINAL_APP = false
            FLT_PHASE.DECELERATION = true
            FLT_PHASE.ON_RWY = true
            COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = false
            COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = false
        end
    end
    if FLT_PHASE.GA then
        TXT_PHASE = "Go Arround"
        if THR_STATE == 1 then
            FLT_PHASE.GA = false
            FLT_PHASE.TAKEOFF = true
        end
    end
    if FLT_PHASE.DECELERATION then
        TXT_PHASE = "Decel"
        if ENG_1_REV == 0 and ENG_2_REV == 0 then
            FLT_PHASE.DECELERATION = false
            RAINING = false
            FLT_PHASE.TAXI_IN = true
        end
    end
    if FLT_PHASE.TAXI_IN then
        TXT_PHASE = "Taxi In"
        if CRONO > 180 and not COMPLETED_PROC.OETA_DONE and not MINUTE3 then
            play_sound(CRONO3)
            ONEENG_TAXI_ARR_AVAIL = true
            MINUTE3 = true
        end
        if PRKBRK_SW == 1 and ENG_1_Master == 0 and ENG_2_Master == 0 then
            FLT_PHASE.TAXI_IN = false
            FLT_PHASE.PARKING = true
        end
    end
    if FLT_PHASE.PARKING then
        TXT_PHASE = "Parking"
        if CHECKLIST.PARK_CL then
            MINUTE3 = false
            FLT_PHASE.PARKING = false
            FLT_PHASE.PREFLIGHT = true
            COMPLETED_PROC.PF_DONE = false
            COMPLETED_PROC.TO_BRIEFING = false
            COMPLETED_PROC.FLTCTL_CHK = false
            APP_TYPE.ILS_APP = false
            APP_TYPE.MLS_APP = false
            APP_TYPE.RNAV_APP = false
            APP_TYPE.RNAVAR_APP = false
            APP_TYPE.VOR_APP = false
            APP_TYPE.NDB_APP = false
            APP_TYPE.LDA_APP = false
            APP_TYPE.FLS = false
            APP_TYPE.CAT_II_III = false
        end
    end
end

do_every_frame("phase_check()")

-- FO/PM MAIN LOGIC
function FO_main_logic()
    if FLT_PHASE.PREFLIGHT then
        if EXECUTE_PCP then
            pre_cockpit_pre()
        end
    end
    if FLT_PHASE.ENG_START then
        if not COMPLETED_PROC.AS_PROC_DONE then
            if ENG_Mode == 1 then
                after_start_proc()
            end
        end
    end
    if EXECUTE_OETD and not CHECKLIST.EX_BTO_DTL and not EXECUTE_BTP then
        one_engine_taxi_DEP()
    end
    if FLT_PHASE.TAXI_OUT then
        if EXECUTE_BTP then
            before_takeoff_proc()
        end
        if EXECUTE_ENRWY then
            enter_rwy()
        end
        if EXECUTE_EXRWY then
            vacating_rwy()
        end
    end
    if CHECKLIST.BTO_CL and not COMPLETED_PROC.TO_PROC_DONE and not FLT_PHASE.REJECTED then
        take_off_proc()
    end
    if FLT_PHASE.REJECTED then
        touch_down()
    end
    if GNDAIR_SW == 0 then
        if not FLT_PHASE.GA or not EXECUTE_FLP then
            gear_command()
        end
        if not EXECUTE_GEAR then
            flaps_commanded_change()
        end
    end
    if FLT_PHASE.TAKEOFF then
        if THR_STATE == 1 and fo_autoperform then
            clean_up_auto()
        end
    end
    if FLT_PHASE.CLIMB then
        if fo_autoperform then
            if not COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE and IND_ALTITUDE > 14000 then
                COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = false
                ten_thausand_feet_CLB()
            end
        elseif EXECUTE_10FT_CLB then
            COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = false
            ten_thausand_feet_CLB()
        end
    end
    if FLT_PHASE.DESCEND then
        if fo_autoperform then
            if not COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and IND_ALTITUDE < 14000 then
                ten_thausand_feet_DES()
            end
        elseif EXECUTE_10FT_DES then
            ten_thausand_feet_DES()
        end
    end
    if FLT_PHASE.FINAL_APP then
        ap_discn_behaviour()
    end
    if FLT_PHASE.GA then
        go_arround()
    end
    if FLT_PHASE.DECELERATION then
        touch_down()
    end
    if FLT_PHASE.TAXI_IN then
        if not COMPLETED_PROC.AL_PROC and SPDBRK_Lever == 0 then
            if not EXECUTE_EXRWY then
                after_landing_proc()
            end
        end
        if EXECUTE_EXRWY and not EXECUTE_AL_PROC then
            vacating_rwy()
        end
        if EXECUTE_ENRWY and not EXECUTE_AL_PROC then
            enter_rwy()
        end
        if EXECUTE_OETA then
            one_engine_taxi_ARR()
        end
        if CRONO >= 300 and not COMPLETED_PROC.BRKTEMP_CHK_DONE then
            brake_temp_check()
        end
    end
    if FLT_PHASE.PARKING then
        if not COMPLETED_PROC.BRKTEMP_CHK_DONE then
            brake_temp_check()
        end
        if not COMPLETED_PROC.PARK_PROC and COMPLETED_PROC.BRKTEMP_CHK_DONE then
            parking_proc()
        end
    end
end

do_every_frame("FO_main_logic()")

-- FO CHECKLIST LOGIC
function FO_checklist()
    if CHECKLIST.EX_BS_DTL then
        checklist_before_start()
    end
    if CHECKLIST.EX_BS_CL then
        checklist_before_start_BTL()
    end
    if CHECKLIST.EX_AS_CL then
        checklist_after_start()
    end
    if CHECKLIST.EX_BTO_DTL then
        checklist_before_takeoff()
    end
    if CHECKLIST.EX_BTO_CL then
        checklist_before_takeoff_BTL()
    end
    if CHECKLIST.EX_ATO_CL then
        checklist_after_takeoff()
    end
    if CHECKLIST.EX_CLB_CL then
        checklist_climb()
    end
    if CHECKLIST.EX_APP_CL then
        checklist_approach()
    end
    if CHECKLIST.EX_LND_CL then
        checklist_landing()
    end
    if CHECKLIST.EX_AL_CL then
        checklist_after_landing()
    end
    if CHECKLIST.EX_PARK_CL then
        checklist_parking()
    end
    if CHECKLIST.EX_SEC_CL then
        checklist_securing()
    end
end

do_every_frame("FO_checklist()")

-- /////////////////////////////////
-- ///////// IMGUI BUILDER /////////
-- /////////////////////////////////

-- SAVE CONFIGURATION FUNCTION
function config_save()
    local rute = SCRIPT_DIRECTORY .. "FO PM/FO COnfig.lua"
    local config = io.open(rute, "w")
    if config then
        config:write("--------------------------\n")
        config:write("---- FO CONFIGURATION ----\n")
        config:write("--------------------------\n\n")
        config:write("speak_only_essencials = " .. tostring(speak_only_essencials) .. "\n")
        config:write("fo_autoperform = " .. tostring(fo_autoperform) .. "\n")
        config:close()
    end
end

-- IMGUI CHECK AVAIL
if not SUPPORTS_FLOATING_WINDOWS then
    logMsg("imgui not supported by your FlyWithLua version")
    return
end

-- IMGUI VARIABLES
local WND_SETTINGS = false
local WND_MAIN = true
local WND_BREAFING = false
local DEPARTURE_BRIEFING_BLEED_OPT = 1
local setting_change = false

-- IMGUI BUILDER
function FO_imgui_builder(FO_INTERFACE, x, y)
    if WND_MAIN then -- MAIN WINDOW
        if imgui.SmallButton("Settings") then
            WND_SETTINGS = true
            WND_MAIN = false
            WND_BREAFING = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Breafing") then
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BREAFING = true
        end
        imgui.TextUnformatted("     ")
        imgui.SameLine()
        if imgui.SmallButton("X") then
            response_CHECK = true
        end
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("FLT Phase:")
        imgui.SameLine()
        imgui.TextUnformatted(TXT_PHASE)
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        -- CHECKLIST
        if FLT_PHASE.PREFLIGHT then
            if not CHECKLIST.BS_DTL and not CHECKLIST.EX_BS_DTL and not CHECKLIST.EX_SEC_CL and COMPLETED_PROC.PF_DONE then
                if imgui.SmallButton("Before Start CKL") then
                    CHECKLIST.EX_BS_DTL = true
                end
            end
            imgui.SameLine()
            if not CHECKLIST.SEC_CL and not CHECKLIST.EX_SEC_CL and not CHECKLIST.BS_DTL and not CHECKLIST.EX_BS_DTL then
                if imgui.SmallButton("Securing CKL") then
                    CHECKLIST.EX_SEC_CL = true
                end
            end
            if CHECKLIST.BS_DTL and not CHECKLIST.EX_BS_CL then
                if imgui.SmallButton("Before Start CKL BTL") then
                    CHECKLIST.EX_BS_CL = true
                end
            end
        end
        if FLT_PHASE.PUSHBACK then
            if not CHECKLIST.AS_CL and
               not CHECKLIST.EX_AS_CL and 
               COMPLETED_PROC.AS_PROC_DONE and
               not ONEENG_TAXI_DEP
               then
                if imgui.SmallButton("After Start CKL") then
                    CHECKLIST.EX_AS_CL = true
                end
            end
        end
        if FLT_PHASE.TAXI_OUT then
            if not CHECKLIST.BTO_DTL and not CHECKLIST.EX_BTO_DTL and COMPLETED_PROC.BTO_PROC_DONE then
                if imgui.SmallButton("Before Takeoff CKL") then
                    CHECKLIST.EX_BTO_DTL = true
                end
            end
            if CHECKLIST.BTO_DTL and not CHECKLIST.BTO_CL and COMPLETED_PROC.ENT_RWY_DONE and not CHECKLIST.EX_BTO_CL then
                if imgui.SmallButton("Before Takeoff CKL BTL") then
                    CHECKLIST.EX_BTO_CL = true
                end
            end
        end
        if FLT_PHASE.TAKEOFF then
            if COMPLETED_PROC.TO_PROC_DONE and not CHECKLIST.EX_ATO_CL then
                if imgui.SmallButton("After Takeoff CKL") then
                    CHECKLIST.EX_ATO_CL = true
                end
            end
        end
        if FLT_PHASE.CLIMB then
            if not CHECKLIST.CLB_CL and not CHECKLIST.EX_CLB_CL then
                if imgui.SmallButton("Climb CKL") then
                    CHECKLIST.EX_CLB_CL = true
                end
            end
        end
        if FLT_PHASE.DESCEND or FLT_PHASE.CLIMB then
            if COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and not CHECKLIST.EX_APP_CL then
                if imgui.SmallButton("Approach CKL") then
                    CHECKLIST.EX_APP_CL = true
                end
            end
        end
        if FLT_PHASE.APPROACH then
            if not CHECKLIST.LND_CL and not CHECKLIST.EX_LND_CL then
                if imgui.SmallButton("Landing CKL") then
                    CHECKLIST.EX_LND_CL = true
                end
            end
        end
        if FLT_PHASE.TAXI_IN then
            if not CHECKLIST.AL_CL and not CHECKLIST.EX_AL_CL and COMPLETED_PROC.AL_PROC then
                if imgui.SmallButton("After Landing CKL") then
                    CHECKLIST.EX_AL_CL = true
                end
            end
        end
        if FLT_PHASE.PARKING then
            if COMPLETED_PROC.PARK_PROC and not CHECKLIST.PARK_CL and not CHECKLIST.EX_PARK_CL then
                if imgui.SmallButton("Parking CKL") then
                    CHECKLIST.EX_PARK_CL = true
                end
            end
        end
        -- PROCEDURES
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        if FLT_PHASE.PREFLIGHT then
            if not COMPLETED_PROC.PF_DONE and not EXECUTE_PCP then
                if imgui.SmallButton("Preliminary Cockpit Prep.") then
                    EXECUTE_PCP = true
                end
            end
        end
        if FLT_PHASE.TAXI_OUT then
            if not COMPLETED_PROC.BTO_PROC_DONE and not EXECUTE_BTP then
                if imgui.SmallButton("Before Takeoff Proc.") then
                    EXECUTE_BTP = true
                end
            end
            imgui.SameLine()
            if not EXECUTE_ENRWY and not FLT_PHASE.ON_RWY then
                if imgui.SmallButton("Entry RWY") then
                    EXECUTE_ENRWY = true
                end
            end
            if not EXECUTE_EXRWY and FLT_PHASE.ON_RWY then
                if imgui.SmallButton("Exit RWY") then
                    EXECUTE_EXRWY = true
                end
            end
            if not START_ENG2 and ONEENG_TAXI_DEP and ENG_2_AVAIL ~= 1 then
                if imgui.SmallButton("Start ENG 2") then
                    START_ENG2 = true
                end
            end
        end
        if FLT_PHASE.REJECTED_DES then
            if imgui.SmallButton("Taxi OUT") then
                FLT_PHASE.REJECTED_DES = false
                FLT_PHASE.TAXI_OUT = true
                COMPLETED_PROC.DECEL_CALLOUTS = false
                CHECKLIST.BTO_CL = false
            end
            imgui.SameLine()
            if imgui.SmallButton("Taxi IN") then
                FLT_PHASE.REJECTED_DES = false
                FLT_PHASE.TAXI_IN = true
            end
        end
        if FLT_PHASE.CLIMB then
            if not COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE and not EXECUTE_10FT_CLB then
                if imgui.SmallButton("Crossing 10.000ft") then
                    EXECUTE_10FT_CLB = true
                end
            end
        end
        if FLT_PHASE.DESCEND then
            if not COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and not EXECUTE_10FT_DES then
                if imgui.SmallButton("Crossing 10.000ft") then
                    EXECUTE_10FT_DES = true
                end
            end
        end
        if FLT_PHASE.TAXI_IN then
            if not EXECUTE_ENRWY and not FLT_PHASE.ON_RWY then
                if imgui.SmallButton("Entry RWY") then
                    EXECUTE_ENRWY = true
                end
            end
            if not EXECUTE_EXRWY and FLT_PHASE.ON_RWY then
                if imgui.SmallButton("Exit RWY") then
                    EXECUTE_EXRWY = true
                end
            end
            if ONEENG_TAXI_ARR_AVAIL and not EXECUTE_OETA then
                if imgui.SmallButton("One Engine Taxi ARR") then
                    EXECUTE_OETA = true
                end
            end
        end
    end
    if WND_BREAFING then -- BREAFING WINDOW
        if imgui.SmallButton("Settings") then
            WND_SETTINGS = true
            WND_MAIN = false
            WND_BREAFING = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Main") then
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BREAFING = false
        end
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("FLT Phase:")
        imgui.SameLine()
        imgui.TextUnformatted(TXT_PHASE)
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        if FLT_PHASE.PREFLIGHT or FLT_PHASE.PUSHBACK or FLT_PHASE.TAXI_OUT then
            imgui.TextUnformatted("Departure Briefing")
            imgui.Spacing()
            if imgui.RadioButton("PACKS Off", DEPARTURE_BRIEFING_BLEED_OPT == 1) then
                DEPARTURE_BRIEFING_BLEED_OPT = 1
                PACKS_FOR_TO = false
                APU_TO_PACKS = false
            end
            imgui.SameLine()
            if imgui.RadioButton("PACKS On", DEPARTURE_BRIEFING_BLEED_OPT == 2) then
                DEPARTURE_BRIEFING_BLEED_OPT = 2
                PACKS_FOR_TO = true
                APU_TO_PACKS = false
            end
            imgui.SameLine()
            if imgui.RadioButton("APU to PACKS", DEPARTURE_BRIEFING_BLEED_OPT == 3) then
                DEPARTURE_BRIEFING_BLEED_OPT = 3
                PACKS_FOR_TO = false
                APU_TO_PACKS = true
            end
            imgui.TextUnformatted("Flaps:")
            imgui.SameLine()
            if FLAPS_TO_CONFIG == 1 then
                imgui.TextUnformatted("1+F")
            else
                imgui.TextUnformatted(FLAPS_TO_CONFIG)
            end
            imgui.TextUnformatted("V1:")
            imgui.SameLine()
            imgui.TextUnformatted(V1_SPEED)
            imgui.SameLine()
            imgui.TextUnformatted("VR:")
            imgui.SameLine()
            imgui.TextUnformatted(VR_SPEED)
            imgui.SameLine()
            imgui.TextUnformatted("V2:")
            imgui.SameLine()
            imgui.TextUnformatted(V2_SPEED)
            imgui.TextUnformatted("Raining:")
            imgui.SameLine()
            if imgui.RadioButton("No", not RAINING) then
                RAINING = false
            end
            imgui.SameLine()
            if imgui.RadioButton("Yes", RAINING) then
                RAINING = true
            end
            local dep_change, change = imgui.Checkbox("AR Departure", APP_TYPE.AR_DEP)
            if dep_change then
                APP_TYPE.AR_DEP = change
            end
            local dep_change, change = imgui.Checkbox("ONE Engine DEP", ONEENG_TAXI_DEP)
            if dep_change then
                ONEENG_TAXI_DEP = change
            end
            if not COMPLETED_PROC.TO_BRIEFING then
                if imgui.SmallButton("CONFIRM") then
                    local bindex = math.random(4)
                    play_sound(BRIEFING_CONF[bindex])
                    COMPLETED_PROC.TO_BRIEFING = true
                    DELAY = TIME + 3
                end
            end
        end
        if FLT_PHASE.CLIMB or FLT_PHASE.CRUISE or FLT_PHASE.DESCEND or FLT_PHASE.APPROACH then
            imgui.TextUnformatted("Arrival Breafing")
            if imgui.RadioButton("ILS/MLS", APP_TYPE.ILS_APP or APP_TYPE.MLS_APP) then
                APP_TYPE.ILS_APP = true
                APP_TYPE.MLS_APP = true
                APP_TYPE.RNAV_APP = false
                APP_TYPE.RNAVAR_APP = false
                APP_TYPE.VOR_APP = false
                APP_TYPE.NDB_APP = false
                APP_TYPE.LDA_APP = false
                APP_TYPE.FLS = false
            end
            imgui.SameLine()
            if imgui.RadioButton("CAT II/III", APP_TYPE.CAT_II_III) then
                APP_TYPE.ILS_APP = true
                APP_TYPE.MLS_APP = true
                APP_TYPE.CAT_II_III = true
                APP_TYPE.RNAV_APP = false
                APP_TYPE.RNAVAR_APP = false
                APP_TYPE.VOR_APP = false
                APP_TYPE.NDB_APP = false
                APP_TYPE.LDA_APP = false
                APP_TYPE.FLS = false
            end
            if imgui.RadioButton("RNAV", APP_TYPE.RNAV_APP) then
                APP_TYPE.ILS_APP = false
                APP_TYPE.MLS_APP = false
                APP_TYPE.CAT_II_III = false
                APP_TYPE.RNAV_APP = true
                APP_TYPE.RNAVAR_APP = false
                APP_TYPE.VOR_APP = false
                APP_TYPE.NDB_APP = false
                APP_TYPE.LDA_APP = false
            end
            imgui.SameLine()
            if imgui.RadioButton("FLS", APP_TYPE.FLS) then
                APP_TYPE.ILS_APP = false
                APP_TYPE.MLS_APP = false
                APP_TYPE.CAT_II_III = false
                APP_TYPE.RNAVAR_APP = false
                APP_TYPE.FLS = true
            end
            if imgui.RadioButton("RNP AR", APP_TYPE.RNAVAR_APP) then
                APP_TYPE.ILS_APP = false
                APP_TYPE.MLS_APP = false
                APP_TYPE.CAT_II_III = false
                APP_TYPE.RNAV_APP = false
                APP_TYPE.RNAVAR_APP = true
                APP_TYPE.VOR_APP = false
                APP_TYPE.NDB_APP = false
                APP_TYPE.LDA_APP = false
                APP_TYPE.FLS = false
            end
            if imgui.RadioButton("VOR/NDB", APP_TYPE.VOR_APP or APP_TYPE.NDB_APP) then
                APP_TYPE.ILS_APP = false
                APP_TYPE.MLS_APP = false
                APP_TYPE.CAT_II_III = false
                APP_TYPE.RNAV_APP = false
                APP_TYPE.RNAVAR_APP = false
                APP_TYPE.VOR_APP = true
                APP_TYPE.NDB_APP = true
                APP_TYPE.LDA_APP = false
            end
            imgui.SameLine()
            if imgui.RadioButton("LDA", APP_TYPE.LDA_APP) then
                APP_TYPE.ILS_APP = false
                APP_TYPE.MLS_APP = false
                APP_TYPE.CAT_II_III = false
                APP_TYPE.RNAV_APP = false
                APP_TYPE.RNAVAR_APP = false
                APP_TYPE.VOR_APP = false
                APP_TYPE.NDB_APP = false
                APP_TYPE.LDA_APP = true
                APP_TYPE.FLS = false
            end
            if imgui.RadioButton("Raining", RAINING) then
                RAINING = true
            end
            if not COMPLETED_PROC.DES_BRIEFING then
                if imgui.SmallButton("CONFIRM") then
                    local bindex = math.random(4)
                    play_sound(BRIEFING_CONF[bindex])
                    COMPLETED_PROC.DES_BRIEFING = true
                    DELAY = TIME + 3
                end
            end
        end
    end
    if WND_SETTINGS then -- SETTINGS WINDOW
        if imgui.SmallButton("Main") then
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BREAFING = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Breafing") then
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BREAFING = true
        end
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        local setting_change, change = imgui.Checkbox("Speak Only Essencials", speak_only_essencials)
        if setting_change then
            speak_only_essencials = change
            config_save()
        end
        local setting_change, change = imgui.Checkbox("FO Auto Perfomr", fo_autoperform)
        if setting_change then
            fo_autoperform = change
            config_save()
        end
    end
end

-- FLOAT WINDOWS MASTER
FO_INTERFACE = nil

function show_interface()
    local posX = (SCREEN_WIDTH / 1.08) - (250 / 2)
    local posY = (SCREEN_HEIGHT / 1.15) - (125 / 2)
    FO_INTERFACE = float_wnd_create(250, 125, 1, true)
    float_wnd_set_title(FO_INTERFACE, "FO/PM")
    float_wnd_set_position(FO_INTERFACE, posX, posY)
    float_wnd_set_imgui_builder(FO_INTERFACE, "FO_imgui_builder")
end


function hide_interface()
    if FO_INTERFACE then
        float_wnd_destroy(FO_INTERFACE)
    end
end

FOinterface_show_only_once = 0
FOinterface_hide_only_once = 0

function toggle_interface()
	show_wnd = not show_wnd
	if show_wnd then
		if FOinterface_show_only_once == 0 then
			show_interface()
			FOinterface_show_only_once = 1
			FOinterface_hide_only_once = 0
		end
	else
		if FOinterface_hide_only_once == 0 then
			hide_interface()
			FOinterface_hide_only_once = 1
			FOinterface_show_only_once = 0
		end
	end
end

-- MACRO/COMMANDS
add_macro("FO/PM", "show_interface()", "hide_interface()", "deactivate")
create_command("Toliss_A32S_FO/Show_Interface", "open/close FO interface", "toggle_interface()", "", "")
create_command("Toliss_A32S_FO/Checklist_Response", "Confirm validation for Checklist", "response_CHECK = not response_CHECK", "", "")
create_command("Toliss_A32S_FO/Command_GEAR_UP", "Command Gear UP", "command_GUP = not command_GUP", "", "")
create_command("Toliss_A32S_FO/Command_GEAR_DN", "Command Gear DN", "command_GDN = not command_GDN", "", "")
create_command("Toliss_A32S_FO/Command_FLAPS_1_UP", "Command FLAPS 1 Position UP", "command_FLPS_1UP = not command_FLPS_1UP", "", "")
create_command("Toliss_A32S_FO/Command_FLAPS_1_DN", "Command FLAPS 1 Position DN", "command_FLPS_1DN = not command_FLPS_1DN", "", "")

logMsg("XXXXX FO/PM LOADED")
end -- LUA ENDS
