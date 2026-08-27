----------------------------------
---- Voices Load System V 2.0 ----
----------------------------------

------------------------------------
------ FMOD AUDIO ENGINE V 1.1 -----
------------------------------------
-- ALL THE SOUND LOADING AND PLAYBACK OF THE FO/PM GOES THROUGH THIS SECTION.
-- REQUIRES FlyWithLua NG+ 2.8.9 OR NEWER (X-Plane 12 Fmod SDK).

-- OUTPUT BUS: "interior" (COCKPIT), "ui", "com1" (RADIO) OR "master"
FOPM_AUDIO_BUS = "interior"

-- FO/PM VOICE VOLUME, 0.0 = SILENT, 1.0 = NORMAL, UP TO 5.0
FOPM_AUDIO_VOLUME = 1.0

-- FMOD BUS DISPATCH
local FOPM_PLAY_ON_BUS = {
    interior = play_sound_on_interior_bus,
    ui       = play_sound_on_ui_bus,
    com1     = play_sound_on_com1_bus,
    master   = play_sound_on_master_bus
}

local FOPM_STOP_ON_BUS = {
    interior = stop_sound_on_interior_bus,
    ui       = stop_sound_on_ui_bus,
    com1     = stop_sound_on_com1_bus,
    master   = stop_sound_on_master_bus
}

-- FlyWithLua CHANNEL GROUP DATAREFS, THEY START MUTED / AT ZERO VOLUME
-- SO THE BUS MUST BE OPENED BEFORE ANYTHING CAN BE HEARD
local FOPM_BUS_GROUP = {
    interior = "FlyWithLua_InteriorChannelGroup",
    ui       = "FlyWithLua_UIChannelGroup",
    com1     = "FlyWithLua_Com1ChannelGroup",
    master   = "FlyWithLua_MasterChannelGroup"
}

-- ENGINE AVAILABILITY, CHECKED ONCE AT LOAD
FOPM_AUDIO_READY = type(load_fmod_sound) == "function" and FOPM_PLAY_ON_BUS[FOPM_AUDIO_BUS] ~= nil

if not FOPM_AUDIO_READY then
    logMsg("XXXXX   FO/PM Audio ERROR: Fmod not available on bus '"..tostring(FOPM_AUDIO_BUS).."', update FlyWithLua to NG+ 2.8.9 or newer")
end

-- OPENS THE BUS: SETS THE VOLUME AND CLEARS THE MUTE FLAG
function FOPM_ApplyAudioLevel()
    local group = FOPM_BUS_GROUP[FOPM_AUDIO_BUS]
    if group == nil then return end
    if XPLMFindDataRef(group.."/Volume") ~= nil then
        set(group.."/Volume", FOPM_AUDIO_VOLUME)
    else
        logMsg("XXXXX   FO/PM Audio ERROR: dataref "..group.."/Volume not found")
    end
    if XPLMFindDataRef(group.."/Mute") ~= nil then
        set(group.."/Mute", 0)
    end
    logMsg("XXXXX   FO/PM Audio: bus '"..FOPM_AUDIO_BUS.."' open at volume "..tostring(FOPM_AUDIO_VOLUME))
end

if FOPM_AUDIO_READY then
    FOPM_ApplyAudioLevel()
end

-- SINGLE LOAD ENTRY POINT
function FOPM_LoadSound(path)
    if not FOPM_AUDIO_READY then return nil end
    local handle = load_fmod_sound(path)
    if handle == nil then
        logMsg("XXXXX   FO/PM Audio ERROR: can't load "..tostring(path))
    end
    return handle
end

-- SINGLE PLAYBACK ENTRY POINT
function FOPM_PlaySound(handle)
    if handle == nil then return end
    local play = FOPM_PLAY_ON_BUS[FOPM_AUDIO_BUS]
    if play == nil then return end
    play(handle)
end

-- SINGLE STOP ENTRY POINT, STOPS EVERYTHING PLAYING ON THE FO/PM BUS
function FOPM_StopSound()
    local stop = FOPM_STOP_ON_BUS[FOPM_AUDIO_BUS]
    if stop == nil then return end
    stop()
end

-- BULK VOICE PACK LOADER
local function FOPM_LoadVoicePack(directory, target, pack)
    for name, data in pairs(directory) do
        target[name] = FOPM_LoadSound(SCRIPT_DIRECTORY.."FO PM/Voices/"..pack.."/"..data.code..".wav")
    end
end

-- VOICE SEARCH DIRECTION
FOPM_Talk = {}

BRAKE_WARNINGS = {}

BRIEFING_CONF = {}

READY = {}

READY_FOR_TO = {}

-- VOICES AVAILABLE CONFIG
FO_voice_config = {
    [1] = "Active"
}

-- VOICES DIRECTORY
FO_voices_directory = {
-- MUST CUMON --
    OFF = {code = "OFF", del = 0},
    ON = {code = "ON", del = 0},
    NORMAL = {code = "NORMAL", del = 0},
    CHECK = {code = "CHECK", del = 0},
-- NUMBERS --
    N0 = {code = "0", del = 0},
    N1 = {code = "1", del = 0},
    N2 = {code = "2", del =0},
    N3 = {code = "3", del = 0},
    N4 = {code = "4", del =0},
    N5 = {code = "5", del = 0},
    N6 = {code = "6", del = 0},
    N7 = {code = "7", del = 0},
    N8 = {code = "8", del = 0},
    N9 = {code = "9", del = 0},
-- SECTION 1 --
    RETRACT_AND_DISARM = {code = "RETRACT & DISARM", del = 0},
    ARM = {code = "ARM", del = 0},
    UP = {code = "UP", del = 0},
    DOWN = {code = "DOWN", del = 0},
-- SECTION 2 --
    FULL_UP = {code = "FULL UP", del = 0},
    FULL_DOWN = {code = "FULL DOWN", del = 0},
    NEUTRAL = {code = "NEUTRAL", del = 0},
    FULL_LEFT = {code = "FULL LEFT", del =0},
    FULL_RIGHT = {code = "FULL RIGHT", del = 0},
    SET = {code = "SET", del = 0},
    TA_RA = {code = "TARA", del = 0},
    IGNITION = {code = "IGNITION", del = 0},
    AVAIL = {code = "AVAIL", del = 0},
    LOW = {code = "LOW", del = 0},
    MEDIUM = {code = "MEDIUM", del = 0},
    MAX = {code = "MAX", del = 0},
-- SECTION 3 --
    ENGINE_MASTERS = {code = "ENGINEMST", del = 0},
    ENGINE_MODE_SELECTOR = {code = "ENGINEMODE", del = 0},
    WEATHER_RADAR = {code = "WXTX", del = 0},
    LANDING_GEAR = {code = "LNDGR", del = 0},
    WIPERS = {code = "WIPERS", del = 0},
    BATTERIES = {code = "BATT", del = 0},
    EXTERNAL_POWER = {code = "EXTPWR", del = 0},
    SYSTEMS_CHECK = {code = "SYSCHECK", del = 0},
    OXYGEN = {code = "OXY", del = 0},
    HYDRAULICS = {code = "HYD", del = 0},
    OIL_QUANTITY = {code = "OILQTY", del = 0},
    FLAPS = {code = "FLAPS", del = 0},
    SPEED_BRAKE = {code = "SPDBRK", del = 0},
    PARKING_BRAKE = {code = "PRKBRK", del = 0},
-- SECTION 4 --
    BRAKE_ACCUMULATOR = {code = "BRKACCU", del = 0},
    ALTERNATE_BRAKES = {code = "ALTNBRK", del = 0},
    GROUND_SPOILERS = {code = "GNDSPOILERS", del = 0},
    RUDDER_TRIM = {code = "RUDDERTRIM", del = 0},
    PITCHTRM = {code = "PITCHTRIM", del = 0},
    FLIGHT_CONTROLS_CHECK = {code = "FLTCTLCHECK", del = 0},
    ELEVATOR = {code = "ELEV", del = 0},
    AILERONS = {code = "AILERONS", del = 0},
    RDR = {code = "RUDDER", del = 0},
    PWS = {code = "PWS", del = 0},
    BRAKE_TEMP = {code = "BRKTEMP", del = 0},
-- SECTION 5 --
    BRAKE_FAN = {code = "BRKFAN", del = 0},
    EXTERIOR_LIGHTS = {code = "EXTLIGHTS", del = 0},
    TCAS = {code = "TCAS", del = 0},
    PACKS = {code = "PACKS", del = 0},
    STABLE = {code = "STABLE", del = 0},
    TRHUST_SET = {code = "THRSET", del = 0},
    N100 = {code = "100", del = 0},
    V1 = {code = "V1", del = 0},
    ROTATE = {code = "ROTATE", del = 0},
    POSITIVE_RATE = {code = "POSITIVECLIMB", del = 0},
    GEAR_UP = {code = "GEARUP", del = 0},
    GEAR_DOWN = {code = "GEARDN", del = 0},
    GEAR_3GREENS = {code = "3GREENS", del = 0},
    APU_MASTER = {code = "APUMASTER", del = 0},
    STARTING_APU = {code = "STARTINGAPU", del = 0},
    SPEED_CHECK = {code = "SPDCHECK", del = 0},
    TERRAIN = {code = "TERRAIN", del = 0},
-- SECTION 6 --
    SEAT_BELTS = {code = "SEATBELTS", del = 0},
    LS = {code = "LS", del = 0},
    GO_ARROUND = {code = "GOARROUND", del = 0},
    TOGA = {code = "TOGA", del = 0},
    SPOILERS = {code = "SPOILERS", del = 0},
    REVERSE_GREEN = {code = "REVERSEGREEN", del = 0},
    DECEL = {code = "DECEL", del = 0},
    N70_KNOTS = {code = "70", del = 0},
    TRNS_ALT = {code = "TRANS ALT", del = 0},
    TRNS_LVL = {code = "TRANS LVL", del = 0},
    FLIGHT_DIRECTORS = {code = "FD", del = 0},
-- SECTION 7 --
    LANDING_LIGHTS = {code = "LNDLIGHTS", del = 0},
    TAXI_LIGHT = {code = "TAXILIGHT", del = 0},
    APU_BLEED = {code = "APUBLEED", del = 0},
    FUEL_PUMPS = {code = "FUELPUMPS", del = 0},
    ENGINE1 = {code = "ENGINE1", del = 0},
    ENGINE2 = {code = "ENGINE2", del = 0},
    YELLOW_HYDRAULIC_PUMP = {code = "YHYDPUMP", del = 0},
    STARTING_NUMBER_2 = {code = "START2", del = 0},
    CHECK_TIME = {code = "CHECKTIME", del = 0},
    CROSS_BLEED = {code = "CROSSBLEED", del = 0},
    AUTOBRAKES = {code = "AUTOBRK", del = 0},
    ENGINE_2_SHUTDOWN = {code = "ENG2SD", del = 0},
    ECAM_RCLL = {code = "ECAMRCLL", del = 0},
    TEN_THAUSAND_FEET = {code = "10000 FEET", del = 0},
-- SPECIAL PROCEDURES (AR-CAT II/III)
    NAVAIDS_DESELECTION = {code = "NAVAIDS", del = 0},
    GPS_NAV_MODE = {code = "GPSNAVMODE", del = 0},
    BOTH_NAV = {code = "BOTHNAV", del = 0},
    ON_ON = {code = "ON_ON", del = 0},
    CRONO3 = {code = "3MINUTES", del = 0},
-- CHEKCLIST ANSWERS --
    COMPLETED = {code = "COMPLT", del = 0},
    REMOVED = {code = "REMOVED", del = 0},
    ON_AUTO = {code = "ONAUTO", del = 0},
    NAV = {code = "NAV", del = 0},
    CLOSE = {code = "CLOSE", del = 0},
    IDLE = {code = "IDLE", del = 0},
    CONFIRM = {code = "CONFIRM", del = 0},
    TAKEOFF_NO_BLUE = {code = "TONOBLUE", del = 0},
    ADVISED = {code = "ADVISED", del = 0},
    MANAGE_SPEED = {code = "MNGSPD", del = 0},
    SELECTED_SPEED = {code = "SELECSPD", del = 0},
    RETRACTED = {code = "RETRACTED", del = 0},
    DISARMED = {code = "DISARMED", del = 0},
    AUTO = {code = "AUTO", del = 0},
    DESELECTED = {code = "DESELECTED", del = 0},

-- FLIGHT PARAMETERS CALLOUTS
    SPEED = {code = "SPEED", del = 0},
    SINK_RATE = {code = "SINK_RATE", del = 0},
    BANK = {code = "BANK", del = 0},
    PITCH = {code = "PITCH", del = 0},
    LOC = {code = "LOC", del = 0},
    GLIDE = {code = "GLIDE", del = 0},
    CROSS_TRACK = {code = "XTRK", del = 0},
    LAT_DEV = {code = "LAT_DEV", del = 0},
    V_DEV = {code = "V_DEV", del = 0},
    GA_UNSTABLE = {code = "GA_UNSTABLE", del = 0},

-- AUTOLAND CALLOUTS
    LAND = {code = "LAND", del = 0},
    FLARE = {code = "FLARE", del = 0},
    ROLL_OUT = {code = "ROLLOUT", del = 0},
---------------
-- CHECKLIST --
---------------

-- CHECKLIST 1--
    BEFORE_START_CHECKLIST = {code = "CKL1", del = 0},
    EFB_PREPARATION = {code = "CKL2", del = 0},
    AIRCRAFT_PBN_CAPABILITY = {code = "CKL3", del = 0},
    COCKPIT_PREPARATION = {code = "CKL4", del = 0},
    GEAR_PINS_AND_COVERS = {code = "CKL5", del = 0},
    SIGNS = {code = "CKL6", del = 0},
    ADIRS = {code = "CKL7", del = 0},
    FUEL_QUANTITY = {code = "CKL8", del = 0},
    BARO_REFERENCE = {code = "CKL9", del = 0},
    DOWN_TO_THE_LINE = {code = "CKL10", del = 0},
-- CHECLIST 2 --
    BEFORE_START_CHECKLIST_BELOW_THE_LINE = {code = "CKL11", del = 0},
    EFB = {code = "CKL12", del = 0},
    ATC = {code = "CKL13", del = 0},
    WINDOWS_AND_DOORS = {code = "CKL14", del = 0},
    BEACON = {code = "CKL15", del = 0},
    THRUST_LEVERS = {code = "CKL16", del = 0},
    CHECKLIST_COMPLETED = {code = "CKL18", del = 0},
    AFTER_START_CHECKLIST = {code = "CKL19", del = 0},
    ANTI_ICE = {code = "CKL20", del = 0},
-- CHECKLIST 3 --
    ECAM_STATUS = {code = "CKL21", del = 0},
    BEFORE_TAKEOFF_CHECKLIST = {code = "CKL22", del = 0},
    FLIGHT_CONTROLS = {code = "CKL23", del = 0},
    FLY_INSTRUMENTS = {code = "CKL24", del = 0},
    BRIEFING = {code = "CKL25", del = 0},
    V1_VR_V2_FLEX_TEMP = {code = "CKL26", del = 0},
    ECAM_MEMO = {code = "CKL27", del = 0},
    TAKEOFF_RUNWAY = {code = "CKL28", del = 0},
    NAV_ON_FMA = {code = "CKL29", del = 0},
    CABIN_CREW = {code = "CKL30", del = 0},
-- CHECKLIST 4 --
    PACKS_AND_APU_BLEED = {code = "CKL31", del = 0},
    AFTER_TAKEOFF_CHECKLIST = {code = "CKL32", del = 0},
    CLIMB_CHECKLIST = {code = "CKL34", del = 0},
    APPROACH_CHECKLIST = {code = "CKL35", del = 0},
    MINIMUMS = {code = "CKL36", del = 0},
    LANDING_CHECKLIST = {code = "CKL37", del = 0},
    AUTO_TRHUST = {code = "CKL38", del = 0},
    AFTER_LANDING_CHECKLIST = {code = "CKL40", del = 0},
    APU = {code = "CKL48", del = 0},
-- CHECKLIST 5 --
    PARKING_CHECKLIST = {code = "CKL41", del = 0},
    ENGINES = {code = "CKL42", del = 0},
    SECURING_CHECKLIST = {code = "CKL43", del = 0},
    EMERGENCY_EXIT_LIGHTS = {code = "CKL44", del = 0},
    NO_PORTABLE_SIGNS = {code = "CKL45", del = 0},
    APU_AND_BATTERY = {code = "CKL46", del = 0},
    BEFORE_TAKEOFF_CHECKLIST_BELOW_THE_LINE = {code = "CKL47", del = 0},
    COCKPIT_PREPARATION_CHECKLIST = {code = "CKL49", del = 0},
    RADIONAV_POSITION = {code = "CKL50", del = 0},
-- CHECKLIST 6 --
    TAKEOFF_SPEEDS_AND_THRUST = {code = "CKL51", del = 0},
    FLAPS_SETTING = {code = "CKL52", del = 0},
    RADAR_AND_PRED_WS = {code = "CKL53", del = 0},
    DEPARTURE_CHANGE_CHECKLIST = {code = "CKL54", del = 0},
    RUNWAY_AND_SID = {code = "CKL55", del = 0},
    FCU_ALTITUDE = {code = "CKL56", del = 0},
    PARKING_BRAKE_OR_CHOCKS = {code = "CKL57", del = 0},
    WING_LIGHTS = {code = "CKL58", del = 0},
    TAXI_CHECKLIST = {code = "CKL59", del = 0},
    LINEUP_CHECKLIST = {code = "CKL60", del = 0},
}

-- FLAP CONFIG DIRECTORY
FLAP_CONFIG = {
    CP1 = {code = "CONF 1+F", del = 0},
    CP2 = {code = "CONF 2", del = 0},
    CP3= {code = "CONF 3", del = 0},
}
-- FLAP POSITION DIRECTORY
FLAP_POS = {
    P0 = {code = "FLAPS0", del = 0},
    P1 = {code = "FLAPS1", del = 0},
    P2 = {code = "FLAPS2", del = 0},
    P3 = {code = "FLAPS3", del = 0},
    FULL = {code = "FLAPSFULL", del = 0},
}
-- BRKAE TEMP WARNING
BRAKE_WARN = {
    [1] = {code = "BW1", del = 0},
    [2] = {code = "BW2", del = 0},
    [3] = {code = "BW3", del = 0},
}
-- POST BRIEFING
BRIEF_CONF = {
    [1] = {code = "BRFCMP1", del = 0},
    [2] = {code = "BRFCMP2", del = 0},
    [3] = {code = "BRFCMP3", del = 0},
    [4] = {code = "BRFCMP4", del = 0},
}
-- READY SPEECH
RDY = {
    [1] = {code = "READY1", del = 0},
    [2] = {code = "READY2", del = 0},
    [3] = {code = "READY3", del = 0},
    [4] = {code = "READY4", del = 0},
    [5] = {code = "READY5", del = 0},
}
-- READY FOR T/O
RDY_TO_DIR = {
    [1] = {code = "RDYTO1", del = 0},
    [2] = {code = "RDYTO2", del = 0},
    [3] = {code = "RDYTO3", del = 0},
}

-- LOAD SYSTEM
for _, pack in ipairs(FO_voice_config) do
    FOPM_LoadVoicePack(FO_voices_directory, FOPM_Talk,      pack)
    FOPM_LoadVoicePack(FLAP_CONFIG,         FOPM_Talk,      pack)
    FOPM_LoadVoicePack(FLAP_POS,            FOPM_Talk,      pack)
    FOPM_LoadVoicePack(BRAKE_WARN,          BRAKE_WARNINGS, pack)
    FOPM_LoadVoicePack(BRIEF_CONF,          BRIEFING_CONF,  pack)
    FOPM_LoadVoicePack(RDY,                 READY,          pack)
    FOPM_LoadVoicePack(RDY_TO_DIR,          READY_FOR_TO,   pack)
end
