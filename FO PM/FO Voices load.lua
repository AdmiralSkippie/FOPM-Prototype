--------------------------
---- Male Voices Load ----
--------------------------

OFF = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/OFF.wav") -- 0.720
ON = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ON.wav") -- 0.720
NORMAL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/NORMAL.wav") -- 0.929
CHECK = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CHECK.wav") -- 0.639
-- NUMBERS --
    N0 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/0.wav") -- 0.916
    N1 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/1.wav") -- 0.942
    N2 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/2.wav") -- 0.836
    N3 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/3.wav") -- 0.876
    N4 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/4.wav") -- 0.809
    N5 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/5.wav") -- 0.916
    N6 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/6.wav") -- 0.929
    N7 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/7.wav") -- 0.942
    N8 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/8.wav") -- 0.942
    N9 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/9.wav") -- 0.743
-- SECTION 1 --
    FULL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FULL.wav") -- 0.454
    RETRACT_AND_DISARM = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RETRACT & DISARM.wav") -- 1.528
    ARM = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ARM.wav") -- 0.800
    FLAP_CONFIG = {
        P1 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CONF 1+F.wav"), -- 1.288
        P2 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CONF 2.wav"), -- 0.832
        P3= load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CONF 3.wav") -- 0.892
    }
UP = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/UP.wav") -- 0.678
DOWN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/DOWN.wav") -- 0.810
-- SECTION 2 --
    FULL_UP = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FULL UP.wav") -- 0.900
    FULL_DOWN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FULL DOWN.wav") -- 0.825
    NEUTRAL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/NEUTRAL.wav") -- 0.655
    FULL_LEFT = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FULL LEFT.wav") -- 1.109
    FULL_RIGHT = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FULL RIGHT.wav") -- 1.017
    SET = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/SET.wav") -- 0.671
    TA_RA = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TARA.wav") -- 1.592
    IGNITION = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/IGNITION.wav") -- 0.895
    N1_2 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/1&2.wav") -- 0.999
    FLAP_POS = {
        P0 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FLAPS0.wav"), -- 0.886
        P1 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FLAPS1.wav"), -- 0.996 
        P2 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FLAPS2.wav"), -- 1.027 
        P3 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FLAPS3.wav"), -- 1.229 
        FULL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FLAPSFULL.wav") --0.943
    }
    PUSH = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/PUSH.wav") -- 0.602
    AVAIL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/AVAIL.wav") -- 0.954
    LOW = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/LOW.wav") -- 0.547
    MEDIUM = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/MEDIUM.wav") -- 0.710
    MAX = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/MAX.wav") -- 0.751
--------------------
-- SECTION 3 --
    ENGINE_MASTERS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ENGINEMST.wav") -- 1.509
    ENGINE_MODE_SELECTOR = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ENGINEMODE.wav") -- 1.685
    WEATHER_RADAR = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/WXTX.wav") -- 1.009
    LANDING_GEAR = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/LNDGR.wav") -- 0.846
    WIPERS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/WIPERS.wav") -- 0.827
    BATTERIES = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BATT.wav") -- 0.862
    EXTERNAL_POWER = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/EXTPWR.wav") -- 1.236
    RECALL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RECALL.wav") -- 0.841
    SYSTEMS_CHECK = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/SYSCHECK.wav") -- 1.044
    OXYGEN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/OXY.wav") -- 0.813
    HYDRAULICS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/HYD.wav") -- 0.924
    OIL_QUANTITY = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/OILQTY.wav") -- 1.211
    FLAPS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FLAPS.wav") -- 0.912
    SPEED_BRAKE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/SPDBRK.wav") -- 1.063
    PARKING_BRAKE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/PRKBRK.wav") -- 1.013
-- SECTION 4 --
    BRAKE_ACCUMULATOR = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BRKACCU.wav") -- 1.423
    ALTERNATE_BRAKES = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ALTNBRK.wav") -- 1.259
    GROUND_SPOILERS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/GNDSPOILERS.wav") -- 1.414
    RUDDER_TRIM = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RUDDERTRIM.wav") --0.809
    PITCHTRM = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/PITCHTRIM.wav") -- 1.128
    ECAM_STATUS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ECAMSTATUS.wav") -- 1.322
    FLIGHT_CONTROLS_CHECK = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FLTCTLCHECK.wav") -- 1.414
    ELEVATOR = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ELEV.wav") --0.962
    AILERONS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/AILERONS.wav") -- 0.907
    RDR = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RUDDER.wav") -- 0.795
    PWS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/PWS.wav") -- 1.086
    BRAKE_TEMP = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BRKTEMP.wav") -- 1.004
-- BRKAE TEMP WARNING --
    BRAKE_WARNINGS = {
    [1] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BW1.wav"), -- 1.937
    [2] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BW2.wav"), -- 1.786
    [3] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BW3.wav") -- 2.195
    }
-- SECTION 5 --
    BRAKE_FAN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BRKFAN.wav") -- 0.973
    EXTERIOR_LIGHTS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/EXTLIGHTS.wav") -- 1.540
    TCAS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TCAS.wav") -- 1.018
    PACKS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/PACKS.wav") -- 0.799
    STABLE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/STABLE.wav") -- 0.838
    TRHUST_SET = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/THRSET.wav") -- 1.147
    N100 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/100.wav") -- 0.979
    V1 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/V1.wav") -- 0.792
    ROTATE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ROTATE.wav") -- 0.805
    POSITIVE_RATE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/POSITIVERATE.wav") -- 1.321
    GEAR_UP = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/GEARUP.wav") -- 0.786
    GEAR_DOWN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/GEARDN.wav") -- 0.696
    GEAR_3GREENS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/3GREENS.wav") -- 0.854
    APU_MASTER = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/APUMASTER.wav") -- 1.218
    STARTING_APU = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/STARTINGAPU.wav") -- 1.540
    SPEED_CHECK = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/SPDCHECK.wav") -- 1.136
    TERRAIN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TERRAIN.wav") -- 0.825
-- POST BRIEFING --
    BRIEFING_CONF = {
        [1] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BRFCMP1.wav"), --* OK CAPTAIN BRIEFING COMPLETED -- 2.034
        [2] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BRFCMP2.wav"), --* ROGER BRIEFING COMPLETED -- 1.601
        [3] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BRFCMP3.wav"), --* UNDERSTOOD NOTHING TO ADD -- 1.326
        [4] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BRFCMP4.wav")  --* OK CAPTAIN -- 0.704
    }
-- SECTION 6 --
    SEAT_BELTS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/SEATBELTS.wav") -- 1.089
    LS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/LS.wav") -- 0.982
    GO_ARROUND = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/GOARROUND.wav") -- 0.995
    TOGA = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TOGA.wav") -- 0.645
    SPOILERS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/SPOILERS.wav") -- 1.076
    REVERSE_GREEN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/REVERSEGREEN.wav") -- 0.753
    DECEL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/DECEL.wav") -- 0.834
    N60_KNOTS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/60.wav") -- 1.197
    TRNS_ALT = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TRANS ALT.wav") -- 1.101
    TRNS_LVL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TRANS LVL.wav") -- 0.863
    FLIGHT_DIRECTORS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FD.wav") -- 1.028
-- SECTION 7 --
    ANTI_ICE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ANTIICE1.wav") -- 1.180
    LANDING_LIGHTS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/LNDLIGHTS.wav") -- 1.180
    TAXI_LIGHT = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TAXILIGHT.wav") -- 0.978
    APU_BLEED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/APUBLEED.wav") -- 1.003
    FUEL_PUMPS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/FUELPUMPS.wav") -- 0.953
    ATC = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ATC.wav") -- 0.839
    ENGINE1 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ENGINE1.wav") -- 1.035
    ENGINE2 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ENGINE2.wav") -- 0.865
    AFTER_START_PROCEDURES = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/AFTSTARTPROC.wav") -- 1.281
    YELLOW_HYDRAULIC_PUMP = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/YHYDPUMP.wav") -- 1.250
    STARTING_NUMBER_2 = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/START2.wav") -- 1.186
    CHECK_TIME = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CHECKTIME.wav") -- 0.909
    CROSS_BLEED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CROSSBLEED.wav") -- 0.827
    AUTOBRAKES = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/AUTOBRK.wav") --1.010
    ENGINE_2_SHUTDOWN = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ENG2SD.wav") -- 1.352
    ECAM_RCLL = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ECAMRCLL.wav") -- 0.866
    TEN_THAUSAND_FEET = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/10000 FEET.wav") -- 1.006
-- READY SPEECH --

READY = {
    [1] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/READY1.wav"),
    [2] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/READY2.wav"),
    [3] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/READY3.wav"),
    [4] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/READY4.wav"),
    [5] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/READY5.wav")
}

-- SPECIAL PROCEDURES (AR-CAT II/III)
NAVAIDS_DESELECTION = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/NAVAIDS.wav") -- 1.236
GPS_NAV_MODE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/GPSNAVMODE.wav") -- 1.072
BOTH_NAV = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/BOTHNAV.wav") -- 0.739
ON_ON = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ON_ON.wav") -- 0.770

-- READY FOR T/O
READY_FOR_TO = {
    [1] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RDYTO1.wav"), -- 1.181
    [2] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RDYTO2.wav"), -- 1.649
    [3] = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RDYTO3.wav") -- 1.068
}

-- CHEKCLIST ANSWERS --
COMPLETED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/COMPLT.wav") -- 0.757
REMOVED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/REMOVED.wav") -- 0.669
ON_AUTO = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ONAUTO.wav") -- 1.323
NAV = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/NAV.wav") -- 0.894
CLOSE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CLOSE.wav") -- 0.615
IDLE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/IDLE.wav") -- 0.590
CONFIRM = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CONFIRM.wav") -- 0.791
TAKEOFF_NO_BLUE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/TONOBLUE.wav") -- 1.098
ADVISED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/ADVISED.wav") -- 0.836
MANAGE_SPEED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/MNGSPD.wav") -- 1.180
SELECTED_SPEED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/SELECSPD.wav") -- 1.277
RETRACTED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/RETRACTED.wav") -- 0.643
DISARMED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/DISARMED.wav") -- 0.727
AUTO = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/AUTO.wav") -- 0.480

---------------
-- CHECKLIST --
---------------

-- CHECKLIST 1--
    BEFORE_START_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL1.wav") -- 1.318 
    EFB_PREPARATION = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL2.wav") -- 1.581
    AIRCRAFT_PBN_CAPABILITY = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL3.wav") -- 1.940
    COCKPIT_PREPARATION = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL4.wav") -- 1.409
    GEAR_PINS_AND_COVERS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL5.wav") -- 1.516
    SIGNS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL6.wav") -- 0.672
    ADIRS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL7.wav") -- 0.793
    FUEL_QUANTITY = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL8.wav") -- 1.036
    BARO_REFERENCE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL9.wav") -- 1.233
    DOWN_TO_THE_LINE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL10.wav") -- 0.982
-- CHECLIST 2 --
    BEFORE_START_CHECKLIST_BELOW_THE_LINE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL11.wav") -- 1.888
    EFB = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL12.wav") -- 0.842
    ATC = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL13.wav") -- 0.736
    WINDOWS_AND_DOORS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL14.wav") -- 1.215
    BEACON = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL15.wav") -- 0.576
    THRUST_LEVERS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL16.wav") -- 1.176
    PARKING_BRAKE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL17.wav") -- 0.736
    CHECKLIST_COMPLETED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL18.wav") -- 1.302
    AFTER_START_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL19.wav") -- 1.558
    ANTI_ICE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL20.wav") -- 1.027
-- CHECKLIST 3 --
    ECAM_STATUS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL21.wav") -- 1.143
    BEFORE_TAKEOFF_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL22.wav") -- 1.425
    FLIGHT_CONTROLS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL23.wav") -- 1.008
    FLY_INSTRUMENTS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL24.wav") -- 1.032
    BRIEFING = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL25.wav") -- 0.645
    V1_VR_V2_FLEX_TEMP = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL26.wav") -- 1.900
    ECAM_MEMO = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL27.wav") -- 0.938
    TAKEOFF_RUNWAY = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL28.wav") -- 1.120
    NAV_ON_FMA = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL29.wav") -- 1.143
    CABIN_CREW = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL30.wav") -- 0.945
-- CHECKLIST 4 --
    PACKS_AND_APU_BLEED = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL31.wav") -- 1.419
    AFTER_TAKEOFF_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL32.wav") -- 1.361
    LANDING_GEAR = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL33.wav") -- 0.937
    CLIMB_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL34.wav") -- 1.105
    APPROACH_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL35.wav") -- 1.315
    MINIMUMS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL36.wav") -- 0.867
    LANDING_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL37.wav") -- 1.175
    AUTO_TRHUST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL38.wav") -- 0.983
    AOUTOBRAKES = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL39.wav") -- 1.012
    AFTER_LANDING_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL40.wav") -- 1.595
    APU = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL48.wav") -- 0.987
-- CHECKLIST 5 --
    PARKING_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL41.wav") -- 1.051
    ENGINES = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL42.wav") -- 0.777
    SECURING_CHECKLIST = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL43.wav") -- 1.333
    EMERGENCY_EXIT_LIGHTS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL44.wav") -- 1.455
    NO_PORTABLE_SIGNS = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL45.wav") -- 1.212
    APU_AND_BATTERY = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL46.wav") -- 1.351
    BEFORE_TAKEOFF_CHECKLIST_BELOW_THE_LINE = load_WAV_file(SCRIPT_DIRECTORY .. "FO PM/Voices/Male/CKL47.wav") -- 2.052