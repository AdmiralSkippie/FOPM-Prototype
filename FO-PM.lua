-----------------------------------------
----- //// TOLISS FO / PM V1.2 //// -----
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
math.randomseed(os.time() + math.floor(os.clock() * 1000000))

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

-- LOGBOOK LOAD
dofile(SCRIPT_DIRECTORY.."/FO PM/Logbooks/A32S Logbook.lua")
logMsg("XXXXX   Logbook loaded")

----------------
---- PHASES ----
----------------
FOPM_TL_FLT_PHASE = {
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
    ACT_CL = "",
    EXECUTE_CL = false,
    Cockpit_preparation_checklist = false,
    Before_start_checklist = false,
    BS_CL_BTL = false,
    After_start_checklist = false,
    Taxi_checklist = false,
    Departure_change_checklist = true,
    BTO_CL = false,
    Lineup_checklist = false,
    BTO_CL_BTL = false,
    ATO_CL = false,
    CLB_CL = false,
    Approach_checklist = false,
    Landing_checklist = false,
    After_landing_checklist = false,
    Parking_checklist = false,
    Securing_checklist = false,
}

-----------------------------
---- APPROACH PROCEDURES ----
-----------------------------
FOPM_TL_APP_TYPE = {
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
    EXECUTE_BARO_SET = false,
    EXECUTE_WX_REQ = false
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
    DELAY_PROC = 0,
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
    STEP_RWY = 0,
    PROC_OE_STEP = 0,
    PROC_STEP = 0,
    PROC_RWY_STEP = 0,
    CKLST_STEP = 0,
    DES_MADED = false,
    DES_MADED_OE = false,
    DES_MADED_RWY = false
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
        MEDIUM = false
    },
    IAE_SD_TIME = math.floor(TIME),
    TO_RWY = "-",
    DEP_ARRP = "----",
    ARR_ARRP = "----",
    ALT_ARRP = "----",
    WX_READY = false
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
do_every_frame("FOPM_SpeechQueueRun()")


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

-- SECURITY CHECK
local available_packs = {
    Airbus = true,
    Avianca_2022 = true
}
if not available_packs[prcl_to_load] then
    prcl_to_load = "Airbus"
end

-- PROCEDURES LOAD
dofile(SCRIPT_DIRECTORY.."/FO PM/Procedures-Checklists/"..prcl_to_load.."/Procedures.lua")
logMsg("XXXXX   Procedures Loaded")

-- CHECKLISTS LOAD
dofile(SCRIPT_DIRECTORY.."/FO PM/Procedures-Checklists/"..prcl_to_load.."/Checklists.lua")
logMsg("XXXXX   Checklists Loaded")

------------------
---- RECOVERY ----
------------------
local RECOVERY_AVAIL = true
local NEED_SAVE = false
function save_backup()
    if NEED_SAVE then
        -- ONE ENGINE TAXI DEP IS LONG, SO ITS POSITION IS SAVED TO RESUME IT WHERE IT WAS.
        -- ONLY WHILE IT RUNS, ONE ENGINE TAXI ARR USES THE SAME STEPS AND MUST NOT LEAVE
        -- THEM BEHIND. A STEP WITH recovery_step IN THE PACK RESUMES FROM THAT STEP INSTEAD
        -- (A CHECKLIST IT WAS WAITING FOR DOES NOT SURVIVE A RELOAD).
        local oe_step, oe_pstep, oe_des = 0, 0, false
        if FOPM_Procedures_Control.EXECUTE_OETD then
            oe_step = FOPM_STEP_VARIABLE.STEP_ONEENG
            oe_pstep = FOPM_STEP_VARIABLE.PROC_OE_STEP
            oe_des = FOPM_STEP_VARIABLE.DES_MADED_OE
            local pack = FOPM_procedure.One_engine_taxi_DEP
            local e = pack and pack[oe_pstep]
            if e and e.recovery_step then
                oe_step = 1
                oe_pstep = e.recovery_step
                oe_des = false
            end
        end
        local rute = SCRIPT_DIRECTORY .. "FO PM/FO_Recovery.lua"
        local config = io.open(rute, "w")
        if config then
            config:write("-- FLT PHASE\n")
            config:write("FOPM_TL_FLT_PHASE.PREFLIGHT = "..tostring(FOPM_TL_FLT_PHASE.PREFLIGHT).."\n")
            config:write("FOPM_TL_FLT_PHASE.PUSHBACK = "..tostring(FOPM_TL_FLT_PHASE.PUSHBACK).."\n")
            config:write("FOPM_TL_FLT_PHASE.ENG_START = "..tostring(FOPM_TL_FLT_PHASE.ENG_START).."\n")
            config:write("FOPM_TL_FLT_PHASE.TAXI_OUT = "..tostring(FOPM_TL_FLT_PHASE.TAXI_OUT).."\n")
            config:write("FOPM_TL_FLT_PHASE.ON_RWY = "..tostring(FOPM_TL_FLT_PHASE.ON_RWY).."\n")
            config:write("FOPM_TL_FLT_PHASE.TAKEOFF = "..tostring(FOPM_TL_FLT_PHASE.TAKEOFF).."\n")
            config:write("FOPM_TL_FLT_PHASE.REJECTED = "..tostring(FOPM_TL_FLT_PHASE.REJECTED).."\n")
            config:write("FOPM_TL_FLT_PHASE.REJECTED_DES = "..tostring(FOPM_TL_FLT_PHASE.REJECTED_DES).."\n")
            config:write("FOPM_TL_FLT_PHASE.CLIMB = "..tostring(FOPM_TL_FLT_PHASE.CLIMB).."\n")
            config:write("FOPM_TL_FLT_PHASE.CRUISE = "..tostring(FOPM_TL_FLT_PHASE.CRUISE).."\n")
            config:write("FOPM_TL_FLT_PHASE.DESCEND = "..tostring(FOPM_TL_FLT_PHASE.DESCEND).."\n")
            config:write("FOPM_TL_FLT_PHASE.APPROACH = "..tostring(FOPM_TL_FLT_PHASE.APPROACH).."\n")
            config:write("FOPM_TL_FLT_PHASE.FINAL_APP = "..tostring(FOPM_TL_FLT_PHASE.FINAL_APP).."\n")
            config:write("FOPM_TL_FLT_PHASE.DECELERATION = "..tostring(FOPM_TL_FLT_PHASE.DECELERATION).."\n")
            config:write("FOPM_TL_FLT_PHASE.GA = "..tostring(FOPM_TL_FLT_PHASE.GA).."\n")
            config:write("FOPM_TL_FLT_PHASE.TAXI_IN = "..tostring(FOPM_TL_FLT_PHASE.TAXI_IN).."\n")
            config:write("FOPM_TL_FLT_PHASE.PARKING = "..tostring(FOPM_TL_FLT_PHASE.PARKING).."\n")
            config:write("-- PROCEDURES\n")
            config:write("FOPM_TL_COMPLETED_PROC.PF_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.PF_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.TO_BRIEFING = "..tostring(FOPM_TL_COMPLETED_PROC.TO_BRIEFING).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.AS_PROC_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.AS_PROC_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.TAXI_PROC_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.TAXI_PROC_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.TO_PROC_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.TO_PROC_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.ACF_CLEAN = "..tostring(FOPM_TL_COMPLETED_PROC.ACF_CLEAN).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.DES_BRIEFING = "..tostring(FOPM_TL_COMPLETED_PROC.DES_BRIEFING).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.AP_DISCN_PROC = "..tostring(FOPM_TL_COMPLETED_PROC.AP_DISCN_PROC).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.GA_PROC = "..tostring(FOPM_TL_COMPLETED_PROC.GA_PROC).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS = "..tostring(FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.AL_PROC = "..tostring(FOPM_TL_COMPLETED_PROC.AL_PROC).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.PARK_PROC = "..tostring(FOPM_TL_COMPLETED_PROC.PARK_PROC).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.FLTCTL_CHK = "..tostring(FOPM_TL_COMPLETED_PROC.FLTCTL_CHK).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.EXIT_RWY_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.EXIT_RWY_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE).."\n")
            config:write("FOPM_TL_COMPLETED_PROC.OETA_DONE = "..tostring(FOPM_TL_COMPLETED_PROC.OETA_DONE).."\n")
            config:write("FOPM_Procedures_Control.ONEENG_TAXI_ARR_AVAIL = "..tostring(FOPM_Procedures_Control.ONEENG_TAXI_ARR_AVAIL).."\n")
            config:write("FOPM_Procedures_Control.ONEENG_TAXI_DEP = "..tostring(FOPM_Procedures_Control.ONEENG_TAXI_DEP).."\n")
            config:write("FOPM_Procedures_Control.EXECUTE_OETD = "..tostring(FOPM_Procedures_Control.EXECUTE_OETD).."\n")
            config:write("FOPM_STEP_VARIABLE.STEP_ONEENG = "..oe_step.."\n")
            config:write("FOPM_STEP_VARIABLE.PROC_OE_STEP = "..oe_pstep.."\n")
            config:write("FOPM_STEP_VARIABLE.DES_MADED_OE = "..tostring(oe_des).."\n")
            config:write("-- CHECKLITS\n")
            config:write("FOPM_TL_CHECKLIST.Cockpit_preparation_checklist = "..tostring(FOPM_TL_CHECKLIST.Cockpit_preparation_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.Before_start_checklist = "..tostring(FOPM_TL_CHECKLIST.Before_start_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.BS_CL_BTL = "..tostring(FOPM_TL_CHECKLIST.BS_CL_BTL).."\n")
            config:write("FOPM_TL_CHECKLIST.After_start_checklist = "..tostring(FOPM_TL_CHECKLIST.After_start_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.Taxi_checklist = "..tostring(FOPM_TL_CHECKLIST.Taxi_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.Departure_change_checklist = "..tostring(FOPM_TL_CHECKLIST.Departure_change_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.BTO_CL = "..tostring(FOPM_TL_CHECKLIST.BTO_CL).."\n")
            config:write("FOPM_TL_CHECKLIST.Lineup_checklist = "..tostring(FOPM_TL_CHECKLIST.Lineup_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.BTO_CL_BTL = "..tostring(FOPM_TL_CHECKLIST.BTO_CL_BTL).."\n")
            config:write("FOPM_TL_CHECKLIST.ATO_CL = "..tostring(FOPM_TL_CHECKLIST.ATO_CL).."\n")
            config:write("FOPM_TL_CHECKLIST.CLB_CL = "..tostring(FOPM_TL_CHECKLIST.CLB_CL).."\n")
            config:write("FOPM_TL_CHECKLIST.Approach_checklist = "..tostring(FOPM_TL_CHECKLIST.Approach_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.Landing_checklist = "..tostring(FOPM_TL_CHECKLIST.Landing_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.After_landing_checklist = "..tostring(FOPM_TL_CHECKLIST.After_landing_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.Parking_checklist = "..tostring(FOPM_TL_CHECKLIST.Parking_checklist).."\n")
            config:write("FOPM_TL_CHECKLIST.Securing_checklist = "..tostring(FOPM_TL_CHECKLIST.Securing_checklist).."\n")
            config:write("-- APP TYPE\n")
            config:write("FOPM_TL_APP_TYPE.AR_DEP = "..tostring(FOPM_TL_APP_TYPE.AR_DEP).."\n")
            config:write("FOPM_TL_APP_TYPE.ILS_APP = "..tostring(FOPM_TL_APP_TYPE.ILS_APP).."\n")
            config:write("FOPM_TL_APP_TYPE.MLS_APP = "..tostring(FOPM_TL_APP_TYPE.MLS_APP).."\n")
            config:write("FOPM_TL_APP_TYPE.CAT_II_III = "..tostring(FOPM_TL_APP_TYPE.CAT_II_III).."\n")
            config:write("FOPM_TL_APP_TYPE.RNAV_APP = "..tostring(FOPM_TL_APP_TYPE.RNAV_APP).."\n")
            config:write("FOPM_TL_APP_TYPE.RNAVAR_APP = "..tostring(FOPM_TL_APP_TYPE.RNAVAR_APP).."\n")
            config:write("FOPM_TL_APP_TYPE.VOR_APP = "..tostring(FOPM_TL_APP_TYPE.VOR_APP).."\n")
            config:write("FOPM_TL_APP_TYPE.NDB_APP = "..tostring(FOPM_TL_APP_TYPE.NDB_APP).."\n")
            config:write("FOPM_TL_APP_TYPE.LDA_APP = "..tostring(FOPM_TL_APP_TYPE.LDA_APP).."\n")
            config:write("FOPM_TL_APP_TYPE.FLS = "..tostring(FOPM_TL_APP_TYPE.FLS).."\n")
            config:write("-- CONFIG\n")
            config:write("FOPM_CONFIG_VARIABLE.PT_TO_CONFIG = "..tonumber(FOPM_CONFIG_VARIABLE.PT_TO_CONFIG).."\n")
            config:write("FOPM_CONFIG_VARIABLE.RAINING = "..tostring(FOPM_CONFIG_VARIABLE.RAINING).."\n")
            config:write("FOPM_CONFIG_VARIABLE.PACKS_FOR_TO = "..tostring(FOPM_CONFIG_VARIABLE.PACKS_FOR_TO).."\n")
            config:write("FOPM_CONFIG_VARIABLE.APU_TO_PACKS = "..tostring(FOPM_CONFIG_VARIABLE.APU_TO_PACKS).."\n")
            config:write("FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED = "..tonumber(FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED).."\n")
            config:write("FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED = "..tonumber(FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED).."\n")
            config:write("FOPM_CONFIG_VARIABLE.GREENDOT = "..tonumber(FOPM_CONFIG_VARIABLE.GREENDOT).."\n")
            config:write("FOPM_CONFIG_VARIABLE.CHECK_SPEED = "..tonumber(FOPM_CONFIG_VARIABLE.CHECK_SPEED).."\n")
            config:write("FOPM_CONFIG_VARIABLE.F_TARGET = "..tonumber(FOPM_CONFIG_VARIABLE.F_TARGET).."\n")
            config:write("FOPM_CONFIG_VARIABLE.F_ATARGET = "..tonumber(FOPM_CONFIG_VARIABLE.F_ATARGET).."\n")
            config:write("FOPM_CONFIG_VARIABLE.MINUTE3 = "..tostring(FOPM_CONFIG_VARIABLE.MINUTE3).."\n")
            config:write("FOPM_CONFIG_VARIABLE.PASSED_TRANS_ALT = "..tostring(FOPM_CONFIG_VARIABLE.PASSED_TRANS_ALT).."\n")
            config:write("FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL = "..tostring(FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL).."\n")
            config:write("FOPM_CONFIG_VARIABLE.AUTOBRAKES.LOW = "..tostring(FOPM_CONFIG_VARIABLE.AUTOBRAKES.LOW).."\n")
            config:write("FOPM_CONFIG_VARIABLE.AUTOBRAKES.MEDIUM = "..tostring(FOPM_CONFIG_VARIABLE.AUTOBRAKES.MEDIUM).."\n")
            config:write("FOPM_CONFIG_VARIABLE.IAE_SD_TIME = "..tonumber(FOPM_CONFIG_VARIABLE.IAE_SD_TIME).."\n")
            config:write("FOPM_CONFIG_VARIABLE.TO_RWY = "..'"'..tostring(FOPM_CONFIG_VARIABLE.TO_RWY)..'"'.."\n")
            config:write("-- LOGBOOK\n")
            config:write("fopm_logbook_total_flthr = "..fopm_logbook_total_flthr.."\n")
            config:close()
            RECOVERY_AVAIL = false
            NEED_SAVE = false
        end
    end
end

do_sometimes("save_backup()")

-------------------
----- LOGBOOK -----
-------------------

local actual_flthr = 0
local flthr_diff = 0
local logbook_mark = 0
local logging_flthr = false
function fopm_logbook_engine()
    if not logging_flthr then
        if FOPM_TL_FLT_PHASE.PUSHBACK and (math.floor(GND_SPEED*10)/10) >= 1 then
            logging_flthr = true
            actual_flthr = fopm_logbook_total_flthr
            logbook_mark = math.floor(simtime)
        end
    else
        flthr_diff = math.floor(simtime) - logbook_mark
        fopm_logbook_total_flthr = actual_flthr + flthr_diff
        if FOPM_TL_COMPLETED_PROC.PARK_PROC then
            logging_flthr = false
            fopm_logbook_total_flts = fopm_logbook_total_flts + 1
            local rute = SCRIPT_DIRECTORY .. "FO PM/Logbooks/A32S Logbook.lua"
            local config = io.open(rute, "w")
            if config then
                config:write("-- ///// A32S LOGBOOK /////\n")
                config:write("fopm_logbook_total_flthr = "..fopm_logbook_total_flthr.."\n")
                config:write("fopm_logbook_total_flts = "..fopm_logbook_total_flts.."\n")
                config:close()
            end
        end
    end
end

do_often("fopm_logbook_engine()")

-- //////////////////////////////
-- ///////// PROCEDURES /////////
-- //////////////////////////////

---- FLIGHT_CONTROLS_CHECK
function flt_ctl_chk()
    if FOPM_STEP_VARIABLE.STEP_FLT == 0 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "FLIGHT_CONTROLS_CHECK"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
            FOPM_STEP_VARIABLE.STEP_FLT = 1
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "ELEVATOR"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 1.25
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1.25 then
        if math.floor(ELEVATORS + 0.3) == -30 then
            local speech = "FULL_UP"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 1.5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1.5 then
        if math.floor(ELEVATORS + 0.3) == 15 then
            local speech = "FULL_DOWN"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 1.75
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 1.75 then
        if math.floor(ELEVATORS + 0.3) == 0 then
            local speech = "NEUTRAL"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
            FOPM_STEP_VARIABLE.STEP_FLT = 2
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "AILERONS"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
            FOPM_STEP_VARIABLE.STEP_FLT = 2.25
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2.25 then
        if math.floor(LALERONS + 0.3) == 25 and math.floor(RALERONS + 0.3) == -20 then
            local speech = "FULL_LEFT"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 2.5
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2.5 then
        if math.floor(LALERONS + 0.3) == -20 and math.floor(RALERONS + 0.3) == 25 then
            local speech = "FULL_RIGHT"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_STEP_VARIABLE.STEP_FLT = 2.75
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 2.75 then
        if math.floor(LALERONS + 0.3) == 5 and math.floor(RALERONS + 0.3) == 5 then
            local speech = "NEUTRAL"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + 0.955
            FOPM_STEP_VARIABLE.STEP_FLT = 3
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local speech = "RDR"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
            FOPM_STEP_VARIABLE.STEP_FLT = 3.25
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 3.25 then
        if ACF_ICAO == "A321" or ACF_ICAO == "A320" or ACF_ICAO == "A319" then
            if math.floor(RUDDER + 0.3) == -25 then
                local speech = "FULL_LEFT"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_STEP_VARIABLE.STEP_FLT = 3.5
            else
                return
            end
        else
            if math.floor(RUDDER + 0.3) == -30 then
                local speech = "FULL_LEFT"
                FOPM_PlaySound(FOPM_Talk[speech])
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_STEP_VARIABLE.STEP_FLT = 3.75
            else
                return
            end
        else
            if math.floor(RUDDER + 0.3) == 30 then
                local speech = "FULL_RIGHT"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_STEP_VARIABLE.STEP_FLT = 3.75
            else
                return
            end
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 3.75 then
        if math.floor(RUDDER + 0.3) == 0 then
            local speech = "NEUTRAL"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
            FOPM_STEP_VARIABLE.STEP_FLT = 4
        else
            return
        end
    end
    if FOPM_STEP_VARIABLE.STEP_FLT == 4 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            FOPM_TL_COMPLETED_PROC.FLTCTL_CHK = true
            FOPM_STEP_VARIABLE.STEP_FLT = 0
            NEED_SAVE = true
        else
            return
        end
    end
end

-- ///////////////////////////////////////
-- ///////// PROCEDURE ENGINE ///////////
-- ///////////////////////////////////////
-- ONE ENGINE RUNS EVERY PROCEDURE OF THE PACK'S Procedures.lua, THE SAME WAY
-- fopm_checklist_engine() RUNS EVERY CHECKLIST. WHAT USED TO BE COPIED INTO
-- SIX FUNCTIONS LIVES HERE ONCE, AND WHAT IS PARTICULAR TO A PROCEDURE LIVES
-- IN ITS ENTRY OF FOPM_PROC_CFG:
--   pack                TABLE NAME INSIDE FOPM_procedure
--   step / pstep        WHICH FOPM_STEP_VARIABLE FIELDS IT RUNS ON. ONE ENGINE
--                       TAXI KEEPS ITS OWN PAIR SO IT CAN RUN ALONGSIDE THE
--                       OTHERS, AND ITS PACK READS PROC_OE_STEP DIRECTLY, SO
--                       THESE STAY THE SAME GLOBALS AS BEFORE. DELAY AND
--                       DELAY_PROC ARE SHARED AS THEY ALWAYS WERE.
--   des                 DECISION FLAG FIELD, "DES_MADED" UNLESS SET. ONE ENGINE
--                       TAXI HAS ITS OWN, SO A PROCEDURE OR A CHECKLIST RUN WHILE
--                       IT IS PAUSED CANNOT MAKE IT REPEAT A DECISION BRANCH.
--   flap_config         SAY THE FLAPS WITH THE "CONF" CALLOUTS, NOT "FLAPS n"
--   flaps_check_delay   WAIT AFTER MOVING THE FLAPS ON AN action_check
--   int_retry_fo_speed  RETRY A SILENT CHECK EVERY fo_speed INSTEAD OF 10 s
--   ready_for_to        SAY THE "READY FOR TAKEOFF" CALLOUT ON THAT STATE
--   end_ready           SAY A "READY" CALLOUT WHEN THE PROCEDURE ENDS
--   end_ready_optional  THAT "READY" IS SKIPPED WITH SPEAK ONLY ESSENTIALS
--   end_fpln            RETURN THE MCDU TO THE FLIGHT PLAN WHEN IT ENDS
--   save_step           WAKE THE RECOVERY SAVE ON EVERY NEW STEP
--   on_done             COMPLETION FLAGS OF THIS PROCEDURE
--   handlers            (OPTIONAL) DECISION STEPS WITH THEIR OWN LOGIC, BY ITEM NAME.
--                       THEY ARE PER PROCEDURE ON PURPOSE, THE SAME NAME DOES
--                       NOT ALWAYS BEHAVE THE SAME ("OETD CHECK" IN AFTER START
--                       IS NOT "OETD CHECK" IN TAXI).

local function proc_adv(cfg, n)
    FOPM_STEP_VARIABLE[cfg.pstep] = FOPM_STEP_VARIABLE[cfg.pstep] + n
end

local function proc_step(cfg, v)
    FOPM_STEP_VARIABLE[cfg.step] = v
end

-- SPEAKS THE ITEM NAME OF A STEP, RESPECTING SPEAK ONLY ESSENTIALS
local function proc_say_item(e)
    if not e.essential then
        if not speak_only_essencials then
            local speech = e.item
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
        else
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
        end
    else
        local speech = e.item
        FOPM_PlaySound(FOPM_Talk[speech])
        FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
    end
end

-- WRITES ONE DATAREF, OR EVERY DATAREF OF A LIST (dataref_name = {"A", "B"})
local function proc_write(names, value)
    if type(names) == "table" then
        for _, name in ipairs(names) do
            _G[name] = value
        end
    else
        _G[names] = value
    end
end

-- RUNS ONE COMMAND, OR EVERY COMMAND OF A LIST (command = {CMD_A, CMD_B})
local function proc_command(cmd)
    if type(cmd) == "table" then
        for _, c in ipairs(cmd) do
            command_once(c)
        end
    else
        command_once(cmd)
    end
end

-- DOES WHAT AN action, action_check OR action_pre_check ASKS FOR. dataref, command
-- AND run CAN GO TOGETHER IN ONE STEP, delay IS LEFT TO WHOEVER CALLS IT
local function proc_do(act, e)
    if act.dataref ~= nil then
        proc_write(e.dataref_name, act.dataref)
    end
    if act.command then
        proc_command(act.command)
    end
    if act.run then
        act.run()
    end
end

local function proc_pre_action(e)
    if e.action_pre_check then
        proc_do(e.action_pre_check, e)
    end
end

local function proc_flap_voice(cfg)
    if cfg.flap_config then
        return CONFIG_VOICE_SRCH, FLAP_CONFIG
    end
    return FL_VOICE_SRCH, FLAP_POS
end

-- DECISION HANDLERS SHARED WORD FOR WORD BY MORE THAN ONE PROCEDURE
local function h_fltctlchk(e, cfg)
    if e.check() then
        proc_adv(cfg, 1)
        proc_step(cfg, 3)
    else
        flt_ctl_chk()
    end
end

local function h_weather_radar(e, cfg)
    radar_pos = math.random(2)
    if e.check() then
        proc_adv(cfg, 1)
    else
        proc_adv(cfg, 2)
    end
end

local function h_engine_mode(e, cfg)
    if e.check() then
        proc_adv(cfg, 1)
    else
        proc_adv(cfg, 2)
    end
end

local function h_brake_temp(e, cfg)
    if e.check() then
        local rindex = math.random(3)
        FOPM_PlaySound(BRAKE_WARNINGS[rindex])
        FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(BRAKE_WARN, rindex))
        proc_adv(cfg, 1)
    else
        proc_adv(cfg, 2)
    end
end

local function h_temp_check(e, cfg)
    if e.check() then
        local rindex = math.random(5)
        FOPM_PlaySound(READY[rindex])
        FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(RDY, rindex))
        proc_adv(cfg, -1)
    end
end

local function h_on_oetd(e, cfg)
    if e.check() then
        proc_adv(cfg, 1)
    else
        proc_adv(cfg, 3)
        proc_step(cfg, 3)
    end
end

local FOPM_PROC_CFG = {
    PCP = {
        pack = "Pre_cockpit_preparation", step = "STEP", pstep = "PROC_STEP",
        end_ready = true, end_fpln = true,
        on_done = function ()
            FOPM_TL_COMPLETED_PROC.PF_DONE = true
            FOPM_Procedures_Control.EXECUTE_PCP = false
        end,
        handlers = {
            EXTERNAL_CHECK = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 1)
                else
                    proc_adv(cfg, 2)
                end
            end
        }
    },
    ASP = {
        pack = "After_start_procedure", step = "STEP", pstep = "PROC_STEP",
        flap_config = true, flaps_check_delay = 0.9,
        end_ready = true, end_fpln = true,
        on_done = function ()
            FOPM_TL_COMPLETED_PROC.AS_PROC_DONE = true
            FOPM_Procedures_Control.EXECUTE_ASP = false
        end,
        handlers = {
            TRIM_CHECK = function (e, cfg)
                FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION = string.match(MCDU2_BLINE_3, "([UPDN]+)")
                FOPM_CONFIG_VARIABLE.PT_TO_ANGLE = tonumber(string.match(MCDU2_BLINE_3, "/.-[UPDN]+(%d+%.%d+)"))
                FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_1, "(%d+)"))
                FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_2, "(%d+)"))
                FOPM_CONFIG_VARIABLE.GREENDOT = tonumber(string.match(MCDU2_GLINE_3,"(%d+)"))
                if e.check() then
                    FOPM_CONFIG_VARIABLE.PT_TO_CONFIG = FOPM_CONFIG_VARIABLE.PT_TO_ANGLE * 1
                    proc_adv(cfg, 1)
                    command_begin(PITCH_TRIM_UP)
                else
                    FOPM_CONFIG_VARIABLE.PT_TO_CONFIG = FOPM_CONFIG_VARIABLE.PT_TO_ANGLE * -1
                    proc_adv(cfg, 1)
                    command_begin(PITCH_TRIM_DN)
                end
            end,
            TRIM_STOP = function (e, cfg)
                if e.check() then
                    command_end(PITCH_TRIM_DN)
                    command_end(PITCH_TRIM_UP)
                    proc_adv(cfg, 1)
                end
            end,
            ["OETD CHECK"] = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 2)
                    FOPM_Procedures_Control.EXECUTE_OETD = true
                    proc_step(cfg, 3)
                else
                    proc_adv(cfg, 1)
                    proc_step(cfg, 3)
                end
            end,
            FLTCTLCHK = h_fltctlchk
        }
    },
    TXP = {
        pack = "Taxi_procedure", step = "STEP", pstep = "PROC_STEP",
        flap_config = true,
        end_ready = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_TXP = false
            FOPM_TL_COMPLETED_PROC.TAXI_PROC_DONE = true
            FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = false
        end,
        handlers = {
            WEATHER_RADAR = h_weather_radar,
            ENGINE_MODE_SELECTOR = h_engine_mode,
            BRAKE_TEMP = h_brake_temp,
            TEMP_CHECK = h_temp_check,
            ON_OETD = h_on_oetd,
            ["OETD CHECK"] = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 2)
                    FOPM_Procedures_Control.EXECUTE_OETD = true
                    proc_step(cfg, 3)
                else
                    proc_adv(cfg, 1)
                end
            end,
            FLTCTLCHK = h_fltctlchk
        }
    },
    BTP = {
        pack = "Before_takeoff_proc", step = "STEP", pstep = "PROC_STEP",
        flap_config = true,
        end_ready = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_BTP = false
            FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = true
            FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = false
        end,
        handlers = {
            WEATHER_RADAR = h_weather_radar,
            ENGINE_MODE_SELECTOR = h_engine_mode,
            BRAKE_TEMP = h_brake_temp,
            TEMP_CHECK = h_temp_check,
            ON_OETD = h_on_oetd,
            PACKS = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 3)
                else
                    proc_adv(cfg, 1)
                end
            end
        }
    },
    AL = {
        pack = "After_landing_proc", step = "STEP", pstep = "PROC_STEP",
        int_retry_fo_speed = true,
        end_ready = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_AL_PROC = false
            FOPM_TL_COMPLETED_PROC.AL_PROC = true
        end,
        handlers = {
            FLAPS = function (e, cfg)
                if e.check() then
                    FOPM_CONFIG_VARIABLE.F_TARGET = 0.25
                    FOPM_CONFIG_VARIABLE.F_ATARGET = FLAPS_LEVER_State
                    proc_adv(cfg, 1)
                else
                    FOPM_CONFIG_VARIABLE.F_TARGET = 0
                    FOPM_CONFIG_VARIABLE.F_ATARGET = FLAPS_LEVER_State
                    proc_adv(cfg, 1)
                end
            end,
            FLAPS_RET = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 1)
                else
                    command_once(FLAPS_1UP)
                    FOPM_CONFIG_VARIABLE.F_ATARGET = FOPM_CONFIG_VARIABLE.F_ATARGET - 0.25
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
            end
        }
    },
    OETD = {
        pack = "One_engine_taxi_DEP", step = "STEP_ONEENG", pstep = "PROC_OE_STEP", des = "DES_MADED_OE",
        ready_for_to = true, save_step = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_OETD = false
            FOPM_Procedures_Control.ONEENG_TAXI_DEP = false
        end,
        handlers = {
            APU_BLEED = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 3)
                else
                    proc_adv(cfg, 1)
                end
            end,
            ANTI_ICE = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 1)
                else
                    proc_adv(cfg, 2)
                end
            end,
            ["After Start Checklist"] = function (e, cfg)
                if e.check() then
                    -- LAUNCHED THE WAY THE CHECKLIST ENGINE EXPECTS. THE FLAG IS CLEARED
                    -- FIRST SO THE NEXT PACK STEP WAITS FOR THIS FLIGHT'S CHECKLIST AND
                    -- NOT FOR ONE LEFT OVER FROM A PREVIOUS LEG. DURING OETD THE AFTER
                    -- START CKL BUTTON IS HIDDEN, SO NOTHING ELSE CAN HAVE RUN IT.
                    FOPM_TL_CHECKLIST.After_start_checklist = false
                    FOPM_TL_CHECKLIST.ACT_CL = "After_start_checklist"
                    FOPM_TL_CHECKLIST.EXECUTE_CL = true
                    proc_adv(cfg, 1)
                end
            end,
            PROC_COMP = function (e, cfg)
                if e.check() then
                    local rindex = math.random(5)
                    FOPM_PlaySound(READY[rindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(RDY, rindex))
                    proc_adv(cfg, 1)
                end
            end,
            FLTCTLCHK = h_fltctlchk,
            ENG_COMP = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 1)
                else
                    proc_adv(cfg, 3)
                end
            end,
            IAE_CHECK_TIME = function (e, cfg)
                if e.check() then
                    proc_adv(cfg, 1)
                else
                    proc_adv(cfg, 2)
                end
            end
        }
    },
    -- NEVER RUNS WITH ONE ENGINE TAXI DEP, SO IT SHARES ITS STEPS
    OETA = {
        pack = "One_engine_taxi_ARR", step = "STEP_ONEENG", pstep = "PROC_OE_STEP", des = "DES_MADED_OE",
        on_done = function ()
            FOPM_Procedures_Control.ONEENG_TAXI_ARR_AVAIL = false
            FOPM_Procedures_Control.EXECUTE_OETA = false
        end
    },
    -- ENTER AND VACATING RUNWAY CAN RUN DURING THE TAXI PROCEDURES, SO THEY KEEP
    -- THEIR OWN STEPS AND DECISION FLAG (THE TWO NEVER RUN TOGETHER)
    ENRWY = {
        pack = "Enter_runway_proc", step = "STEP_RWY", pstep = "PROC_RWY_STEP", des = "DES_MADED_RWY",
        end_ready = true, end_ready_optional = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_ENRWY = false
            FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE = true
        end
    },
    EXRWY = {
        pack = "Vacating_runway_proc", step = "STEP_RWY", pstep = "PROC_RWY_STEP", des = "DES_MADED_RWY",
        end_ready = true, end_ready_optional = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_EXRWY = false
            FOPM_TL_COMPLETED_PROC.EXIT_RWY_DONE = false
        end
    },
    CLB10 = {
        pack = "Ten_thousand_feet_CLB", step = "STEP", pstep = "PROC_STEP",
        end_ready = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_10FT_CLB = false
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = true
        end
    },
    DES10 = {
        pack = "Ten_thousand_feet_DES", step = "STEP", pstep = "PROC_STEP",
        end_ready = true,
        on_done = function ()
            FOPM_Procedures_Control.EXECUTE_10FT_DES = false
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = true
        end
    },
    PARK = {
        pack = "Parking_proc", step = "STEP", pstep = "PROC_STEP",
        end_ready = true,
        on_done = function ()
            FOPM_TL_COMPLETED_PROC.PARK_PROC = true
        end
    }
}

function fopm_procedure_engine(cfg)
    local S = FOPM_STEP_VARIABLE
    local P = FOPM_procedure[cfg.pack]
    local des = cfg.des or "DES_MADED"
    if P == nil then
        -- THE LOADED PACK DOES NOT HAVE THIS PROCEDURE. IT IS CLOSED AS DONE SO NOTHING
        -- KEEPS WAITING FOR IT (AN AIRCRAFT PACK MAY NOT NEED EVERY PROCEDURE)
        logMsg("XXXXX   FO/PM: procedure "..cfg.pack.." not found in the "..tostring(FOPM_proc_config_name).." pack")
        S[cfg.step] = 0
        S[cfg.pstep] = 0
        cfg.on_done()
        NEED_SAVE = true
        return
    end
    if S[cfg.step] == 0 then
        S[cfg.step] = 1
        S[cfg.pstep] = 1
    elseif S[cfg.step] == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local e = P[S[cfg.pstep]]
            if e == nil or (e.condition and not e.condition()) then
                -- A STEP WHOSE condition IS NOT MET IS JUMPED WITHOUT A PAUSE. A STEP OUT
                -- OF THE PACK (A HANDLER JUMPING PAST THE END, A BAD RECOVERY) IS JUMPED
                -- TOO, SO THE PROCEDURE ENDS OR MOVES ON INSTEAD OF BREAKING
                S[cfg.pstep] = S[cfg.pstep] + 1
                S[cfg.step] = 3
            elseif e.step_desition then
                if e.to_step_desition then
                    if S[des] then
                        S[cfg.pstep] = S[cfg.pstep] + 1
                        S[cfg.step] = 3
                    else
                        proc_pre_action(e)
                        if e.item then
                            proc_say_item(e)
                        elseif e.int_item then
                            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        end
                        S[des] = true
                        S[cfg.step] = 2
                    end
                else
                    if S[des] then
                        S[des] = false
                    end
                    if e.item then
                        proc_say_item(e)
                    end
                    proc_pre_action(e)
                    if e.check then
                        local handler = cfg.handlers and (cfg.handlers[e.int_item] or cfg.handlers[e.item])
                        if handler then
                            handler(e, cfg)
                        end
                    end
                end
            else
                if e.item then
                    proc_say_item(e)
                elseif e.int_item then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                proc_pre_action(e)
                S[cfg.step] = 2
            end
        end
    elseif S[cfg.step] == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            local e = P[S[cfg.pstep]]
            if e == nil then
                -- OUT OF THE PACK, STEP 3 ENDS THE PROCEDURE OR PUTS IT BACK ON A VALID STEP
                S[cfg.step] = 3
            elseif e.check then
                if e.check() then
                    if e.state then
                        if e.item == "FLAPS" or e.int_item == "FLAPS" then
                            if not e.essential then
                                if not speak_only_essencials then
                                    local speech, dir = proc_flap_voice(cfg)
                                    FOPM_PlaySound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(dir, speech))
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                local speech, dir = proc_flap_voice(cfg)
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(dir, speech)) + fo_speed
                            end
                        else
                            if not e.essential then
                                if not speak_only_essencials then
                                    local speech = e.state
                                    FOPM_PlaySound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                                else
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                                end
                            else
                                if cfg.ready_for_to and e.state == "READY_FOR_TO" then
                                    local rindex = math.random(3)
                                    FOPM_PlaySound(READY_FOR_TO[rindex])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(RDY_TO_DIR, rindex)) + fo_speed
                                else
                                    local speech = e.state
                                    FOPM_PlaySound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                                end
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                    S[cfg.step] = 3
                    S[cfg.pstep] = S[cfg.pstep] + 1
                else
                    if e.action_check then
                        local wait = fo_speed
                        if cfg.flaps_check_delay and (e.item == "FLAPS" or e.int_item == "FLAPS") then
                            wait = cfg.flaps_check_delay
                        end
                        proc_do(e.action_check, e)
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (e.action_check.delay or wait)
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_PROC then
                            if e.item then
                                local speech = e.item
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_PROC = TIME + (FOPM_Duration(FO_voices_directory, speech)) + 10
                            elseif e.int_item then
                                if cfg.int_retry_fo_speed then
                                    FOPM_DELAY_VARIABLE.DELAY_PROC = TIME + fo_speed
                                else
                                    FOPM_DELAY_VARIABLE.DELAY_PROC = TIME + 10
                                end
                            end
                        end
                    end
                end
            elseif e.action then
                if e.state then
                    if e.item == "FLAPS" or e.int_item == "FLAPS" then
                        if not e.essential then
                            if not speak_only_essencials then
                                local speech, dir = proc_flap_voice(cfg)
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(dir, speech)) + fo_speed
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech, dir = proc_flap_voice(cfg)
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(dir, speech)) + fo_speed
                        end
                    else
                        if not e.essential then
                            if not speak_only_essencials then
                                local speech = e.state
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                            else
                                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                            end
                        else
                            local speech = e.state
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                        end
                    end
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                proc_do(e.action, e)
                if e.action.delay then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + e.action.delay
                end
                S[cfg.step] = 3
                S[cfg.pstep] = S[cfg.pstep] + 1
            elseif e.state then
                if not e.essential then
                    if not speak_only_essencials then
                        local speech = e.state
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    end
                else
                    local speech = e.state
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
                end
                S[cfg.step] = 3
                S[cfg.pstep] = S[cfg.pstep] + 1
            else
                S[cfg.step] = 3
                S[cfg.pstep] = S[cfg.pstep] + 1
            end
        end
    elseif S[cfg.step] == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if S[cfg.pstep] > #P then
                if cfg.end_ready then
                    if cfg.end_ready_optional and speak_only_essencials then
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    else
                        local rindex = math.random(5)
                        FOPM_PlaySound(READY[rindex])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(RDY, rindex)) + fo_speed
                    end
                end
                if cfg.end_fpln then
                    command_once(MCDU_FO_KEY_Fpln)
                end
                S[cfg.step] = 0
                S[cfg.pstep] = 0
                cfg.on_done()
                NEED_SAVE = true
            else
                if cfg.save_step then
                    NEED_SAVE = true
                end
                S[cfg.step] = 1
            end
        end
    end
end

---- PRELIMINARY COCKPIT PREPARATION
function pre_cockpit_pre()
    fopm_procedure_engine(FOPM_PROC_CFG.PCP)
end

---- AFTER START PROCEDURE
function after_start_proc()
    fopm_procedure_engine(FOPM_PROC_CFG.ASP)
end

---- TAXI PROCEDURE
function taxi_proc()
    fopm_procedure_engine(FOPM_PROC_CFG.TXP)
end

---- BEFORE TAKEOFF PROCEDURE
function before_takeoff_proc()
    fopm_procedure_engine(FOPM_PROC_CFG.BTP)
end

---- ENTER RWY
function enter_rwy()
    if FOPM_TL_FLT_PHASE.ON_RWY then
        if not FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE then
            fopm_procedure_engine(FOPM_PROC_CFG.ENRWY)
        else
            FOPM_Procedures_Control.EXECUTE_ENRWY = false
        end
    end
end

---- VACATING RWY
function vacating_rwy()
    fopm_procedure_engine(FOPM_PROC_CFG.EXRWY)
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_STEP_VARIABLE.STEP = 3
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 3 then -- speeds check
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                if math.floor(IND_AIRSPEED) == 100 then
                    local speech = "N100"
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                end
                if math.floor(IND_AIRSPEED) == V1_SPEED - 1 then
                    local speech = "V1"
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                end
                if math.floor(IND_AIRSPEED) >= VR_SPEED then
                    local speech = "ROTATE"
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                else
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                end
                ENG_Mode = 1
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_TL_COMPLETED_PROC.TO_PROC_DONE = true
                NEED_SAVE = true
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
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FLAP_POS, speech)) + fo_speed
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FLAP_POS, speech)) + fo_speed
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FLAP_POS, speech)) + fo_speed
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
                    NEED_SAVE = true
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FLAP_POS, speech)) + fo_speed
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FLAP_POS, speech)) + fo_speed
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CLEAN = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
    fopm_procedure_engine(FOPM_PROC_CFG.CLB10)
end

---- 10.000FT DES PROCEDURE
function ten_thausand_feet_DES()
    fopm_procedure_engine(FOPM_PROC_CFG.DES10)
end

---- AP DISCONECT
function ap_discn_behaviour()
    if FOPM_STEP_VARIABLE.STEP_AP == 0 then
        if AP_DISCN_ALARM == 1 then
            if not FOPM_TL_APP_TYPE.ILS_APP and not FOPM_TL_APP_TYPE.MLS_APP then
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
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY_AP = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
            NEED_SAVE = true
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FPMTR.CONT_APP = false
            end
        end
        if FO_GS_Avail == 1 and math.floor(RADIO_ALT) > 100 then
            if math.floor(FO_GS_Deviation*10)/10 < -1 or math.floor(FO_GS_Deviation*10)/10 > 1 then
                local speech = "GA_UNSTABLE"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                    FPMTR.SPDDELAY = TIME + 10
                end
            end
        end
    end
    if TIME >= FPMTR.SINKDELAY then
        if math.floor(VERTICAL_SPEED) < -1000 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                local speech = "SINK_RATE"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FPMTR.SINKDELAY = TIME + 10
            end
        end
    end
    if TIME >= FPMTR.BANKDELAY then
        if FOPM_TL_APP_TYPE.ILS_APP or FOPM_TL_APP_TYPE.MLS_APP then
            if (math.floor(ROLL_ANGLE*10)/10) > 7 or (math.floor(ROLL_ANGLE*10)/10) < -7 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "BANK"
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                    FPMTR.BANKDELAY = TIME + 10
                end
            end
        else
            if (math.floor(ROLL_ANGLE*10)/10) > 30 or (math.floor(ROLL_ANGLE*10)/10) < -30 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "BANK"
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                    FPMTR.PITCHDELAY = TIME + 10
                end
            end
        else
            if math.floor(PITCH_ANGLE*10)/10 < -2.5 or math.floor(PITCH_ANGLE*10)/10 > 10 then
                if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                    local speech = "PITCH"
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                    FPMTR.PITCHDELAY = TIME + 10
                end
            end
        end
    end
    if TIME >= FPMTR.LOCDELAY then
        if FOPM_TL_APP_TYPE.ILS_APP or FOPM_TL_APP_TYPE.MLS_APP then
            if FO_LOC_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_LOC_Deviation*10)/10 < -0.5 or math.floor(FO_LOC_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "LOC"
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                        FPMTR.LOCDELAY = TIME + 10
                    end
                end
            end
        elseif FOPM_TL_APP_TYPE.LDA_APP then
            if FO_LOC_Avail == 1 and FO_FD_STATE == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_LOC_Deviation*10)/10 < -0.5 or math.floor(FO_LOC_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "LOC"
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                        FPMTR.LOCDELAY = TIME + 10
                    end
                end
            end
        else
            if FO_LOC_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_LOC_Deviation*10)/10 < -0.5 or math.floor(FO_LOC_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "LAT_DEV"
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                        FPMTR.LOCDELAY = TIME + 10
                    end
                end
            end
        end
    end
    if TIME >= FPMTR.GLIDEDELAY then
        if FOPM_TL_APP_TYPE.ILS_APP or FOPM_TL_APP_TYPE.MLS_APP then
            if FO_GS_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_GS_Deviation*10)/10 < -0.5 or math.floor(FO_GS_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "GLIDE"
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                        FPMTR.GLIDEDELAY = TIME + 10
                    end
                end
            end
        elseif FOPM_TL_APP_TYPE.LDA_APP then
            if FO_GS_Avail == 1 and FO_FD_STATE == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_GS_Deviation*10)/10 < -0.5 or math.floor(FO_GS_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "GLIDE"
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
                        FPMTR.GLIDEDELAY = TIME + 10
                    end
                end
            end
        else
            if FO_GS_Avail == 1 and math.floor(RADIO_ALT) > 100 then
                if math.floor(FO_GS_Deviation*10)/10 < -0.5 or math.floor(FO_GS_Deviation*10)/10 > 0.5 then
                    if TIME >= FOPM_DELAY_VARIABLE.DELAY_SPEACH then
                        local speech = "V_DEV"
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY_AL = TIME + (FOPM_Duration(FO_voices_directory, speech))
            FOPM_STEP_VARIABLE.STEP_AL = 1
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AL == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AL then
            if string.find(FMA_G_STATE, "FLARE") then
                local speech = "FLARE"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_AL = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_STEP_VARIABLE.STEP_AL = 2
            end
        end
    end
    if FOPM_STEP_VARIABLE.STEP_AL == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_AL then
            if string.find(FMA_G_STATE, "ROLL OUT") then
                local speech = "ROLL_OUT"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_AL = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                FOPM_TL_CHECKLIST.Approach_checklist = false
                FOPM_TL_CHECKLIST.ATO_CL = false
                FOPM_TL_CHECKLIST.Landing_checklist = false
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 1 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                local speech = "GO_ARROUND"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_STEP_VARIABLE.STEP = 2
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 2 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                local speech = "TOGA"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + 0.5
                FOPM_STEP_VARIABLE.STEP = 3
            else
                return
            end
        end
        if FOPM_STEP_VARIABLE.STEP == 3 then
            if TIME >= FOPM_DELAY_VARIABLE.DELAY then
                local speech = FLUP_VOICE_SRCH
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FLAP_POS, speech)) + fo_speed
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
                if FOPM_TL_APP_TYPE.ILS_APP or FOPM_TL_APP_TYPE.MLS_APP then
                    FOPM_STEP_VARIABLE.STEP = 10
                else
                    local speech = "FLIGHT_DIRECTORS"
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_SPEACH = TIME + (FOPM_Duration(FO_voices_directory, speech))
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
                    if string.match(MCDU2_GLINE_1, "(%d+)") then
                        FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_1, "(%d+)"))
                    end
                    if string.match(MCDU2_GLINE_2, "(%d+)") then
                        FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_2, "(%d+)"))
                    end
                    if string.match(MCDU2_GLINE_3,"(%d+)") then
                        FOPM_CONFIG_VARIABLE.GREENDOT = tonumber(string.match(MCDU2_GLINE_3,"(%d+)"))
                    end
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
                NEED_SAVE = true
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
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
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
                    FOPM_STEP_VARIABLE.STEP = 0
                    FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS = true
                    NEED_SAVE = true
                end
            end
        end
    end
end

---- AFTER LANDING PROCEDURE
function after_landing_proc()
    fopm_procedure_engine(FOPM_PROC_CFG.AL)
end

---- BRAKE TEMP CHECK PROCEDURE
function brake_temp_check()
    if BRAKE1_TEMP > 150 or BRAKE2_TEMP > 150 or BRAKE3_TEMP > 150 or BRAKE4_TEMP > 150 then
        if not speak_only_essencials then
            local speech = "BRAKE_FAN"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech)) + fo_speed
        else
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
        end
        command_once(BRKFAN_PB)
        FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = true
        NEED_SAVE = true
    else
        FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE = true
        NEED_SAVE = true
    end
end

-- PARKING PROCEDURE
function parking_proc()
    fopm_procedure_engine(FOPM_PROC_CFG.PARK)
end

-- ONE ENGINE TAXI DEPARTURE
function one_engine_taxi_DEP()
    fopm_procedure_engine(FOPM_PROC_CFG.OETD)
end

-- ONE ENGINE TAXI ARRIVAL
function one_engine_taxi_ARR()
    fopm_procedure_engine(FOPM_PROC_CFG.OETA)
end

-- ///////////////////////////////////
-- ///// CHECKLIST ANSWER ENGINE /////
-- ///////////////////////////////////

-- LAST QNH READ FROM A METAR, MIRRORED HERE SO THE CHECKLIST PACKS CAN SEE IT.
-- THE STATION IS KEPT TOO, SO AN ARRIVAL ITEM NEVER VALIDATES OR READS BACK A
-- DEPARTURE QNH THAT IS STILL SITTING IN MEMORY.
FOPM_METAR = {QNH = nil, UNIT = nil, STATION = nil}

-- RETURNS THE METAR QNH ONLY IF IT BELONGS TO THE AIRPORT THAT MATTERS RIGHT NOW
function FOPM_MetarQNH()
    if FOPM_METAR.QNH == nil then return nil end
    local expected
    if FOPM_TL_FLT_PHASE.PREFLIGHT or FOPM_TL_FLT_PHASE.PUSHBACK or FOPM_TL_FLT_PHASE.TAXI_OUT then
        expected = FOPM_CONFIG_VARIABLE.DEP_ARRP
    else
        expected = FOPM_CONFIG_VARIABLE.ARR_ARRP
    end
    if expected and FOPM_METAR.STATION and FOPM_METAR.STATION ~= expected then
        return nil
    end
    return FOPM_METAR.QNH, FOPM_METAR.UNIT
end

-- TRUE WHEN AN ALTIMETER READING IN INHG MATCHES THE METAR QNH, USING THE SAME
-- ROUNDING set_baro_ref() USES TO DRIVE THE KNOB
local function baro_matches(setting, qnh, unit)
    if unit == "InHg" then
        return math.floor((setting * 100) + 0.5) == qnh
    end
    return math.floor((setting * 33.8639) + 0.5) == qnh
end

-- CHECKLIST CHECK FOR BARO REFERENCE.
-- WITH A USABLE METAR BOTH ALTIMETERS MUST SIT ON THAT QNH.
-- WITHOUT ONE IT FALLS BACK TO THE OLD RULE, CP AND FO SIMPLY AGREE.
function FOPM_BaroCheck()
    local qnh, unit = FOPM_MetarQNH()
    if qnh == nil then
        return CM_QNH == FO_QNH
    end
    return baro_matches(CM_QNH, qnh, unit) and baro_matches(FO_QNH, qnh, unit)
end

-- VALUES ABOVE 1500 ARE INHG (2992), BELOW ARE HPA (1013), SAME RULE AS set_baro_ref()
function FOPM_BaroWord(qnh)
    if qnh > 1500 then
        return "ALTIMETER"
    end
    return "QNH"
end

-- RUNWAY SIDE LETTER TO ITS VOICE KEY
local rwy_side_voice = {L = "LEFT", R = "RIGHT", C = "CENTER"}

-- SPEAKS THE ANSWER OF A CHECKLIST ITEM AND RETURNS HOW LONG IT TAKES.
-- BARO REFERENCE SAYS QNH/ALTIMETER, SPELLS THE METAR QNH DIGIT BY DIGIT AND
-- THEN SAYS ITS STATE, THE SAME WAY set_baro_ref() DOES.
-- TAKEOFF RUNWAY SPELLS THE RUNWAY NUMBER, ITS SIDE IF IT HAS ONE AND THE STATE.
-- EVERY OTHER ITEM IS ONE PLAIN CLIP.
function FOPM_AnswerSay(entry)
    local state = entry.state
    if entry.item == "BARO_REFERENCE" then
        local qnh = FOPM_MetarQNH()
        if qnh then
            local keys = {FOPM_BaroWord(qnh)}
            local digits = string.format("%d", qnh)
            for i = 1, #digits do
                keys[#keys + 1] = "N"..digits:sub(i, i)
            end
            keys[#keys + 1] = state
            return FOPM_SayList(keys, -0.17)
        end
    elseif entry.item == "TAKEOFF_RUNWAY" then
        local number, side = string.match(tostring(FOPM_CONFIG_VARIABLE.TO_RWY), "(%d+)%s*([LRC]?)")
        if number then
            local keys = {}
            for i = 1, #number do
                keys[#keys + 1] = "N"..number:sub(i, i)
            end
            if rwy_side_voice[side] then
                keys[#keys + 1] = rwy_side_voice[side]
            end
            keys[#keys + 1] = state
            return FOPM_SayList(keys, -0.17)
        end
    end
    if state == "FLAPS" then
        FOPM_PlaySound(FOPM_Talk[FL_VOICE_SRCH])
        return FOPM_Duration(FLAP_POS, FL_VOICE_SRCH)
    end
    FOPM_PlaySound(FOPM_Talk[state])
    return FOPM_Duration(FO_voices_directory, state)
end

-- //////////////////////////////
-- ///////// CHECKLISTS /////////
-- //////////////////////////////

-- CHEKCLIST ENGINE
function fopm_checklist_engine()
    if FOPM_STEP_VARIABLE.STEP_CHECK == 0 then
        FOPM_STEP_VARIABLE.STEP_CHECK = 1
        FOPM_STEP_VARIABLE.CKLST_STEP = 1
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].AR_item then
                if FOPM_TL_APP_TYPE.AR_DEP then
                    local speech = FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].item
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FO_voices_directory, speech))
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].CAT_item then
                if FOPM_TL_APP_TYPE.CAT_II_III then
                    local speech = FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].item
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FO_voices_directory, speech))
                    FOPM_STEP_VARIABLE.STEP_CHECK = 2
                    response_CHECK = false
                else
                    FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                end
            elseif FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].step_desition then
                if not FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED then
                        FOPM_STEP_VARIABLE.DES_MADED = false
                    end
                    if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].item then
                        local speech = FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].item
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FO_voices_directory, speech))
                    end
                    if FOPM_TL_CHECKLIST.ACT_CL == "Taxi_checklist" then
                        if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "ENGINE_MODE_SELECTOR" then
                            if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                            end
                        elseif FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].int_item == "OETD CHECK" then
                            if FOPM_checklist.Taxi_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                            else
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                            end
                        end
                    elseif FOPM_TL_CHECKLIST.ACT_CL == "Lineup_checklist" then
                        if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "PACKS_AND_APU_BLEED" or FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "PACKS" then
                            if FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[1]() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                            elseif FOPM_checklist.Lineup_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[2]() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                            else
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 3
                            end
                        end
                    elseif FOPM_TL_CHECKLIST.ACT_CL == "Before_takeoff_checklist_BTL" then
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
                    elseif FOPM_TL_CHECKLIST.ACT_CL == "Approach_checklist" then
                        if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "ENGINE_MODE_SELECTOR" then
                            if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                            end
                        elseif FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "AUTOBRAKES" then
                            if FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[1]() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                            elseif FOPM_checklist.Approach_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check[2]() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                            end
                        end
                    elseif FOPM_TL_CHECKLIST.ACT_CL == "Landing_checklist" then
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
                    elseif FOPM_TL_CHECKLIST.ACT_CL == "After_landing_checklist" then
                        if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].item == "APU" then
                            if FOPM_checklist.After_landing_checklist[FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                            else
                                FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 2
                            end
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
                local speech = FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].item
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_STEP_VARIABLE.STEP_CHECK = 2
                response_CHECK = false
            end
        end
    elseif FOPM_STEP_VARIABLE.STEP_CHECK == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
            if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].check then
                if response_CHECK then
                    if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].check() then
                        if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                            if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential or
                               (not FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential and not speak_only_essencials) then
                                local speech = CONFIG_VOICE_SRCH
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FLAP_CONFIG, speech))
                            end
                        else
                            if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential or
                               (not FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential and not speak_only_essencials) then
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + FOPM_AnswerSay(FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP])
                            end
                        end
                        FOPM_STEP_VARIABLE.STEP_CHECK = 3
                        FOPM_STEP_VARIABLE.CKLST_STEP = FOPM_STEP_VARIABLE.CKLST_STEP + 1
                    else
                        response_CHECK = false
                    end
                end
            elseif FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].state then
                if response_CHECK then
                    if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].state == "FLAPS" then
                        if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential or
                           (not FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential and not speak_only_essencials) then
                            local speech = CONFIG_VOICE_SRCH
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FLAP_CONFIG, speech))
                        end
                    else
                        if FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential or
                           (not FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].essential and not speak_only_essencials) then
                            FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + FOPM_AnswerSay(FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP])
                        end
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
            if FOPM_STEP_VARIABLE.CKLST_STEP > #FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL] then
                FOPM_STEP_VARIABLE.STEP_CHECK = 0
                FOPM_STEP_VARIABLE.CKLST_STEP = 0
                FOPM_TL_CHECKLIST[FOPM_TL_CHECKLIST.ACT_CL] = true
                FOPM_TL_CHECKLIST.EXECUTE_CL = false
                NEED_SAVE = true
            else
                FOPM_STEP_VARIABLE.STEP_CHECK = 1
            end
        end
    end
end

-- BARO SETTING
-- DEBUGIN
local qnh_value = 1013
local qnh_target = 0
local qnh_step = 0
local qnh_unit = "hPa"
local qnh_speed = 0.05
local qnh_digits = ""
local qnh_digit_index = 1
local search_line = 0
-- SET BARO REF
function set_baro_ref()
        if qnh_step == 0 then
            qnh_target = qnh_value
            if qnh_value > 1500 then
                qnh_unit = "InHg"
            else
                qnh_unit = "hPa"
            end
            qnh_digits = string.format("%d", qnh_target)
            qnh_digit_index = 1    
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            qnh_step = 1
        end
        if TIME >= FOPM_DELAY_VARIABLE.DELAY then
            if qnh_step == 1 then
                if qnh_unit == "hPa" then
                    BARO_UNIT_FO = 1
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    qnh_step = 2
                elseif qnh_unit == "InHg" then
                    BARO_UNIT_FO = 0
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    qnh_step = 2
                end
                FOPM_PlaySound(FOPM_Talk[FOPM_BaroWord(qnh_target)])
            elseif qnh_step == 2 then
                if BARO_STD_FO == 1 then
                    command_once(FO_BARO_PUSH)
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    qnh_step = 3
                elseif BARO_STD_FO == 0 then
                    FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                    qnh_step = 3
                end
            elseif qnh_step == 3 then
                if qnh_unit == "InHg" then
                    if (math.floor(((FO_QNH*100)+0.5))) ~= qnh_target then
                        if (math.floor(((FO_QNH*100)+0.5))) < qnh_target then
                            BARO_ROTATE_FO = BARO_ROTATE_FO + 1
                            FOPM_DELAY_VARIABLE.DELAY = TIME + qnh_speed
                            return
                        elseif (math.floor(((FO_QNH*100)+0.5))) > qnh_target then
                            BARO_ROTATE_FO = BARO_ROTATE_FO - 1
                            FOPM_DELAY_VARIABLE.DELAY = TIME + qnh_speed
                            return
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        qnh_step = 4
                    end
                elseif qnh_unit == "hPa" then
                    if (math.floor(((FO_QNH*33.8639)+0.5))) ~= qnh_target then
                        if (math.floor(((FO_QNH*33.8639)+0.5))) < qnh_target then
                            BARO_ROTATE_FO = BARO_ROTATE_FO + 1
                            FOPM_DELAY_VARIABLE.DELAY = TIME + qnh_speed
                            return
                        elseif (math.floor(((FO_QNH*33.8639)+0.5))) > qnh_target then
                            BARO_ROTATE_FO = BARO_ROTATE_FO - 1
                            FOPM_DELAY_VARIABLE.DELAY = TIME + qnh_speed
                            return
                        end
                    else
                        qnh_step = 4
                    end
                end
            elseif qnh_step == 4 then
                if qnh_digit_index <= #qnh_digits then
                    local d = qnh_digits:sub(qnh_digit_index, qnh_digit_index)
                    local voice = "N"..d
    
                    FOPM_PlaySound(FOPM_Talk[voice])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + FOPM_Duration(FO_voices_directory, voice) - 0.17
                    qnh_digit_index = qnh_digit_index + 1
                else
                    qnh_step = 5
                end
            elseif qnh_step == 5 then
                if math.floor(IND_ALTITUDE) >= TRANSITION_ALT then
                    command_once(FO_BARO_PULL)
                end
                FOPM_PlaySound(FOPM_Talk["SET"])
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                qnh_step = 0
                FOPM_Procedures_Control.EXECUTE_BARO_SET = false
            end
        end
end

-- WEATHER DATA EXTRACTION
local function clean_mcdu_line(raw)
    if not raw then return "" end
    local s = tostring(raw)
    s = s:gsub("%z", " ")
    s = s:gsub("[^%w%s/%-%+%.]", " ")
    s = s:gsub("%s+", " ")
    s = s:gsub("^%s*(.-)%s*$", "%1")
    return s
end
local function join_mcdu_lines(lines)
    local parts = {}
    for i = 1, #lines do
        local l = clean_mcdu_line(lines[i])
        if l ~= "" then
            parts[#parts + 1] = l
        end
    end
    return table.concat(parts, " ")
end
local QNH_HPA_MIN,  QNH_HPA_MAX  = 650,  1200
local QNH_INHG_MIN, QNH_INHG_MAX = 2400, 3300
local function is_icao(token)
    return token:match("^%a%a%a%a$") ~= nil
end
local function is_timestamp(token)
    return token:match("^%d%d%d%d%d%dZ$") ~= nil
end
local function parse_pressure(token)
    local hpa = token:match("^Q(%d%d%d%d)$") or token:match("^Q(%d%d%d)$")
    if hpa then
        local v = tonumber(hpa)
        if v >= QNH_HPA_MIN and v <= QNH_HPA_MAX then
            return v, "hPa"
        end
    end
    local inhg = token:match("^A(%d%d%d%d)$")
    if inhg then
        local v = tonumber(inhg)
        if v >= QNH_INHG_MIN and v <= QNH_INHG_MAX then
            return v, "InHg"
        end
    end

    return nil
end
function extract_qnh_from_screen(text)
    if not text or text == "" then return nil end

    local tokens = {}
    for t in text:gmatch("%S+") do
        tokens[#tokens + 1] = t
    end
    local station = nil
    for i = 1, #tokens do
        if is_icao(tokens[i]) and tokens[i + 1] and is_timestamp(tokens[i + 1]) then
            station = tokens[i]
            break
        end
    end
    if not station then return nil end
    for i = 1, #tokens do
        if tokens[i] == "RMK" then break end
        local value, unit = parse_pressure(tokens[i])
        if value then
            return value, unit, station
        end
    end

    return nil
end
function read_mcdu_green_text()
    local lines = {
        MCDU2_SHORT_GLINE_2, MCDU2_SHORT_GLINE_3, MCDU2_SHORT_GLINE_4,
        MCDU2_SHORT_GLINE_5, MCDU2_SHORT_GLINE_6, MCDU2_SHORT_GLINE_7,
        MCDU2_SHORT_GLINE_8, MCDU2_SHORT_GLINE_9, MCDU2_SHORT_GLINE_10,
        MCDU2_SHORT_GLINE_11, MCDU2_SHORT_GLINE_12
    }
    return join_mcdu_lines(lines)
end
function read_qnh_from_mcdu(expected_icao)
    local text = read_mcdu_green_text()
    local value, unit, station = extract_qnh_from_screen(text)
    if not value then
        return nil, "NO_REPORT"
    end
    if expected_icao and station ~= expected_icao then
        logMsg("FO/PM: METAR en pantalla es de "..tostring(station)..
               ", se esperaba "..tostring(expected_icao))
        return nil, "WRONG_STATION"
    end
    return value, unit
end

-- WEATHER REQUEST
function weather_request()
    if TIME >= FOPM_DELAY_VARIABLE.DELAY then
        if FOPM_STEP_VARIABLE.STEP == 0 then -- INICIO
            if FOPM_CONFIG_VARIABLE.WX_READY then -- EVITA BUCLE O REPETICION INECESARIA
                FOPM_Procedures_Control.EXECUTE_WX_REQ = false
            else
                FOPM_STEP_VARIABLE.STEP = 1
            end
        elseif FOPM_STEP_VARIABLE.STEP == 1 then -- INICIO DE NAVEGACION
            command_once(MCDU_FO_KEY_Menu)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 2
        elseif FOPM_STEP_VARIABLE.STEP == 2 then
            command_once(MCDU_FO_KEY_L2)
            FOPM_STEP_VARIABLE.STEP = 3
        elseif FOPM_STEP_VARIABLE.STEP == 3 then -- COMPROBACION DEL SISTEMA ACTIVO
            if string.find(MCDU2_WTITLE, "ATSU DATALINK") then
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 4
            end
        elseif FOPM_STEP_VARIABLE.STEP == 4 then
            command_once(MCDU_FO_KEY_R1)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 5
        elseif FOPM_STEP_VARIABLE.STEP == 5 then
            command_once(MCDU_FO_KEY_R2)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 6
        elseif FOPM_STEP_VARIABLE.STEP == 6 then -- VERIFICACION/EXTRACCION DE AEROPUERTOS
            if string.sub(MCDU2_WLINE_1, -4) == "----" or string.sub(MCDU2_WLINE_2, -4) == "----" then -- DEP/ARR ARRP
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_Procedures_Control.EXECUTE_WX_REQ = false
                command_once(MCDU_FO_KEY_Fpln)
            elseif string.sub(MCDU2_WLINE_3, -4) == "----" then -- ALT_ARRP
                FOPM_CONFIG_VARIABLE.DEP_ARRP = string.sub(MCDU2_GLINE_1, -4)
                FOPM_CONFIG_VARIABLE.ARR_ARRP = string.sub(MCDU2_GLINE_2, -4)
                FOPM_CONFIG_VARIABLE.ALT_ARRP = "----"
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 7
            else
                FOPM_CONFIG_VARIABLE.DEP_ARRP = string.sub(MCDU2_GLINE_1, -4)
                FOPM_CONFIG_VARIABLE.ARR_ARRP = string.sub(MCDU2_GLINE_2, -4)
                FOPM_CONFIG_VARIABLE.ALT_ARRP = string.sub(MCDU2_GLINE_3, -4)
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 7
            end
        elseif FOPM_STEP_VARIABLE.STEP == 7 then -- VERIFICACION DE SISTEMA ACTIVO
            if string.find(MCDU2_BLINE_6, "METAR*") then
                command_once(MCDU_FO_KEY_R6)
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 8
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_Procedures_Control.EXECUTE_WX_REQ = false
                command_once(MCDU_FO_KEY_Fpln)
            end
        elseif FOPM_STEP_VARIABLE.STEP == 8 then -- VERIFICACION DE REQUEST ENVIADO
            if string.find(MCDU2_BLINE_6, "METAR*") then
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 9
            end
        elseif FOPM_STEP_VARIABLE.STEP == 9 then -- NAVEGACINO A MENSAJES RECIBIDOS
            command_once(MCDU_FO_KEY_L6)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 10
        elseif FOPM_STEP_VARIABLE.STEP == 10 then
            command_once(MCDU_FO_KEY_R6)
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed + 5
            FOPM_STEP_VARIABLE.STEP = 11
            search_line = 2
        elseif FOPM_STEP_VARIABLE.STEP == 11 then -- BUSQUEDA DEL METAR CORRECTO
            if search_line < 11 then
                if FOPM_TL_FLT_PHASE.PREFLIGHT or FOPM_TL_FLT_PHASE.PUSHBACK or FOPM_TL_FLT_PHASE.TAXI_OUT then
                    if string.find((_G["MCDU2_SHORT_WLINE_"..search_line]), "METAR "..FOPM_CONFIG_VARIABLE.DEP_ARRP) then
                        command_once(_G["MCDU_FO_KEY_L"..(search_line/2)])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        FOPM_STEP_VARIABLE.STEP = 12
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        search_line = search_line + 2
                        return
                    end
                else
                    if string.find((_G["MCDU2_SHORT_WLINE_"..search_line]), "METAR "..FOPM_CONFIG_VARIABLE.ARR_ARRP) then
                        command_once(_G["MCDU_FO_KEY_L"..(search_line/2)])
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        FOPM_STEP_VARIABLE.STEP = 12
                    else
                        FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                        search_line = search_line + 2
                        return
                    end
                end
            else
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_Procedures_Control.EXECUTE_WX_REQ = false
                command_once(MCDU_FO_KEY_Fpln)
            end
        elseif FOPM_STEP_VARIABLE.STEP == 12 then -- EXTRAE LOS DATOS
            local station
            if FOPM_TL_FLT_PHASE.PREFLIGHT or FOPM_TL_FLT_PHASE.PUSHBACK or FOPM_TL_FLT_PHASE.TAXI_OUT then
                station = FOPM_CONFIG_VARIABLE.DEP_ARRP
            else
                station = FOPM_CONFIG_VARIABLE.ARR_ARRP
            end
            local v, u = read_qnh_from_mcdu(station)
            if v == nil then -- SIN QNH USABLE, SE SALE SIN TOCAR EL ALTIMETRO
                logMsg("XXXXX   FO/PM WX: METAR sin QNH usable ("..tostring(u).."), peticion cancelada")
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 0
                FOPM_Procedures_Control.EXECUTE_WX_REQ = false
                command_once(MCDU_FO_KEY_Fpln)
            else
                qnh_value = v
                qnh_unit = u
                FOPM_METAR.QNH = v
                FOPM_METAR.UNIT = u
                FOPM_METAR.STATION = station
                FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
                FOPM_STEP_VARIABLE.STEP = 13
            end
        elseif FOPM_STEP_VARIABLE.STEP == 13 then -- AJUSTA EL ALTIMETRO
            FOPM_Procedures_Control.EXECUTE_BARO_SET = true
            FOPM_STEP_VARIABLE.STEP = 14
        elseif FOPM_STEP_VARIABLE.STEP == 14 then
            if not FOPM_Procedures_Control.EXECUTE_BARO_SET then
                FOPM_STEP_VARIABLE.STEP = 15
            end
        elseif FOPM_STEP_VARIABLE.STEP == 15 then
            FOPM_DELAY_VARIABLE.DELAY = TIME + fo_speed
            FOPM_STEP_VARIABLE.STEP = 0
            FOPM_Procedures_Control.EXECUTE_WX_REQ = false
            FOPM_CONFIG_VARIABLE.WX_READY = true
            command_once(MCDU_FO_KEY_Fpln)
        end
    end
end

---- //////////////////////////////
---- ///////// MAIN LOGIC /////////
---- //////////////////////////////

-- ACTUAL FLIGHT PHASE
function phase_check()
    if FOPM_TL_FLT_PHASE.PREFLIGHT then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Preflight"
        if FOPM_checklist.Before_start_checklist_BTL then
            if FOPM_TL_CHECKLIST.BS_CL_BTL then
                FOPM_TL_FLT_PHASE.PREFLIGHT = false
                FOPM_TL_FLT_PHASE.PUSHBACK = true
                FOPM_TL_COMPLETED_PROC.PARK_PROC = false
                NEED_SAVE = true
            end
        else
            if FOPM_TL_CHECKLIST.Before_start_checklist then
                FOPM_TL_FLT_PHASE.PREFLIGHT = false
                FOPM_TL_FLT_PHASE.PUSHBACK = true
                FOPM_TL_COMPLETED_PROC.PARK_PROC = false
                FOPM_TL_CHECKLIST.Parking_checklist = false
                FOPM_TL_CHECKLIST.Securing_checklist = false
                NEED_SAVE = true
            end
        end
    end
    if FOPM_TL_FLT_PHASE.PUSHBACK then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Pushback"
        if ENG_Mode == 2 then
            FOPM_TL_FLT_PHASE.ENG_START = true
            NEED_SAVE = true
        end
        if TAXILT_SW > 0 and FOPM_TL_COMPLETED_PROC.AS_PROC_DONE then
            FOPM_TL_FLT_PHASE.ENG_START = false
            FOPM_TL_FLT_PHASE.PUSHBACK = false
            FOPM_TL_FLT_PHASE.TAXI_OUT = true
            NEED_SAVE = true
        end
        if BEACON_STATE == 0 and not FOPM_TL_FLT_PHASE.ENG_START then
            FOPM_TL_FLT_PHASE.PUSHBACK = false
            FOPM_TL_FLT_PHASE.PREFLIGHT = true
            NEED_SAVE = true
        end
    end
    if FOPM_Procedures_Control.EXECUTE_ENRWY then
        FOPM_TL_FLT_PHASE.ON_RWY = true
        FOPM_TL_COMPLETED_PROC.EXIT_RWY_DONE = false
        NEED_SAVE = true
    end
    if FOPM_Procedures_Control.EXECUTE_EXRWY then
        FOPM_TL_FLT_PHASE.ON_RWY = false
        FOPM_TL_COMPLETED_PROC.ENT_RWY_DONE = false
        NEED_SAVE = true
    end
    if FOPM_TL_FLT_PHASE.TAXI_OUT then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Taxi Out"
        if THR_LEVER >= 2 then
            FOPM_TL_FLT_PHASE.TAKEOFF = true
            FOPM_TL_FLT_PHASE.TAXI_OUT = false
            FOPM_TL_COMPLETED_PROC.AS_PROC_DONE = false
            command_GUP = false
            command_GDN = false
            command_FLPS_1UP = false
            command_FLPS_1DN = false
            NEED_SAVE = true
        end
        if ENG_1_Master == 0 and ENG_2_Master == 0 and BEACON_STATE == 0 then
            FOPM_TL_FLT_PHASE.PARKING = true
            FOPM_TL_FLT_PHASE.TAXI_OUT = false
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.TAKEOFF then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Takeoff"
        if GNDAIR_SW == 0 then
            FOPM_TL_FLT_PHASE.ON_RWY = false
            NEED_SAVE = true
        end
        if ENG_1_REV ~= 0 or ENG_2_REV ~= 0 then
            FOPM_STEP_VARIABLE.STEP = 0
            FOPM_TL_FLT_PHASE.REJECTED = true
            FOPM_TL_FLT_PHASE.TAKEOFF = false
            FOPM_TL_CHECKLIST.BTO_CL_BTL = false
            FOPM_TL_CHECKLIST.Lineup_checklist = false
            FOPM_TL_CHECKLIST.Taxi_checklist = false
            FOPM_TL_CHECKLIST.BTO_CL = false
            FOPM_TL_COMPLETED_PROC.TAXI_PROC_DONE = false
            FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = false
            NEED_SAVE = true
        end
        if FOPM_checklist.After_takeoff_checklist then
            if THR_STATE == 1 and FOPM_TL_CHECKLIST.ATO_CL then
                FOPM_CONFIG_VARIABLE.TXT_PHASE = "Climb"
                FOPM_TL_FLT_PHASE.CLIMB = true
                FOPM_TL_APP_TYPE.AR_DEP = false
                FOPM_CONFIG_VARIABLE.RAINING = false
                FOPM_TL_FLT_PHASE.TAKEOFF = false
                FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = false
                FOPM_TL_COMPLETED_PROC.ACF_CLEAN = false
                FOPM_TL_COMPLETED_PROC.AL_PROC = false
                command_GUP = false
                command_GDN = false
                command_FLPS_1UP = false
                command_FLPS_1DN = false
                FOPM_CONFIG_VARIABLE.WX_READY = false
                NEED_SAVE = true
            end
        else
            if THR_STATE == 1 and FOPM_TL_COMPLETED_PROC.TO_PROC_DONE then
                FOPM_CONFIG_VARIABLE.TXT_PHASE = "Climb"
                FOPM_TL_FLT_PHASE.CLIMB = true
                FOPM_TL_APP_TYPE.AR_DEP = false
                FOPM_CONFIG_VARIABLE.RAINING = false
                FOPM_TL_FLT_PHASE.TAKEOFF = false
                FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = false
                FOPM_TL_COMPLETED_PROC.ACF_CLEAN = false
                FOPM_TL_COMPLETED_PROC.AL_PROC = false
                command_GUP = false
                command_GDN = false
                command_FLPS_1UP = false
                command_FLPS_1DN = false
                FOPM_CONFIG_VARIABLE.WX_READY = false
                NEED_SAVE = true
            end
        end
    end
    if FOPM_TL_FLT_PHASE.REJECTED then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Rejected"
        if ENG_1_REV == 0 and ENG_2_REV == 0 then
            FOPM_TL_FLT_PHASE.REJECTED = false
            FOPM_TL_FLT_PHASE.REJECTED_DES = true
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.CLIMB or FOPM_TL_FLT_PHASE.CRUISE or FOPM_TL_FLT_PHASE.DESCEND then
        if string.find(FMA_G_STATE, "CLB") then
            FOPM_CONFIG_VARIABLE.TXT_PHASE = "Climb"
            FOPM_TL_FLT_PHASE.CLIMB = true
            FOPM_TL_FLT_PHASE.CRUISE = false
            FOPM_TL_FLT_PHASE.DESCEND = false
            NEED_SAVE = true
        end
        if string.find(FMA_G_STATE, "CRZ") then
            FOPM_CONFIG_VARIABLE.TXT_PHASE = "Cruise"
            FOPM_TL_FLT_PHASE.CLIMB = false
            FOPM_TL_FLT_PHASE.CRUISE = true
            FOPM_TL_FLT_PHASE.DESCEND = false
            NEED_SAVE = true
        end
        if string.find(FMA_G_STATE, "DES") then
            FOPM_CONFIG_VARIABLE.TXT_PHASE = "Descend"
            FOPM_TL_FLT_PHASE.CLIMB = false
            FOPM_TL_FLT_PHASE.CRUISE = false
            FOPM_TL_FLT_PHASE.DESCEND = true
            NEED_SAVE = true
        end
        if FOPM_TL_CHECKLIST.Approach_checklist then
            FOPM_TL_FLT_PHASE.CLIMB = false
            FOPM_TL_FLT_PHASE.CRUISE = false
            FOPM_TL_FLT_PHASE.DESCEND = false
            FOPM_TL_FLT_PHASE.APPROACH = true
            FOPM_TL_COMPLETED_PROC.AP_DISCN_PROC = false
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.APPROACH then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Approach"
        if FOPM_TL_CHECKLIST.Landing_checklist then
            FOPM_TL_FLT_PHASE.APPROACH = false
            FOPM_TL_FLT_PHASE.FINAL_APP = true
            FOPM_TL_COMPLETED_PROC.GA_PROC = false
            FPMTR.CONT_APP = true
            FOPM_STEP_VARIABLE.STEP_AL = 0
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.FINAL_APP then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Final APP"
        if THR_LEVER == 3 then
            FOPM_TL_FLT_PHASE.FINAL_APP = false
            FOPM_TL_FLT_PHASE.GA = true
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = false
            FOPM_TL_COMPLETED_PROC.DES_BRIEFING = false
            FOPM_STEP_VARIABLE.STEP_AL = 0
            FOPM_CONFIG_VARIABLE.WX_READY = false
            NEED_SAVE = true
        end
        if ENG_1_REV > 0 or ENG_2_REV > 0 then
            FOPM_TL_FLT_PHASE.FINAL_APP = false
            FOPM_TL_FLT_PHASE.DECELERATION = true
            FOPM_TL_FLT_PHASE.ON_RWY = true
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE = false
            FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE = false
            FOPM_STEP_VARIABLE.STEP_AL = 0
            FOPM_CONFIG_VARIABLE.WX_READY = false
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.GA then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Go Arround"
        if THR_STATE == 1 then
            FOPM_TL_FLT_PHASE.GA = false
            FOPM_TL_FLT_PHASE.TAKEOFF = true
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.DECELERATION then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Decel"
        if ENG_1_REV == 0 and ENG_2_REV == 0 then
            FOPM_TL_FLT_PHASE.DECELERATION = false
            FOPM_CONFIG_VARIABLE.RAINING = false
            FOPM_TL_FLT_PHASE.TAXI_IN = true
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.TAXI_IN then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Taxi In"
        if CRONO > 180 and not FOPM_TL_COMPLETED_PROC.OETA_DONE and not FOPM_CONFIG_VARIABLE.MINUTE3 then
            local speech = "CRONO3"
            FOPM_PlaySound(FOPM_Talk[speech])
            FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
            FOPM_Procedures_Control.ONEENG_TAXI_ARR_AVAIL = true
            FOPM_CONFIG_VARIABLE.MINUTE3 = true
            NEED_SAVE = true
        end
        if PRKBRK_SW == 1 and ENG_1_Master == 0 and ENG_2_Master == 0 then
            FOPM_TL_FLT_PHASE.TAXI_IN = false
            FOPM_TL_FLT_PHASE.PARKING = true
            NEED_SAVE = true
        end
    end
    if FOPM_TL_FLT_PHASE.PARKING then
        FOPM_CONFIG_VARIABLE.TXT_PHASE = "Parking"
        if FOPM_TL_CHECKLIST.Parking_checklist then
            FOPM_CONFIG_VARIABLE.MINUTE3 = false
            FOPM_TL_FLT_PHASE.PARKING = false
            FOPM_TL_FLT_PHASE.PREFLIGHT = true
            FOPM_TL_COMPLETED_PROC.PF_DONE = false
            FOPM_TL_COMPLETED_PROC.TO_BRIEFING = false
            FOPM_TL_COMPLETED_PROC.FLTCTL_CHK = false
            FOPM_TL_APP_TYPE.ILS_APP = false
            FOPM_TL_APP_TYPE.MLS_APP = false
            FOPM_TL_APP_TYPE.RNAV_APP = false
            FOPM_TL_APP_TYPE.RNAVAR_APP = false
            FOPM_TL_APP_TYPE.VOR_APP = false
            FOPM_TL_APP_TYPE.NDB_APP = false
            FOPM_TL_APP_TYPE.LDA_APP = false
            FOPM_TL_APP_TYPE.FLS = false
            FOPM_TL_APP_TYPE.CAT_II_III = false
            NEED_SAVE = true
        end
    end
end

do_every_frame("phase_check()")

-- FO/PM MAIN LOGIC
function FO_main_logic()
    if FOPM_TL_FLT_PHASE.PREFLIGHT then
        if FOPM_Procedures_Control.EXECUTE_PCP then
            pre_cockpit_pre()
        end
    end
    if FOPM_TL_FLT_PHASE.ENG_START then
        if not FOPM_TL_COMPLETED_PROC.AS_PROC_DONE then
            if ENG_Mode == 1 then
                after_start_proc()
            end
        end
    end
    if FOPM_Procedures_Control.EXECUTE_OETD and
       not FOPM_Procedures_Control.EXECUTE_BTP and
       not FOPM_Procedures_Control.EXECUTE_TXP and
       not FOPM_Procedures_Control.EXECUTE_ENRWY and
       not FOPM_Procedures_Control.EXECUTE_EXRWY then
        one_engine_taxi_DEP()
    end
    if FOPM_TL_FLT_PHASE.TAXI_OUT then
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
        if FOPM_TL_CHECKLIST.BTO_CL_BTL and not FOPM_TL_COMPLETED_PROC.TO_PROC_DONE and (not FOPM_TL_FLT_PHASE.REJECTED or FOPM_TL_FLT_PHASE.REJECTED_DES) then
            take_off_proc()
        end
    else
        if FOPM_TL_CHECKLIST.Lineup_checklist and not FOPM_TL_COMPLETED_PROC.TO_PROC_DONE and (not FOPM_TL_FLT_PHASE.REJECTED or FOPM_TL_FLT_PHASE.REJECTED_DES) then
            take_off_proc()
        end
    end
    if FOPM_TL_FLT_PHASE.REJECTED then
        touch_down()
    end
    if GNDAIR_SW == 0 then
        if not FOPM_TL_FLT_PHASE.GA and not FOPM_Procedures_Control.EXECUTE_FLP then
            gear_command()
        end
        if not FOPM_Procedures_Control.EXECUTE_GEAR then
            flaps_commanded_change()
        end
    else
        if command_FLPS_1UP or command_FLPS_1DN then
            command_FLPS_1UP = false
            command_FLPS_1DN = false
        end
        if command_GUP or command_GDN then
            command_GUP = false
            command_GDN = false
        end
    end
    if FOPM_TL_FLT_PHASE.TAKEOFF then
        if THR_STATE == 1 and fo_autoperform then
            if not FOPM_TL_COMPLETED_PROC.ACF_CLEAN and not string.find(FMA_G_STATE, "SRS") then
                clean_up_auto()
            end
        end
    end
    if FOPM_TL_FLT_PHASE.CLIMB then
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
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_ALT = true
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL = false
                command_once(FO_BARO_PULL)
            end
        end
    end
    if FOPM_TL_FLT_PHASE.DESCEND then
        if fo_autoperform then
            if (not FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and IND_ALTITUDE < 14000) or FOPM_Procedures_Control.EXECUTE_10FT_DES then
                ten_thausand_feet_DES()
            end
        elseif FOPM_Procedures_Control.EXECUTE_10FT_DES then
            ten_thausand_feet_DES()
        end
    end
    if FOPM_TL_FLT_PHASE.DESCEND or FOPM_TL_FLT_PHASE.APPROACH then
        if not FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL then
            if TRANSITION_LVL >= math.floor(IND_ALTITUDE) then
                local speech = "TRNS_LVL"
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FOPM_Duration(FO_voices_directory, speech))
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_ALT = false
                FOPM_CONFIG_VARIABLE.PASSED_TRANS_LVL = true
                command_once(FO_BARO_PUSH)
            end
        end
    end
    if FOPM_TL_FLT_PHASE.FINAL_APP then
        ap_discn_behaviour()
        if FOPM_TL_APP_TYPE.CAT_II_III and AP1_ENGAGE == 1 and AP2_ENGAGE == 1 then
            autoland_fma_check()
        end
        if math.floor(RADIO_ALT) < 1000 then
            flight_parameters_check()
        end
    end
    if FOPM_TL_FLT_PHASE.GA then
        go_arround()
    end
    if FOPM_TL_FLT_PHASE.DECELERATION then
        touch_down()
    end
    if FOPM_TL_FLT_PHASE.TAXI_IN then
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
    if FOPM_TL_FLT_PHASE.PARKING then
        if not FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE then
            brake_temp_check()
        end
        if not FOPM_TL_COMPLETED_PROC.PARK_PROC and FOPM_TL_COMPLETED_PROC.BRKTEMP_CHK_DONE then
            parking_proc()
        end
    end
    if FOPM_Procedures_Control.EXECUTE_BARO_SET then
        set_baro_ref()
    end
    if FOPM_Procedures_Control.EXECUTE_WX_REQ then
        weather_request()
    end
end

do_every_frame("FO_main_logic()")

-- FO CHECKLIST LOGIC
function FO_checklist()
    if FOPM_TL_CHECKLIST.EXECUTE_CL then
        fopm_checklist_engine()
    end
end

do_every_frame("FO_checklist()")

-- /////////////////////////////////
-- ///////// IMGUI BUILDER /////////
-- /////////////////////////////////

-- SAVE CONFIGURATION FUNCTION
function config_save()
    local rute = SCRIPT_DIRECTORY .. "FO PM/FO Config.lua"
    local config = io.open(rute, "w")
    if config then
        config:write("--------------------------\n")
        config:write("---- FO CONFIGURATION ----\n")
        config:write("--------------------------\n\n")
        config:write('FOPM_plugin_version = "'..FOPM_plugin_version..'"\n')
        config:write("speak_only_essencials = " .. tostring(speak_only_essencials) .. "\n")
        config:write("fo_autoperform = " .. tostring(fo_autoperform) .. "\n")
        config:write("fo_wx_req = " .. tostring(fo_wx_req) .. "\n")
        config:write("fo_speed = ".. fo_speed.."\n")
        config:write('prcl_to_load = "'.. prcl_to_load..'"\n')
        config:write("fopm_show_checklist = "..tostring(fopm_show_checklist).."\n\n")
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

-- //////////////////////////////////
-- ///////// PAGE GEOMETRY //////////
-- //////////////////////////////////

local FOPM_PAGE_SIZE = {
    MAIN     = {w = 250, h = 125},
    MAIN_DC  = {w = 251, h = 179}, -- MAIN WHILE IT CARRIES THE EXTRA "Departure Change CKL" BUTTON
    BRIEFING = {w = 310, h = 313},
    SETTINGS = {w = 290, h = 251},
    PRCL_SEL = {w = 235, h = 142}
}

local FOPM_PAGE_MEASURED = {}
FOPM_AUTOSIZE = true
local FOPM_AUTOSIZE_OK = nil -- nil UNTIL THE imgui CALLS HAVE BEEN TRIED ONCE

local function FOPM_main_has_dc()
    if not (FOPM_TL_FLT_PHASE.PUSHBACK or FOPM_TL_FLT_PHASE.TAXI_OUT) then return false end
    if not FOPM_checklist.Departure_change_checklist then return false end
    return (not FOPM_TL_CHECKLIST.Departure_change_checklist) and (not FOPM_TL_CHECKLIST.EX_DC_CL)
end

local function FOPM_active_page()
    if WND_BRIEFING then return "BRIEFING" end
    if WND_SETTINGS then return "SETTINGS" end
    if WND_PRCL_SEL then return "PRCL_SEL" end
    if FOPM_main_has_dc() then return "MAIN_DC" end
    return "MAIN"
end

function FOPM_resize_to(to)
    if FO_INTERFACE == nil then return end
    local from = FOPM_active_page()
    if to == "MAIN" and FOPM_main_has_dc() then to = "MAIN_DC" end
    local a, b = FOPM_PAGE_SIZE[from], FOPM_PAGE_SIZE[to]
    if a == nil or b == nil or from == to then return end
    local dh
    if FOPM_PAGE_MEASURED[from] ~= nil and FOPM_PAGE_MEASURED[to] ~= nil then
        dh = FOPM_PAGE_MEASURED[to] - FOPM_PAGE_MEASURED[from]
    else
        dh = b.h - a.h
    end
    FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
    float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft-(b.w-a.w),FOPM_wtop,FOPM_wright,FOPM_wbottom-dh)
    FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
end

local function FOPM_measure_raw(wnd)
    local ww, wh = imgui.GetWindowSize()
    if type(wh) ~= "number" or wh <= 0 then return nil end
    local cy = imgui.GetCursorPosY()
    if type(cy) ~= "number" then return nil end
    local left, top, right, bottom = float_wnd_get_geometry(wnd)
    return cy * ((top - bottom) / wh)
end

function FOPM_MeasurePage(wnd)
    if not FOPM_AUTOSIZE or FOPM_AUTOSIZE_OK == false then return end
    local ok, h = pcall(FOPM_measure_raw, wnd)
    if not ok then
        FOPM_AUTOSIZE_OK = false
        logMsg("XXXXX   FO/PM UI: imgui measuring not available, page sizes fall back to the built in table")
        return
    end
    FOPM_AUTOSIZE_OK = true
    if type(h) == "number" and h > 40 and h < 2000 then
        FOPM_PAGE_MEASURED[FOPM_active_page()] = h
    end
end

local FOPM_RIGHT_ALIGN_OK = nil
local FOPM_RIGHT_MARGIN = 10

local function FOPM_right_align_raw(label)
    local ww = imgui.GetWindowSize()
    if type(ww) ~= "number" or ww <= 0 then return false end
    local bw = 20
    if type(imgui.CalcTextSize) == "function" then
        local tw = imgui.CalcTextSize(label)
        if type(tw) == "number" and tw > 0 then bw = tw + 10 end
    end
    local px = ww - bw - FOPM_RIGHT_MARGIN
    if px <= 0 then return false end
    imgui.SameLine(px)
    return true
end

function FOPM_SameLineRight(label)
    if FOPM_RIGHT_ALIGN_OK ~= false then
        local ok, placed = pcall(FOPM_right_align_raw, label)
        if ok then
            FOPM_RIGHT_ALIGN_OK = true
            if placed then return end
        else
            FOPM_RIGHT_ALIGN_OK = false
            logMsg("XXXXX   FO/PM UI: imgui right align not available, the X button keeps its fixed spacing")
        end
    end
    imgui.SameLine()
    imgui.TextUnformatted("     ")
    imgui.SameLine()
end

-- IMGUI BUILDER
function FO_imgui_builder(FO_INTERFACE, x, y)
    if WND_MAIN then -- MAIN WINDOW
    imgui.Spacing()
        if imgui.SmallButton("Settings") then
            FOPM_resize_to("SETTINGS")
            WND_SETTINGS = true
            WND_MAIN = false
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Briefing") then
            FOPM_resize_to("BRIEFING")
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BRIEFING = true
            WND_PRCL_SEL = false
        end
        FOPM_SameLineRight("X")
        if imgui.SmallButton("X") then
            response_CHECK = true
        end
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("FLT Phase: "..FOPM_CONFIG_VARIABLE.TXT_PHASE)
        imgui.SameLine()
        if RECOVERY_AVAIL then
            if imgui.SmallButton("RECOVERY") then
                dofile(SCRIPT_DIRECTORY .. "/FO PM/FO_Recovery.lua")
                if not FOPM_TL_FLT_PHASE.PREFLIGHT or not FOPM_TL_FLT_PHASE.PUSHBACK then
                    logging_flthr = true
                    logbook_mark = math.floor(simtime)
                end
                RECOVERY_AVAIL = false
            end
        end
        -- DEBUGING

        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        -- CHECKLIST
        if FOPM_TL_CHECKLIST.EXECUTE_CL then
            if fopm_show_checklist then
                if FOPM_STEP_VARIABLE.CKLST_STEP <= #FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL] then
                    imgui.TextUnformatted(FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].item_name.."... "..FOPM_checklist[FOPM_TL_CHECKLIST.ACT_CL][FOPM_STEP_VARIABLE.CKLST_STEP].item_answer)
                end
            else
                imgui.TextUnformatted("Executing Checklist")
            end
        else
            if FOPM_TL_FLT_PHASE.PREFLIGHT then
                if FOPM_checklist.Cockpit_preparation_checklist then
                    if not FOPM_TL_CHECKLIST.Cockpit_preparation_checklist and FOPM_TL_COMPLETED_PROC.PF_DONE then
                        if imgui.SmallButton("Cockpit Preparation CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Cockpit_preparation_checklist"
                        end
                        imgui.SameLine()
                    end
                end
                if FOPM_checklist.Before_start_checklist then
                    if FOPM_checklist.Cockpit_preparation_checklist then
                        if not FOPM_TL_CHECKLIST.Before_start_checklist and FOPM_TL_CHECKLIST.Cockpit_preparation_checklist then
                            if imgui.SmallButton("Before Start CKL") then
                                FOPM_TL_CHECKLIST.EXECUTE_CL = true
                                FOPM_TL_CHECKLIST.ACT_CL = "Before_start_checklist"
                            end
                            imgui.SameLine()
                        end
                    else
                        if not FOPM_TL_CHECKLIST.Before_start_checklist and FOPM_TL_COMPLETED_PROC.PF_DONE then
                            if imgui.SmallButton("Before Start CKL") then
                                FOPM_TL_CHECKLIST.EXECUTE_CL = true
                                FOPM_TL_CHECKLIST.ACT_CL = "Before_start_checklist"
                            end
                            imgui.SameLine()
                        end
                    end
                end
                if FOPM_checklist.Securing_checklist then
                    if not FOPM_TL_CHECKLIST.Securing_checklist and not FOPM_TL_CHECKLIST.EX_BS_CL then
                        if imgui.SmallButton("Securing CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Securing_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.PUSHBACK then
                if FOPM_checklist.After_start_checklist then
                    if not FOPM_TL_CHECKLIST.After_start_checklist and
                    FOPM_TL_COMPLETED_PROC.AS_PROC_DONE and
                    not FOPM_Procedures_Control.ONEENG_TAXI_DEP
                    then
                        if imgui.SmallButton("After Start CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "After_start_checklist"
                        end
                    end
                end
                if FOPM_checklist.Departure_change_checklist then
                    if not FOPM_TL_CHECKLIST.Departure_change_checklist then
                        if imgui.SmallButton("Departure Change CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Departure_change_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.TAXI_OUT then
                if FOPM_checklist.Taxi_checklist then
                    -- HIDDEN WHILE ONE ENGINE TAXI IS RUNNING, SO THE TWO CANNOT TALK OVER EACH OTHER
                    if not FOPM_TL_CHECKLIST.Taxi_checklist and FOPM_TL_COMPLETED_PROC.TAXI_PROC_DONE then
                        if imgui.SmallButton("Taxi CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Taxi_checklist"
                        end
                    end
                end
                if FOPM_checklist.Before_takeoff_checklist then
                    if not FOPM_TL_CHECKLIST.BTO_CL and FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE then
                        if imgui.SmallButton("Before Takeoff CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Before_takeoff_checklist"
                        end
                    end
                end
                if FOPM_checklist.Departure_change_checklist then
                    if not FOPM_TL_CHECKLIST.Departure_change_checklist then
                        if imgui.SmallButton("Departure Change CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Departure_change_checklist"
                        end
                    end
                end
                if FOPM_checklist.Lineup_checklist then
                    if not FOPM_TL_CHECKLIST.Lineup_checklist and FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE then
                        if imgui.SmallButton("Line Up CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Lineup_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.TAKEOFF then
                if FOPM_checklist.After_takeoff_checklist then
                    if FOPM_TL_COMPLETED_PROC.TO_PROC_DONE then
                        if imgui.SmallButton("After Takeoff CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "After_takeoff_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.CLIMB then
                if FOPM_checklist.Climb_checklist then
                    if not FOPM_TL_CHECKLIST.CLB_CL then
                        if imgui.SmallButton("Climb CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Climb_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.DESCEND or FOPM_TL_FLT_PHASE.CLIMB then
                if  FOPM_checklist.Approach_checklist then
                    if FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE then
                        if imgui.SmallButton("Approach CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Approach_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.APPROACH then
                if FOPM_checklist.Approach_checklist then
                    if not FOPM_TL_CHECKLIST.Landing_checklist then
                        if imgui.SmallButton("Landing CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Landing_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.TAXI_IN then
                if FOPM_checklist.After_landing_checklist then
                    if not FOPM_TL_CHECKLIST.After_landing_checklist and FOPM_TL_COMPLETED_PROC.AL_PROC then
                        if imgui.SmallButton("After Landing CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "After_landing_checklist"
                        end
                    end
                end
            end
            if FOPM_TL_FLT_PHASE.PARKING then
                if FOPM_checklist.Parking_checklist then
                    if FOPM_TL_COMPLETED_PROC.PARK_PROC and not FOPM_TL_CHECKLIST.Parking_checklist  then
                        if imgui.SmallButton("Parking CKL") then
                            FOPM_TL_CHECKLIST.EXECUTE_CL = true
                            FOPM_TL_CHECKLIST.ACT_CL = "Parking_checklist"
                        end
                    end
                end
            end
        end
        -- PROCEDURES
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        if FOPM_TL_FLT_PHASE.PREFLIGHT then
            if not FOPM_TL_COMPLETED_PROC.PF_DONE and not FOPM_Procedures_Control.EXECUTE_PCP then
                if imgui.SmallButton("Preliminary Cockpit Prep.") then
                    FOPM_Procedures_Control.EXECUTE_PCP = true
                end
            end
        end
        if FOPM_TL_FLT_PHASE.TAXI_OUT then
            if FOPM_procedure.Taxi_procedure then
                if not FOPM_TL_COMPLETED_PROC.TAXI_PROC_DONE and not FOPM_Procedures_Control.EXECUTE_TXP then
                    if imgui.SmallButton("Taxi Proc.") then
                        FOPM_Procedures_Control.EXECUTE_TXP = true
                    end
                    imgui.SameLine()
                end
            end
            if FOPM_checklist.Taxi_checklist then
                if FOPM_TL_CHECKLIST.Taxi_checklist then
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
            if not FOPM_Procedures_Control.EXECUTE_ENRWY and not FOPM_TL_FLT_PHASE.ON_RWY then
                if imgui.SmallButton("Entry RWY") then
                    FOPM_Procedures_Control.EXECUTE_ENRWY = true
                end
            end
            if not FOPM_Procedures_Control.EXECUTE_EXRWY and FOPM_TL_FLT_PHASE.ON_RWY then
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
        if FOPM_TL_FLT_PHASE.REJECTED_DES then
            if imgui.SmallButton("Taxi OUT") then
                FOPM_TL_FLT_PHASE.REJECTED_DES = false
                FOPM_TL_FLT_PHASE.TAXI_OUT = true
                FOPM_TL_COMPLETED_PROC.DECEL_CALLOUTS = false
                FOPM_TL_COMPLETED_PROC.BTO_PROC_DONE = false
                FOPM_TL_CHECKLIST.Lineup_checklist = false
                FOPM_TL_CHECKLIST.BTO_CL_BTL = false
            end
            imgui.SameLine()
            if imgui.SmallButton("Taxi IN") then
                FOPM_DELAY_VARIABLE.DELAY = TIME + 1
                FOPM_TL_FLT_PHASE.REJECTED_DES = false
                FOPM_TL_FLT_PHASE.TAXI_IN = true
            end
        end
        if FOPM_TL_FLT_PHASE.CLIMB then
            if not FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_CLB_DONE and not FOPM_Procedures_Control.EXECUTE_10FT_CLB then
                if imgui.SmallButton("Crossing 10.000ft") then
                    FOPM_Procedures_Control.EXECUTE_10FT_CLB = true
                end
            end
        end
        if FOPM_TL_FLT_PHASE.DESCEND then
            if not FOPM_TL_COMPLETED_PROC.TEN_THAUSAND_FEET_DES_DONE and not FOPM_Procedures_Control.EXECUTE_10FT_DES then
                if imgui.SmallButton("Crossing 10.000ft") then
                    FOPM_Procedures_Control.EXECUTE_10FT_DES = true
                end
            end
        end
        if FOPM_TL_FLT_PHASE.TAXI_IN then
            if not FOPM_Procedures_Control.EXECUTE_ENRWY and not FOPM_TL_FLT_PHASE.ON_RWY and not FOPM_Procedures_Control.EXECUTE_AL_PROC and not FOPM_TL_CHECKLIST.EX_AL_CL then
                if imgui.SmallButton("Entry RWY") then
                    FOPM_Procedures_Control.EXECUTE_ENRWY = true
                end
            end
            if not FOPM_Procedures_Control.EXECUTE_EXRWY and FOPM_TL_FLT_PHASE.ON_RWY and not FOPM_Procedures_Control.EXECUTE_AL_PROC and not FOPM_TL_CHECKLIST.EX_AL_CL then
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
            FOPM_resize_to("SETTINGS")
            WND_SETTINGS = true
            WND_MAIN = false
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Main") then
            FOPM_resize_to("MAIN")
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        -- DEBUGING

        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        -- ACF/ENG TYPES
        if FOPM_TL_FLT_PHASE.PREFLIGHT then
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
                    imgui.TextUnformatted("Aircraft Type: A321-272"..acf_neo_type)
                    imgui.TextUnformatted("Engine: PW 1130G-JM")
                elseif ENG_MODEL == 3 then
                    imgui.TextUnformatted("Aircraft Type: A321-253"..acf_neo_type)
                    imgui.TextUnformatted("Engine: CFM LEAP-1A33")
                end
            end
            imgui.Spacing()
            imgui.Separator()
            imgui.Spacing()
        end
        -- DEPARTURE BRIEFING
        if FOPM_TL_FLT_PHASE.PREFLIGHT or FOPM_TL_FLT_PHASE.PUSHBACK or FOPM_TL_FLT_PHASE.TAXI_OUT then
            imgui.TextUnformatted("Departure Briefing")
            imgui.Spacing()
            if ENG_MODEL == 0 then
                imgui.TextUnformatted("Time Since ENG SD: "..math.floor((TIME - FOPM_CONFIG_VARIABLE.IAE_SD_TIME)/60).." min")
            end
            imgui.TextUnformatted("FLIGHT: "..FOPM_CONFIG_VARIABLE.DEP_ARRP.." -> "..FOPM_CONFIG_VARIABLE.ARR_ARRP.." / "..FOPM_CONFIG_VARIABLE.ALT_ARRP)
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
            imgui.SameLine()
            imgui.TextUnformatted("Trim:")
            imgui.SameLine()
            if string.find(MCDU1_WTITLE, "TAKE OFF") then
                if string.find(MCDU1_BLINE_3, "([UPDN]+)") then
                    FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION = string.match(MCDU1_BLINE_3, "([UPDN]+)")
                    FOPM_CONFIG_VARIABLE.PT_TO_ANGLE = tonumber(string.match(MCDU1_BLINE_3, "/.-[UPDN]+(%d+%.%d+)"))
                end
            end
            if FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION == 0 then
                imgui.TextUnformatted(FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION.."."..FOPM_CONFIG_VARIABLE.PT_TO_ANGLE)
            else
                imgui.TextUnformatted(FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION..FOPM_CONFIG_VARIABLE.PT_TO_ANGLE)
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
            imgui.TextUnformatted("Baro Ref: "..qnh_unit.." "..qnh_value)
            imgui.TextUnformatted("Thrust:")
            imgui.SameLine()
            if THR_SETTING == -20 then
                imgui.TextUnformatted("TOGA")
            else
                imgui.TextUnformatted("Flex "..THR_SETTING)
            end
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
            imgui.TextUnformatted("Raining:")
            imgui.SameLine()
            if imgui.RadioButton("No", not FOPM_CONFIG_VARIABLE.RAINING) then
                FOPM_CONFIG_VARIABLE.RAINING = false
            end
            imgui.SameLine()
            if imgui.RadioButton("Yes", FOPM_CONFIG_VARIABLE.RAINING) then
                FOPM_CONFIG_VARIABLE.RAINING = true
            end
            local dep_change, change = imgui.Checkbox("RNP AR Departure", FOPM_TL_APP_TYPE.AR_DEP)
            if dep_change then
                FOPM_TL_APP_TYPE.AR_DEP = change
            end
            local dep_change, change = imgui.Checkbox("ONE Engine DEP", FOPM_Procedures_Control.ONEENG_TAXI_DEP)
            if dep_change then
                FOPM_Procedures_Control.ONEENG_TAXI_DEP = change
            end
            if not FOPM_TL_COMPLETED_PROC.TO_BRIEFING then
                if imgui.SmallButton("CONFIRM") then
                    local bindex = math.random(4)
                    FOPM_PlaySound(BRIEFING_CONF[bindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(BRIEF_CONF, bindex))
                    FOPM_TL_COMPLETED_PROC.TO_BRIEFING = true
                    FOPM_resize_to("MAIN")
                    WND_BRIEFING = false
                    WND_MAIN = true
                    NEED_SAVE = true
                end
            else
                if imgui.SmallButton("DEP CHANGE") then
                    local bindex = math.random(4)
                    FOPM_PlaySound(BRIEFING_CONF[bindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(BRIEF_CONF, bindex))
                    FOPM_TL_CHECKLIST.Departure_change_checklist = false
                    FOPM_resize_to("MAIN")
                    WND_BRIEFING = false
                    WND_MAIN = true
                    NEED_SAVE = true
                end
            end
            if fo_wx_req then
                imgui.SameLine()
                if not FOPM_Procedures_Control.EXECUTE_WX_REQ then
                    if imgui.SmallButton("WX REQUEST") then
                        FOPM_CONFIG_VARIABLE.WX_READY = false
                        FOPM_Procedures_Control.EXECUTE_WX_REQ = true
                    end
                end
            else
                imgui.TextUnformatted("Set Baro Ref:")
                imgui.SameLine()
                _, qnh_value = imgui.InputInt("", qnh_value)
                if (qnh_value >= 785 and qnh_value <= 1100) or (qnh_value >= 2200 and qnh_value <= 3248) then
                    if not FOPM_Procedures_Control.EXECUTE_BARO_SET then
                        if imgui.SmallButton("SET") then
                            if qnh_value > 1500 then
                                FOPM_METAR.UNIT = "InHg"
                            else
                                FOPM_METAR.UNIT = "hPa"
                            end
                            FOPM_METAR.QNH = qnh_value
                            FOPM_METAR.STATION = nil
                            FOPM_Procedures_Control.EXECUTE_BARO_SET = true
                            FOPM_Procedures_Control.EXECUTE_BARO_SET = true
                        end
                    end
                end
            end
        end
        -- ARRIVAL BRIEFING
        if FOPM_TL_FLT_PHASE.CLIMB or FOPM_TL_FLT_PHASE.CRUISE or FOPM_TL_FLT_PHASE.DESCEND or FOPM_TL_FLT_PHASE.APPROACH then
            imgui.TextUnformatted("Arrival Briefing")
            if imgui.RadioButton("ILS/MLS", FOPM_TL_APP_TYPE.ILS_APP or FOPM_TL_APP_TYPE.MLS_APP) then
                FOPM_TL_APP_TYPE.ILS_APP = true
                FOPM_TL_APP_TYPE.MLS_APP = true
                FOPM_TL_APP_TYPE.RNAV_APP = false
                FOPM_TL_APP_TYPE.RNAVAR_APP = false
                FOPM_TL_APP_TYPE.VOR_APP = false
                FOPM_TL_APP_TYPE.NDB_APP = false
                FOPM_TL_APP_TYPE.LDA_APP = false
                FOPM_TL_APP_TYPE.FLS = false
            end
            imgui.SameLine()
            if imgui.RadioButton("CAT II/III", FOPM_TL_APP_TYPE.CAT_II_III) then
                FOPM_TL_APP_TYPE.ILS_APP = true
                FOPM_TL_APP_TYPE.MLS_APP = true
                FOPM_TL_APP_TYPE.CAT_II_III = true
                FOPM_TL_APP_TYPE.RNAV_APP = false
                FOPM_TL_APP_TYPE.RNAVAR_APP = false
                FOPM_TL_APP_TYPE.VOR_APP = false
                FOPM_TL_APP_TYPE.NDB_APP = false
                FOPM_TL_APP_TYPE.LDA_APP = false
                FOPM_TL_APP_TYPE.FLS = false
            end
            if imgui.RadioButton("RNAV", FOPM_TL_APP_TYPE.RNAV_APP) then
                FOPM_TL_APP_TYPE.ILS_APP = false
                FOPM_TL_APP_TYPE.MLS_APP = false
                FOPM_TL_APP_TYPE.CAT_II_III = false
                FOPM_TL_APP_TYPE.RNAV_APP = true
                FOPM_TL_APP_TYPE.RNAVAR_APP = false
                FOPM_TL_APP_TYPE.VOR_APP = false
                FOPM_TL_APP_TYPE.NDB_APP = false
                FOPM_TL_APP_TYPE.LDA_APP = false
            end
            imgui.SameLine()
            if imgui.RadioButton("FLS", FOPM_TL_APP_TYPE.FLS) then
                FOPM_TL_APP_TYPE.ILS_APP = false
                FOPM_TL_APP_TYPE.MLS_APP = false
                FOPM_TL_APP_TYPE.CAT_II_III = false
                FOPM_TL_APP_TYPE.RNAVAR_APP = false
                FOPM_TL_APP_TYPE.FLS = true
            end
            if imgui.RadioButton("RNP AR", FOPM_TL_APP_TYPE.RNAVAR_APP) then
                FOPM_TL_APP_TYPE.ILS_APP = false
                FOPM_TL_APP_TYPE.MLS_APP = false
                FOPM_TL_APP_TYPE.CAT_II_III = false
                FOPM_TL_APP_TYPE.RNAV_APP = false
                FOPM_TL_APP_TYPE.RNAVAR_APP = true
                FOPM_TL_APP_TYPE.VOR_APP = false
                FOPM_TL_APP_TYPE.NDB_APP = false
                FOPM_TL_APP_TYPE.LDA_APP = false
                FOPM_TL_APP_TYPE.FLS = false
            end
            if imgui.RadioButton("VOR/NDB", FOPM_TL_APP_TYPE.VOR_APP or FOPM_TL_APP_TYPE.NDB_APP) then
                FOPM_TL_APP_TYPE.ILS_APP = false
                FOPM_TL_APP_TYPE.MLS_APP = false
                FOPM_TL_APP_TYPE.CAT_II_III = false
                FOPM_TL_APP_TYPE.RNAV_APP = false
                FOPM_TL_APP_TYPE.RNAVAR_APP = false
                FOPM_TL_APP_TYPE.VOR_APP = true
                FOPM_TL_APP_TYPE.NDB_APP = true
                FOPM_TL_APP_TYPE.LDA_APP = false
            end
            imgui.SameLine()
            if imgui.RadioButton("LDA", FOPM_TL_APP_TYPE.LDA_APP) then
                FOPM_TL_APP_TYPE.ILS_APP = false
                FOPM_TL_APP_TYPE.MLS_APP = false
                FOPM_TL_APP_TYPE.CAT_II_III = false
                FOPM_TL_APP_TYPE.RNAV_APP = false
                FOPM_TL_APP_TYPE.RNAVAR_APP = false
                FOPM_TL_APP_TYPE.VOR_APP = false
                FOPM_TL_APP_TYPE.NDB_APP = false
                FOPM_TL_APP_TYPE.LDA_APP = true
                FOPM_TL_APP_TYPE.FLS = false
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
                    FOPM_PlaySound(BRIEFING_CONF[bindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(BRIEF_CONF, bindex))
                    FOPM_TL_COMPLETED_PROC.DES_BRIEFING = true
                    FOPM_resize_to("MAIN")
                    WND_BRIEFING = false
                    WND_MAIN = true
                    NEED_SAVE = true
                end
            else
                if imgui.SmallButton("ARR/APP CHANGE") then
                    local bindex = math.random(4)
                    FOPM_PlaySound(BRIEFING_CONF[bindex])
                    FOPM_DELAY_VARIABLE.DELAY = TIME + (FOPM_Duration(BRIEF_CONF, bindex))
                    FOPM_TL_COMPLETED_PROC.DES_BRIEFING = true
                    FOPM_resize_to("MAIN")
                    WND_BRIEFING = false
                    WND_MAIN = true
                    NEED_SAVE = true
                end
            end
            if fo_wx_req then
                imgui.SameLine()
                if not FOPM_Procedures_Control.EXECUTE_WX_REQ then
                    if imgui.SmallButton("WX REQUEST") then
                        FOPM_CONFIG_VARIABLE.WX_READY = false
                        FOPM_Procedures_Control.EXECUTE_WX_REQ = true
                    end
                end
            else
                imgui.TextUnformatted("Set Baro Ref:")
                imgui.SameLine()
                _, qnh_value = imgui.InputInt("", qnh_value)
                if (qnh_value >= 785 and qnh_value <= 1100) or (qnh_value >= 2200 and qnh_value <= 3248) then
                    if not FOPM_Procedures_Control.EXECUTE_BARO_SET then
                        if imgui.SmallButton("SET") then
                            if qnh_value > 1500 then
                                FOPM_METAR.UNIT = "InHg"
                            else
                                FOPM_METAR.UNIT = "hPa"
                            end
                            FOPM_METAR.QNH     = qnh_value
                            FOPM_METAR.STATION = nil
                            FOPM_Procedures_Control.EXECUTE_BARO_SET = true
                        end
                    end
                end
            end
        end
    end
    if WND_SETTINGS then -- SETTINGS WINDOW
        imgui.Spacing()
        if imgui.SmallButton("Main") then
            FOPM_resize_to("MAIN")
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Briefing") then
            FOPM_resize_to("BRIEFING")
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BRIEFING = true
            WND_PRCL_SEL = false
        end
        -- DEBUGING

        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("Total Flt Hours: "..(math.floor(((fopm_logbook_total_flthr/60)/60)*10)/10).." hr")
        imgui.TextUnformatted("Total Flights: "..math.floor(fopm_logbook_total_flts).." Flts")
        imgui.TextUnformatted("FOPM Version: "..FOPM_plugin_version)
        imgui.TextUnformatted("Voice Pack: "..FOPM_voicepack_name)
        if #FOPM_SOUND_MISSING > 0 then
            imgui.TextUnformatted("Voice Pack: "..#FOPM_SOUND_MISSING.." missing files, see the log")
        end
        imgui.TextUnformatted("Procedures: "..FOPM_proc_config_name)
        imgui.TextUnformatted("Checklists: "..FOPM_cklst_config_name)
        if FOPM_proc_config_name ~= prcl_to_load then
            imgui.TextUnformatted("Reload the script to see changes")
        end
        if imgui.SmallButton("Change PROC/CKLT Pack") then
            FOPM_resize_to("PRCL_SEL")
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
        local setting_change, change = imgui.Checkbox("FO Auto Perform", fo_autoperform)
        if setting_change then
            fo_autoperform = change
            config_save()
        end
        local WX_setting, WX_set_chg = imgui.Checkbox("FO Request Weather (Hoppie Required)", fo_wx_req)
        if WX_setting then
            fo_wx_req = WX_set_chg
            config_save()
        end
        local CL_setting, SCL_set_chg = imgui.Checkbox("Interface Checklist", fopm_show_checklist)
        if CL_setting then
            fopm_show_checklist = SCL_set_chg
            config_save()
        end
        imgui.TextUnformatted("Speak Only Essentials: ")
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
            FOPM_resize_to("SETTINGS")
            WND_SETTINGS = true
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Main") then
            FOPM_resize_to("MAIN")
            WND_SETTINGS = false
            WND_MAIN = true
            WND_BRIEFING = false
            WND_PRCL_SEL = false
        end
        imgui.SameLine()
        if imgui.SmallButton("Briefing") then
            FOPM_resize_to("BRIEFING")
            WND_SETTINGS = false
            WND_MAIN = false
            WND_BRIEFING = true
            WND_PRCL_SEL = false
        end
        -- DEBUGING

        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        imgui.TextUnformatted("Packs Available")
        if imgui.RadioButton("Airbus", prcl_to_load == "Airbus") then
            prcl_to_load = "Airbus"
        end
        if imgui.RadioButton("Avianca 2022", prcl_to_load == "Avianca_2022") then
            prcl_to_load = "Avianca_2022"
        end
        if FOPM_proc_config_name ~= prcl_to_load then
            imgui.TextUnformatted("Reload the script to see changes")
            if imgui.SmallButton("SAVE") then
                FOPM_resize_to("SETTINGS")
                config_save()
                WND_SETTINGS = true
                WND_PRCL_SEL = false
            end
        end
    end
    FOPM_MeasurePage(FO_INTERFACE)
end

-- FLOAT WINDOWS MASTER

-- GEOMETRY SANITY CHECK
-- A GEOMETRY READ BACK FROM A WINDOW THAT WAS ALREADY GONE, OR SAVED ON A
-- MONITOR THAT IS NO LONGER THERE, COMES OUT AS nil OR AS AN ABSURD
-- COORDINATE. APPLYING IT WOULD PUT THE INTERFACE WHERE NOBODY CAN REACH IT.
local function FOPM_geometry_valid()
    if type(FOPM_wleft) ~= "number" or type(FOPM_wtop) ~= "number" or
       type(FOPM_wright) ~= "number" or type(FOPM_wbottom) ~= "number" then
        return false
    end
    if FOPM_wleft < 0 or FOPM_wleft > 10000 or
       FOPM_wtop < 0 or FOPM_wtop > 10000 or
       FOPM_wright < 0 or FOPM_wright > 10000 or
       FOPM_wbottom < 0 or FOPM_wbottom > 10000 then
        return false
    end
    return true
end

-- READS THE GEOMETRY AND WRITES IT TO THE CONFIG.
-- THE PAGE IS COLLAPSED BACK TO MAIN FIRST BECAUSE THE PAGE FLAGS ARE NOT
-- PERSISTED AND EVERY FRESH LOAD STARTS ON MAIN, SO SAVING A SETTINGS SIZED
-- RECT WOULD REOPEN THE MAIN PAGE AT THE WRONG SIZE ON THE NEXT SESSION.
local function FOPM_save_geometry()
    FOPM_resize_to("MAIN")
    WND_SETTINGS = false
    WND_MAIN = true
    WND_BRIEFING = false
    WND_PRCL_SEL = false
    FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom = float_wnd_get_geometry(FO_INTERFACE)
    if not FOPM_geometry_valid() then
        FOPM_wleft = nil
        FOPM_wtop = nil
        FOPM_wright = nil
        FOPM_wbottom = nil
    end
    config_save()
end

-- SINGLE CLOSE PATH
-- THE HANDLE ITSELF IS THE OPEN/CLOSED STATE, THERE IS NOTHING ELSE TO KEEP IN
-- STEP. RUNS ONCE: WHOEVER GETS THERE FIRST CLEARS THE HANDLE AND THE SECOND
-- CALLER FINDS nil AND DOES NOTHING.
local function FOPM_interface_cleanup()
    if FO_INTERFACE == nil then return end
    FOPM_save_geometry()
    FO_INTERFACE = nil
end

-- CALLED BY FlyWithLua WHEN THE WINDOW GOES AWAY, WHICH IS HOW CLOSING WITH THE
-- NATIVE X ENDS UP IN THE SAME PLACE AS THE COMMAND AND THE MACRO. THE WINDOW
-- IS STILL ALIVE INSIDE THIS CALLBACK, SO ITS GEOMETRY CAN STILL BE READ, AND
-- IT MUST NOT BE DESTROYED HERE.
function on_interface_closed(wnd)
    FOPM_interface_cleanup()
end

function show_interface()
    if FO_INTERFACE then return end
    FO_INTERFACE = float_wnd_create(250, 125, 1, true)
    float_wnd_set_title(FO_INTERFACE, "FO/PM")
    float_wnd_set_imgui_builder(FO_INTERFACE, "FO_imgui_builder")
    if type(float_wnd_set_onclose) == "function" then
        float_wnd_set_onclose(FO_INTERFACE, "on_interface_closed")
    else
        logMsg("XXXXX   FO/PM UI: float_wnd_set_onclose not available in this FlyWithLua build, closing with the X will not save the position")
    end
    if FOPM_geometry_valid() then
        float_wnd_set_geometry(FO_INTERFACE,FOPM_wleft,FOPM_wtop,FOPM_wright,FOPM_wbottom)
    end
end

function hide_interface()
    if FO_INTERFACE == nil then return end
    local wnd = FO_INTERFACE
    FOPM_interface_cleanup() -- SAVES WHILE THE WINDOW IS STILL ALIVE, THEN CLEARS THE HANDLE
    float_wnd_destroy(wnd)   -- IF THIS FIRES on_interface_closed IT FINDS nil AND DOES NOTHING
end

function toggle_interface()
    if FO_INTERFACE then
        hide_interface()
    else
        show_interface()
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
