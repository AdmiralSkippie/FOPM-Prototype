---------------------
-- FO/PM CHECKLIST --
---------------------

FOPM_cklst_config_name = "Avianca 2022"

FOPM_checklist = {
    Cockpit_preparation_checklist = {
        [1] = {
            item = "COCKPIT_PREPARATION_CHECKLIST",
        },
        [2] = {
            item = "GEAR_PINS_AND_COVERS",
            state = "REMOVED"
        },
        [3] = {
            item = "FUEL_QUANTITY",
            state = "CHECK"
        },
        [4] = {
            item = "SEAT_BELTS",
            state = "ON",
            check = function () return SEATBELTS_SW == 1 end
        },
        [5] = {
            item = "ADIRS",
            state = "NAV",
            check = function () return ADIR_1_STATE == 1 and ADIR_2_STATE == 1 and ADIR_3_STATE == 1 end
        },
        [6] = {
            item = "BARO_REFERENCE",
            state = "SET",
            check = function () return CM_QNH == FO_QNH end
        },
        [7] = {
            AR_item = true,
            item = "RADIONAV_POSITION",
            state = "DESELECTED",
        },
        [8] = {
            item = "CHECKLIST_COMPLETED",
        },
    },
    Before_start_checklist = {
        [1] = {
            item = "BEFORE_START_CHECKLIST",
        },
        [2] = {
            item = "PARKING_BRAKE",
            state = "SET"
        },
        [3] = {
            item = "TAKEOFF_SPEEDS_AND_THRUST",
            state = "CHECK"
        },
        [4] = {
            item = "WINDOWS_AND_DOORS",
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
            state = "ON",
            check = function () return BEACON_STATE == 1 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    After_start_checklist = {
        [1] = {
            item = "AFTER_START_CHECKLIST"
        },
        [2] = {
            item = "ANTI_ICE",
            state = "SET",
        },
        [3] = {
            item = "ECAM_STATUS",
            state = "CHECK",
        },
        [4] = {
            item = "PITCHTRM",
            state = "SET",
            check = function () return FOPM_CONFIG_VARIABLE.PT_TO_CONFIG == math.floor(PITCH_TRIM * 10) / 10 end
        },
        [5] = {
            item = "RUDDER_TRIM",
            state = "NEUTRAL",
            check = function () return RUDDER_TRIM_POS < 0.2 and RUDDER_TRIM_POS > -0.2 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Taxi_checklist = {
        [1] = {
            item = "TAXI_CHECKLIST"
        },
        [2] = {
            int_item = "OETD CHECK",
            step_desition = true,
            check = function () return FOPM_Procedures_Control.ONEENG_TAXI_DEP end
        },
        [3] = {
            item = "FLIGHT_CONTROLS",
            state = "CHECK",
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end
        },
        [4] = {
            item = "FLAPS_SETTING",
            state = "FLAPS"
        },
        [5] = {
            item = "RADAR_AND_PRED_WS",
            state = "ON_AUTO",
            check = function () return (RADAR_SYS_SW == 0 or RADAR_SYS_SW == 2) and PWS_SW == 2 end
        },
        [6] = {
            item = "ENGINE_MODE_SELECTOR",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end,
        },
        [7] = {
            state = "IGNITION",
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 2 end,
        },
        [8] = {
            state = "NORMAL",
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 1 end,
        },
        [9] = {
            item = "ECAM_MEMO",
            state = "TAKEOFF_NO_BLUE",
        },
        [10] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Departure_change_checklist = {
        [1] = {
            item = "DEPARTURE_CHANGE_CHECKLIST"
        },
        [2] =  {
            item = "RUNWAY_AND_SID",
            state = "CHECK"
        },
        [3] = {
            item = "FLAPS_SETTING",
            state = "FLAPS"
        },
        [4] = {
            item = "TAKEOFF_SPEEDS_AND_THRUST",
            state = "CHECK"
        },
        [5] = {
            item = "FCU_ALTITUDE",
            state = "CHECK"
        },
        [6] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Lineup_checklist = {
        [1] = {
            item = "LINEUP_CHECKLIST"
        },
        [2] = {
            item = "TAKEOFF_RUNWAY",
            state = "CONFIRM"
        },
        [3] = {
            item = "TCAS",
            state = "TA_RA",
            check = function () return TCAS_SW == 4 end
        },
        [4] = {
            item = "PACKS",
            step_desition = true,
            check = {
                [1] = function () return FOPM_CONFIG_VARIABLE.PACKS_FOR_TO end,
                [2] = function () return FOPM_CONFIG_VARIABLE.APU_TO_PACKS end
            }
        },
        [5] = {
            state = "CHECK",
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 0 end,
        },
        [6] = {
            state = "CHECK",
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 1 end,
        },
        [7] = {
            state = "CHECK",
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 0 and PACK_2_STATE == 0 and APU_BLEED_STATE == 0 end,
        },
        [8] = {
            AR_item = true,
            item = "GPS_NAV_MODE",
            state = "BOTH_NAV",
        },
        [9] = {
            AR_item = true,
            item = "NAV_ON_FMA",
            state = "CHECK",
            check = function () return string.find(FMA_B_STATE, "NAV") end
        },
        [10] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Approach_checklist = {
        [1] = {
            item = "APPROACH_CHECKLIST"
        },
        [2] = {
            item = "BARO_REFERENCE",
            state = "SET"
        },
        [3] = {
            item = "SEAT_BELTS",
            state = "ON",
            check = function () return SEATBELTS_SW == 1 end
        },
        [4] = {
            item = "MINIMUMS",
            state = "SET"
        },
        [5] = {
            item = "AUTOBRAKES",
            step_desition = true,
            check = {
                [1] = function () return FOPM_CONFIG_VARIABLE.AUTOBRAKES.LOW end,
                [2] = function () return FOPM_CONFIG_VARIABLE.AUTOBRAKES.MEDIUM end
            }
        },
        [6] = {
            state = "LOW",
            step_desition = true,
            to_step_desition = true,
            check = function () return AUTOBRK_LOW == 1 end
        },
        [7] = {
            state = "MEDIUM",
            step_desition = true,
            to_step_desition = true,
            check = function () return AUTOBRK_MED == 1 end
        },
        [8] = {
            item = "ENGINE_MODE_SELECTOR",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end,
        },
        [9] = {
            state = "IGNITION",
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 2 end,
        },
        [10] = {
            state = "NORMAL",
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 1 end,
        },
        [11] = {
            AR_item = true,
            item = "RADIONAV_POSITION",
            state = "DESELECTED",
        },
        [12] = {
            AR_item = true,
            item = "GPS_NAV_MODE",
            state = "BOTH_NAV",
        },
        [13] = {
            item = "CHECKLIST_COMPLETED"
        },
    },
    Landing_checklist = {
        [1] = {
            item = "LANDING_CHECKLIST"
        },
        [2] = {
            item = "ECAM_MEMO",
            state = "CHECK",
        },
        [3] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    After_landing_checklist = {
        [1] = {
            item = "AFTER_LANDING_CHECKLIST"
        },
        [2] = {
            item = "RADAR_AND_PRED_WS",
            state = "OFF",
            check = function () return RADAR_SYS_SW == 1 and PWS_SW == 0 end
        },
        [3] = {
            item = "CHECKLIST_COMPLETED"
        },
    },
    Parking_checklist = {
        [1] = {
            item = "PARKING_CHECKLIST"
        },
        [2] = {
            item = "PARKING_BRAKE_OR_CHOCKS",
            state = "SET"
        },
        [3] = {
            item = "ENGINES",
            state = "OFF",
            check = function () return ENG_1_Master == 0 and ENG_2_Master == 0 end
        },
        [4] = {
            item = "WING_LIGHTS",
            state = "OFF",
            check = function () return WINGLT_SW == 0 end
        },
        [5] = {
            item = "FUEL_PUMPS",
            state = "OFF",
            check = function () return FPUMP_RTANK_1_STATE == 0 and
                   FPUMP_RTANK_2_STATE == 0 and
                   FPUMP_CTANK_1_STATE == 0 and
                   FPUMP_CTANK_2_STATE == 0 and
                   FPUMP_LTANK_1_STATE == 0 and
                   FPUMP_LTANK_2_STATE == 0 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Securing_checklist = {
        [1] = {
            item = "SECURING_CHECKLIST"
        },
        [2] = {
            item = "OXYGEN",
            state = "OFF",
        },
        [3] = {
            item = "EMERGENCY_EXIT_LIGHTS",
            state = "OFF",
        },
        [4] = {
            item = "EFB",
            state = "OFF",
        },
        [5] = {
            item = "BATTERIES",
            state = "OFF",
            check = function () return BAT_1_State == 0 and BAT_2_State == 0 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
}