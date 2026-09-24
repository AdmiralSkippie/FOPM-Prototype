---------------------
-- FO/PM CHECKLIST --
---------------------

FOPM_cklst_config_name = "Avianca_2022"

FOPM_checklist = {
    Cockpit_preparation_checklist = {
        [1] = {
            item = "COCKPIT_PREPARATION_CHECKLIST",
            item_name = "COCKPIT PREPARATION",
            item_answer = ""
        },
        [2] = {
            item = "GEAR_PINS_AND_COVERS",
            item_name = "GEAR PINS & COVERS",
            item_answer = "REMOVED",
            essential = false,
            state = "REMOVED"
        },
        [3] = {
            item = "FUEL_QUANTITY",
            item_name = "FUEL QUANTITY",
            item_answer = "____KG/LB",
            essential = false,
            state = "CHECK"
        },
        [4] = {
            item = "SEAT_BELTS",
            item_name = "SEAT BELTS",
            item_answer = "ON",
            essential = false,
            state = "ON",
            check = function () return SEATBELTS_SW == 1 end
        },
        [5] = {
            item = "ADIRS",
            item_name = "ADIRS",
            item_answer = "NAV",
            essential = false,
            state = "NAV",
            check = function () return ADIR_1_STATE == 1 and ADIR_2_STATE == 1 and ADIR_3_STATE == 1 end
        },
        [6] = {
            item = "BARO_REFERENCE",
            item_name = "BARO REF",
            essential = true,
            item_answer = "____",
            state = "SET",
            check = function () return FOPM_BaroCheck() end
        },
        [7] = {
            AR_item = true,
            item = "RADIONAV_POSITION",
            item_name = "RADIONAV POSITION",
            item_answer = "DESELECTED",
            essential = false,
            state = "DESELECTED",
        },
        [8] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = "",
        },
    },
    Before_start_checklist = {
        [1] = {
            item = "BEFORE_START_CHECKLIST",
            item_name = "BEFORE START",
            item_answer = ""
        },
        [2] = {
            item = "PARKING_BRAKE",
            item_name = "PARKING BRAKE",
            item_answer = "___",
            essential = false,
            state = "SET"
        },
        [3] = {
            item = "TAKEOFF_SPEEDS_AND_THRUST",
            item_name = "T.O SPEEDS & THRUST",
            item_answer = "V1_VR_V2_THR_",
            essential = true,
            state = "CHECK"
        },
        [4] = {
            item = "WINDOWS_AND_DOORS",
            item_name = "WINDOWS & DOORS",
            item_answer = "CLOSE",
            essential = true,
            state = "CLOSE",
            check = function () return DOOR_1L == 0 and
                DOOR_1R == 0 and
                DOOR_2L == 0 and
                DOOR_2R == 0 and
                DOOR_3L == 0 and
                DOOR_3R == 0 and
                DOOR_4L == 0 and
                DOOR_4R == 0 end
        },
        [5] = {
            item = "BEACON",
            item_name = "BEACON",
            item_answer = "ON",
            essential = false,
            state = "ON",
            check = function () return BEACON_STATE == 1 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = "",
        }
    },
    After_start_checklist = {
        [1] = {
            item = "AFTER_START_CHECKLIST",
            item_name = "AFTER START",
            item_answer = ""
        },
        [2] = {
            item = "ANTI_ICE",
            item_name = "ANTI ICE",
            item_answer = "____",
            essential = false,
            state = "SET",
        },
        [3] = {
            item = "ECAM_STATUS",
            item_name = "ECAM STATUS",
            item_answer = "CHECKED",
            essential = false,
            state = "CHECK",
        },
        [4] = {
            item = "PITCHTRM",
            item_name = "PITCH TRIM",
            item_answer = "____%",
            essential = false,
            state = "SET",
            check = function () return FOPM_CONFIG_VARIABLE.PT_TO_CONFIG == math.floor(PITCH_TRIM * 10) / 10 end
        },
        [5] = {
            item = "RUDDER_TRIM",
            item_name = "RUDDER TRIM",
            item_answer = "NEUTRAL",
            essential = false,
            state = "NEUTRAL",
            check = function () return RUDDER_TRIM_POS < 0.2 and RUDDER_TRIM_POS > -0.2 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = "",
        }
    },
    Taxi_checklist = {
        [1] = {
            item = "TAXI_CHECKLIST",
            item_name = "TAXI",
            item_answer = "",
        },
        [2] = {
            int_item = "OETD CHECK",
            item_name = "TAXI",
            item_answer = "",
            step_desition = true,
            check = function () return FOPM_Procedures_Control.ONEENG_TAXI_DEP end
        },
        [3] = {
            item = "FLIGHT_CONTROLS",
            item_name = "FLIGHT CONTROLS",
            item_answer = "CHECKED",
            essential = true,
            state = "CHECK",
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end
        },
        [4] = {
            item = "FLAPS_SETTING",
            item_name = "FLAPS SETTING",
            item_answer = "CONF____",
            essential = true,
            state = "FLAPS"
        },
        [5] = {
            item = "RADAR_AND_PRED_WS",
            item_name = "RADAR & PRED W/S",
            item_answer = "ON & AUTO",
            essential = false,
            state = "ON_AUTO",
            check = function () return (RADAR_SYS_SW == 0 or RADAR_SYS_SW == 2) and PWS_SW == 2 end
        },
        [6] = {
            item = "ENGINE_MODE_SELECTOR",
            item_name = "ENG MODE SEL",
            item_answer = "____",
            essential = false,
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end,
        },
        [7] = {
            state = "IGNITION",
            item_name = "ENG MODE SEL",
            item_answer = "IGNITION",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 2 end,
        },
        [8] = {
            state = "NORMAL",
            item_name = "ENG MODE SEL",
            item_answer = "NORMAL",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 1 end,
        },
        [9] = {
            item = "ECAM_MEMO",
            item_name = "ECAM MEMO",
            item_answer = "TO NO BLUE",
            essential = false,
            state = "TAKEOFF_NO_BLUE",
        },
        [10] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = "",
        }
    },
    Departure_change_checklist = {
        [1] = {
            item = "DEPARTURE_CHANGE_CHECKLIST",
            item_name = "DEPARTURE CHANGE",
            item_answer = ""
        },
        [2] =  {
            item = "RUNWAY_AND_SID",
            item_name = "RWY & SID",
            item_answer = "____",
            essential = false,
            state = "CHECK"
        },
        [3] = {
            item = "FLAPS_SETTING",
            item_name = "FLAPS SETTING",
            item_answer = "CONF____",
            essential = true,
            state = "FLAPS"
        },
        [4] = {
            item = "TAKEOFF_SPEEDS_AND_THRUST",
            item_name = "T.O SPEEDS & THRUST",
            item_answer = "V1_VR_V2_THR_",
            essential = true,
            state = "CHECK"
        },
        [5] = {
            item = "FCU_ALTITUDE",
            item_name = "FCU ALT",
            item_answer = "____",
            essential = false,
            state = "CHECK"
        },
        [6] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = ""
        }
    },
    Lineup_checklist = {
        [1] = {
            item = "LINEUP_CHECKLIST",
            item_name = "LINEUP",
            item_answer = ""
        },
        [2] = {
            item = "TAKEOFF_RUNWAY",
            item_name = "T.O RWY",
            item_answer = "____",
            essential = true,
            state = "CONFIRM"
        },
        [3] = {
            item = "TCAS",
            item_name = "TCAS",
            item_answer = "TA/RA",
            essential = false,
            state = "TA_RA",
            check = function () return TCAS_SW == 4 end
        },
        [4] = {
            item = "PACKS",
            item_name = "PACKS",
            item_answer = "____",
            essential = false,
            step_desition = true,
            check = {
                [1] = function () return FOPM_CONFIG_VARIABLE.PACKS_FOR_TO end,
                [2] = function () return FOPM_CONFIG_VARIABLE.APU_TO_PACKS end
            }
        },
        [5] = {
            state = "ON",
            item_name = "PACKS",
            item_answer = "ON",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 0 end,
        },
        [6] = {
            state = "ON",
            item_name = "PACKS",
            item_answer = "ON",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 1 end,
        },
        [7] = {
            state = "OFF",
            item_name = "PACKS",
            item_answer = "OFF",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 0 and PACK_2_STATE == 0 and APU_BLEED_STATE == 0 end,
        },
        [8] = {
            AR_item = true,
            item = "GPS_NAV_MODE",
            item_name = "GPS NAV MODE",
            item_answer = "BOTH IN NAV",
            essential = false,
            state = "BOTH_NAV",
        },
        [9] = {
            AR_item = true,
            item = "NAV_ON_FMA",
            item_name = "NAV ON FMA",
            item_answer = "CHECKED",
            essential = false,
            state = "CHECK",
            check = function () return string.find(FMA_B_STATE, "NAV") end
        },
        [10] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = ""
        }
    },
    Approach_checklist = { 
        [1] = {
            item = "APPROACH_CHECKLIST",
            item_name = "APPROACH",
            item_answer = ""
        },
        [2] = {
            item = "BARO_REFERENCE",
            item_name = "BARO REF",
            item_answer = "____",
            essential = true,
            state = "SET",
            check = function () return FOPM_BaroCheck() end
        },
        [3] = {
            item = "SEAT_BELTS",
            item_name = "SEAT BELTS",
            item_answer = "ON",
            essential = false,
            state = "ON",
            check = function () return SEATBELTS_SW == 1 end
        },
        [4] = {
            item = "MINIMUMS",
            item_name = "MINIMUMS",
            item_answer = "____",
            essential = false,
            state = "SET"
        },
        [5] = {
            item = "AUTOBRAKES",
            item_name = "AUTO BRAKE",
            item_answer = "____",
            essential = false,
            step_desition = true,
            check = {
                [1] = function () return FOPM_CONFIG_VARIABLE.AUTOBRAKES.LOW end,
                [2] = function () return FOPM_CONFIG_VARIABLE.AUTOBRAKES.MEDIUM end
            }
        },
        [6] = {
            state = "LOW",
            item_name = "AUTO BRAKE",
            item_answer = "LOW",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return AUTOBRK_LOW == 1 end
        },
        [7] = {
            state = "MEDIUM",
            item_name = "AUTO BRAKE",
            item_answer = "MED",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return AUTOBRK_MED == 1 end
        },
        [8] = {
            item = "ENGINE_MODE_SELECTOR",
            item_name = "ENG MODE SEL",
            item_answer = "____",
            essential = false,
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end,
        },
        [9] = {
            state = "IGNITION",
            item_name = "ENG MODE SEL",
            item_answer = "IGNITION",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 2 end,
        },
        [10] = {
            state = "NORMAL",
            item_name = "ENG MODE SEL",
            item_answer = "NORMAL",
            essential = false,
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 1 end,
        },
        [11] = {
            AR_item = true,
            item = "RADIONAV_POSITION",
            item_name = "RADIO NAV POSITION",
            item_answer = "DESELECTED",
            essential = false,
            state = "DESELECTED",
        },
        [12] = {
            AR_item = true,
            item = "GPS_NAV_MODE",
            item_name = "GPS NAV MODE",
            item_answer = "BOTH IN NAV",
            essential = false,
            state = "BOTH_NAV",
        },
        [13] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = ""
        },
    },
    Landing_checklist = {
        [1] = {
            item = "LANDING_CHECKLIST",
            item_name = "LANDING",
            item_answer = ""
        },
        [2] = {
            item = "ECAM_MEMO",
            item_name = "ECAM MEMO",
            item_answer = "LDG NO BLUE",
            essential = false,
            state = "CHECK",
        },
        [3] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = ""
        }
    },
    After_landing_checklist = {
        [1] = {
            item = "AFTER_LANDING_CHECKLIST",
            item_name = "AFTER LANDING",
            item_answer = ""
        },
        [2] = {
            item = "RADAR_AND_PRED_WS",
            item_name = "RADAR & PRED W/S",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
            check = function () return RADAR_SYS_SW == 1 and PWS_SW == 0 end
        },
        [3] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = ""
        },
    },
    Parking_checklist = {
        [1] = {
            item = "PARKING_CHECKLIST",
            item_name = "PARKING",
            item_answer = ""
        },
        [2] = {
            item = "PARKING_BRAKE_OR_CHOCKS",
            item_name = "PARK BRK OR CHOCKS",
            item_answer = "SET",
            essential = false,
            state = "SET"
        },
        [3] = {
            item = "ENGINES",
            item_name = "ENGINES",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
            check = function () return ENG_1_Master == 0 and ENG_2_Master == 0 end
        },
        [4] = {
            item = "WING_LIGHTS",
            item_name = "WING LIGHTS",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
            check = function () return WINGLT_SW == 0 end
        },
        [5] = {
            item = "FUEL_PUMPS",
            item_name = "FUEL PUMPS",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
            check = function () return FPUMP_RTANK_1_STATE == 0 and
                   FPUMP_RTANK_2_STATE == 0 and
                   FPUMP_CTANK_1_STATE == 0 and
                   FPUMP_CTANK_2_STATE == 0 and
                   FPUMP_LTANK_1_STATE == 0 and
                   FPUMP_LTANK_2_STATE == 0 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = ""
        }
    },
    Securing_checklist = {
        [1] = {
            item = "SECURING_CHECKLIST",
            item_name = "SECURING THE AIRCRAFT",
            item_answer = ""
        },
        [2] = {
            item = "OXYGEN",
            item_name = "OXYGEN",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
        },
        [3] = {
            item = "EMERGENCY_EXIT_LIGHTS",
            item_name = "EMER EXIT LT",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
        },
        [4] = {
            item = "EFB",
            item_name = "EFBs",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
        },
        [5] = {
            item = "BATTERIES",
            item_name = "BATTERIES",
            item_answer = "OFF",
            essential = false,
            state = "OFF",
            check = function () return BAT_1_State == 0 and BAT_2_State == 0 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED",
            item_name = "CHECKLIST COMPLETED",
            item_answer = ""
        }
    },
}