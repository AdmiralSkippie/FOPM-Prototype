------------------
---- DATAREFS ----
------------------

--|||| GENERAL |||||--
dataref("TIME", "sim/time/total_running_time_sec", "readonly")
dataref("ENG_MODEL", "AirbusFBW/EngineTypeIndex", "readonly") -- 0 IAE/1 CFM/2 PW/3 LEAP
dataref("ACF_ICAO", "sim/aircraft/view/acf_ICAO", "readonly") -- 

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
dataref ("BRKFAN_State", "AirbusFBW/BrakeFan", "readonly")
PACK_1_PB = "toliss_airbus/aircondcommands/Pack1Toggle"
PACK_2_PB = "toliss_airbus/aircondcommands/Pack2Toggle"
APU_MASTER_PB = "toliss_airbus/apucommands/MasterToggle"
APU_START_PB = "toliss_airbus/apucommands/StarterToggle"
APU_BLEED_PB = "toliss_airbus/apucommands/BleedToggle"
TERRAIN_FO_PB = "toliss_airbus/dispcommands/TerrOnND2Toggle"
GPWS_FLAP3_PB = "toliss_airbus/gpwscommands/Flap3Toggle"
LS_FO_PB = "toliss_airbus/dispcommands/CoLSButtonPush"
HDGTRK_TOGGLE = "toliss_airbus/hdgtrk_button_push"
FD_CAP_PB = "toliss_airbus/fd1_push"
FD_FO_PB = "toliss_airbus/fd2_push"
dataref("FO_FD_STATE", "AirbusFBW/FD2Engage", "readonly")
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
--dataref("FO_QNH_PUSH", "AirbusFBW/BaroStdFO", "writable") -- FO_QNH_STD --
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
dataref("MCDU_BLINE_3", "AirbusFBW/MCDU2cont3b", "readonly") -- text line --
MCDU_FO_KEY_Perf = "AirbusFBW/MCDU2Perf"
MCDU_FO_KEY_Fpln = "AirbusFBW/MCDU2Fpln"
dataref("MCDU_GLINE_1", "AirbusFBW/MCDU2cont1g", "readonly") -- text line FLP retract to FLP1 --
dataref("MCDU_GLINE_2", "AirbusFBW/MCDU2cont2g", "readonly") -- text line SLAT retract to 0 --
dataref("MCDU_GLINE_3", "AirbusFBW/MCDU2cont3g", "readonly") -- text line Green DOT --

---- INDICATIONS ----
-- dataref("OXY_Press", "", "readonly")
dataref("Y_HYD_RESVR", "AirbusFBW/HydSysQtyArray", "readonly", 1) -- 0.8 min
dataref("G_HYD_RESVR", "AirbusFBW/HydSysQtyArray", "readonly", 0) -- 0.8 min
dataref("B_HYD_RESVR", "AirbusFBW/HydSysQtyArray", "readonly", 2) -- 0.75 min
-- dataref("ENG_1_OILQTY", "", "readonly")
-- dataref("ENG_2_OILQTY", "", "readonly")
dataref("BRK_ACCU_Press", "AirbusFBW/AccuNeedle", "readonly") -- 1 green / 0.93 min
dataref("ELEVATORS", "AirbusFBW/NormLawCmd_Elev", "readonly") -- 0 NEUTRAL/15 DOWN/-30 UP
dataref("LALERONS", "AirbusFBW/NormLawCmd_LAil", "readonly") -- 0 NTRL/-25 LEFT/25 RIGHT
dataref("RALERONS", "AirbusFBW/NormLawCmd_RAil", "readonly") -- 0 NTRL/25 LEFT/-25 RIGHT
dataref("RUDDER", "AirbusFBW/NormLawCmd_Rud", "readonly") -- 0 NTRL/-25 LEFT/25 RIGHT
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
dataref("IND_AIRSPEED", "sim/cockpit2/gauges/indicators/airspeed_kts_copilot", "readonly")
dataref("V1_SPEED", "AirbusFBW/V1Value", "readonly")
dataref("VR_SPEED", "toliss_airbus/performance/VR", "readonly")
dataref("V2_SPEED", "toliss_airbus/performance/V2", "readonly")
dataref("VERTICAL_SPEED", "toliss_airbus/pfdoutputs/captain/vertical_speed", "readonly")
dataref("ENG_ATHR_MODE", "AirbusFBW/ATHRmode", "readonly") -- ONLY SHOWS ATHR ENGAGE --
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
dataref("FMA_B_STATE", "AirbusFBW/FMA2b", "readonly")
dataref("FMA_G_STATE", "AirbusFBW/FMA1g", "readonly")
-- QNH INDICATOR --
    dataref("CM_QNH", "sim/cockpit/misc/barometer_setting", "readonly") -- convertir a qnh
    dataref("FO_QNH", "sim/cockpit/misc/barometer_setting2", "readonly") -- convertir a qnh
    dataref("ISIS_QNH", "AirbusFBW/ISIBaroSetting", "readonly")
    dataref("BARO_UNIT_CM","AirbusFBW/BaroUnitCapt", "readonly")
    dataref("BARO_UNIT_FO","AirbusFBW/BaroUnitFO", "readonly")
dataref("LBRAKE_Press", "AirbusFBW/LeftBrakeNeedle", "readonly") -- 0.7 FULL PRESS
dataref("RBRAKE_Press", "AirbusFBW/RightBrakeNeedle", "readonly")
dataref("IND_ALTITUDE", "AirbusFBW/ALTFO", "readonly")
dataref("AGL_ALTITUDE", "sim/flightmodel/position/y_agl", "readonly")
dataref("AP_DISCN_ALARM", "AirbusFBW/APWarning", "readonly") -- 1 ON --
dataref("OAT", "sim/cockpit2/temperature/outside_air_temp_degc", "readonly")
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