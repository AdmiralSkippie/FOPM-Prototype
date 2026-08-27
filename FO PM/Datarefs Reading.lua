------------------
---- DATAREFS ----
------------------

--|||| GENERAL |||||--
dataref("TIME", "sim/time/total_running_time_sec", "readonly")
dataref("ENG_MODEL", "AirbusFBW/EngineTypeIndex", "readonly") -- 0 IAE/1 CFM/2 PW/3 LEAP
dataref("FUEL_ACF_CONFIG", "AirbusFBW/FuelConfigIndex", "readonly") -- FOR NEO 1 NEO/2 LR /3 XLR

--|||| COMMAND/CHANGE ||||--
----- P/B -----
BAT_1_PB = "toliss_airbus/eleccommands/Bat1Toggle"
BAT_2_PB = "toliss_airbus/eleccommands/Bat2Toggle"
EXTPWR_PB = "toliss_airbus/eleccommands/ExtPowToggle"
ECAM_Recall_PB = "AirbusFBW/ECAMRecall"
ECAM_DOOR_PB = "AirbusFBW/ECP/SelectDoorOxyPage"
ECAM_HYD_PB = "AirbusFBW/ECP/SelectHydraulicPage"
ECAM_ENG_PB = "AirbusFBW/ECP/SelectEnginePage"
ECAM_WHEEL_PB = "AirbusFBW/ECP/SelectWheelPage"
ECAM_STS_PB = "AirbusFBW/ECP/SelectStatusPage"
RUDDER_TRIM_RESET = "sim/flight_controls/rudder_trim_center"
BRKFAN_PB = "toliss_airbus/gear/brake_fan"
dataref("BRKFAN_State", "AirbusFBW/BrakeFan", "readonly")
PACK_1_PB = "toliss_airbus/aircondcommands/Pack1Toggle"
PACK_2_PB = "toliss_airbus/aircondcommands/Pack2Toggle"
APU_MASTER_PB = "toliss_airbus/apucommands/MasterToggle"
APU_START_PB = "toliss_airbus/apucommands/StarterToggle"
APU_BLEED_PB = "toliss_airbus/apucommands/BleedToggle"
TERRAIN_FO_PB = "toliss_airbus/dispcommands/TerrOnND2Toggle"
GPWS_FLAP3_PB = "toliss_airbus/gpwscommands/Flap3Toggle"
LS_FO_PB = "toliss_airbus/dispcommands/CoLSButtonPush"
dataref("LS_FO_State","AirbusFBW/ILSonFO","readonly") -- 1 == ON
HDGTRK_TOGGLE = "toliss_airbus/hdgtrk_button_push"
dataref("HDGTRK_MODE", "AirbusFBW/HDGTRKmode", "readonly") -- 0 = HDG
FD_CAP_PB = "toliss_airbus/fd1_push"
FD_FO_PB = "toliss_airbus/fd2_push"
dataref("FO_FD_STATE", "AirbusFBW/FD2Engage", "readonly")
dataref("CP_FD_STATE", "AirbusFBW/FD1Engage", "readonly")
FO_ND_CSTR_PB = "toliss_airbus/dispcommands/CoCstrPushButton"
dataref("FO_CSTR_STATE", "AirbusFBW/NDShowCSTRFO", "readonly")
CRONO_SET_PB = "toliss_airbus/chrono/ChronoStartStopPush"
CRONO_RESET_PB= "toliss_airbus/chrono/ChronoResetPush"
ANTI_ICE_ENG1_PB = "toliss_airbus/antiicecommands/ENG1Toggle"
ANTI_ICE_ENG2_PB = "toliss_airbus/antiicecommands/ENG2Toggle"
ANTI_ICE_WING_PB = "toliss_airbus/antiicecommands/WingToggle"
-- FUEL PUMPS --
    FPUMP_RTANK_1_PB = "toliss_airbus/fuelcommands/PumpRWing1Toggle"
    FPUMP_RTANK_2_PB = "toliss_airbus/fuelcommands/PumpRWing2Toggle"
    FPUMP_CTANK_1_PB = "toliss_airbus/fuelcommands/PumpRCenterToggle"
    FPUMP_CTANK_2_PB = "toliss_airbus/fuelcommands/PumpLCenterToggle"
    FPUMP_LTANK_1_PB = "toliss_airbus/fuelcommands/PumpLWing1Toggle"
    FPUMP_LTANK_2_PB = "toliss_airbus/fuelcommands/PumpLWing2Toggle"
dataref("Y_ELEC_PUMP_PB", "AirbusFBW/HydOHPArray", "writable", 3) -- Y HYD PUMP PB --
AUTOBRK_MAX_PB = "AirbusFBW/AbrkMax"
TO_CONFIG_PB = "AirbusFBW/TOConfigPress"
dataref("ENG_1_BLEED_PB", "AirbusFBW/ENG1BleedSwitch", "writable") -- ENG1BLEED -- 
dataref("ENG_2_BLEED_PB", "AirbusFBW/ENG2BleedSwitch", "writable") -- ENG2BLEED --

----- S/W -----
dataref("ENG_1_Master", "AirbusFBW/ENG1MasterSwitch", "writable")
dataref("ENG_2_Master", "AirbusFBW/ENG2MasterSwitch", "writable")
dataref("ENG_Mode", "AirbusFBW/ENGModeSwitch", "writable") -- 1 Normal --
dataref("RADAR_SYS_SW", "AirbusFBW/WXPowerSwitch", "writable") -- 1 off --
dataref("LWipers_Mode", "AirbusFBW/LeftWiperSwitch", "writable")
dataref("RWipers_Mode", "AirbusFBW/RightWiperSwitch", "writable")
dataref("PRKBRK_SW", "AirbusFBW/ParkBrake", "writable")
dataref("LANDLT_L_SW", "AirbusFBW/OHPLightSwitches", "writable", 4) -- 0 Retract --
dataref("LANDLT_R_SW", "AirbusFBW/OHPLightSwitches", "writable", 5)
dataref("TAXILT_SW", "AirbusFBW/OHPLightSwitches", "writable", 3)
dataref("STROBE_SW", "AirbusFBW/OHPLightSwitches", "writable", 7) -- 1 Auto --
dataref("RWYTOLT_SW", "AirbusFBW/OHPLightSwitches", "writable", 6)
dataref("WINGLT_SW", "AirbusFBW/OHPLightSwitches", "writable", 1)
dataref("TCAS_SW", "AirbusFBW/XPDRPower", "writable") -- 1/STBY 2/XPNDR 4/TA/RA --
dataref("EFIS_RNG", "AirbusFBW/NDrangeFO", "writable") -- 0/10 --
dataref("PWS_SW", "AirbusFBW/WXSwitchPWS", "writable") -- 2/ON --
dataref("XBLEED_SW", "AirbusFBW/XBleedSwitch", "writable") -- 1/AUTO --
dataref("FO_QNH_SW", "ckpt/fcu/baroRight/anim", "writable") -- 5to5 posible --

---- LEVERS ---- brace moore
dataref("LG_Lever", "AirbusFBW/GearLever", "writable") -- 0 up
FLAPS_1UP = "sim/flight_controls/flaps_up" -- COMAND --
FLAPS_1DOWN = "sim/flight_controls/flaps_down" -- COMAND --
dataref("SPDBRK_Lever", "sim/cockpit2/controls/speedbrake_ratio", "writable") -- -0.5 ARM/0 RET <> 1
PITCH_TRIM_DN = "sim/flight_controls/pitch_trim_down"
PITCH_TRIM_UP = "sim/flight_controls/pitch_trim_up"

--|||| READ/CHECK ||||--
----- P/B -----
dataref("BAT_1_State", "AirbusFBW/BatOHPArray", "readonly", 0)
dataref("BAT_2_State", "AirbusFBW/BatOHPArray", "readonly", 1)
dataref("EXTPWR_State", "AirbusFBW/ExtPowOHPArray", "readonly", 0) -- 1 ON/2 AVAIL -- 
dataref("ALTNBRK_State", "AirbusFBW/AltnBrake", "readonly")
dataref("APU_BLEED_STATE", "AirbusFBW/APUBleedSwitch", "readonly")
dataref("Y_ELEC_PUMP_STATE", "AirbusFBW/HydPumpOHPArray", "readonly", 3)
dataref("TCAS_STATE", "AirbusFBW/XPDRPower", "readonly")
dataref("PACK_1_STATE", "AirbusFBW/Pack1Switch", "readonly")
dataref("PACK_2_STATE", "AirbusFBW/Pack2Switch", "readonly")
-- AUTOBRK STATE --
    dataref("AUTOBRK_LOW", "AirbusFBW/AutoBrkLo", "readonly")
    dataref("AUTOBRK_MED", "AirbusFBW/AutoBrkMed", "readonly")
    dataref("AUTOBRK_MAX", "AirbusFBW/AutoBrkMax", "readonly")
-- FUEL PUMPS --
    dataref("FPUMP_RTANK_1_STATE", "AirbusFBW/FuelAutoPumpOHPArray", "readonly", 0)
    dataref("FPUMP_RTANK_2_STATE", "AirbusFBW/FuelAutoPumpOHPArray", "readonly", 1)
    dataref("FPUMP_CTANK_1_STATE", "AirbusFBW/FuelAutoPumpOHPArray", "readonly", 2)
    dataref("FPUMP_CTANK_2_STATE", "AirbusFBW/FuelAutoPumpOHPArray", "readonly", 3)
    dataref("FPUMP_LTANK_1_STATE", "AirbusFBW/FuelAutoPumpOHPArray", "readonly", 4)
    dataref("FPUMP_LTANK_2_STATE", "AirbusFBW/FuelAutoPumpOHPArray", "readonly", 5)
----- S/W -----
dataref("ENG_1_Master_State", "AirbusFBW/ENG1MasterSwitch", "readonly")
dataref("ENG_2_Master_State", "AirbusFBW/ENG2MasterSwitch", "readonly")
dataref("ENG_Mode_State", "AirbusFBW/ENGModeSwitch", "readonly") -- 1 Normal --
dataref("RADAR_SYS_SW_State", "ckpt/radar/sys/anim", "readonly")
dataref("PWS_STATE", "AirbusFBW/WXSwitchPWS", "readonly")
dataref("LWipers_State", "AirbusFBW/LeftWiperSwitch", "readonly")
dataref("RWipers_State", "AirbusFBW/RightWiperSwitch", "readonly")
dataref("PRKBRK_State", "AirbusFBW/ParkBrake", "readonly") -- 1 ON
dataref("SEATBELTS_SW", "AirbusFBW/OHPLightSwitches", "readonly", 11) -- 1 ON 
dataref("XBLEED_STATE", "AirbusFBW/XBleedSwitch", "readonly") -- 1 Auto --
dataref("SIGNS_STATE", "AirbusFBW/OHPLightSwitches", "readonly", 12)

-- ADIRS --
    dataref("ADIR_1_STATE", "AirbusFBW/ADIRUSwitchArray", "readonly", 0) -- 1 NAV
    dataref("ADIR_2_STATE", "AirbusFBW/ADIRUSwitchArray", "readonly", 1)
    dataref("ADIR_3_STATE", "AirbusFBW/ADIRUSwitchArray", "readonly", 2)

dataref("BEACON_STATE", "sim/cockpit2/switches/beacon_on", "readonly")

---- LEVERS ----
dataref("LG_Lever_State", "AirbusFBW/GearLever", "readonly")
dataref("LG_NG_State", "AirbusFBW/NoseGearInd", "readonly") -- 2 GREEN
dataref("LG_LG_State", "AirbusFBW/LeftGearInd", "readonly")
dataref("LG_RG_State", "AirbusFBW/RightGearInd", "readonly")
dataref("FLAPS_LEVER_State", "AirbusFBW/FlapLeverRatio", "readonly") -- 0.25 = 1/ 0.5 = 2
dataref("FLAPS_State", "AirbusFBW/FlapRequestPos", "readonly") -- -1 = on position
dataref("FLAPS_TO_CONFIG", "AirbusFBW/TOFlapSettingMCDU", "readonly") -- 1 = 1
dataref("SPDBRK_State", "sim/cockpit2/controls/speedbrake_ratio", "readonly")
dataref("THR_STATE", "AirbusFBW/THRRatingType", "readonly") -- 1 CLB/2 MCT/3 TOGA/4 FLEX --
dataref("THR_LEVER", "AirbusFBW/THRLeverMode", "readonly") -- 1 CLB/2 MCT/3 TOGA/4 FLEX --

---- MCDU ----
    -- MCDU 1 CONT--
        dataref("MCDU1_BLINE_3", "AirbusFBW/MCDU1cont3b", "readonly") -- text line --
        dataref("MCDU1_GLINE_1", "AirbusFBW/MCDU1cont1g", "readonly")
        dataref("MCDU1_WLINE_1", "AirbusFBW/MCDU1cont1w", "readonly")
        dataref("MCDU1_WTITLE", "AirbusFBW/MCDU1titlew", "readonly")
    -- MCDU 1 COMMANDS --

    -- MCDU 2 CONT --
        dataref("MCDU2_WTITLE", "AirbusFBW/MCDU2titlew", "readonly")
        dataref("MCDU2_WLINE_1","AirbusFBW/MCDU2cont1w","readonly")
        dataref("MCDU2_WLINE_2","AirbusFBW/MCDU2cont2w","readonly")
        dataref("MCDU2_WLINE_3","AirbusFBW/MCDU2cont3w","readonly")
        dataref("MCDU2_BLINE_3", "AirbusFBW/MCDU2cont3b", "readonly") -- text line --
        dataref("MCDU2_BLINE_6","AirbusFBW/MCDU2cont6b","readonly")
        dataref("MCDU2_GLINE_1", "AirbusFBW/MCDU2cont1g", "readonly") -- text line FLP retract to FLP1 --
        dataref("MCDU2_GLINE_2", "AirbusFBW/MCDU2cont2g", "readonly") -- text line SLAT retract to 0 --
        dataref("MCDU2_GLINE_3", "AirbusFBW/MCDU2cont3g", "readonly") -- text line Green DOT --
        dataref("MCDU2_SHORT_GLINE_2","AirbusFBW/MCDU2scont1g","readonly")
        dataref("MCDU2_SHORT_GLINE_3","AirbusFBW/MCDU2label2g","readonly")
        dataref("MCDU2_SHORT_GLINE_4","AirbusFBW/MCDU2scont2g","readonly")
        dataref("MCDU2_SHORT_GLINE_5","AirbusFBW/MCDU2label3g","readonly")
        dataref("MCDU2_SHORT_GLINE_6","AirbusFBW/MCDU2scont3g","readonly")
        dataref("MCDU2_SHORT_GLINE_7","AirbusFBW/MCDU2label4g","readonly")
        dataref("MCDU2_SHORT_GLINE_8","AirbusFBW/MCDU2scont4g","readonly")
        dataref("MCDU2_SHORT_GLINE_9","AirbusFBW/MCDU2label5g","readonly")
        dataref("MCDU2_SHORT_GLINE_10","AirbusFBW/MCDU2scont5g","readonly")
        dataref("MCDU2_SHORT_GLINE_11","AirbusFBW/MCDU2label6g","readonly")
        dataref("MCDU2_SHORT_GLINE_12","AirbusFBW/MCDU2scont6g","readonly")
        dataref("MCDU2_SHORT_WLINE_1","AirbusFBW/MCDU2label1w","readonly")
        dataref("MCDU2_SHORT_WLINE_2","AirbusFBW/MCDU2scont1w","readonly")
        dataref("MCDU2_SHORT_WLINE_3","AirbusFBW/MCDU2label2w","readonly")
        dataref("MCDU2_SHORT_WLINE_4","AirbusFBW/MCDU2scont2w","readonly")
        dataref("MCDU2_SHORT_WLINE_5","AirbusFBW/MCDU2label3w","readonly")
        dataref("MCDU2_SHORT_WLINE_6","AirbusFBW/MCDU2scont3w","readonly")
        dataref("MCDU2_SHORT_WLINE_7","AirbusFBW/MCDU2label4w","readonly")
        dataref("MCDU2_SHORT_WLINE_8","AirbusFBW/MCDU2scont4w","readonly")
        dataref("MCDU2_SHORT_WLINE_9","AirbusFBW/MCDU2label5w","readonly")
        dataref("MCDU2_SHORT_WLINE_10","AirbusFBW/MCDU2scont5w","readonly")
        dataref("MCDU2_SHORT_WLINE_11","AirbusFBW/MCDU2label6w","readonly")
        dataref("MCDU2_SHORT_WLINE_12","AirbusFBW/MCDU2scont6w","readonly")
    -- MCDU 2 COMMANDS --
        MCDU_FO_KEY_Perf = "AirbusFBW/MCDU2Perf"
        MCDU_FO_KEY_Fpln = "AirbusFBW/MCDU2Fpln"
        MCDU_FO_KEY_Menu = "AirbusFBW/MCDU2Menu"
        MCDU_FO_KEY_L1 = "AirbusFBW/MCDU2LSK1L"
        MCDU_FO_KEY_L2 = "AirbusFBW/MCDU2LSK2L"
        MCDU_FO_KEY_L3 = "AirbusFBW/MCDU2LSK3L"
        MCDU_FO_KEY_L4 = "AirbusFBW/MCDU2LSK4L"
        MCDU_FO_KEY_L5 = "AirbusFBW/MCDU2LSK5L"
        MCDU_FO_KEY_L6 = "AirbusFBW/MCDU2LSK6L"
        MCDU_FO_KEY_R1 = "AirbusFBW/MCDU2LSK1R"
        MCDU_FO_KEY_R2 = "AirbusFBW/MCDU2LSK2R"
        MCDU_FO_KEY_R6 = "AirbusFBW/MCDU2LSK6R"

---- INDICATIONS ----
-- dataref("OXY_Press", "", "readonly")
dataref("Y_HYD_RESVR", "AirbusFBW/HydSysQtyArray", "readonly", 1) -- 0.8 min
dataref("G_HYD_RESVR", "AirbusFBW/HydSysQtyArray", "readonly", 0) -- 0.8 min
dataref("B_HYD_RESVR", "AirbusFBW/HydSysQtyArray", "readonly", 2) -- 0.75 min
-- dataref("ENG_1_OILQTY", "", "readonly")
-- dataref("ENG_2_OILQTY", "", "readonly")
dataref("BRK_ACCU_Press", "AirbusFBW/AccuNeedle", "readonly") -- 1 green / 0.93 min
dataref("ELEVATORS", "sim/flightmodel2/wing/elevator1_deg", "readonly",8) -- 0 NEUTRAL/15 DOWN/-30 UP
dataref("LALERONS", "sim/flightmodel2/wing/aileron1_deg", "readonly",7) -- 0 NTRL/-25 LEFT/25 RIGHT
dataref("RALERONS", "sim/flightmodel2/wing/aileron1_deg", "readonly",6) -- 0 NTRL/25 LEFT/-25 RIGHT
dataref("RUDDER", "sim/flightmodel2/wing/rudder1_deg", "readonly", 10) -- 0 NTRL/-25 LEFT/25 RIGHT
-- ENG INDICATIONS --
    -- CFM/LEAP/PW --       
        dataref("ENG_THRRating_N1", "AirbusFBW/THRRatingN1", "readonly")
        dataref("ENG_1_N1", "sim/cockpit2/engine/indicators/N1_percent", "readonly", 0)
        dataref("ENG_2_N1", "sim/cockpit2/engine/indicators/N1_percent", "readonly", 1)
    -- IAE --
        dataref("ENG_THRRating_EPR", "AirbusFBW/THRRatingEPR", "readonly")
        dataref("ENG_1_EPR", "AirbusFBW/ENGEPRArray", "readonly", 0)
        dataref("ENG_2_EPR", "AirbusFBW/ENGEPRArray", "readonly", 1)
    dataref("ENG_1_REV", "AirbusFBW/ENGRevArray", "readonly", 0) -- 2 GREEN
    dataref("ENG_2_REV", "AirbusFBW/ENGRevArray", "readonly", 1)
    dataref("ENG_1_AVAIL", "sim/flightmodel/engine/ENGN_running", "readonly", 0)
    dataref("ENG_2_AVAIL", "sim/flightmodel/engine/ENGN_running", "readonly", 1)
-- SPEED DATAREFS
    dataref("IND_AIRSPEED", "sim/cockpit2/gauges/indicators/airspeed_kts_copilot", "readonly")
    dataref("TARGET_SPEED","toliss_airbus/pfdoutputs/general/ap_speed_value","readonly")
    dataref("VERTICAL_SPEED", "toliss_airbus/pfdoutputs/captain/vertical_speed", "readonly")
    dataref("V1_SPEED", "AirbusFBW/V1Value", "readonly")
    dataref("VR_SPEED", "toliss_airbus/performance/VR", "readonly")
    dataref("V2_SPEED", "toliss_airbus/performance/V2", "readonly")
dataref("ENG_ATHR_MODE", "AirbusFBW/SPDmanaged", "readonly") -- 1 = Managed
dataref("THR_SETTING", "toliss_airbus/performance/flextemp", "readonly")
dataref("GNDAIR_SW", "sim/flightmodel2/gear/on_ground", "readonly", 1)
dataref("INBD_SPOILERS", "AirbusFBW/SDSpoilerArray", "readonly", 0)
dataref("CRONO", "AirbusFBW/ClockChronoValue", "readonly")
-- BRAKE TEMP --
    dataref("BRAKE1_TEMP", "AirbusFBW/BrakeTemperatureArray", "readonly", 0)
    dataref("BRAKE2_TEMP", "AirbusFBW/BrakeTemperatureArray", "readonly", 1)
    dataref("BRAKE3_TEMP", "AirbusFBW/BrakeTemperatureArray", "readonly", 2)
    dataref("BRAKE4_TEMP", "AirbusFBW/BrakeTemperatureArray", "readonly", 3)
dataref("STEARING_DEGREES", "AirbusFBW/NoseWheelSteeringAngle", "readonly")
dataref("APU_STATE", "AirbusFBW/APUAvail", "readonly")
-- WINDOWS/DOORS --
    dataref("DOOR_1L", "AirbusFBW/PaxDoorArray", "readonly", 0)
    dataref("DOOR_1R", "AirbusFBW/PaxDoorArray", "readonly", 1)
    dataref("DOOR_2L", "AirbusFBW/PaxDoorArray", "readonly", 2)
    dataref("DOOR_2R", "AirbusFBW/PaxDoorArray", "readonly", 3)
    dataref("DOOR_3L", "AirbusFBW/PaxDoorArray", "readonly", 4)
    dataref("DOOR_3R", "AirbusFBW/PaxDoorArray", "readonly", 5)
    dataref("DOOR_4L", "AirbusFBW/PaxDoorArray", "readonly", 6)
    dataref("DOOR_4R", "AirbusFBW/PaxDoorArray", "readonly", 7)
dataref("ECAM_MSG_A", "AirbusFBW/EWD1aText", "readonly")
--dataref("ECAM_UPPER_RIGHT_MSG", "", "readonly")
--dataref("ECAM_LOWER_MSG", "", "readonly")
dataref("PITCH_TRIM", "AirbusFBW/PitchTrimPosition", "readonly")
dataref("RUDDER_TRIM_POS", "AirbusFBW/YawTrimPosition", "readonly")
-- FMA (STRINGS)
    dataref("MINIMUMS_MODE","AirbusFBW/FMA3w","readonly")
    dataref("MINIMUMS_VAL","AirbusFBW/FMA3b","readonly")
    dataref("FMA_B_STATE", "AirbusFBW/FMA2b", "readonly")
    dataref("FMA_G_STATE", "AirbusFBW/FMA1g", "readonly")
-- QNH INDICATOR --
    dataref("CM_QNH", "sim/cockpit/misc/barometer_setting", "readonly") -- convertir a qnh
    dataref("FO_QNH", "sim/cockpit/misc/barometer_setting2", "readonly") -- convertir a qnh
    dataref("ISIS_QNH", "AirbusFBW/ISIBaroSetting", "readonly")
    dataref("BARO_UNIT_CM","AirbusFBW/BaroUnitCapt", "readonly")
    dataref("BARO_UNIT_FO","AirbusFBW/BaroUnitFO", "writable") -- 0 = In.Hg
    FO_BARO_PUSH = "toliss_airbus/copilot_baro_push"
    FO_BARO_PULL = "toliss_airbus/copilot_baro_pull"
    dataref("BARO_STD_FO", "AirbusFBW/BaroStdFO", "readonly") -- 1 standard
    dataref("BARO_ROTATE_FO", "AirbusFBW/BaroKnobRotationFO", "writable") -- -1 izqueirda +1 derecha
dataref("LBRAKE_Press", "AirbusFBW/LeftBrakeNeedle", "readonly") -- 0.7 FULL PRESS
dataref("RBRAKE_Press", "AirbusFBW/RightBrakeNeedle", "readonly")
dataref("IND_ALTITUDE", "AirbusFBW/ALTFO", "readonly")
dataref("TRANSITION_ALT", "toliss_airbus/performance/DeptTrans", "readonly")
dataref("TRANSITION_LVL", "toliss_airbus/performance/DestTrans", "readonly")
dataref("AGL_ALTITUDE", "sim/flightmodel/position/y_agl", "readonly")
dataref("AP_DISCN_ALARM", "AirbusFBW/APWarning", "readonly") -- 1 ON --
dataref("AP1_ENGAGE","AirbusFBW/AP1Engage","readonly")
dataref("AP2_ENGAGE","AirbusFBW/AP2Engage","readonly")
dataref("OAT", "sim/cockpit2/temperature/outside_air_temp_degc", "readonly")
dataref("RADIO_ALT","sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_copilot","readonly")
-- DEVIATION INDICATIONS
    dataref("FO_GS_Avail", "AirbusFBW/GSonFO", "readonly") -- GS avail
    dataref("FO_GS_Deviation","AirbusFBW/GSvalFO","readonly") -- GS Deviation
    dataref("FO_LOC_Avail","AirbusFBW/LOConFO","readonly") -- LOC Avail
    dataref("FO_LOC_Deviation","AirbusFBW/LOCvalFO","readonly") -- LOC Deviation
-- ATT INDICATORS
    dataref("ROLL_ANGLE","toliss_airbus/pfdoutputs/copilot/roll_angle","readonly") -- LEFT TURN / negatives || RIGHT TURN / positive
    dataref("PITCH_ANGLE","toliss_airbus/pfdoutputs/copilot/pitch_angle","readonly")
-- ENG TYPE INDICATION SELECTOR -- 
ENG_THRRate = 0
ENG_1_POWER = 0
ENG_2_POWER = 0
function CHECK_ENGINE_TYPE()
    if ENG_MODEL ~= 0 then
        ENG_THRRate = ENG_THRRating_N1
        ENG_1_POWER = ENG_1_N1
        ENG_2_POWER = ENG_2_N1
    else
        ENG_THRRate = ENG_THRRating_EPR
        ENG_1_POWER = ENG_1_EPR
        ENG_2_POWER = ENG_2_EPR
    end
end

do_every_frame("CHECK_ENGINE_TYPE()")

---- FLAP LIMITS ----
FLAPS_LIMIT = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0
}
GEAR_EXTENTION_LIMIT = 250
GEAR_RETRACTION_LIMIT = 220
function flaps_gear_limits()
    if ACF_ICAO == "A319" or ACF_ICAO == "A320" or ACF_ICAO == "A20N" then
        FLAPS_LIMIT[1] = 230
        FLAPS_LIMIT[2] = 200
        FLAPS_LIMIT[3] = 185
        FLAPS_LIMIT[4] = 177
        FLAPS_LIMIT[5] = 0
    elseif ACF_ICAO == "A321" or ACF_ICAO == "A21N" then
        FLAPS_LIMIT[1] = 238
        FLAPS_LIMIT[2] = 215
        FLAPS_LIMIT[3] = 195
        FLAPS_LIMIT[4] = 186
        FLAPS_LIMIT[5] = 0
    end
end

do_sometimes("flaps_gear_limits()")