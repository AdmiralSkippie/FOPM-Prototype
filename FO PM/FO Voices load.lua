---------------------------
---- Voices Load System----
---------------------------

-- vOICE SEARCH DIRECTION
FOPM_Talk = {
    Male = {},
    Female = {}
}

BRAKE_WARNINGS = {
    Male = {},
    Female = {}
}

BRIEFING_CONF = {
    Male = {},
    Female = {}
}

READY = {
    Male = {},
    Female = {}
}

READY_FOR_TO = {
    Male = {},
    Female = {}
}

-- VOICES AVAILABLE CONFIG
FO_voice_config = {
    [1] = "Male",
    [2] = "Female"
}

-- VOICES DIRECTORY
FO_voices_directory = {
    OFF = {code = "OFF", del = {
                            Male = 0.382,
                            Female = 0.574}},
    ON = {code = "ON", del = {
                            Male = 0.413,
                            Female = 0.619}},
    NORMAL = {code = "NORMAL", del = {
                            Male = 0.615,
                            Female = 0.801}},
    CHECK = {code = "CHECK", del = {
                            Male = 0.639,
                            Female = 0.643}},
-- NUMBERS --
    N0 = {code = "0", del = {
                        Male = 0.499,
                        Female = 0.595}},
    N1 = {code = "1", del = {
                        Male = 0.450,
                        Female = 0.592}},
    N2 = {code = "2", del ={
                        Male = 0.403,
                        Female = 0.577}},
    N3 = {code = "3", del = {
                        Male = 0.454,
                        Female = 0.593}},
    N4 = {code = "4", del ={
                        Male = 0.404,
                        Female = 0.648}},
    N5 = {code = "5", del = {
                        Male = 0.408,
                        Female = 0.676}},
    N6 = {code = "6", del = {
                        Male = 0.403,
                        Female = 0.727}},
    N7 = {code = "7", del = {
                        Male = 0.497,
                        Female = 0.606}},
    N8 = {code = "8", del = {
                        Male = 0.440,
                        Female = 0.484}},
    N9 = {code = "9", del = {
                        Male = 0.445,
                        Female = 0.818}},
-- SECTION 1 --
    FULL = {code = "FULL", del = {
                        Male = 0.454}},
    RETRACT_AND_DISARM = {code = "RETRACT & DISARM", del = {
                        Male = 1.528,
                        Female = 1.137}},
    ARM = {code = "ARM", del = {
                        Male = 0.393,
                        Female = 0.597}},
    UP = {code = "UP", del = {
                        Male = 0.396,
                        Female = 0.489}},
    DOWN = {code = "DOWN", del = {
                        Male = 0.591,
                        Female = 0.696}},
-- SECTION 2 --
    FULL_UP = {code = "FULL UP", del = {
                        Male = 0.669,
                        Female = 0.832}},
    FULL_DOWN = {code = "FULL DOWN", del = {
                        Male = 0.566,
                        Female = 0.978}},
    NEUTRAL = {code = "NEUTRAL", del = {
                        Male = 0.422,
                        Female = 0.853}},
    FULL_LEFT = {code = "FULL LEFT", del ={
                        Male = 0.836,
                        Female = 0.771}},
    FULL_RIGHT = {code = "FULL RIGHT", del = {
                        Male = 0.852,
                        Female = 0.881}},
    SET = {code = "SET", del = {
                        Male = 0.671,
                        Female = 0.715}},
    TA_RA = {code = "TARA", del = {
                        Male = 1.592,
                        Female = 1.081}},
    IGNITION = {code = "IGNITION", del = {
                        Male = 0.605,
                        Female = 0.755}},
    N1_2 = {code = "1&2", del = {
                        Male = 0.827,
                        Female = 0.674}},
    PUSH = {code = "PUSH", del = {
                        Male = 0.602,
                        Female = 0.606}},
    AVAIL = {code = "AVAIL", del = {
                        Male = 0.724,
                        Female = 0.799}},
    LOW = {code = "LOW", del = {
                        Male = 0.385,
                        Female = 0.566}},
    MEDIUM = {code = "MEDIUM", del = {
                        Male = 0.509,
                        Female = 0.704}},
    MAX = {code = "MAX", del = {
                        Male = 0.514,
                        Female = 0.843}},
-- SECTION 3 --
    ENGINE_MASTERS = {code = "ENGINEMST", del = {
                        Male = 1.509,
                        Female = 1.074}},
    ENGINE_MODE_SELECTOR = {code = "ENGINEMODE", del = {
                        Male = 1.685,
                        Female = 1.358}},
    WEATHER_RADAR = {code = "WXTX", del = {
                        Male = 1.009,
                        Female = 1.030}},
    LANDING_GEAR = {code = "LNDGR", del = {
                        Male = 0.846,
                        Female = 0.962}},
    WIPERS = {code = "WIPERS", del = {
                        Male = 0.668,
                        Female = 0.747}},
    BATTERIES = {code = "BATT", del = {
                        Male = 0.679,
                        Female = 0.710}},
    EXTERNAL_POWER = {code = "EXTPWR", del = {
                        Male = 1.236,
                        Female = 1.083}},
    RECALL = {code = "RECALL", del = {
                        Male = 0.841,
                        Female = 0.716}},
    SYSTEMS_CHECK = {code = "SYSCHECK", del = {
                        Male = 1.044,
                        Female = 1.101}},
    OXYGEN = {code = "OXY", del = {
                        Male = 0.690,
                        Female = 0.768}},
    HYDRAULICS = {code = "HYD", del = {
                        Male = 0.686,
                        Female = 1.073}},
    OIL_QUANTITY = {code = "OILQTY", del = {
                        Male = 0.965,
                        Female = 1.149}},
    FLAPS = {code = "FLAPS", del = {
                        Male = 0.602,
                        Female = 0.668}},
    SPEED_BRAKE = {code = "SPDBRK", del = {
                        Male = 1.063,
                        Female = 0.903}},
    PARKING_BRAKE = {code = "PRKBRK", del = {
                        Male = 1.013,
                        Female = 0.799}},
-- SECTION 4 --
    BRAKE_ACCUMULATOR = {code = "BRKACCU", del = {
                        Male = 1.186,
                        Female = 1.043}},
    ALTERNATE_BRAKES = {code = "ALTNBRK", del = {
                        Male = 0.982,
                        Female = 0.992}},
    GROUND_SPOILERS = {code = "GNDSPOILERS", del = {
                        Male = 1.052,
                        Female = 1.016}},
    RUDDER_TRIM = {code = "RUDDERTRIM", del = {
                        Male = 0.809,
                        Female = 0.846}},
    PITCHTRM = {code = "PITCHTRIM", del = {
                        Male = 1.128,
                        Female = 0.773}},
    FLIGHT_CONTROLS_CHECK = {code = "FLTCTLCHECK", del = {
                        Male = 1.117,
                        Female = 1.235}},
    ELEVATOR = {code = "ELEV", del = {
                        Male = 0.962,
                        Female = 0.788}},
    AILERONS = {code = "AILERONS", del = {
                        Male = 0.690,
                        Female = 0.903}},
    RDR = {code = "RUDDER", del = {
                        Male = 0.502,
                        Female = 0.693}},
    PWS = {code = "PWS", del = {
                        Male = 0.825,
                        Female = 1.024}},
    BRAKE_TEMP = {code = "BRKTEMP", del = {
                        Male = 0.768,
                        Female = 0.852}},
-- SECTION 5 --
    BRAKE_FAN = {code = "BRKFAN", del = {
                        Male = 0.778,
                        Female = 0.843}},
    EXTERIOR_LIGHTS = {code = "EXTLIGHTS", del = {
                        Male = 1.540,
                        Female = 1.373}},
    TCAS = {code = "TCAS", del = {
                        Male = 0.738,
                        Female = 0.709}},
    PACKS = {code = "PACKS", del = {
                        Male = 0.480,
                        Female = 0.674}},
    STABLE = {code = "STABLE", del = {
                        Male = 0.838,
                        Female = 0.864}}, 
    TRHUST_SET = {code = "THRSET", del = {
                        Male = 1.147,
                        Female = 0.782}},
    N100 = {code = "100", del = {
                        Male = 0.663,
                        Female = 0.836}},
    V1 = {code = "V1", del = {
                        Male = 0.493,
                        Female = 0.944}},
    ROTATE = {code = "ROTATE", del = {
                        Male = 0.517,
                        Female = 0.730}},
    POSITIVE_RATE = {code = "POSITIVECLIMB", del = {
                        Male = 1.321,
                        Female = 1.015}},
    GEAR_UP = {code = "GEARUP", del = {
                        Male = 0.555,
                        Female = 0.714}},
    GEAR_DOWN = {code = "GEARDN", del = {
                        Male = 0.696,
                        Female = 0.944}},
    GEAR_3GREENS = {code = "3GREENS", del = {
                        Male = 0.849,
                        Female = 1}},
    APU_MASTER = {code = "APUMASTER", del = {
                        Male = 0.921,
                        Female = 1.031}},
    STARTING_APU = {code = "STARTINGAPU", del = {
                        Male = 1.540,
                        Female = 1.205}},
    SPEED_CHECK = {code = "SPDCHECK", del = {
                        Male = 1.136,
                        Female = 0.884}},
    TERRAIN = {code = "TERRAIN", del = {
                        Male = 0.825,
                        Female = 0.725}},
-- SECTION 6 --
    SEAT_BELTS = {code = "SEATBELTS", del = {
                        Male = 1.089,
                        Female = 0.932}},
    LS = {code = "LS", del = {
                        Male = 0.708,
                        Female = 0.731}},
    GO_ARROUND = {code = "GOARROUND", del = {
                        Male = 0.751,
                        Female = 0.962}},
    TOGA = {code = "TOGA", del = {
                        Male = 0.645,
                        Female = 0.653}},
    SPOILERS = {code = "SPOILERS", del = {
                        Male = 1.076,
                        Female = 0.989}},
    REVERSE_GREEN = {code = "REVERSEGREEN", del = {
                        Male = 0.753,
                        Female = 1.209}},
    DECEL = {code = "DECEL", del = {
                        Male = 0.834,
                        Female = 0.922}},
    N60_KNOTS = {code = "60", del = {
                        Male = 0.712,
                        Female = 1.116}},
    TRNS_ALT = {code = "TRANS ALT", del = {
                        Male = 1.101,
                        Female = 1.223}},
    TRNS_LVL = {code = "TRANS LVL", del = {
                        Male = 0.863,
                        Female = 1.076}},
    FLIGHT_DIRECTORS = {code = "FD", del = {
                        Male = 1.028,
                        Female = 1.254}},
-- SECTION 7 --
    LANDING_LIGHTS = {code = "LNDLIGHTS", del = {
                        Male = 0.936,
                        Female = 0.949}},
    TAXI_LIGHT = {code = "TAXILIGHT", del = {
                        Male = 0.978,
                        Female = 1.062}},
    APU_BLEED = {code = "APUBLEED", del = {
                        Male = 1.001,
                        Female = 1.066}},
    FUEL_PUMPS = {code = "FUELPUMPS", del = {
                        Male = 0.738,
                        Female = 0.949}},
    ENGINE1 = {code = "ENGINE1", del = {
                        Male = 0.805,
                        Female = 0.855}},
    ENGINE2 = {code = "ENGINE2", del = {
                        Male = 0.741,
                        Female = 0.884}},
    YELLOW_HYDRAULIC_PUMP = {code = "YHYDPUMP", del = {
                        Male = 1.170,
                        Female = 1.702}},
    STARTING_NUMBER_2 = {code = "START2", del = {
                        Male = 1.186,
                        Female = 1.242}},
    CHECK_TIME = {code = "CHECKTIME", del = {
                        Male = 0.749,
                        Female = 0.834}},
    CROSS_BLEED = {code = "CROSSBLEED", del = {
                        Male = 0.827,
                        Female = 0.826}},
    AUTOBRAKES = {code = "AUTOBRK", del = {
                        Male = 0.840,
                        Female = 0.915}},
    ENGINE_2_SHUTDOWN = {code = "ENG2SD", del = {
                        Male = 1.114,
                        Female = 1.314}},
    ECAM_RCLL = {code = "ECAMRCLL", del = {
                        Male = 0.866,
                        Female = 1.101}},
    TEN_THAUSAND_FEET = {code = "10000 FEET", del = {
                        Male = 1.006,
                        Female = 0.966}},
-- SPECIAL PROCEDURES (AR-CAT II/III)
    NAVAIDS_DESELECTION = {code = "NAVAIDS", del = {
                        Male = 1.236,
                        Female = 1.402}},
    GPS_NAV_MODE = {code = "GPSNAVMODE", del = {
                        Male = 1.072,
                        Female = 1.3}},
    BOTH_NAV = {code = "BOTHNAV", del = {
                        Male = 0.739,
                        Female = 0.945}},
    ON_ON = {code = "ON_ON", del = {
                        Male = 0.770,
                        Female = 1.478}},
    CRONO3 = {code = "3MINUTES", del = {
                        Male = 0.573,
                        Female = 1.287}},

-- CHEKCLIST ANSWERS --
    COMPLETED = {code = "COMPLT", del = {
                        Male = 0.757,
                        Female = 0.884}},
    REMOVED = {code = "REMOVED", del = {
                        Male = 0.669,
                        Female = 0.693}},
    ON_AUTO = {code = "ONAUTO", del = {
                        Male = 1.323,
                        Female = 1.291}},
    NAV = {code = "NAV", del = {
                        Male = 0.584,
                        Female = 0.569}},
    CLOSE = {code = "CLOSE", del = {
                        Male = 0.447,
                        Female = 0.681}},
    IDLE = {code = "IDLE", del = {
                        Male = 0.479,
                        Female = 0.741}},
    CONFIRM = {code = "CONFIRM", del = {
                        Male = 0.791,
                        Female = 0.733}},
    TAKEOFF_NO_BLUE = {code = "TONOBLUE", del = {
                        Male = 1.098,
                        Female = 1.172}},
    ADVISED = {code = "ADVISED", del = {
                        Male = 0.697,
                        Female = 0.911}},
    MANAGE_SPEED = {code = "MNGSPD", del = {
                        Male = 1.035,
                        Female = 1.081}},
    SELECTED_SPEED = {code = "SELECSPD", del = {
                        Male = 1.277,
                        Female = 1.152}},
    RETRACTED = {code = "RETRACTED", del = {
                        Male = 0.643,
                        Female = 0.774}},
    DISARMED = {code = "DISARMED", del = {
                        Male = 0.727,
                        Female = 0.785}},
    AUTO = {code = "AUTO", del = {
                        Male = 0.416,
                        Female = 0.646}},

---------------
-- CHECKLIST --
---------------

-- CHECKLIST 1--
    BEFORE_START_CHECKLIST = {code = "CKL1", del = {
                        Male = 1.318,
                        Female = 1.544}},
    EFB_PREPARATION = {code = "CKL2", del = {
                        Male = 1.581,
                        Female = 1.352}},
    AIRCRAFT_PBN_CAPABILITY = {code = "CKL3", del = {
                        Male = 1.940,
                        Female = 1.821}},
    COCKPIT_PREPARATION = {code = "CKL4", del = {
                        Male = 1.409,
                        Female = 1.331}},
    GEAR_PINS_AND_COVERS = {code = "CKL5", del = {
                        Male = 1.516,
                        Female = 1.243}},
    SIGNS = {code = "CKL6", del = {
                        Male = 0.672,
                        Female = 0.742}},
    ADIRS = {code = "CKL7", del = {
                        Male = 0.793,
                        Female = 0.803}},
    FUEL_QUANTITY = {code = "CKL8", del = {
                        Male = 1.036,
                        Female = 0.974}},
    BARO_REFERENCE = {code = "CKL9", del = {
                        Male = 1.233,
                        Female = 1.344}},
    DOWN_TO_THE_LINE = {code = "CKL10", del = {
                        Male = 0.982,
                        Female = 1.039}},
-- CHECLIST 2 --
    BEFORE_START_CHECKLIST_BELOW_THE_LINE = {code = "CKL11", del = {
                        Male = 1.888,
                        Female = 2.324}},
    EFB = {code = "CKL12", del = {
                        Male = 0.842,
                        Female = 0.855}},
    ATC = {code = "CKL13", del = {
                        Male = 0.715,
                        Female = 0.919}},
    WINDOWS_AND_DOORS = {code = "CKL14", del = {
                        Male = 1.215,
                        Female = 1.082}},
    BEACON = {code = "CKL15", del = {
                        Male = 0.576,
                        Female = 0.620}},
    THRUST_LEVERS = {code = "CKL16", del = {
                        Male = 1.093,
                        Female = 1.124}},
    CHECKLIST_COMPLETED = {code = "CKL18", del = {
                        Male = 1.172,
                        Female = 1.113}},
    AFTER_START_CHECKLIST = {code = "CKL19", del = {
                        Male = 1.558,
                        Female = 1.520}},
    ANTI_ICE = {code = "CKL20", del = {
                        Male = 0.864,
                        Female = 1.039}},
-- CHECKLIST 3 --
    ECAM_STATUS = {code = "CKL21", del = {
                        Male = 1.143,
                        Female = .188}},
    BEFORE_TAKEOFF_CHECKLIST = {code = "CKL22", del = {
                        Male = 1.425,
                        Female = 1.678}},
    FLIGHT_CONTROLS = {code = "CKL23", del = {
                        Male = 0.843,
                        Female = 0.954}},
    FLY_INSTRUMENTS = {code = "CKL24", del = {
                        Male = 1.032,
                        Female = 1.081}},
    BRIEFING = {code = "CKL25", del = {
                        Male = 0.645,
                        Female = 0.666}},
    V1_VR_V2_FLEX_TEMP = {code = "CKL26", del = {
                        Male = 1.900,
                        Female = 2.238}},
    ECAM_MEMO = {code = "CKL27", del = {
                        Male = 0.938,
                        Female = 1.068}},
    TAKEOFF_RUNWAY = {code = "CKL28", del = {
                        Male = 1.120,
                        Female = 0.893}},
    NAV_ON_FMA = {code = "CKL29", del = {
                        Male = 1.143,
                        Female = 1.560}},
    CABIN_CREW = {code = "CKL30", del = {
                        Male = 0.945,
                        Female = 0.810}},
-- CHECKLIST 4 --
    PACKS_AND_APU_BLEED = {code = "CKL31", del = {
                        Male = 1.419,
                        Female = 1.363}},
    AFTER_TAKEOFF_CHECKLIST = {code = "CKL32", del = {
                        Male = 1.361,
                        Female = 1.465}},
    CLIMB_CHECKLIST = {code = "CKL34", del = {
                        Male = 1.105,
                        Female = 1.323}},
    APPROACH_CHECKLIST = {code = "CKL35", del = {
                        Male = 1.315,
                        Female = 1.401}},
    MINIMUMS = {code = "CKL36", del = {
                        Male = 0.867,
                        Female = 0.846}},
    LANDING_CHECKLIST = {code = "CKL37", del = {
                        Male = 1.175,
                        Female = 1.327}},
    AUTO_TRHUST = {code = "CKL38", del = {
                        Male = 0.983,
                        Female = 1.033}},
    AFTER_LANDING_CHECKLIST = {code = "CKL40", del = {
                        Male = 1.595,
                        Female = 1.505}},
    APU = {code = "CKL48", del = {
                        Male = 0.710,
                        Female = 0.951}},
-- CHECKLIST 5 --
    PARKING_CHECKLIST = {code = "CKL41", del = {
                        Male = 1.051,
                        Female = 1.161}},
    ENGINES = {code = "CKL42", del = {
                        Male = 0.777,
                        Female = 0.832}},
    SECURING_CHECKLIST = {code = "CKL43", del = {
                        Male = 1.333,
                        Female = 2.033}},
    EMERGENCY_EXIT_LIGHTS = {code = "CKL44", del = {
                        Male = 1.455,
                        Female = 1.367}},
    NO_PORTABLE_SIGNS = {code = "CKL45", del = {
                        Male = 1.212,
                        Female = 1.223}},
    APU_AND_BATTERY = {code = "CKL46", del = {
                        Male = 1.351,
                        Female = 1.348}},
    BEFORE_TAKEOFF_CHECKLIST_BELOW_THE_LINE = {code = "CKL47", del = {
                        Male = 2.052,
                        Female = 2.016}}
}

FLAP_CONFIG = {
    CP1 = {code = "CONF 1+F", del = {
                        Male = 1.288,
                        Female = 1.472}},
    CP2 = {code = "CONF 2", del = {
                        Male = 0.832,
                        Female = 0.914}},
    CP3= {code = "CONF 3", del = {
                        Male = 0.892,
                        Female = 0.840}}
}
FLAP_POS = {
    P0 = {code = "FLAPS0", del = {
                        Male = 0.886,
                        Female = 1.012}},
    P1 = {code = "FLAPS1", del = {
                        Male = 0.742,
                        Female = 0.869}},
    P2 = {code = "FLAPS2", del = {
                        Male = 0.756,
                        Female = 0.725}},
    P3 = {code = "FLAPS3", del = {
                        Male = 0.813,
                        Female = 0.849}},
    FULL = {code = "FLAPSFULL", del = {
                        Male = 0.660,
                        Female = 0.839}}
}
-- BRKAE TEMP WARNING --
BRAKE_WARN = {
    [1] = {code = "BW1", del = {
                        Male = 1.937,
                        Female = 1.943}},
    [2] = {code = "BW2", del = {
                        Male = 1.786,
                        Female = 3.413}},
    [3] = {code = "BW3", del = {
                        Male = 1.901,
                        Female = 2.995}}
}
-- POST BRIEFING --
BRIEF_CONF = {
    [1] = {code = "BRFCMP1", del = {
                        Male = 2.034,
                        Female = 2.099}},
    [2] = {code = "BRFCMP2", del = {
                        Male = 1.601,
                        Female = 1.892}},
    [3] = {code = "BRFCMP3", del = {
                        Male = 1.326,
                        Female = 2.728}},
    [4] = {code = "BRFCMP4", del = {
                        Male = 0.704,
                        Female = 2.461}}
}
-- READY SPEECH --
RDY = {
    [1] = {code = "READY1", del = {
                        Male = 0.635,
                        Female = 1.079}},
    [2] = {code = "READY2", del = {
                        Male = 0.824,
                        Female = 1.050}},
    [3] = {code = "READY3", del = {
                        Male = 0.788,
                        Female = 0.974}},
    [4] = {code = "READY4", del = {
                        Male = 1.101,
                        Female = 0.913}},
    [5] = {code = "READY5", del = {
                        Male = 1.207,
                        Female = 2.087}}
}
-- READY FOR T/O
RDY_TO_DIR = {
    [1] = {code = "RDYTO1", del = {
                        Male = 1.181,
                        Female = 1.207}},
    [2] = {code = "RDYTO2", del = {
                        Male = 1.649,
                        Female = 2.283}},
    [3] = {code = "RDYTO3", del = {
                        Male = 1.068,
                        Female = 1.744}}
}

-- LOAD SYSTEM
for config_option, file in ipairs(FO_voice_config) do
    for name, data in pairs(FO_voices_directory) do
        local codex = data.code
        FOPM_Talk[file][name] = load_WAV_file(SCRIPT_DIRECTORY.."FO PM/Voices/"..file.."/"..codex..".wav")
    end
    for name, data in pairs(FLAP_CONFIG) do
        local codex = data.code
        FOPM_Talk[file][name] = load_WAV_file(SCRIPT_DIRECTORY.."FO PM/Voices/"..file.."/"..codex..".wav")
    end
    for name, data in pairs(FLAP_POS) do
        local codex = data.code
        FOPM_Talk[file][name] = load_WAV_file(SCRIPT_DIRECTORY.."FO PM/Voices/"..file.."/"..codex..".wav")
    end
    for name, data in ipairs(BRAKE_WARN) do
        local codex = data.code
        BRAKE_WARNINGS[file][name] = load_WAV_file(SCRIPT_DIRECTORY.."FO PM/Voices/"..file.."/"..codex..".wav")
    end
    for name, data in ipairs(BRIEF_CONF) do
        local codex = data.code
        BRIEFING_CONF[file][name] = load_WAV_file(SCRIPT_DIRECTORY.."FO PM/Voices/"..file.."/"..codex..".wav")
    end
    for name, data in ipairs(RDY) do
        local codex = data.code
        READY[file][name] = load_WAV_file(SCRIPT_DIRECTORY.."FO PM/Voices/"..file.."/"..codex..".wav")
    end
    for name, data in ipairs(RDY_TO_DIR) do
        local codex = data.code
        READY_FOR_TO[file][name] = load_WAV_file(SCRIPT_DIRECTORY.."FO PM/Voices/"..file.."/"..codex..".wav")
    end
end