-----------------------------------------
----- //// TOLISS FO / PM V1.0 //// -----
-----------------------------------------

logMsg("XXXXX   FO/PM Initiate")

-- PLANE CHECK
local COMPATIBLE_ACF = {
    A319 = true,
    A320 = true,
    A20N = true,
    A321 = true,
    A21N = true
}
dataref("ACF_ICAO", "sim/aircraft/view/acf_ICAO", "readonly")
dataref("ACF_UI_Name","sim/aircraft/view/acf_ui_name","readonly")
if COMPATIBLE_ACF[ACF_ICAO] then -- LUA START
if string.find(string.lower(ACF_UI_Name),"toliss") then
logMsg("XXXXX   ACF Compatible")
dataref("TIME", "sim/time/total_running_time_sec", "readonly")

-- /////////////////////////////////
-- ///// FOPM MAIN CONFIG LOAD /////
-- /////////////////////////////////

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

-- VOICE PACK CONFIG LOAD
dofile(SCRIPT_DIRECTORY.."/FO PM/Voices/Active/FO Voicepack conf.lua")
logMsg("XXXXX   Voices Pack Config Loaded")

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
FOPM_TL_COMPLETED_PROC = {
    PF_DONE = false,
    TO_BRIEFING = false,
    AS_PROC_DONE = false,
    TAXI_PROC_DONE = false,
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
FOPM_TL_CHECKLIST = {
    CP_CL = false,
    EX_CP_CL = false,
    BS_CL = false,
    EX_BS_CL = false,
    BS_CL_BTL = false,
    EX_BS_CL_BTL = false,
    AS_CL = false,
    EX_AS_CL = false,
    TX_CL = false,
    EX_TX_CL = false,
    DC_CL = true,
    EX_DC_CL = false,
    BTO_CL = false,
    EX_BTO_CL = false,
    LU_CL = false,
    EX_LU_CL = false,
    BTO_CL_BTL = false,
    EX_BTO_CL_BTL = false,
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
FOPM_Procedures_Control = {
    EXECUTE_PCP = false,
    EXECUTE_ASP = false,
    EXECUTE_TXP = false,
    EXECUTE_BTP = false,
    EXECUTE_10FT_CLB = false,
    EXECUTE_10FT_DES = false,
    ONEENG_TAXI_DEP = false,
    EXECUTE_OETD = false,
    START_ENG2 = false,
    EXECUTE_AL_PROC = false,
    EXECUTE_ENRWY = false,
    EXECUTE_EXRWY = false,
    ONEENG_TAXI_ARR_AVAIL = false,
    EXECUTE_OETA = false,
    EXECUTE_FLP = false,
    EXECUTE_GEAR = false,
}

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

FOPM_DELAY_VARIABLE = {
    DELAY = 0,
    DELAY_CHECK = 0,
    DELAY_CLEAN = 0,
    DELAY_SPEACH = 0,
    DELAY_AP = 0,
    DELAY_AL = 0,
}
FOPM_STEP_VARIABLE = {
    STEP = 0,
    STEP_FLT = 0,
    STEP_CLEAN = 0,
    STEP_SPEACH = 0,
    STEP_AP = 0,
    STEP_AL = 0,
    STEP_CHECK = 0,
    STEP_ONEENG = 0,
    PROC_STEP = 0,
    CKLST_STEP = 0,
    DES_MADED = false
}
FOPM_CONFIG_VARIABLE = {
    PT_TO_DIRECTION = 0,
    PT_TO_ANGLE = 0,
    PT_TO_CONFIG = 0,
    RAINING = false,
    PACKS_FOR_TO = false,
    APU_TO_PACKS = false,
    FLAP_RETRACT_SPEED = 0,
    SLAT_RETRACT_SPEED = 0,
    GREENDOT = 0,
    CHECK_SPEED = 0,
    F_TARGET = 0,
    F_ATARGET = 0,
    TXT_PHASE = nil,
    MINUTE3 = false,
    PASSED_TRANS_ALT = false,
    PASSED_TRANS_LVL= false,
    AUTOBRAKES = {
        LOW = true,
        MEDIUM = true
    },
    IAE_SD_TIME = math.floor(TIME),
    TO_RWY = "-"
}

-- FLIGHT PARAMETERS VARIABLES
local FPMTR = {
    SPDDELAY = 0,
    SINKDELAY = 0,
    BANKDELAY = 0,
    PITCHDELAY = 0,
    LOCDELAY = 0,
    GLIDEDELAY = 0,
    XTRKDELAY = 0,
    CONT_APP = true
}

logMsg("XXXXX   Variables Loaded")

-------------------------
---- ENGINE THR MATH ----
-------------------------

local STABLE1_CHECK = 0
local STABLE2_CHECK = 0
local ENG_THR_Rating = 0
local ENG_1_THR = 0
local ENG_2_THR = 0

function engine_math()
    if ENG_MODEL == 0 then
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


------------------------------
---- FLAPS TO VOICE CHECK ----
------------------------------

local FLAP_VOICE_DIR = {"P0", "P1", "P2", "P3", "FULL"}
local CONFIG_VOICE_DIR = {"CP1", "CP2", "CP3"}
local CONFIG_VOICE_SRCH = "CP1"
local FL_VOICE_SRCH = "P0"
local FLUP_VOICE_SRCH = "P0"
local lindex = 1

function flaps_voice_search()
    local index = math.floor((FLAPS_LEVER_State * 4) + 1)
    FL_VOICE_SRCH = FLAP_VOICE_DIR[index]
    FLUP_VOICE_SRCH = FLAP_VOICE_DIR[(index - 1)]
    CONFIG_VOICE_SRCH = CONFIG_VOICE_DIR[(index - 1)]
end

do_every_frame("flaps_voice_search()")

---------------------------------------
---- PROCEDURES AND CHECKLIST LOAD ----
---------------------------------------

-- PROCEDURES LOAD
dofile(SCRIPT_DIRECTORY.."/FO PM/Procedures-Checklists/"..prcl_to_load.."/Procedures.lua")
logMsg("XXXXX   Procedures Loaded")

-- CHECKLISTS LOAD
dofile(SCRIPT_DIRECTORY.."/FO PM/Procedures-Checklists/"..prcl_to_load.."/Checklists.lua")
logMsg("XXXXX   Checklists Loaded")

-- //////////////////////////////
-- ///////// PROCEDURES /////////
-- //////////////////////////////

---- FLIGHT_CONTROLS_CHECK
function flt_ctl_chk()
    if FOPM_STEP_VARIABLE.STEP_FLT == 0 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "FLIGHT_CONTROLS_CHECK"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP_FLT = 1
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "ELEVATOR"
            play_sound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 1.25
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1.25 then
        if math.floor(ELEVATORS + 0.3) == -30 then
            local speech = "FULL_UP"
            play_sound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 1.5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1.5 then
        if math.floor(ELEVATORS + 0.3) == 15 then
            local speech = "FULL_DOWN"
            play_sound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 1.75
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1.75 then
        if math.floor(ELEVATORS + 0.3) == 0 then
            local speech = "NEUTRAL"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP_FLT = 2
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "AILERONS"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP_FLT = 2.25
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2.25 then
        if math.floor(LALERONS + 0.3) == 25 and math.floor(RALERONS + 0.3) == -20 then
            local speech = "FULL_LEFT"
            play_sound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 2.5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2.5 then
        if math.floor(LALERONS + 0.3) == -20 and math.floor(RALERONS + 0.3) == 25 then
            local speech = "FULL_RIGHT"
            play_sound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 2.75
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2.75 then
        if math.floor(LALERONS + 0.3) == 5 and math.floor(RALERONS + 0.3) == 5 then
            local speech = "NEUTRAL"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + 0.955
            FOPM_STEP_VARIABLE.STEP_FLT = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "RDR"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP_FLT = 3.25
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 3.25 then
        if ACF_ICAO == "A321" or ACF_ICAO == "A320" or ACF_ICAO == "A319" then
            if math.floor(RUDDER + 0.3) == -25 then
                local speech = "FULL_LEFT"
                play_sound(FOPM_Talk[speech])
                FOPM_STEP_VARIABLE.STEP_FLT = 3.5
            else
                return
            end
        else
            if math.floor(RUDDER + 0.3) == -30 then
                local speech = "FULL_LEFT"
                play_sound(FOPM_Talk[speech])
                FOPM_STEP_VARIABLE.STEP_FLT = 3.5
            else
                return
            end
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 3.5 then
        if ACF_ICAO == "A321" or ACF_ICAO == "A320" or ACF_ICAO == "A319" then
            if math.floor(RUDDER + 0.3) == 25 then
                local speech = "FULL_RIGHT"
                play_sound(FOPM_Talk[speech])
                FOPM_STEP_VARIABLE.STEP_FLT = 3.75
            else
                return
            end
        else
            if math.floor(RUDDER + 0.3) == 30 then
                local speech = "FULL_RIGHT"
                play_sound(FOPM_Talk[speech])
                FOPM_STEP_VARIABLE.STEP_FLT = 3.75
            else
                return
            end
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 3.75 then
        if math.floor(RUDDER + 0.3) == 0 then
            local speech = "NEUTRAL"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP_FLT = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            FOPM_TL_COMPLETED_PROC.FLTCTL_CHK = true
            FOPM_STEP_VARIABLE.STEP_FLT = 0
        else
            return
        end
    end
end

---- PRELIMINARY COCKPIT PREPARATION
function pre_cockpit_pre()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        FOPM_STEP_VARIABLE.STEP = 1
        FOPM_STEP_VARIABLE.PROC_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].step_desition then
                if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                    else
                        if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                            if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                                local dataref_name = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                                _G[dataref_name] = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                            elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                                command_once(FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                            end
                        end
                        if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item then
                            if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                        FOPM_STEP_VARIABLE.DES_MADED = true
                        FOPM_STEP_VARIABLE.STEP = 2
                    end
                else
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item then
                        if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                    if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                        if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                            local dataref_name = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                        elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                            command_once(FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                        end
                    end
                    if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].check then
                        if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item == "EXTERNAL_CHECK" or FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "EXTERNAL_CHECK" then
                            if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        end
                    end
                end
            else
                if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item then
                    if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                        if not speak_only_essencials then
                            local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        else
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    end
                elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                    if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                        local dataref_name = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                        _G[dataref_name] = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                    elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                        command_once(FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                    end
                end
                FOPM_STEP_VARIABLE.STEP = 2
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].check then
                if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                    if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state then
                        if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                            if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FL_VOICE_SRCH
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FL_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                            end
                        else
                            if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 3
                    FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                else
                    if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_check then
                        if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref then
                            local dataref_name = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command then
                            command_once(FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command)
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                            if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item then
                                local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + 10
                            elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + 10
                            end
                        end
                    end
                end
            elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action then
                if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state then
                    if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                        if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FL_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                        end
                    else
                        if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref then
                    local dataref_name = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                    _G[dataref_name] = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref
                elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action.command then
                    command_once(FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action.command)
                elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action.delay then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].action.delay
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            elseif FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state then
                if not FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                    if not speak_only_essencials then
                        local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                else
                    local speech = FOPM_procedure.Pre_cockpit_preparation[FOPM_STEP_VARIABLE.PROC_STEP].state
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            else
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_STEP_VARIABLE.PROC_STEP > #FOPM_procedure.Pre_cockpit_preparation then
                local rindex = math.random(5)
                play_sound(READY[rindex])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del) + fo_speed
                command_once(MCDU_FO_KEY_Fpln)
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_STEP_VARIABLE.PROC_STEP = 0
                FOPM_TL_COMPLETED_PROC.PF_DONE = true
                FOPM_Procedures_Control.EXECUTE_PCP = false
            else
                FOPM_STEP_VARIABLE.STEP = 1
            end
        end
    end
end

---- AFTER START PROCEDURE
function after_start_proc()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        FOPM_STEP_VARIABLE.STEP = 1
        FOPM_STEP_VARIABLE.PROC_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].step_desition then
                if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                    else
                        if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                                local dataref_name = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                                _G[dataref_name] = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                            elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                                command_once(FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                            end
                        end
                        if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                            if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                        FOPM_STEP_VARIABLE.DES_MADED = true
                        FOPM_STEP_VARIABLE.STEP = 2
                    end
                else
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                        if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                    if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                        if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                            local dataref_name = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                            command_once(FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                        end
                    end
                    if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check then
                        if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "TRIM_CHECK" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "TRIM_CHECK" then
                            FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION = string.match(MCDU_BLINE_3, "([UPDN]+)")
                            FOPM_CONFIG_VARIABLE.PT_TO_ANGLE = string.match(MCDU_BLINE_3, "/.-[UPDN]+(%d+%.%d+)")
                            FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_1, "(%d+)"))
                            FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_2, "(%d+)"))
                            FOPM_CONFIG_VARIABLE.GREENDOT = tonumber(string.match(MCDU2_GLINE_3,"(%d+)"))
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_CONFIG_VARIABLE.PT_TO_CONFIG = FOPM_CONFIG_VARIABLE.PT_TO_ANGLE * 1
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                                command_begin(PITCH_TRIM_UP)
                            else
                                FOPM_CONFIG_VARIABLE.PT_TO_CONFIG = FOPM_CONFIG_VARIABLE.PT_TO_ANGLE * -1
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                                command_begin(PITCH_TRIM_DN)
                            end
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "TRIM_STOP" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "TRIM_STOP" then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                command_end(PITCH_TRIM_DN)
                                command_end(PITCH_TRIM_UP)
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "OETD CHECK" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "OETD CHECK" then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                                FOPM_Procedures_Control.EXECUTE_OETD = true
                                FOPM_STEP_VARIABLE.STEP = 3
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLTCTLCHK" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLTCTLCHK" then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                                FOPM_STEP_VARIABLE.STEP = 3
                            else
                                flt_ctl_chk()
                            end
                        end
                    end
                end
            else
                if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                    if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                        if not speak_only_essencials then
                            local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        else
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    end
                elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                    if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                        local dataref_name = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                        _G[dataref_name] = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                    elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                        command_once(FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                    end
                end
                FOPM_STEP_VARIABLE.STEP = 2
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check then
                if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                    if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state then
                        if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                            if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = CONFIG_VOICE_SRCH
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = CONFIG_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                            end
                        else
                            if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 3
                    FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                else
                    if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check then
                        if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref then
                            local dataref_name = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command then
                            command_once(FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command)
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                                local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + 10
                            elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + 10
                            end
                        end
                    end
                end
            elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action then
                if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state then
                    if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                        if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = CONFIG_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                        end
                    else
                        if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref then
                    local dataref_name = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                    _G[dataref_name] = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref
                elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.command then
                    command_once(FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.command)
                elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.delay then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.delay
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state then
                if not FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                    if not speak_only_essencials then
                        local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                else
                    local speech = FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            else
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_STEP_VARIABLE.PROC_STEP > #FOPM_procedure.After_start_procedure then
                local rindex = math.random(5)
                play_sound(READY[rindex])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del) + fo_speed
                command_once(MCDU_FO_KEY_Fpln)
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_STEP_VARIABLE.PROC_STEP = 0
                FOPM_TL_COMPLETED_PROC.AS_PROC_DONE = true
                FOPM_Procedures_Control.EXECUTE_ASP = false
            else
                FOPM_STEP_VARIABLE.STEP = 1
            end
        end
    end
end

---- TAXI PROCEDURE
function taxi_proc()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        FOPM_STEP_VARIABLE.STEP = 1
        FOPM_STEP_VARIABLE.PROC_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].step_desition then
                if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                    else
                        if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                                local dataref_name = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                                _G[dataref_name] = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                            elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                                command_once(FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                            end
                        end
                        if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                            if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                        FOPM_STEP_VARIABLE.DES_MADED = true
                        FOPM_STEP_VARIABLE.STEP = 2
                    end
                else
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                        if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                    if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                        if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                            local dataref_name = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                        elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                            command_once(FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                        end
                    end
                    if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check then
                        if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "WEATHER_RADAR" or FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "WEATHER_RADAR" then
                            radar_pos = math.random(2)
                            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "ENGINE_MODE_SELECTOR" or FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "ENGINE_MODE_SELECTOR" then
                            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "BRAKE_TEMP" or FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "BRAKE_TEMP" then
                            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                local rindex = math.random(3)
                                play_sound(BRAKE_WARNINGS[rindex])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (BRAKE_WARN[rindex].del)
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "TEMP_CHECK" or FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "TEMP_CHECK" then
                            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                local rindex = math.random(5)
                                play_sound(READY[rindex])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP - 1
                            end
                        elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "ON_OETD" or FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "ON_OETD" then
                            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 3
                                FOPM_STEP_VARIABLE.STEP = 3
                            end
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "OETD CHECK" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "OETD CHECK" then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                                FOPM_Procedures_Control.EXECUTE_OETD = true
                                FOPM_STEP_VARIABLE.STEP = 3
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLTCTLCHK" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLTCTLCHK" then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                                FOPM_STEP_VARIABLE.STEP = 3
                            else
                                flt_ctl_chk()
                            end
                        end
                    end
                end
            else
                if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                    if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                        if not speak_only_essencials then
                            local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        else
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    end
                elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                    if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                        local dataref_name = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                        _G[dataref_name] = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                    elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                        command_once(FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                    end
                end
                FOPM_STEP_VARIABLE.STEP = 2
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check then
                if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                    if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state then
                        if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                            if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = CONFIG_VOICE_SRCH
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = CONFIG_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                            end
                        else
                            if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 3
                    FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                else
                    if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check then
                        if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref then
                            local dataref_name = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command then
                            command_once(FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command)
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                            if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item then
                                local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + 10
                            elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + 10
                            end
                        end
                    end
                end
            elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action then
                if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state then
                    if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                        if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = CONFIG_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                        end
                    else
                        if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref then
                    local dataref_name = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                    _G[dataref_name] = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref
                elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.command then
                    command_once(FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.command)
                elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.delay then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].action.delay
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            elseif FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state then
                if not FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                    if not speak_only_essencials then
                        local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                else
                    local speech = FOPM_procedure.Taxi_procedure[FOPM_STEP_VARIABLE.PROC_STEP].state
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            else
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_STEP_VARIABLE.PROC_STEP > #FOPM_procedure.Taxi_procedure then
                local rindex = math.random(5)
                play_sound(READY[rindex])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del) + fo_speed
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_STEP_VARIABLE.PROC_STEP = 0
                FOPM_Procedures_Control.EXECUTE_BTP = false
                FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = true
                FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = false
            else
                FOPM_STEP_VARIABLE.STEP = 1
            end
        end
    end
end

---- BEFORE TAKEOFF PROCEDURE
function before_takeoff_proc()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        FOPM_STEP_VARIABLE.STEP = 1
        FOPM_STEP_VARIABLE.PROC_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].step_desition then
                if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                    else
                        if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                                local dataref_name = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                                _G[dataref_name] = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                            elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                                command_once(FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                            end
                        end
                        if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                            if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                        FOPM_STEP_VARIABLE.DES_MADED = true
                        FOPM_STEP_VARIABLE.STEP = 2
                    end
                else
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                        if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                    if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                        if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                            local dataref_name = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                            command_once(FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                        end
                    end
                    if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check then
                        if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "WEATHER_RADAR" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "WEATHER_RADAR" then
                            radar_pos = math.random(2)
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "ENGINE_MODE_SELECTOR" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "ENGINE_MODE_SELECTOR" then
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "BRAKE_TEMP" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "BRAKE_TEMP" then
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                local rindex = math.random(3)
                                play_sound(BRAKE_WARNINGS[rindex])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (BRAKE_WARN[rindex].del)
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "TEMP_CHECK" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "TEMP_CHECK" then
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                local rindex = math.random(5)
                                play_sound(READY[rindex])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP - 1
                            end
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "ON_OETD" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "ON_OETD" then
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 3
                                FOPM_STEP_VARIABLE.STEP = 3
                            end
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "PACKS" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "PACKS" then
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 3
                            end
                        end
                    end
                end
            else
                if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                    if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                        if not speak_only_essencials then
                            local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        else
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    end
                elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                    if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                        local dataref_name = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                        _G[dataref_name] = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                    elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                        command_once(FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                    end
                end
                FOPM_STEP_VARIABLE.STEP = 2
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check then
                if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                    if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state then
                        if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                            if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = CONFIG_VOICE_SRCH
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = CONFIG_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                            end
                        else
                            if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 3
                    FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                else
                    if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check then
                        if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref then
                            local dataref_name = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command then
                            command_once(FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command)
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                            if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                                local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + 10
                            elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + 10
                            end
                        end
                    end
                end
            elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action then
                if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state then
                    if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                        if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = CONFIG_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_CONFIG[speech].del) + fo_speed
                        end
                    else
                        if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref then
                    local dataref_name = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                    _G[dataref_name] = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref
                elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.command then
                    command_once(FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.command)
                elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.delay then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.delay
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            elseif FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state then
                if not FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                    if not speak_only_essencials then
                        local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                else
                    local speech = FOPM_procedure.Before_takeoff_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            else
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_STEP_VARIABLE.PROC_STEP > #FOPM_procedure.Before_takeoff_proc then
                local rindex = math.random(5)
                play_sound(READY[rindex])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del) + fo_speed
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_STEP_VARIABLE.PROC_STEP = 0
                FOPM_Procedures_Control.EXECUTE_BTP = false
                FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = true
                FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = false
            else
                FOPM_STEP_VARIABLE.STEP = 1
            end
        end
    end
end

---- ENTER RWY
function enter_rwy()
    if FLT_PHASE.ON_RWY then
        if not FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE then
            if FOPM_STEP_VARIABLE.STEP == 0 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + 1
                    FOPM_STEP_VARIABLE.STEP = 1
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 1 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    if not speak_only_essencials then
                        local speech = "EXTERIOR_LIGHTS"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 1.2
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 1.2 then
                if not FLT_PHASE.TAXI_IN then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                        STROBE_SW = 2
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        FOPM_STEP_VARIABLE.STEP = 1.3
                    else
                        return
                    end
                else
                    FOPM_STEP_VARIABLE.STEP = 1.3
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 1.3 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    LANDLT_L_SW = 2
                    LANDLT_R_SW = 2
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 1.4
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 1.4 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    TAXILT_SW = 2
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 1.5
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 1.5 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    if not speak_only_essencials then
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                            local speech = "SET"
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 2
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 2 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    if not speak_only_essencials then
                        local speech = "TCAS"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 3
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 3 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    if not speak_only_essencials then
                        local speech = "SET"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    TCAS_SW = 4
                    FOPM_STEP_VARIABLE.STEP = 4
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 4 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    if not speak_only_essencials then
                        local rindex = math.random(5)
                        play_sound(READY[rindex])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 0
                    FOPM_Procedures_Control.EXECUTE_ENRWY = false
                    FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE = true
                else
                    return
                end
            end
        else
            FOPM_Procedures_Control.EXECUTE_ENRWY = false
        end
    end
end

---- VACATING RWY
function vacating_rwy()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            FOPM_DELAY_VARIABLE.DELAY = TIME + 1
            FOPM_STEP_VARIABLE.STEP = 1
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "EXTERIOR_LIGHTS"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
            end
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 2
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            LANDLT_L_SW = 0
            LANDLT_R_SW = 0
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            STROBE_SW = 1
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "SET"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                else
                    return
                end
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            TAXILT_SW = 1
            FOPM_STEP_VARIABLE.STEP = 5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "TCAS"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            FOPM_STEP_VARIABLE.STEP = 6
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 6 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "SET"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            TCAS_SW = 2
            FOPM_STEP_VARIABLE.STEP = 7
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 7 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local rindex = math.random(5)
                play_sound(READY[rindex])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            FOPM_STEP_VARIABLE.STEP = 0
            FOPM_Procedures_Control.EXECUTE_EXRWY = false
            FOPM_TL_COMPLETED_PROC.EXIT_RWY_DONE = false
        else
            return
        end
    end
end

---- TAKE OFF PROCEDURE
function take_off_proc()
    if not FOPM_TL_COMPLETED_PROC.TO_PROC_DONE then
        if FOPM_STEP_VARIABLE.STEP == 0 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if ENG_1_N1 > 50 and ENG_2_N1 > 50 then
                    STABLE1_CHECK = ENG_1_THR
                    STABLE2_CHECK = ENG_2_THR
                    FOPM_STEP_VARIABLE.STEP = 1
                    FOPM_DELAY_VARIABLE.DELAY = TIME + 3
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if ENG_1_THR == STABLE1_CHECK and ENG_2_THR == STABLE2_CHECK then
                    local speech = "STABLE"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP = 2
                else
                    STABLE1_CHECK = ENG_1_THR
                    STABLE2_CHECK = ENG_2_THR
                    FOPM_DELAY_VARIABLE.DELAY = TIME + 0.8
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 2 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if ENG_1_THR == ENG_THR_Rating and ENG_2_THR == ENG_THR_Rating then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + 1
                    FOPM_STEP_VARIABLE.STEP = 2.5
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 2.5 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                local speech = "TRHUST_SET"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP = 3
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 3 then -- speeds check
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if math.floor(IND_AIRSPEED) == 100 then
                    local speech = "N100"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                end
                if math.floor(IND_AIRSPEED) == V1_SPEED - 1 then
                    local speech = "V1"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                end
                if math.floor(IND_AIRSPEED) >= VR_SPEED then
                    local speech = "ROTATE"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP = 4
                end
                return
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 4 then
            if VERTICAL_SPEED > 700 then
                FOPM_DELAY_VARIABLE.DELAY = TIME + 1.5
                FOPM_STEP_VARIABLE.STEP = 5
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 5 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if GNDAIR_SW == 0 then
                    if VERTICAL_SPEED > 500 then
                        local speech = "POSITIVE_RATE"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        FOPM_STEP_VARIABLE.STEP = 6
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + 1
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 6 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if fo_autoperform then
                    local speech = "GEAR_UP"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    LG_Lever = 0
                    FOPM_STEP_VARIABLE.STEP = 7
                else
                    FOPM_STEP_VARIABLE.STEP = 7
                    FOPM_DELAY_VARIABLE.DELAY = TIME + 0.5
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7 then -- decide next proc --
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not FOPM_CONFIG_VARIABLE.PACKS_FOR_TO then
                    if THR_STATE == 1 then
                        FOPM_DELAY_VARIABLE.DELAY = TIME + 3
                        FOPM_STEP_VARIABLE.STEP = 7.2
                    else
                        return
                    end
                elseif FOPM_CONFIG_VARIABLE.APU_TO_PACKS then
                    if THR_STATE == 1 then
                        FOPM_DELAY_VARIABLE.DELAY = TIME + 3
                        FOPM_STEP_VARIABLE.STEP = 7.4
                    else
                        return
                    end
                else
                    if THR_STATE == 1 then
                        FOPM_DELAY_VARIABLE.DELAY = TIME + 3
                        FOPM_STEP_VARIABLE.STEP = 8
                        return
                    else
                        return
                    end
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.2 then -- PACKS OFF --
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not speak_only_essencials then
                    local speech = "PACKS"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 7.21
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.21 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                command_once(PACK_1_PB)
                FOPM_DELAY_VARIABLE.DELAY = TIME + 30
                FOPM_STEP_VARIABLE.STEP = 7.22
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.22 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                command_once(PACK_2_PB)
                FOPM_DELAY_VARIABLE.DELAY = TIME +0.3
                FOPM_STEP_VARIABLE.STEP = 8
                return
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.4 then -- APU TO PACKS --
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                ENG_1_BLEED_PB = 0
                FOPM_DELAY_VARIABLE.DELAY = TIME + 10
                FOPM_STEP_VARIABLE.STEP = 7.41
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.41 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                ENG_2_BLEED_PB = 0
                FOPM_DELAY_VARIABLE.DELAY = TIME + 0.7
                FOPM_STEP_VARIABLE.STEP = 7.42
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.42 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not speak_only_essencials then
                    local speech = "APU_BLEED"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 7.43
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.43 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not speak_only_essencials then
                    local speech = "OFF"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                command_once(APU_BLEED_PB)
                FOPM_STEP_VARIABLE.STEP = 7.44
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.44 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not speak_only_essencials then
                    local speech = "APU_MASTER"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 7.45
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7.45 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not speak_only_essencials then
                    local speech = "OFF"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                command_once(APU_MASTER_PB)
                FOPM_STEP_VARIABLE.STEP = 8
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 8 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not speak_only_essencials then
                    local speech = "ENGINE_MODE_SELECTOR"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 8.5
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 8.5 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if not speak_only_essencials then
                    local speech = "NORMAL"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                ENG_Mode = 1
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_TL_COMPLETED_PROC.TO_PROC_DONE = true
            else
                return
            end
        end
    end
end

---- CLEAN UP PROCEDURE (AUTO)
function clean_up_auto()
    if FOPM_STEP_VARIABLE.STEP_CLEAN == 0 then
        FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + 5
        FOPM_STEP_VARIABLE.STEP_SPEACH = 0
        FOPM_STEP_VARIABLE.STEP_CLEAN = 1
    end
    if FOPM_STEP_VARIABLE.STEP_CLEAN == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
            if FLAPS_LEVER_State ~= 0.25 then
                if FOPM_STEP_VARIABLE.STEP_SPEACH == 0 then
                    if math.floor(IND_AIRSPEED) > FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED + 2 then
                        local speech = "SPEED_CHECK"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FO_voices_directory[speech].del)
                        FOPM_STEP_VARIABLE.STEP_SPEACH = 1
                        return
                    else
                        return
                    end
                end
                if FOPM_STEP_VARIABLE.STEP_SPEACH == 1 then
                    command_once(FLAPS_1UP)
                    FOPM_STEP_VARIABLE.STEP_SPEACH = 2
                end
                if FOPM_STEP_VARIABLE.STEP_SPEACH == 2 then
                    if FLAPS_LEVER_State ~= 0.25 then
                        if FLAPS_State ~= -1 then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FLAP_POS[speech].del) + fo_speed
                            FOPM_STEP_VARIABLE.STEP_SPEACH = 3
                        else
                            return
                        end
                    else
                        return
                    end
                end
                if FOPM_STEP_VARIABLE.STEP_SPEACH == 3 then
                    if FLAPS_State == -1 then
                        FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + 1
                        FOPM_STEP_VARIABLE.STEP_SPEACH = 0
                        return
                    else
                        return
                    end
                end
            else
                local speech = FL_VOICE_SRCH
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FLAP_POS[speech].del) + fo_speed
                FOPM_STEP_VARIABLE.STEP_SPEACH = 0
                FOPM_STEP_VARIABLE.STEP_CLEAN = 2
            end
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_CLEAN == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
            if FOPM_STEP_VARIABLE.STEP_SPEACH == 0 then
                if math.floor(IND_AIRSPEED) > FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED + 2 then
                    local speech = "SPEED_CHECK"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FO_voices_directory[speech].del)
                    FOPM_CONFIG_VARIABLE.F_TARGET = FLAPS_LEVER_State - 0.25
                    FOPM_STEP_VARIABLE.STEP_SPEACH = 1
                    return
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP_SPEACH == 1 then
                command_once(FLAPS_1UP)
                FOPM_STEP_VARIABLE.STEP_SPEACH = 2
            end
            if FOPM_STEP_VARIABLE.STEP_SPEACH == 2 then
                if FLAPS_LEVER_State == FOPM_CONFIG_VARIABLE.F_TARGET then
                    local speech = FL_VOICE_SRCH
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FLAP_POS[speech].del) + fo_speed
                    FOPM_STEP_VARIABLE.STEP_SPEACH = 3
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP_SPEACH == 3 then
                if FLAPS_State == -1 then
                    FOPM_STEP_VARIABLE.STEP_SPEACH = 0
                    FOPM_STEP_VARIABLE.STEP_CLEAN = 0
                    FOPM_DELAY_VARIABLE.DELAY = TIME + 1
                    FOPM_TL_COMPLETED_PROC.ACF_CLEAN = true
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
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 0 then
            FOPM_Procedures_Control.EXECUTE_FLP = true  
            FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + 0.3
            if FLAPS_LEVER_State == 0 then
                FOPM_Procedures_Control.EXECUTE_FLP = false
            else
                FOPM_STEP_VARIABLE.STEP_CLEAN = 1
            end
        end 
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
                local speech = "SPEED_CHECK"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CLEAN = 2
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 2 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
                if FLAPS_LEVER_State > 0.25 then
                    if math.floor(IND_AIRSPEED) > FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED then
                        command_once(FLAPS_1UP)
                        FOPM_STEP_VARIABLE.STEP_CLEAN = 3
                        FOPM_CONFIG_VARIABLE.F_TARGET = FLAPS_LEVER_State - 0.25
                    else
                        return
                    end
                elseif FLAPS_LEVER_State == 0.25 then
                    if math.floor(IND_AIRSPEED) > FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED then
                        command_once(FLAPS_1UP)
                        FOPM_STEP_VARIABLE.STEP_CLEAN = 3
                        FOPM_CONFIG_VARIABLE.F_TARGET = FLAPS_LEVER_State - 0.25
                    else
                        return
                    end
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 3 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
                if FLAPS_LEVER_State == FOPM_CONFIG_VARIABLE.F_TARGET then
                    local speech = FL_VOICE_SRCH
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FLAP_POS[speech].del) + fo_speed
                    FOPM_STEP_VARIABLE.STEP_CLEAN = 0
                    command_FLPS_1UP = false
                    FOPM_Procedures_Control.EXECUTE_FLP = false
                else
                    return
                end
            else
                return
            end
        end
    elseif command_FLPS_1DN then
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 0 then
            FOPM_Procedures_Control.EXECUTE_FLP = true
            FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + 0.3
            if FLAPS_LEVER_State == 1 then
                FOPM_Procedures_Control.EXECUTE_FLP = false
            else
                FOPM_STEP_VARIABLE.STEP_CLEAN = 1
            end
        end
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
                local speech = "SPEED_CHECK"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FO_voices_directory[speech].del)
                lindex = math.floor((FLAPS_LEVER_State * 4) + 1)
                FOPM_STEP_VARIABLE.STEP_CLEAN = 2
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 2 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
                if math.floor(IND_AIRSPEED) < FLAPS_LIMIT[lindex] then
                    command_once(FLAPS_1DOWN)
                    FOPM_STEP_VARIABLE.STEP_CLEAN = 3
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP_CLEAN == 3 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CLEAN then
                if FLAPS_State ~= -1 then
                    local speech = FL_VOICE_SRCH
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FLAP_POS[speech].del) + fo_speed
                    FOPM_STEP_VARIABLE.STEP_CLEAN = 0
                    FOPM_Procedures_Control.EXECUTE_FLP = false
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
        if FOPM_STEP_VARIABLE.STEP_FLT == 0 then
            FOPM_Procedures_Control.EXECUTE_GEAR = true
            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + fo_speed
            if LG_Lever == 0 then
                FOPM_Procedures_Control.EXECUTE_GEAR = false
            else
                FOPM_STEP_VARIABLE.STEP_FLT = 1
            end
        end
        if FOPM_STEP_VARIABLE.STEP_FLT == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                if math.floor(IND_AIRSPEED) <= GEAR_RETRACTION_LIMIT then
                    local speech = "GEAR_UP"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    LG_Lever = 0
                    command_GUP = false
                    FOPM_Procedures_Control.EXECUTE_GEAR = false
                    FOPM_STEP_VARIABLE.STEP_FLT = 0
                else
                    return
                end
            else
                return
            end
        end
    elseif command_GDN then
        if FOPM_STEP_VARIABLE.STEP_FLT == 0 then
            FOPM_Procedures_Control.EXECUTE_GEAR = true
            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + fo_speed
            if LG_Lever == 1 then
                FOPM_Procedures_Control.EXECUTE_GEAR = false
            else
                FOPM_STEP_VARIABLE.STEP_FLT = 1
            end
        end
        if FOPM_STEP_VARIABLE.STEP_FLT == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                if math.floor(IND_AIRSPEED) <= GEAR_EXTENTION_LIMIT then
                    local speech = "GEAR_DOWN"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + fo_speed
                    LG_Lever = 1
                    FOPM_STEP_VARIABLE.STEP_FLT = 2
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP_FLT == 2 then
            if LG_NG_State == 2 and LG_RG_State == 2 and LG_LG_State == 2 then
                FOPM_STEP_VARIABLE.STEP_FLT = 3
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + 0.3
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP_FLT == 3 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                local speech = "GEAR_3GREENS"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FO_voices_directory[speech].del)
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_FLT = 0
                FOPM_Procedures_Control.EXECUTE_GEAR = false
                command_GDN = false
            else
                return
            end
        end
    end
end

---- 10.000FT CLB PROCEDURE
function ten_thausand_feet_CLB()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        if fo_autoperform then
            local speech = "TEN_THAUSAND_FEET"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP = 2
        else
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 2
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "EXTERIOR_LIGHTS"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
            end
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 2.3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 2.3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            RWYTOLT_SW = 0
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 2.4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 2.4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            LANDLT_L_SW = 0
            LANDLT_R_SW = 0
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 2.5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 2.5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            TAXILT_SW = 0
            if not speak_only_essencials then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                local speech = "OFF"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            FOPM_STEP_VARIABLE.STEP = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            EFIS_RNG = 3
            FOPM_DELAY_VARIABLE.DELAY = TIME + 0.7
            FOPM_STEP_VARIABLE.STEP = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            command_once(TERRAIN_FO_PB)
            FOPM_DELAY_VARIABLE.DELAY = TIME + 1
            FOPM_STEP_VARIABLE.STEP = 5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local rindex = math.random(5)
            play_sound(READY[rindex])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
            FOPM_STEP_VARIABLE.STEP = 0
            FOPM_Procedures_Control.EXECUTE_10FT_CLB = false
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = true
        else
            return
        end
    end
end

---- 10.000FT DES PROCEDURE
function ten_thausand_feet_DES()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if fo_autoperform then
                local speech = "TEN_THAUSAND_FEET"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP = 1
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 1
            end
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "EXTERIOR_LIGHTS"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
            end
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 1.3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 1.3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            RWYTOLT_SW = 1
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 1.4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 1.4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            LANDLT_L_SW = 2
            LANDLT_R_SW = 2
            FOPM_DELAY_VARIABLE.DELAY = TIME +fo_speed
            FOPM_STEP_VARIABLE.STEP = 1.5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 1.5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            TAXILT_SW = 2
            if not speak_only_essencials then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                local speech = "ON"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            FOPM_STEP_VARIABLE.STEP = 2
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            EFIS_RNG = 1
            FOPM_DELAY_VARIABLE.DELAY = TIME + 0.7
            FOPM_STEP_VARIABLE.STEP = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            command_once(TERRAIN_FO_PB)
            FOPM_DELAY_VARIABLE.DELAY = TIME + 0.5
            FOPM_STEP_VARIABLE.STEP = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP or APP_TYPE.LDA_APP or APP_TYPE.FLS then
                if not speak_only_essencials then
                    local speech = "LS"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                command_once(LS_FO_PB)
                FOPM_STEP_VARIABLE.STEP = 5
            else
                FOPM_STEP_VARIABLE.STEP = 5
            end
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 then
                if not speak_only_essencials then
                    local speech = "ENGINE_MODE_SELECTOR"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 5.5
            else
                FOPM_STEP_VARIABLE.STEP = 6
            end
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 5.5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "IGNITION"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            ENG_Mode = 2
            FOPM_STEP_VARIABLE.STEP = 6
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 6 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local rindex = math.random(5)
            play_sound(READY[rindex])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
            FOPM_STEP_VARIABLE.STEP = 0
            FOPM_Procedures_Control.EXECUTE_10FT_DES = false
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = true
        else
            return
        end
    end
end

---- AP DISCONECT
function ap_discn_behaviour()
    if FOPM_STEP_VARIABLE.STEP_AP == 0 then
        if AP_DISCN_ALARM == 1 then
            if not APP_TYPE.ILS_APP and not APP_TYPE.MLS_APP then
                FOPM_DELAY_VARIABLE.DELAY_AP = TIME + 2
                FOPM_STEP_VARIABLE.STEP_AP = 1
            else
                FOPM_STEP_VARIABLE.STEP_AP = 0
                FOPM_TL_COMPLETED_PROC.AP_DISCN_PROC = true
            end
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AP then
            local speech = "FLIGHT_DIRECTORS"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
            FOPM_DELAY_VARIABLE.DELAY_AP = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP_AP = 2
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AP then
            command_once(FD_CAP_PB)
            FOPM_DELAY_VARIABLE.DELAY_AP = TIME + 0.7
            FOPM_STEP_VARIABLE.STEP_AP = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AP then
            command_once(FD_FO_PB)
            FOPM_DELAY_VARIABLE.DELAY_AP = TIME + 0.7
            FOPM_STEP_VARIABLE.STEP_AP = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AP == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
            local speech = "OFF"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY_AP = TIME + (FO_voices_directory[speech].del) + fo_speed
            FOPM_STEP_VARIABLE.STEP_AP = 5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AP == 5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AP then
            command_once(HDGTRK_TOGGLE)
            FOPM_DELAY_VARIABLE.DELAY_AP = TIME + 0.5
            FOPM_STEP_VARIABLE.STEP_AP = 0
            FOPM_TL_COMPLETED_PROC.AP_DISCN_PROC = true
        else
            return
        end
    end
end

-- FLIGHT PARAMETERS MONITORING
function flight_parameters_check()
    if FPMTR.CONT_APP then
        if FO_LOC_Avail == 1 and math.floor(RADIO_ALT) > 100 then
            if math.floor(FO_LOC_Deviation*10)/10 < -1 or math.floor(FO_LOC_Deviation*10)/10 > 1 then
                local speech = "GA_UNSTABLE"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FPMTR.CONT_APP = false
            end
        end
        if FO_GS_Avail == 1 and math.floor(RADIO_ALT) > 100 then
            if math.floor(FO_GS_Deviation*10)/10 < -1 or math.floor(FO_GS_Deviation*10)/10 > 1 then
                local speech = "GA_UNSTABLE"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FPMTR.CONT_APP = false
            end
        end
    end
    if TIME >= FPMTR.SPDDELAY then
        if math.floor(RADIO_ALT) > 20 then
            if math.floor(IND_AIRSPEED) < math.floor(TARGET_SPEED) - 5 or 
               math.floor(IND_AIRSPEED) > math.floor(TARGET_SPEED) + 10 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "SPEED"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                    FPMTR.SPDDELAY = TIME + 10
                end
            end
        end
    end
    if TIME >= FPMTR.SINKDELAY then
        if math.floor(VERTICAL_SPEED) < -1000 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                local speech = "SINK_RATE"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                FPMTR.SINKDELAY = TIME + 10
            end
        end
    end
    if TIME >= FPMTR.BANKDELAY then
        if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP then
            if (math.floor(ROLL_ANGLE*10)/10) > 7 or (math.floor(ROLL_ANGLE*10)/10) < -7 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "BANK"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                    FPMTR.BANKDELAY = TIME + 10
                end
            end
        else
            if (math.floor(ROLL_ANGLE*10)/10) > 30 or (math.floor(ROLL_ANGLE*10)/10) < -30 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "BANK"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                    FPMTR.BANKDELAY = TIME + 10
                end
            end
        end
    end
    if TIME >= FPMTR.PITCHDELAY then
        if ACF_ICAO == "A321" or ACF_ICAO == "A21N" then
            if math.floor(PITCH_ANGLE*10)/10 < -2.5 or math.floor(PITCH_ANGLE*10)/10 > 7.5 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "PITCH"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                    FPMTR.PITCHDELAY = TIME + 10
                end
            end
        else
            if math.floor(PITCH_ANGLE*10)/10 < -2.5 or math.floor(PITCH_ANGLE*10)/10 > 10 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "PITCH"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                    FPMTR.PITCHDELAY = TIME + 10
                end
            end
        end
    end
    if TIME >= FPMTR.LOCDELAY then
        if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP then
            if FO_LOC_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_LOC_Deviation*10)/10 < -0.5 or math.floor(FO_LOC_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "LOC"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                        FPMTR.LOCDELAY = TIME + 10
                    end
                end
            end
        elseif APP_TYPE.LDA_APP then
            if FO_LOC_Avail == 1 and FO_FD_STATE == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_LOC_Deviation*10)/10 < -0.5 or math.floor(FO_LOC_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "LOC"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                        FPMTR.LOCDELAY = TIME + 10
                    end
                end
            end
        else
            if FO_LOC_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_LOC_Deviation*10)/10 < -0.5 or math.floor(FO_LOC_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "LAT_DEV"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                        FPMTR.LOCDELAY = TIME + 10
                    end
                end
            end
        end
    end
    if TIME >= FPMTR.GLIDEDELAY then
        if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP then
            if FO_GS_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_GS_Deviation*10)/10 < -0.5 or math.floor(FO_GS_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "GLIDE"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                        FPMTR.GLIDEDELAY = TIME + 10
                    end
                end
            end
        elseif APP_TYPE.LDA_APP then
            if FO_GS_Avail == 1 and FO_FD_STATE == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_GS_Deviation*10)/10 < -0.5 or math.floor(FO_GS_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "GLIDE"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                        FPMTR.GLIDEDELAY = TIME + 10
                    end
                end
            end
        else
            if FO_GS_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_GS_Deviation*10)/10 < -0.5 or math.floor(FO_GS_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "V_DEV"
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                        FPMTR.GLIDEDELAY = TIME + 10
                    end
                end
            end
        end
    end
end

-- CAT III AUTOLAND
function autoland_fma_check()
    if FOPM_STEP_VARIABLE.STEP_AL == 0 then
        if string.find(FMA_G_STATE, "LAND") then
            local speech = "LAND"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY_AL = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP_AL = 1
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AL == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AL then
            if string.find(FMA_G_STATE, "FLARE") then
                local speech = "FLARE"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_AL = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_AL = 2
            end
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AL == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AL then
            if string.find(FMA_G_STATE, "ROLL OUT") then
                local speech = "ROLL_OUT"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_AL = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_AL = 3
            end
        end
    end
end

---- GO ARROUND PROCEDURE
function go_arround()
    if not FOPM_TL_COMPLETED_PROC.GA_PROC then
        if FOPM_STEP_VARIABLE.STEP == 0 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                FOPM_DELAY_VARIABLE.DELAY = TIME + 0.25
                FOPM_STEP_VARIABLE.STEP = 1
                FOPM_TL_CHECKLIST.APP_CL = false
                FOPM_TL_CHECKLIST.ATO_CL = false
                FOPM_TL_CHECKLIST.LND_CL = false
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                local speech = "GO_ARROUND"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP = 2
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 2 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                local speech = "TOGA"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + 0.5
                FOPM_STEP_VARIABLE.STEP = 3
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 3 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                local speech = FLUP_VOICE_SRCH
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                command_once(FLAPS_1UP)
                FOPM_STEP_VARIABLE.STEP = 4
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 4 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if VERTICAL_SPEED > 700 then
                    local speech = "POSITIVE_RATE"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP = 5
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 5 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if fo_autoperform then
                    command_GUP = true
                end
                if command_GUP then
                    local speech = "GEAR_UP"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    LG_Lever = 0
                    FOPM_STEP_VARIABLE.STEP = 6
                    FOPM_Procedures_Control.EXECUTE_GEAR = false
                    command_GUP = false
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 6 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if APP_TYPE.ILS_APP or APP_TYPE.MLS_APP then
                    FOPM_STEP_VARIABLE.STEP = 11
                else
                    local speech = "FLIGHT_DIRECTORS"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FO_voices_directory[speech].del)
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 7
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 7 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if FO_FD_STATE ~= 1 then
                    command_once(FD_FO_PB)
                end
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 8
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 8 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if CP_FD_STATE ~= 1 then
                    command_once(FD_CAP_PB)
                end
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 9
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 9 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                if HDGTRK_MODE == 1 then
                    command_once(HDGTRK_TOGGLE)
                end
                local speech = "ON"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                FOPM_STEP_VARIABLE.STEP = 10
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 10 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    command_once(MCDU_FO_KEY_Perf)
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 11
                else
                    return
                end
            end
            if FOPM_STEP_VARIABLE.STEP == 11 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                    FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_1, "(%d+)"))
                    FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_2, "(%d+)"))
                    FOPM_CONFIG_VARIABLE.GREENDOT = tonumber(string.match(MCDU2_GLINE_3,"(%d+)"))
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 12
                else
                    return
                end
            end
        if FOPM_STEP_VARIABLE.STEP == 12 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                command_once(MCDU_FO_KEY_Fpln)
                FOPM_TL_COMPLETED_PROC.GA_PROC = true
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_Procedures_Control.EXECUTE_GEAR = false
                FOPM_STEP_VARIABLE.STEP_FLT = 0
                command_GUP = false
            else
                return
            end
        end
    end
end

---- TOUCH DOWN PROCEDURE
function touch_down()
    if not FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS then
        if FOPM_STEP_VARIABLE.STEP == 0 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if INBD_SPOILERS == 1 then
                    local speech = "SPOILERS"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 1
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if ENG_1_REV == 2 and ENG_2_REV == 2 then
                    local speech = "REVERSE_GREEN"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 2
                    FOPM_CONFIG_VARIABLE.CHECK_SPEED = math.floor(IND_AIRSPEED) - 10
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 2 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if math.floor(IND_AIRSPEED) < FOPM_CONFIG_VARIABLE.CHECK_SPEED then
                    local speech = "DECEL"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 3
                else
                    return
                end
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 3 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if math.floor(IND_AIRSPEED) < 70 then
                    local speech = "N70_KNOTS"
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 0
                    FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS = true
                end
            end
        end
    end
end

---- AFTER LANDING PROCEDURE
function after_landing_proc()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        FOPM_STEP_VARIABLE.STEP = 1
        FOPM_STEP_VARIABLE.PROC_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].step_desition then
                if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                    else
                        if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                            if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                                local dataref_name = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                                _G[dataref_name] = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                            elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                                command_once(FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                            end
                        end
                        if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                            if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                        FOPM_STEP_VARIABLE.DES_MADED = true
                        FOPM_STEP_VARIABLE.STEP = 2
                    end
                else
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                        if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                    if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                        if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                            local dataref_name = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                        elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                            command_once(FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                        end
                    end
                    if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].check then
                        if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" or FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" then
                            if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_CONFIG_VARIABLE.F_TARGET = 0.25
                                FOPM_CONFIG_VARIABLE.F_ATARGET = FLAPS_LEVER_State
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_CONFIG_VARIABLE.F_TARGET = 0
                                FOPM_CONFIG_VARIABLE.F_ATARGET = FLAPS_LEVER_State
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS_RET" or FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS_RET" then
                            if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                command_once(FLAPS_1UP)
                                FOPM_CONFIG_VARIABLE.F_ATARGET = FOPM_CONFIG_VARIABLE.F_ATARGET - 0.25
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        end
                    end
                end
            else
                if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                    if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                        if not speak_only_essencials then
                            local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        else
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    end
                elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                    if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                        local dataref_name = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                        _G[dataref_name] = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                    elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                        command_once(FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                    end
                end
                FOPM_STEP_VARIABLE.STEP = 2
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].check then
                if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                    if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state then
                        if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                            if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FL_VOICE_SRCH
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FL_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                            end
                        else
                            if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 3
                    FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                else
                    if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check then
                        if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref then
                            local dataref_name = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command then
                            command_once(FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command)
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                            if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item then
                                local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + 10
                            elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + fo_speed
                            end
                        end
                    end
                end
            elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action then
                if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state then
                    if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                        if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FL_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                        end
                    else
                        if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref then
                    local dataref_name = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                    _G[dataref_name] = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref
                elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.command then
                    command_once(FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.command)
                elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.delay then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].action.delay
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            elseif FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state then
                if not FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                    if not speak_only_essencials then
                        local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                else
                    local speech = FOPM_procedure.After_landing_proc[FOPM_STEP_VARIABLE.PROC_STEP].state
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            else
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_STEP_VARIABLE.PROC_STEP > #FOPM_procedure.After_landing_proc then
                local rindex = math.random(5)
                play_sound(READY[rindex])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del) + fo_speed
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_STEP_VARIABLE.PROC_STEP = 0
                FOPM_Procedures_Control.EXECUTE_AL_PROC = false
                FOPM_TL_COMPLETED_PROC.AL_PROC = true
            else
                FOPM_STEP_VARIABLE.STEP = 1
            end
        end
    end
end

---- BRAKE TEMP CHECK PROCEDURE
function brake_temp_check()
    if BRAKE1_TEMP > 150 or BRAKE2_TEMP > 150 or BRAKE3_TEMP > 150 or BRAKE4_TEMP > 150 then
        if not speak_only_essencials then
            local speech = "BRAKE_FAN"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
        else
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
        end
        command_once(BRKFAN_PB)
        FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = true
    else
        FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = true
    end
end

-- PARKING PROCEDURE
function parking_proc()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if ENG_MODEL == 0 then
                FOPM_CONFIG_VARIABLE.IAE_SD_TIME = math.floor(TIME)
            end
            FOPM_DELAY_VARIABLE.DELAY = TIME + 1
            FOPM_STEP_VARIABLE.STEP = 1
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "APU_BLEED"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            FOPM_STEP_VARIABLE.STEP = 2
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "ON"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            command_once(APU_BLEED_PB)
            FOPM_STEP_VARIABLE.STEP = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "FUEL_PUMPS"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            FOPM_STEP_VARIABLE.STEP = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            command_once(FPUMP_LTANK_1_PB)
            command_once(FPUMP_LTANK_2_PB)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 5 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            command_once(FPUMP_CTANK_1_PB)
            command_once(FPUMP_CTANK_2_PB)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 6
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 6 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "OFF"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            command_once(FPUMP_RTANK_1_PB)
            command_once(FPUMP_RTANK_2_PB)
            FOPM_STEP_VARIABLE.STEP = 7
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 7 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "ATC"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME +fo_speed
            end
            FOPM_STEP_VARIABLE.STEP = 8
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 8 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if not speak_only_essencials then
                local speech = "SET"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            end
            TCAS_SW = 0
            FOPM_STEP_VARIABLE.STEP = 9
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 9 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            command_once(CRONO_SET_PB)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 10
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 10 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            command_once(CRONO_RESET_PB)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 11
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP == 11 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local rindex = math.random(5)
            play_sound(READY[rindex])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
            FOPM_STEP_VARIABLE.STEP = 0
            FOPM_TL_COMPLETED_PROC.PARK_PROC = true
        else
            return
        end
    end
end

-- ONE ENGINE TAXI DEPARTURE
function one_engine_taxi_DEP()
    if FOPM_STEP_VARIABLE.STEP == 0 then
        FOPM_STEP_VARIABLE.STEP = 1
        FOPM_STEP_VARIABLE.PROC_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].step_desition then
                if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                    else
                        if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                                local dataref_name = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                                _G[dataref_name] = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                            elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                                command_once(FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                            end
                        end
                        if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item then
                            if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                        FOPM_STEP_VARIABLE.DES_MADED = true
                        FOPM_STEP_VARIABLE.STEP = 2
                    end
                else
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item then
                        if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                    if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                        if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                            local dataref_name = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                            command_once(FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                        end
                    end
                    if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check then
                        if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "APU_BLEED" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "APU_BLEED" then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 3
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "ANTI_ICE" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "ANTI_ICE" then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "After Start Checklist" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "After Start Checklist" then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_TL_CHECKLIST.EX_AS_CL = true
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "PROC_COMP" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "PROC_COMP" then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                local rindex = math.random(5)
                                play_sound(READY[rindex])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY[rindex].del)
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "TIME_COMP" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "TIME_COMP" then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                local rindex = math.random(3)
                                play_sound(READY_FOR_TO[rindex])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (RDY_TO_DIR[rindex].del) + fo_speed
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            end
                        elseif FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLTCTLCHK" or FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLTCTLCHK" then
                            if FOPM_procedure.After_start_procedure[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                                FOPM_STEP_VARIABLE.STEP = 3
                            else
                                flt_ctl_chk()
                            end
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "ENG_COMP" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "After Start Checklist" then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 3
                            end
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "IAE_CHECK_TIME" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "After Start Checklist" then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 2
                            end
                        end
                    end
                end
            else
                if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item then
                    if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                        if not speak_only_essencials then
                            local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        else
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                    end
                elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check then
                    if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref then
                        local dataref_name = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                        _G[dataref_name] = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.dataref
                    elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command then
                        command_once(FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_pre_check.command)
                    end
                end
                FOPM_STEP_VARIABLE.STEP = 2
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check then
                if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].check() then
                    if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state then
                        if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                            if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FL_VOICE_SRCH
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FL_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                            end
                        else
                            if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                                if not speak_only_essencials then
                                    local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state
                                    play_sound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    FOPM_STEP_VARIABLE.STEP = 3
                    FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
                else
                    if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_check then
                        if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref then
                            local dataref_name = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_check.dataref
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command then
                            command_once(FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action_check.command)
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                            if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item then
                                local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + 10
                            elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item then
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + 10
                            end
                        end
                    end
                end
            elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action then
                if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state then
                    if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].item == "FLAPS" or FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].int_item == "FLAPS" then
                        if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FL_VOICE_SRCH
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FLAP_POS[speech].del) + fo_speed
                        end
                    else
                        if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state
                                play_sound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                        end
                    end
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                if FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref then
                    local dataref_name = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].dataref_name
                    _G[dataref_name] = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action.dataref
                elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action.command then
                    command_once(FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action.command)
                elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action.delay then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].action.delay
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            elseif FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state then
                if not FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].essential then
                    if not speak_only_essencials then
                        local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                else
                    local speech = FOPM_procedure.One_engine_taxi_DEP[FOPM_STEP_VARIABLE.PROC_STEP].state
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
                end
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            else
                FOPM_STEP_VARIABLE.STEP = 3
                FOPM_STEP_VARIABLE.PROC_STEP = FOPM_STEP_VARIABLE.PROC_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if FOPM_STEP_VARIABLE.PROC_STEP > #FOPM_procedure.One_engine_taxi_DEP then
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_STEP_VARIABLE.PROC_STEP = 0
                FOPM_Procedures_Control.EXECUTE_OETD = false
                FOPM_Procedures_Control.ONEENG_TAXI_DEP = false
            else
                FOPM_STEP_VARIABLE.STEP = 1
            end
        end
    end
end

-- ONE ENGINE TAXI ARRIVAL
function one_engine_taxi_ARR()
    if FOPM_STEP_VARIABLE.STEP_ONEENG == 0 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if APU_STATE == 1 then
                FOPM_DELAY_VARIABLE.DELAY = TIME + 0.7
                FOPM_STEP_VARIABLE.STEP_ONEENG = 1
            else
                return
            end
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_ONEENG == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "ENGINE_2_SHUTDOWN"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_STEP_VARIABLE.STEP_ONEENG = 2
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_ONEENG == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            ENG_2_Master = 0
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP_ONEENG = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_ONEENG == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "YELLOW_HYDRAULIC_PUMP"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
            FOPM_STEP_VARIABLE.STEP_ONEENG = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_ONEENG == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "ON"
            Y_ELEC_PUMP_PB = 1
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del) + fo_speed
            FOPM_STEP_VARIABLE.STEP_ONEENG = 0
            FOPM_Procedures_Control.ONEENG_TAXI_ARR_AVAIL = false
            FOPM_Procedures_Control.EXECUTE_OETA = false
        else
            return
        end
    end
end

-- //////////////////////////////
-- ///////// CHECKLISTS /////////
-- //////////////////////////////

-- COCKPIT PREPARATION CHECKLIST
function checklist_cockpit_prep()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Cockpit_preparation_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Cockpit_preparation_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_CP_CL = false
                FOPM_TL_CHECKLIST.CP_CL = true
                FOPM_TL_CHECKLIST.PARK_CL = false
                FOPM_TL_CHECKLIST.SEC_CL = false
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- BEFORE START CHECKLIST
function checklist_before_start()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Before_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Before_start_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_BS_CL = false
                FOPM_TL_CHECKLIST.BS_CL = true
                FOPM_TL_CHECKLIST.PARK_CL = false
                FOPM_TL_CHECKLIST.SEC_CL = false
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- BEFORE START CHECKLIST BELOW THE LINE
function checklist_before_start_BTL()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Before_start_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Before_start_checklist_BTL then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_BS_CL_BTL = false
                FOPM_TL_CHECKLIST.BS_CL_BTL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- AFTER START CHECKLIST
function checklist_after_start()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                        else
                            local speech = FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = CONFIG_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                    else
                        local speech = FOPM_checklist.After_start_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.After_start_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_AS_CL = false
                FOPM_TL_CHECKLIST.AS_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end    
end

-- TAXI CHECKLIST
function checklist_taxi()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].step_desition then
                if not FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    local speech = FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "ENGINE_MODE_SELECTOR" then
                        if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        else
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        end
                    end
                else
                    if not FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.STEP_CHECK = 2
                        response_CHECK = false
                        FOPM_STEP_VARIABLE.DES_MADED = true
                    else
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    end
                end
            else
                local speech = FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                        else
                            local speech = FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = CONFIG_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                    else
                        local speech = FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Taxi_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_TX_CL = false
                FOPM_TL_CHECKLIST.TX_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- DEPARTURE CHANGE CHECKLIST
function checklist_departure_change()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Departure_change_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Departure_change_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_DC_CL = false
                FOPM_TL_CHECKLIST.DC_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- BEFORE TAKEOFF CHECKLIST
function checklist_before_takeoff()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                        else
                            local speech = FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = CONFIG_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                    else
                        local speech = FOPM_checklist.Before_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Before_takeoff_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_BTO_CL = false
                FOPM_TL_CHECKLIST.BTO_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- LINE-UP CHECKLIST
function checklist_lineup()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].step_desition then
                if not FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    local speech = FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "PACKS_AND_APU_BLEED" or FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "PACKS" then
                        if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[1]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        elseif FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[2]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        else
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 3
                        end
                    end
                else
                    if not FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.STEP_CHECK = 2
                        response_CHECK = false
                        FOPM_STEP_VARIABLE.DES_MADED = true
                    else
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    end
                end
            else
                local speech = FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                        else
                            local speech = FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = CONFIG_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                    else
                        local speech = FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Lineup_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_LU_CL = false
                FOPM_TL_CHECKLIST.LU_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- BEFORE TAKEOFF CHECKLIST BELOW THE LINE
function checklist_before_takeoff_BTL()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].step_desition then
                if not FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    local speech = FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item == "ENGINE_MODE_SELECTOR" then
                        if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        else
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        end
                    elseif FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item == "PACKS_AND_APU_BLEED" or FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item == "PACKS" then
                        if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].check[1]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        elseif FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].check[2]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        else
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 3
                        end
                    end
                else
                    if not FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.STEP_CHECK = 2
                        response_CHECK = false
                        FOPM_STEP_VARIABLE.DES_MADED = true
                    else
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    end
                end
            else
                local speech = FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = CONFIG_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                        else
                            local speech = FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = CONFIG_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_CONFIG[speech].del)
                    else
                        local speech = FOPM_checklist.Before_takeoff_checklist_BTL[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Before_takeoff_checklist_BTL then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_BTO_CL_BTL = false
                FOPM_TL_CHECKLIST.BTO_CL_BTL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- AFTER TAKEOFF CHECKLIST
function checklist_after_takeoff()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.After_takeoff_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.After_takeoff_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_ATO_CL = false
                FOPM_TL_CHECKLIST.ATO_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- CLIMB CHECKLIST
function checklist_climb()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Climb_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Climb_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_CLB_CL = false
                FOPM_TL_CHECKLIST.CLB_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- APPROACH CHECKLIST
function checklist_approach()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].CAT_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].step_desition then
                if not FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "ENGINE_MODE_SELECTOR" then
                        if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        else
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        end
                    elseif FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "AUTOBRAKES" then
                        if FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[1]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        elseif FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[2]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        end
                    end
                else
                    if not FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.STEP_CHECK = 2
                        response_CHECK = false
                        FOPM_STEP_VARIABLE.DES_MADED = true
                    else
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    end
                end
            else
                local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Approach_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_APP_CL = false
                FOPM_TL_CHECKLIST.APP_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- LANDING CHECKLIST
function checklist_landing()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].CAT_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].step_desition then
                if not FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    local speech = FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    if FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "AUTO_TRHUST" then
                        if FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        else
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        end
                    elseif FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "AUTOBRAKES" then
                        if FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[1]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        elseif FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[2]() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        end
                    end
                else
                    if not FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.STEP_CHECK = 2
                        response_CHECK = false
                        FOPM_STEP_VARIABLE.DES_MADED = true
                    else
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    end
                end
            else
                local speech = FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Landing_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_LND_CL = false
                FOPM_TL_CHECKLIST.LND_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- AFTER LANDING CHECKLIST
function checklist_after_landing()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].CAT_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].step_desition then
                if not FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    local speech = FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "APU" then
                        if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                        else
                            FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                        end
                    end
                else
                    if not FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.STEP_CHECK = 2
                        response_CHECK = false
                        FOPM_STEP_VARIABLE.DES_MADED = true
                    else
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    end
                end
            else
                local speech = FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.After_landing_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_AL_CL = false
                FOPM_TL_CHECKLIST.AL_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- PARKING CHECKLIST
function checklist_parking()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Parking_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Parking_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_PARK_CL = false
                FOPM_TL_CHECKLIST.PARK_CL = true
                FOPM_TL_CHECKLIST.BS_CL = false
                FOPM_TL_CHECKLIST.BS_CL_BTL = false
                FOPM_TL_CHECKLIST.AS_CL = false
                FOPM_TL_CHECKLIST.BTO_CL = false
                FOPM_TL_CHECKLIST.BTO_CL_BTL = false
                FOPM_TL_CHECKLIST.ATO_CL = false
                FOPM_TL_COMPLETED_PROC.TO_PROC_DONE = false
                FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS = false
                FOPM_TL_CHECKLIST.CLB_CL = false
                FOPM_TL_CHECKLIST.APP_CL = false
                FOPM_TL_CHECKLIST.LND_CL = false
                FOPM_TL_CHECKLIST.AL_CL = false
                FOPM_CONFIG_VARIABLE.MINUTE3 = false
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- SECURING CHECKLIST
function checklist_securing()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                    play_sound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                local speech = FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            local speech = FL_VOICE_SRCH
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                        else
                            local speech = FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                            play_sound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        local speech = FL_VOICE_SRCH
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FLAP_POS[speech].del)
                    else
                        local speech = FOPM_checklist.Securing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].state
                        play_sound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                    end
                    FOPM_STEP_VARIABLE.STEP_CHECK = 3
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 3
                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist.Securing_checklist then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST.EX_SEC_CL = false
                FOPM_TL_CHECKLIST.SEC_CL = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

---- //////////////////////////////
---- ///////// MAIN LOGIC /////////
---- //////////////////////////////

-- ACTUAL FLIGHT PHASE
function phase_check()
    if FLT_PHASE.PREFLIGHT then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Preflight"
        if FOPM_checklist.Before_start_checklist_BTL then
            if FOPM_TL_CHECKLIST.BS_CL_BTL then
                FLT_PHASE.PREFLIGHT = false
                FLT_PHASE.PUSHBACK = true
                FOPM_TL_COMPLETED_PROC.PARK_PROC = false
            end
        else
            if FOPM_TL_CHECKLIST.BS_CL then
                FLT_PHASE.PREFLIGHT = false
                FLT_PHASE.PUSHBACK = true
                FOPM_TL_COMPLETED_PROC.PARK_PROC = false
            end
        end
    end
    if FLT_PHASE.PUSHBACK then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Pushback"
        if ENG_Mode == 2 then
            FLT_PHASE.ENG_START = true
        end
        if TAXILT_SW > 0 and FOPM_TL_COMPLETED_PROC.AS_PROC_DONE then
            FLT_PHASE.ENG_START = false
            FLT_PHASE.PUSHBACK = false
            FLT_PHASE.TAXI_OUT = true
        end
        if BEACON_STATE == 0 and not FLT_PHASE.ENG_START then
            FLT_PHASE.PUSHBACK = false
            FLT_PHASE.PREFLIGHT = true
        end
    end
    if FOPM_Procedures_Control.EXECUTE_ENRWY then
        FLT_PHASE.ON_RWY = true
        FOPM_TL_COMPLETED_PROC.EXIT_RWY_DONE = false
    end
    if FOPM_Procedures_Control.EXECUTE_EXRWY then
        FLT_PHASE.ON_RWY = false
        FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE = false
    end
    if FLT_PHASE.TAXI_OUT then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Taxi Out"
        if THR_LEVER >= 2 then
            FLT_PHASE.TAKEOFF = true
            FLT_PHASE.TAXI_OUT = false
            FOPM_TL_COMPLETED_PROC.AS_PROC_DONE = false
            command_GUP = false
            command_GDN = false
            command_FLPS_1UP = false
            command_FLPS_1DN = false
        end
        if ENG_1_Master == 0 and ENG_2_Master == 0 and BEACON_STATE == 0 then
            FLT_PHASE.PARKING = true
            FLT_PHASE.TAXI_OUT = false
        end
    end
    if FLT_PHASE.TAKEOFF then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Takeoff"
        if GNDAIR_SW == 0 then
            FLT_PHASE.ON_RWY = false
        end
        if ENG_1_REV ~= 0 or ENG_2_REV ~= 0 then
            FOPM_STEP_VARIABLE.STEP = 0
            FLT_PHASE.REJECTED = true
            FLT_PHASE.TAKEOFF = false
        end
        if FOPM_checklist.After_takeoff_checklist then
            if THR_STATE == 1 and FOPM_TL_CHECKLIST.ATO_CL then
                FOPM_CONFIG_VARIABLE.TXT_PHASE = "Climb"
                FLT_PHASE.CLIMB = true
                APP_TYPE.AR_DEP = false
                FOPM_CONFIG_VARIABLE.RAINING = false
                FLT_PHASE.TAKEOFF = false
                FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = false
                FOPM_TL_COMPLETED_PROC.ACF_CLEAN = false
                FOPM_TL_COMPLETED_PROC.AL_PROC = false
                command_GUP = false
                command_GDN = false
                command_FLPS_1UP = false
                command_FLPS_1DN = false
            end
        else
            if THR_STATE == 1 and FOPM_TL_COMPLETED_PROC.TO_PROC_DONE then
                FOPM_CONFIG_VARIABLE.TXT_PHASE = "Climb"
                FLT_PHASE.CLIMB = true
                APP_TYPE.AR_DEP = false
                FOPM_CONFIG_VARIABLE.RAINING = false
                FLT_PHASE.TAKEOFF = false
                FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = false
                FOPM_TL_COMPLETED_PROC.ACF_CLEAN = false
                FOPM_TL_COMPLETED_PROC.AL_PROC = false
                command_GUP = false
                command_GDN = false
                command_FLPS_1UP = false
                command_FLPS_1DN = false
            end
        end
    end
    if FLT_PHASE.REJECTED then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Rejected"
        if ENG_1_REV == 0 and ENG_2_REV == 0 then
            FLT_PHASE.REJECTED = false
            FLT_PHASE.REJECTED_DES = true
        end
    end
    if FLT_PHASE.CLIMB or FLT_PHASE.CRUISE or FLT_PHASE.DESCEND then
        if string.find(FMA_G_STATE, "CLB") then
            FOPM_CONFIG_VARIABLE.TXT_PHASE = "Climb"
            FLT_PHASE.CLIMB = true
            FLT_PHASE.CRUISE = false
            FLT_PHASE.DESCEND = false
        end
        if string.find(FMA_G_STATE, "CRZ") then
            FOPM_CONFIG_VARIABLE.TXT_PHASE = "Cruise"
            FLT_PHASE.CLIMB = false
            FLT_PHASE.CRUISE = true
            FLT_PHASE.DESCEND = false
        end
        if string.find(FMA_G_STATE, "DES") then
            FOPM_CONFIG_VARIABLE.TXT_PHASE = "Descend"
            FLT_PHASE.CLIMB = false
            FLT_PHASE.CRUISE = false
            FLT_PHASE.DESCEND = true
        end
        if FOPM_TL_CHECKLIST.APP_CL then
            FLT_PHASE.CLIMB = false
            FLT_PHASE.CRUISE = false
            FLT_PHASE.DESCEND = false
            FLT_PHASE.APPROACH = true
            FOPM_TL_COMPLETED_PROC.AP_DISCN_PROC = false
        end
    end
    if FLT_PHASE.APPROACH then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Approach"
        if FOPM_TL_CHECKLIST.LND_CL then
            FLT_PHASE.APPROACH = false
            FLT_PHASE.FINAL_APP = true
            FOPM_TL_COMPLETED_PROC.GA_PROC = false
            FPMTR.CONT_APP = true
            FOPM_STEP_VARIABLE.STEP_AL = 0
        end
    end
    if FLT_PHASE.FINAL_APP then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Final APP"
        if THR_LEVER == 3 then
            FLT_PHASE.FINAL_APP = false
            FLT_PHASE.GA = true
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = false
            FOPM_TL_COMPLETED_PROC.DES_BRIEFING = false
            FOPM_STEP_VARIABLE.STEP_AL = 0
        end
        if ENG_1_REV > 0 or ENG_2_REV > 0 then
            FLT_PHASE.FINAL_APP = false
            FLT_PHASE.DECELERATION = true
            FLT_PHASE.ON_RWY = true
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = false
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = false
            FOPM_STEP_VARIABLE.STEP_AL = 0
        end
    end
    if FLT_PHASE.GA then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Go Arround"
        if THR_STATE == 1 then
            FLT_PHASE.GA = false
            FLT_PHASE.TAKEOFF = true
        end
    end
    if FLT_PHASE.DECELERATION then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Decel"
        if ENG_1_REV == 0 and ENG_2_REV == 0 then
            FLT_PHASE.DECELERATION = false
            FOPM_CONFIG_VARIABLE.RAINING = false
            FLT_PHASE.TAXI_IN = true
        end
    end
    if FLT_PHASE.TAXI_IN then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Taxi In"
        if CRONO > 180 and not FOPM_TL_COMPLETED_PROC.OETA_DONE and not FOPM_CONFIG_VARIABLE.MINUTE3 then
            local speech = "CRONO3"
            play_sound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
            FOPM_Procedures_Control.ONEENG_TAXI_ARR_AVAIL = true
            FOPM_CONFIG_VARIABLE.MINUTE3 = true
        end
        if PRKBRK_SW == 1 and ENG_1_Master == 0 and ENG_2_Master == 0 then
            FLT_PHASE.TAXI_IN = false
            FLT_PHASE.PARKING = true
        end
    end
    if FLT_PHASE.PARKING then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Parking"
        if FOPM_TL_CHECKLIST.PARK_CL then
            FOPM_CONFIG_VARIABLE.MINUTE3 = false
            FLT_PHASE.PARKING = false
            FLT_PHASE.PREFLIGHT = true
            FOPM_TL_COMPLETED_PROC.PF_DONE = false
            FOPM_TL_COMPLETED_PROC.TO_BRIEFING = false
            FOPM_TL_COMPLETED_PROC.FLTCTL_CHK = false
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
        if FOPM_Procedures_Control.EXECUTE_PCP then
            pre_cockpit_pre()
        end
    end
    if FLT_PHASE.ENG_START then
        if not FOPM_TL_COMPLETED_PROC.AS_PROC_DONE then
            if ENG_Mode == 1 then
                after_start_proc()
            end
        end
    end
    if FOPM_Procedures_Control.EXECUTE_OETD and not FOPM_TL_CHECKLIST.EX_BTO_CL and not FOPM_Procedures_Control.EXECUTE_BTP and not FOPM_Procedures_Control.EXECUTE_ENRWY and not FOPM_Procedures_Control.EXECUTE_EXRWY then
        one_engine_taxi_DEP()
    end
    if FLT_PHASE.TAXI_OUT then
        if FOPM_Procedures_Control.EXECUTE_TXP then
            taxi_proc()
        end
        if FOPM_Procedures_Control.EXECUTE_BTP then
            before_takeoff_proc()
        end
        if FOPM_Procedures_Control.EXECUTE_ENRWY then
            enter_rwy()
        end
        if FOPM_Procedures_Control.EXECUTE_EXRWY then
            vacating_rwy()
        end
    end
    if FOPM_checklist.Before_takeoff_checklist_BTL then
        if FOPM_TL_CHECKLIST.BTO_CL_BTL and not FOPM_TL_COMPLETED_PROC.TO_PROC_DONE and not FLT_PHASE.REJECTED then
            take_off_proc()
        end
    else
        if FOPM_TL_CHECKLIST.LU_CL and not FOPM_TL_COMPLETED_PROC.TO_PROC_DONE and not FLT_PHASE.REJECTED then
            take_off_proc()
        end
    end
    if FLT_PHASE.REJECTED then
        touch_down()
    end
    if GNDAIR_SW == 0 then
        if not FLT_PHASE.GA or not FOPM_Procedures_Control.EXECUTE_FLP then
            gear_command()
        end
        if not FOPM_Procedures_Control.EXECUTE_GEAR then
            flaps_commanded_change()
        end
    else
        if command_FLPS_1UP or command_FLPS_1UP then
            command_FLPS_1UP = false
            command_FLPS_1DN = false
        end
        if command_GUP or command_GDN then
            command_GUP = false
            command_GDN = false
        end
    end
    if FLT_PHASE.TAKEOFF then
        if THR_STATE == 1 and fo_autoperform then
            if not FOPM_TL_COMPLETED_PROC.ACF_CLEAN and not string.find(FMA_G_STATE, "SRS") then
                clean_up_auto()
            end
        end
    end
    if FLT_PHASE.CLIMB then
        if fo_autoperform then
            if (not FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE and IND_ALTITUDE > 14000) or FOPM_Procedures_Control.EXECUTE_10FT_CLB then
                FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = false
                ten_thausand_feet_CLB()
            end
        elseif FOPM_Procedures_Control.EXECUTE_10FT_CLB then
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = false
            ten_thausand_feet_CLB()
        end
        if not FOPM_CONFIG_VARIABLE.PASSED_TRANS_ALT then
            if TRANSITION_ALT <= math.floor(IND_ALTITUDE) then
                local speech = "TRNS_ALT"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_ALT = true
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL = false
            end
        end
    end
    if FLT_PHASE.DESCEND then
        if fo_autoperform then
            if (not FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and IND_ALTITUDE < 14000) or FOPM_Procedures_Control.EXECUTE_10FT_DES then
                ten_thausand_feet_DES()
            end
        elseif FOPM_Procedures_Control.EXECUTE_10FT_DES then
            ten_thausand_feet_DES()
        end
    end
    if FLT_PHASE.DESCEND or FLT_PHASE.APPROACH then
        if not FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL then
            if TRANSITION_LVL >= math.floor(IND_ALTITUDE) then
                local speech = "TRNS_LVL"
                play_sound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FO_voices_directory[speech].del)
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del)
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_ALT = false
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL = true
            end
        end
    end
    if FLT_PHASE.FINAL_APP then
        ap_discn_behaviour()
        if APP_TYPE.CAT_II_III and AP1_ENGAGE == 1 and AP2_ENGAGE == 1 then
            autoland_fma_check()
        end
        if math.floor(RADIO_ALT) < 1000 and FPMTR.CONT_APP then
            flight_parameters_check()
        end
    end
    if FLT_PHASE.GA then
        go_arround()
    end
    if FLT_PHASE.DECELERATION then
        touch_down()
    end
    if FLT_PHASE.TAXI_IN then
        if not FOPM_TL_COMPLETED_PROC.AL_PROC and SPDBRK_Lever == 0 then
            if not FOPM_Procedures_Control.EXECUTE_EXRWY then
                after_landing_proc()
            end
        end
        if FOPM_Procedures_Control.EXECUTE_EXRWY and not FOPM_Procedures_Control.EXECUTE_AL_PROC then
            vacating_rwy()
        end
        if FOPM_Procedures_Control.EXECUTE_ENRWY and not FOPM_Procedures_Control.EXECUTE_AL_PROC then
            enter_rwy()
        end
        if FOPM_Procedures_Control.EXECUTE_OETA then
            one_engine_taxi_ARR()
        end
        if CRONO >= 300 and not FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE then
            brake_temp_check()
        end
    end
    if FLT_PHASE.PARKING then
        if not FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE then
            brake_temp_check()
        end
        if not FOPM_TL_COMPLETED_PROC.PARK_PROC and FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE then
            parking_proc()
        end
    end
end

do_every_frame("FO_main_logic()")

-- FO CHECKLIST LOGIC
function FO_checklist()
    if FOPM_TL_CHECKLIST.EX_CP_CL then
        checklist_cockpit_prep()
    end
    if FOPM_TL_CHECKLIST.EX_BS_CL then
        checklist_before_start()
    end
    if FOPM_TL_CHECKLIST.EX_BS_CL_BTL then
        checklist_before_start_BTL()
    end
    if FOPM_TL_CHECKLIST.EX_AS_CL then
        checklist_after_start()
    end
    if FOPM_TL_CHECKLIST.EX_TX_CL then
        checklist_taxi()
    end
    if FOPM_TL_CHECKLIST.EX_DC_CL then
        checklist_departure_change()
    end
    if FOPM_TL_CHECKLIST.EX_BTO_CL then
        checklist_before_takeoff()
    end
    if FOPM_TL_CHECKLIST.EX_LU_CL then
        checklist_lineup()
    end
    if FOPM_TL_CHECKLIST.EX_BTO_CL_BTL then
        checklist_before_takeoff_BTL()
    end
    if FOPM_TL_CHECKLIST.EX_ATO_CL then
        checklist_after_takeoff()
    end
    if FOPM_TL_CHECKLIST.EX_CLB_CL then
        checklist_climb()
    end
    if FOPM_TL_CHECKLIST.EX_APP_CL then
        checklist_approach()
    end
    if FOPM_TL_CHECKLIST.EX_LND_CL then
        checklist_landing()
    end
    if FOPM_TL_CHECKLIST.EX_AL_CL then
        checklist_after_landing()
    end
    if FOPM_TL_CHECKLIST.EX_PARK_CL then
        checklist_parking()
    end
    if FOPM_TL_CHECKLIST.EX_SEC_CL then
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
        config:write('FOPM_plugin_version = "V1.1"'.."\n")
        config:write("speak_only_essencials = " .. tostring(speak_only_essencials) .. "\n")
        config:write("fo_autoperform = " .. tostring(fo_autoperform) .. "\n")
        config:write("fo_speed = ".. fo_speed.."\n")
        config:write('prcl_to_load = "'.. prcl_to_load..'"\n\n')
        config:write("FOPM_wleft = "..tostring(FOPM_wleft).."\n")
        config:write("FOPM_wtop = "..tostring(FOPM_wtop).."\n")
        config:write("FOPM_wright = "..tostring(FOPM_wright).."\n")
        config:write("FOPM_wbottom = "..tostring(FOPM_wbottom))
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
local WND_BRIEFING = false
local WND_PRCL_SEL = false
local DEPARTURE_BRIEFING_BLEED_OPT = 1
local setting_change = false
local acf_neo_type = "N"
FO_INTERFACE = nil

-- IMGUI BUILDER
function FO_imgui_builder(FO_INTERFACE, x, y)
    if WND_MAIN then -- MAIN WINDOW
    imgui.Spacing()
        if imgui.SmallButton("Settings") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft-40,FOPM_wtop,FOPM_wright,FOPM_wbottom-82)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = true
            WND_MAIN = false
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Briefing") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft-60,FOPM_wtop,FOPM_wright,FOPM_wbottom-144)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BRIEFING = true
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        imgui.TextUnformatted("     ")
        imgui.SameLine()
        if imgui.SmallButton("X") then
            response_CHECK = true
        end
        -- DEBUGING
            imgui.Separator()
            imgui.Spacing()
            imgui.TextUnformatted("FLT Phase: "..FOPM_CONFIG_VARIABLE.TXT_PHASE)
            imgui.TextUnformatted("PROC_STEP: "..FOPM_STEP_VARIABLE.PROC_STEP)
            imgui.TextUnformatted("CKLST_STEP: "..FOPM_STEP_VARIABLE.CKLST_STEP)
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        -- CHECKLIST
        if FLT_PHASE.PREFLIGHT then
            if FOPM_checklist.Cockpit_preparation_checklist then
                if not FOPM_TL_CHECKLIST.CP_CL and not FOPM_TL_CHECKLIST.EX_CP_CL and not FOPM_TL_CHECKLIST.EX_SEC_CL and FOPM_TL_COMPLETED_PROC.PF_DONE then
                    if imgui.SmallButton("Cockpit Preparation CKL") then
                        FOPM_TL_CHECKLIST.EX_CP_CL = true
                    end
                    imgui.SameLine()
                end
            end
            if FOPM_checklist.Before_start_checklist then
                if not FOPM_TL_CHECKLIST.BS_CL and not FOPM_TL_CHECKLIST.EX_BS_CL and not FOPM_TL_CHECKLIST.EX_SEC_CL and FOPM_TL_COMPLETED_PROC.PF_DONE then
                    if imgui.SmallButton("Before Start CKL") then
                        FOPM_TL_CHECKLIST.EX_BS_CL = true
                    end
                    imgui.SameLine()
                end
            end
            if FOPM_checklist.Securing_checklist then
                if not FOPM_TL_CHECKLIST.SEC_CL and not FOPM_TL_CHECKLIST.EX_SEC_CL and not FOPM_TL_CHECKLIST.BS_CL and not FOPM_TL_CHECKLIST.EX_BS_CL then
                    if imgui.SmallButton("Securing CKL") then
                        FOPM_TL_CHECKLIST.EX_SEC_CL = true
                    end
                end
            end
            if FOPM_checklist.Before_start_checklist_BTL then
                if FOPM_TL_CHECKLIST.BS_CL and not FOPM_TL_CHECKLIST.EX_BS_CL_BTL then
                    if imgui.SmallButton("Before Start CKL BTL") then
                        FOPM_TL_CHECKLIST.EX_BS_CL_BTL = true
                    end
                end
            end
        end
        if FLT_PHASE.PUSHBACK then
            if FOPM_checklist.After_start_checklist then
                if not FOPM_TL_CHECKLIST.AS_CL and
                not FOPM_TL_CHECKLIST.EX_AS_CL and 
                FOPM_TL_COMPLETED_PROC.AS_PROC_DONE and
                not FOPM_Procedures_Control.ONEENG_TAXI_DEP
                then
                    if imgui.SmallButton("After Start CKL") then
                        FOPM_TL_CHECKLIST.EX_AS_CL = true
                    end
                end
            end
        end
        if FLT_PHASE.TAXI_OUT then
            if FOPM_checklist.Taxi_checklist then
                if not FOPM_TL_CHECKLIST.TX_CL and not FOPM_TL_CHECKLIST.EX_TX_CL and FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE then
                    if imgui.SmallButton("Taxi CKL") then
                        FOPM_TL_CHECKLIST.EX_TX_CL = true
                    end
                end
            end
            if FOPM_checklist.Before_takeoff_checklist then
                if not FOPM_TL_CHECKLIST.BTO_CL and not FOPM_TL_CHECKLIST.EX_BTO_CL and FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE then
                    if imgui.SmallButton("Before Takeoff CKL") then
                        FOPM_TL_CHECKLIST.EX_BTO_CL = true
                    end
                end
            end
            if FOPM_checklist.Departure_change_checklist then
                if not FOPM_TL_CHECKLIST.DC_CL and not FOPM_TL_CHECKLIST.EX_DC_CL then
                    if imgui.SmallButton("Departure Change CKL") then
                        FOPM_TL_CHECKLIST.EX_DC_CL = true
                    end
                end
            end
            if FOPM_checklist.Lineup_checklist then
                if FOPM_TL_CHECKLIST.LU_CL and not FOPM_TL_CHECKLIST.EX_LU_CL and FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE and not FOPM_TL_CHECKLIST.EX_BTO_CL_BTL then
                    if imgui.SmallButton("Line Up CKL") then
                        FOPM_TL_CHECKLIST.EX_BTO_CL_BTL = true
                    end
                end
            end
            if FOPM_checklist.Before_takeoff_checklist_BTL then
                if FOPM_TL_CHECKLIST.BTO_CL and not FOPM_TL_CHECKLIST.BTO_CL_BTL and FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE and not FOPM_TL_CHECKLIST.EX_BTO_CL_BTL then
                    if imgui.SmallButton("Before Takeoff CKL BTL") then
                        FOPM_TL_CHECKLIST.EX_BTO_CL_BTL = true
                    end
                end
            end
        end
        if FLT_PHASE.TAKEOFF then
            if FOPM_checklist.After_takeoff_checklist then
                if FOPM_TL_COMPLETED_PROC.TO_PROC_DONE and not FOPM_TL_CHECKLIST.EX_ATO_CL then
                    if imgui.SmallButton("After Takeoff CKL") then
                        FOPM_TL_CHECKLIST.EX_ATO_CL = true
                    end
                end
            end
        end
        if FLT_PHASE.CLIMB then
            if FOPM_checklist.Climb_checklist then
                if not FOPM_TL_CHECKLIST.CLB_CL and not FOPM_TL_CHECKLIST.EX_CLB_CL then
                    if imgui.SmallButton("Climb CKL") then
                        FOPM_TL_CHECKLIST.EX_CLB_CL = true
                    end
                end
            end
        end
        if FLT_PHASE.DESCEND or FLT_PHASE.CLIMB then
            if  FOPM_checklist.Approach_checklist then
                if FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and not FOPM_TL_CHECKLIST.EX_APP_CL then
                    if imgui.SmallButton("Approach CKL") then
                        FOPM_TL_CHECKLIST.EX_APP_CL = true
                    end
                end
            end
        end
        if FLT_PHASE.APPROACH then
            if FOPM_checklist.Approach_checklist then
                if not FOPM_TL_CHECKLIST.LND_CL and not FOPM_TL_CHECKLIST.EX_LND_CL then
                    if imgui.SmallButton("Landing CKL") then
                        FOPM_TL_CHECKLIST.EX_LND_CL = true
                    end
                end
            end
        end
        if FLT_PHASE.TAXI_IN then
            if FOPM_checklist.After_landing_checklist then
                if not FOPM_TL_CHECKLIST.AL_CL and not FOPM_TL_CHECKLIST.EX_AL_CL and FOPM_TL_COMPLETED_PROC.AL_PROC then
                    if imgui.SmallButton("After Landing CKL") then
                        FOPM_TL_CHECKLIST.EX_AL_CL = true
                    end
                end
            end
        end
        if FLT_PHASE.PARKING then
            if FOPM_checklist.Parking_checklist then
                if FOPM_TL_COMPLETED_PROC.PARK_PROC and not FOPM_TL_CHECKLIST.PARK_CL and not FOPM_TL_CHECKLIST.EX_PARK_CL then
                    if imgui.SmallButton("Parking CKL") then
                        FOPM_TL_CHECKLIST.EX_PARK_CL = true
                    end
                end
            end
        end
        -- PROCEDURES
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        if FLT_PHASE.PREFLIGHT then
            if not FOPM_TL_COMPLETED_PROC.PF_DONE and not FOPM_Procedures_Control.EXECUTE_PCP then
                if imgui.SmallButton("Preliminary Cockpit Prep.") then
                    FOPM_Procedures_Control.EXECUTE_PCP = true
                end
            end
        end
        if FLT_PHASE.TAXI_OUT then
            if FOPM_procedure.Taxi_procedure then
                if not FOPM_TL_COMPLETED_PROC.TAXI_PROC_DONE and not FOPM_Procedures_Control.EXECUTE_TXP then
                    if imgui.SmallButton("Taxi Proc.") then
                        FOPM_Procedures_Control.EXECUTE_TXP = true
                    end
                    imgui.SameLine()
                end
            end
            if FOPM_checklist.Taxi_checklist then
                if FOPM_TL_CHECKLIST.TX_CL then
                    if not FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE and not FOPM_Procedures_Control.EXECUTE_BTP then
                        if imgui.SmallButton("Before Takeoff Proc.") then
                            FOPM_Procedures_Control.EXECUTE_BTP = true
                        end
                        imgui.SameLine()
                    end
                end
            else
                if not FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE and not FOPM_Procedures_Control.EXECUTE_BTP then
                    if imgui.SmallButton("Before Takeoff Proc.") then
                        FOPM_Procedures_Control.EXECUTE_BTP = true
                    end
                    imgui.SameLine()
                end
            end
            if not FOPM_Procedures_Control.EXECUTE_ENRWY and not FLT_PHASE.ON_RWY then
                if imgui.SmallButton("Entry RWY") then
                    FOPM_Procedures_Control.EXECUTE_ENRWY = true
                end
            end
            if not FOPM_Procedures_Control.EXECUTE_EXRWY and FLT_PHASE.ON_RWY then
                if imgui.SmallButton("Exit RWY") then
                    FOPM_Procedures_Control.EXECUTE_EXRWY = true
                end
            end
            if not FOPM_Procedures_Control.START_ENG2 and FOPM_Procedures_Control.ONEENG_TAXI_DEP and ENG_2_AVAIL ~= 1 then
                if imgui.SmallButton("Start ENG 2") then
                    FOPM_Procedures_Control.START_ENG2 = true
                end
            end
        end
        if FLT_PHASE.REJECTED_DES then
            if imgui.SmallButton("Taxi OUT") then
                FLT_PHASE.REJECTED_DES = false
                FLT_PHASE.TAXI_OUT = true
                FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS = false
                FOPM_TL_CHECKLIST.BTO_CL_BTL = false
            end
            imgui.SameLine()
            if imgui.SmallButton("Taxi IN") then
                FOPM_DELAY_VARIABLE.DELAY = TIME + 1
                FLT_PHASE.REJECTED_DES = false
                FLT_PHASE.TAXI_IN = true
            end
        end
        if FLT_PHASE.CLIMB then
            if not FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE and not FOPM_Procedures_Control.EXECUTE_10FT_CLB then
                if imgui.SmallButton("Crossing 10.000ft") then
                    FOPM_Procedures_Control.EXECUTE_10FT_CLB = true
                end
            end
        end
        if FLT_PHASE.DESCEND then
            if not FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and not FOPM_Procedures_Control.EXECUTE_10FT_DES then
                if imgui.SmallButton("Crossing 10.000ft") then
                    FOPM_Procedures_Control.EXECUTE_10FT_DES = true
                end
            end
        end
        if FLT_PHASE.TAXI_IN then
            if not FOPM_Procedures_Control.EXECUTE_ENRWY and not FLT_PHASE.ON_RWY and not FOPM_Procedures_Control.EXECUTE_AL_PROC and not FOPM_TL_CHECKLIST.EX_AL_CL then
                if imgui.SmallButton("Entry RWY") then
                    FOPM_Procedures_Control.EXECUTE_ENRWY = true
                end
            end
            if not FOPM_Procedures_Control.EXECUTE_EXRWY and FLT_PHASE.ON_RWY and not FOPM_Procedures_Control.EXECUTE_AL_PROC and not FOPM_TL_CHECKLIST.EX_AL_CL then
                if imgui.SmallButton("Exit RWY") then
                    FOPM_Procedures_Control.EXECUTE_EXRWY = true
                end
            end
            if FOPM_Procedures_Control.ONEENG_TAXI_ARR_AVAIL and not FOPM_Procedures_Control.EXECUTE_OETA then
                if imgui.SmallButton("One Engine Taxi ARR") then
                    FOPM_Procedures_Control.EXECUTE_OETA = true
                end
            end
        end
    end
    if WND_BRIEFING then -- BRIEFING WINDOW
        imgui.Spacing()
        if imgui.SmallButton("Settings") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+20,FOPM_wtop,FOPM_wright,FOPM_wbottom+62)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = true
            WND_MAIN = false
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Main") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+60,FOPM_wtop,FOPM_wright,FOPM_wbottom+144)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        -- ACF/ENG TYPES
        if FLT_PHASE.PREFLIGHT then
            if ACF_ICAO == "A319" then
                if ENG_MODEL == 0 then
                    imgui.TextUnformatted("Aircraft Type: A319-132")
                    imgui.TextUnformatted("Engine: IAE V2524-A5")
                elseif ENG_MODEL == 1 then
                    imgui.TextUnformatted("Aircraft Type: A319-112")
                    imgui.TextUnformatted("Engine: CFM56-5B6")
                elseif ENG_MODEL == 4 then
                    imgui.TextUnformatted("Aircraft Type: A319-115")
                    imgui.TextUnformatted("Engine: CFM56-5B7")
                end
            end
            if ACF_ICAO == "A320" or ACF_ICAO == "A20N" then
                if ENG_MODEL == 0 then
                    imgui.TextUnformatted("Aircraft Type: A320-232")
                    imgui.TextUnformatted("Engine: IAE V2527-A5")
                elseif ENG_MODEL == 1 then
                    imgui.TextUnformatted("Aircraft Type: A320-214")
                    imgui.TextUnformatted("Engine: CFM56-5B4")
                elseif ENG_MODEL == 2 then
                    imgui.TextUnformatted("Aircraft Type: A320-271N")
                    imgui.TextUnformatted("Engine: PW 1127G-JM")
                elseif ENG_MODEL == 3 then
                    imgui.TextUnformatted("Aircraft Type: A320-251N")
                    imgui.TextUnformatted("Engine: CFM LEAP-1A26")
                end
            end
            if ACF_ICAO == "A321" then
                if ENG_MODEL == 0 then
                    imgui.TextUnformatted("Aircraft Type: A321-231")
                    imgui.TextUnformatted("Engine: IAE V2533-A5")
                elseif ENG_MODEL == 1 then
                    imgui.TextUnformatted("Aircraft Type: A321-211")
                    imgui.TextUnformatted("Engine: CFM56-5B3")
                end
            end
            if ACF_ICAO == "A21N" then
                if FUEL_ACF_CONFIG == 1 then
                    acf_neo_type = "N"
                elseif FUEL_ACF_CONFIG == 2 then
                    acf_neo_type = "NX"
                elseif FUEL_ACF_CONFIG == 3 then
                    acf_neo_type = "NY"
                end
                if ENG_MODEL == 2 then
                    imgui.TextUnformatted("Aircraft Type: A320-272"..acf_neo_type)
                    imgui.TextUnformatted("Engine: PW 1130G-JM")
                elseif ENG_MODEL == 3 then
                    imgui.TextUnformatted("Aircraft Type: A320-253"..acf_neo_type)
                    imgui.TextUnformatted("Engine: CFM LEAP-1A33")
                end
            end
            imgui.Spacing()
            imgui.Separator()
            imgui.Spacing()
        end
        -- DEPARTURE BRIEFING
        if FLT_PHASE.PREFLIGHT or FLT_PHASE.PUSHBACK or FLT_PHASE.TAXI_OUT then
            imgui.TextUnformatted("Departure Briefing")
            imgui.Spacing()
            imgui.TextUnformatted("Time Since ENG SD: "..math.floor((TIME - FOPM_CONFIG_VARIABLE.IAE_SD_TIME)/60).." min")
            if imgui.RadioButton("PACKS Off", DEPARTURE_BRIEFING_BLEED_OPT == 1) then
                DEPARTURE_BRIEFING_BLEED_OPT = 1
                FOPM_CONFIG_VARIABLE.PACKS_FOR_TO = false
                FOPM_CONFIG_VARIABLE.APU_TO_PACKS = false
            end
            imgui.SameLine()
            if imgui.RadioButton("PACKS On", DEPARTURE_BRIEFING_BLEED_OPT == 2) then
                DEPARTURE_BRIEFING_BLEED_OPT = 2
                FOPM_CONFIG_VARIABLE.PACKS_FOR_TO = true
                FOPM_CONFIG_VARIABLE.APU_TO_PACKS = false
            end
            imgui.SameLine()
            if imgui.RadioButton("APU to PACKS", DEPARTURE_BRIEFING_BLEED_OPT == 3) then
                DEPARTURE_BRIEFING_BLEED_OPT = 3
                FOPM_CONFIG_VARIABLE.PACKS_FOR_TO = false
                FOPM_CONFIG_VARIABLE.APU_TO_PACKS = true
            end
            imgui.TextUnformatted("TO RWY:")
            imgui.SameLine()
            if string.find(MCDU1_WTITLE, "TAKE OFF") then
                if string.sub(MCDU1_WLINE_1, -3) == "---" then
                    FOPM_CONFIG_VARIABLE.TO_RWY = "---"
                elseif string.sub(MCDU1_GLINE_1, -3) ~= "   " then
                    FOPM_CONFIG_VARIABLE.TO_RWY = string.sub(MCDU1_GLINE_1, -3)
                end
            end
            if FOPM_CONFIG_VARIABLE.TO_RWY == "-" then
                imgui.TextUnformatted("---")
            else
                imgui.TextUnformatted(FOPM_CONFIG_VARIABLE.TO_RWY)
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
            imgui.TextUnformatted("Thrust:")
            imgui.SameLine()
            if THR_SETTING == -20 then
                imgui.TextUnformatted("TOGA")
            else
                imgui.TextUnformatted("Flex "..THR_SETTING)
            end
            imgui.TextUnformatted("Raining:")
            imgui.SameLine()
            if imgui.RadioButton("No", not FOPM_CONFIG_VARIABLE.RAINING) then
                FOPM_CONFIG_VARIABLE.RAINING = false
            end
            imgui.SameLine()
            if imgui.RadioButton("Yes", FOPM_CONFIG_VARIABLE.RAINING) then
                FOPM_CONFIG_VARIABLE.RAINING = true
            end
            local dep_change, change = imgui.Checkbox("RNP AR Departure", APP_TYPE.AR_DEP)
            if dep_change then
                APP_TYPE.AR_DEP = change
            end
            local dep_change, change = imgui.Checkbox("ONE Engine DEP", FOPM_Procedures_Control.ONEENG_TAXI_DEP)
            if dep_change then
                FOPM_Procedures_Control.ONEENG_TAXI_DEP = change
            end
            if not FOPM_TL_COMPLETED_PROC.TO_BRIEFING then
                if imgui.SmallButton("CONFIRM") then
                    local bindex = math.random(4)
                    play_sound(BRIEFING_CONF[bindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (BRIEF_CONF[bindex].del)
                    FOPM_TL_COMPLETED_PROC.TO_BRIEFING = true
                    FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
                    float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+59,FOPM_wtop,FOPM_wright,FOPM_wbottom+134)
                    WND_BRIEFING = false
                    WND_MAIN = true
                end
            else
                if imgui.SmallButton("DEP CHANGE") then
                    local bindex = math.random(4)
                    play_sound(BRIEFING_CONF[bindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (BRIEF_CONF[bindex].del)
                    FOPM_TL_CHECKLIST.DC_CL = false
                    FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
                    float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+59,FOPM_wtop,FOPM_wright,FOPM_wbottom+134)
                    WND_BRIEFING = false
                    WND_MAIN = true
                end
            end
        end
        -- ARRIVAL BRIEFING
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
            if imgui.RadioButton("Raining", FOPM_CONFIG_VARIABLE.RAINING) then
                FOPM_CONFIG_VARIABLE.RAINING = true
            end
            imgui.TextUnformatted("Autobrakes:")
            if imgui.RadioButton("LOW", FOPM_CONFIG_VARIABLE.AUTOBRAKES.LOW) then
                FOPM_CONFIG_VARIABLE.AUTOBRAKES.LOW = true
                FOPM_CONFIG_VARIABLE.AUTOBRAKES.MEDIUM = false
            end
            imgui.SameLine()
            if imgui.RadioButton("MED", FOPM_CONFIG_VARIABLE.AUTOBRAKES.MEDIUM) then
                FOPM_CONFIG_VARIABLE.AUTOBRAKES.LOW = false
                FOPM_CONFIG_VARIABLE.AUTOBRAKES.MEDIUM = true
            end
            if not FOPM_TL_COMPLETED_PROC.DES_BRIEFING then
                if imgui.SmallButton("CONFIRM") then
                    local bindex = math.random(4)
                    play_sound(BRIEFING_CONF[bindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (BRIEF_CONF[bindex].del)
                    FOPM_TL_COMPLETED_PROC.DES_BRIEFING = true
                    FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
                    float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+59,FOPM_wtop,FOPM_wright,FOPM_wbottom+134)
                    WND_BRIEFING = false
                    WND_MAIN = true
                end
            end
        end
    end
    if WND_SETTINGS then -- SETTINGS WINDOW
        imgui.Spacing()
        if imgui.SmallButton("Main") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+40,FOPM_wtop,FOPM_wright,FOPM_wbottom+82)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Briefing") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft-20,FOPM_wtop,FOPM_wright,FOPM_wbottom-62)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BRIEFING = true
            WND_PRCL_SEL = false
        end
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("FOPM Version: "..FOPM_plugin_version)
        imgui.TextUnformatted("Voice Pack: "..FOPM_voicepack_name)
        imgui.TextUnformatted("Procedures: "..FOPM_proc_config_name)
        imgui.TextUnformatted("Checklists: "..FOPM_cklst_config_name)
        if FOPM_proc_config_name ~= prcl_to_load then
            imgui.TextUnformatted("Reload the script to see changes")
        end
        if imgui.SmallButton("Change PROC/CKLT Pack") then
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BRIEFING = false
            WND_PRCL_SEL = true
        end
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("General Settings")
        imgui.Spacing()
        local setting_change, change = imgui.Checkbox("FO Auto Perfomr", fo_autoperform)
        if setting_change then
            fo_autoperform = change
            config_save()
        end
        imgui.TextUnformatted("Speak Only Essencials: ")
        imgui.SameLine()
        if imgui.RadioButton("Yes", speak_only_essencials) then
            speak_only_essencials = true
            config_save()
        end
        imgui.SameLine()
        if imgui.RadioButton("No", not speak_only_essencials) then
            speak_only_essencials = false
            if fo_speed > 0.85 then
                fo_speed = 0.85
            end
            config_save()
        end
        imgui.TextUnformatted("FO Speed:")
        if imgui.RadioButton("Fast", fo_speed == 0.6) then
            fo_speed = 0.6
            config_save()
        end
        imgui.SameLine()
        if imgui.RadioButton("Normal", fo_speed == 0.85) then
            fo_speed = 0.85
            config_save()
        end
        imgui.SameLine()
        if imgui.RadioButton("Study", fo_speed == 1.1) then
            fo_speed = 1.1
            speak_only_essencials = true
            config_save()
        end
    end
    if WND_PRCL_SEL then
        imgui.Spacing()
        if imgui.SmallButton("<-") then
            WND_SETTINGS = true
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Main") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+40,FOPM_wtop,FOPM_wright,FOPM_wbottom+82)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Briefing") then
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft-20,FOPM_wtop,FOPM_wright,FOPM_wbottom-62)
            FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BRIEFING = true
            WND_PRCL_SEL = false
        end
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("Packs Available")
        if imgui.RadioButton("Airbus", prcl_to_load == "Airbus") then
            prcl_to_load = "Airbus"
        end
        if imgui.RadioButton("Avianca 2022", prcl_to_load == "Avianca 2022") then
            prcl_to_load = "Avianca 2022"
        end
        if imgui.RadioButton("Legacy", prcl_to_load == "Legacy") then
            prcl_to_load = "Legacy"
        end
        if FOPM_proc_config_name ~= prcl_to_load then
            imgui.TextUnformatted("Reload the script to see changes")
            if imgui.SmallButton("SAVE") then
                config_save()
                WND_SETTINGS = true
                WND_PRCL_SEL = false
            end
        end
    end
end

-- FLOAT WINDOWS MASTER

function show_interface()
    FO_INTERFACE = float_wnd_create(250, 125, 1, true)
    float_wnd_set_title(FO_INTERFACE, "FO/PM")
    float_wnd_set_imgui_builder(FO_INTERFACE, "FO_imgui_builder")
    if FOPM_wleft then
        float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom)
    end
end


function hide_interface()
    if FO_INTERFACE then
        if not WND_MAIN then
            if WND_BRIEFING then
                FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
                float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+59,FOPM_wtop,FOPM_wright,FOPM_wbottom+134)
                WND_SETTINGS = false
                WND_MAIN = true
                WND_BRIEFING = false
            elseif WND_SETTINGS then
                FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
                float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft+40,FOPM_wtop,FOPM_wright,FOPM_wbottom+82)
                WND_SETTINGS = false
                WND_MAIN = true
                WND_BRIEFING = false
            end
        end
        FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
        if FOPM_wleft > 10000 or FOPM_wleft < 0 then
            FOPM_wleft = nil
            FOPM_wtop = nil
            FOPM_wright = nil
            FOPM_wbottom = nil
        end
        config_save()
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

logMsg("XXXXX   FO/PM LOADED")
else
    logMsg("XXXXX   ACF Not Compatible")
end
else
    logMsg("XXXXX   ACF Not Compatible")
end -- LUA ENDS