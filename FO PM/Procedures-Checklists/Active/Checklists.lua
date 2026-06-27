---------------------
-- FO/PM CHECKLIST --
---------------------

FOPM_cklst_config_name = "Avianca 2021"

FOPM_checklist = {
    Before_start_checklist_DTL = {
        [1] = {
            item = "BEFORE_START_CHECKLIST",
        },
        [2] = {
            item = "EFB_PREPARATION",
            state = "COMPLETED"
        },
        [3] = {
            item = "AIRCRAFT_PBN_CAPABILITY",
            state = "CHECK"
        },
        [4] = {
            item = "COCKPIT_PREPARATION",
            state = "COMPLETED",
            check = function () return FOPM_TL_COMPLETED_PROC.PF_DONE end
        },
        [5] = {
            item = "NAVAIDS_DESELECTION",
            state = "CHECK",
            AR_item = true
        },
        [6] = {
            item = "GEAR_PINS_AND_COVERS",
            state = "REMOVED"
        },
        [7] = {
            item = "SIGNS",
            state = "ON_AUTO",
            check = function () return SEATBELTS_SW == 1 and SIGNS_STATE == 1 end
        },
        [8] = {
            item = "ADIRS",
            state = "NAV",
            check = function () return ADIR_1_STATE == 1 and ADIR_2_STATE == 1 and ADIR_3_STATE == 1 end
        },
        [9] = {
            item = "FUEL_QUANTITY",
            state = "CHECK"
        },
        [10] = {
            item = "BARO_REFERENCE",
            state = "SET",
            check = function () return CM_QNH == FO_QNH end
        },
        [11] = {
            item = "DOWN_TO_THE_LINE",
        },
    },
    Before_start_checklist_BTL = {
        [1] = {
            item = "BEFORE_START_CHECKLIST_BELOW_THE_LINE"
        },
        [2] = {
            item = "EFB",
            state = "SET"
        },
        [3] = {
            item = "ATC",
            state = "SET",
            check = function () return TCAS_SW == 2 end
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
            item = "THRUST_LEVERS",
            state = "IDLE",
        },
        [7] = {
            item = "PARKING_BRAKE",
            state = "SET",
        },
        [8] = {
            item = "CHECKLIST_COMPLETED"
        },
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
            state = "N0",
            check = function () return RUDDER_TRIM_POS < 0.2 and RUDDER_TRIM_POS > -0.2 end
        },
        [6] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Before_takeoff_checklist_DTL = {
        [1] = {
            item = "BEFORE_TAKEOFF_CHECKLIST"
        },
        [2] = {
            item = "FLIGHT_CONTROLS",
            state = "CHECK",
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end
        },
        [3] = {
            item = "FLY_INSTRUMENTS",
            state = "CHECK",
        },
        [4] = {
            item = "BRIEFING",
            state = "COMPLETED",
            check = function () return FOPM_TL_COMPLETED_PROC.TO_BRIEFING end
        },
        [5] = {
            item = "FLAPS",
            state = "FLAPS",
        },
        [6] = {
            item = "V1_VR_V2_FLEX_TEMP",
            state = "CHECK",
        },
        [7] = {
            item = "ECAM_MEMO",
            state = "TAKEOFF_NO_BLUE",
        },
        [8] = {
            item = "DOWN_TO_THE_LINE"
        }
    },
    Before_takeoff_checklist_BTL = {
        [1] = {
            item = "BEFORE_TAKEOFF_CHECKLIST_BELOW_THE_LINE"
        },
        [2] = {
            item = "TAKEOFF_RUNWAY",
            state = "CONFIRM"
        },
        [3] = {
            item = "NAV_ON_FMA",
            state = "CHECK",
            check = function () return string.find(FMA_B_STATE, "NAV") end
        },
        [4] = {
            item = "CABIN_CREW",
            state = "ADVISED",
        },
        [5] = {
            item = "TCAS",
            state = "TA_RA",
            check = function () return TCAS_SW == 4 end
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
            item = "PACKS_AND_APU_BLEED",
            step_desition = true,
            check = {
                [1] = function () return FOPM_CONFIG_VARIABLE.PACKS_FOR_TO end,
                [2] = function () return FOPM_CONFIG_VARIABLE.APU_TO_PACKS end
            }
        },
        [10] = {
            state = "CHECK",
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 0 end,
        },
        [11] = {
            state = "CHECK",
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 1 and PACK_2_STATE == 1 and APU_BLEED_STATE == 1 end,
        },
        [12] = {
            state = "CHECK",
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 0 and PACK_2_STATE == 0 and APU_BLEED_STATE == 0 end,
        },
        [13] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    After_takeoff_checklist = {
        [1] = {
            item = "AFTER_TAKEOFF_CHECKLIST"
        },
        [2] = {
            item = "LANDING_GEAR",
            state = "UP",
            check = function () return LG_Lever == 0 end
        },
        [3] = {
            item = "FLAPS",
            state = "RETRACTED",
            check = function () return FLAPS_LEVER_State == 0 end
        },
        [4] = {
            item = "PACKS",
            state = "ON",
            check = function () return PACK_1_STATE == 1 and PACK_2_STATE == 1 end
        },
        [5] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Climb_checklist = {
        [1] = {
            item = "CLIMB_CHECKLIST"
        },
        [2] = {
            item = "BARO_REFERENCE",
            state = "SET",
        },
        [3] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Approach_checklist = {
        [1] = {
            item = "APPROACH_CHECKLIST"
        },
        [2] = {
            AR_item = true,
            item = "NAVAIDS_DESELECTION",
            state = "CHECK",
        },
        [3] = {
            AR_item = true,
            item = "GPS_NAV_MODE",
            state = "BOTH_NAV",
        },
        [4] = {
            item = "BRIEFING",
            state = "COMPLETED",
            check = function () return FOPM_TL_COMPLETED_PROC.DES_BRIEFING end
        },
        [5] = {
            item = "ECAM_STATUS",
            state = "CHECK",
        },
        [6] = {
            CAT_item = true,
            item = "SIGNS",
            state = "ON_ON",
            check = function () return SEATBELTS_SW == 1 and SIGNS_STATE == 2 end
        },
        [7] = {
            item = "BARO_REFERENCE",
            state = "SET",
        },
        [8] = {
            item = "MINIMUMS",
            state = "SET",
        },
        [9] = {
            item = "ENGINE_MODE_SELECTOR",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end,
        },
        [10] = {
            state = "IGNITION",
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 2 end,
        },
        [11] = {
            state = "NORMAL",
            step_desition = true,
            to_step_desition = true,
            check = function () return ENG_Mode == 1 end,
        },
        [12] = {
            item = "CHECKLIST_COMPLETED"
        },
    },
    Landing_checklist = {
        [1] = {
            item = "LANDING_CHECKLIST"
        },
        [2] = {
            item = "CABIN_CREW",
            state = "ADVISED",
        },
        [3] = {
            item = "AUTO_TRHUST",
            step_desition = true,
            check = function () return ENG_ATHR_MODE == 1 end,
        },
        [4] = {
            state = "MANAGE_SPEED",
            step_desition = true,
            to_step_desition = true,
        },
        [5] = {
            state = "SELECTED_SPEED",
            step_desition = true,
            to_step_desition = true,
        },
        [6] = {
            item = "AUTOBRAKES",
            step_desition = true,
            check = {
                [1] = function () return AUTOBRK_LOW == 1 end,
                [2] = function () return AUTOBRK_MED == 1 end
            }
        },
        [7] = {
            state = "LOW",
            step_desition = true,
            to_step_desition = true,
        },
        [8] = {
            state = "MEDIUM",
            step_desition = true,
            to_step_desition = true,
        },
        [9] = {
            item = "ECAM_MEMO",
            state = "CHECK",
        },
        [10] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    After_landing_checklist = {
        [1] = {
            item = "AFTER_LANDING_CHECKLIST"
        },
        [2] = {
            item = "FLAPS",
            state = "FLAPS",
        },
        [3] = {
            item = "SPOILERS",
            state = "DISARMED",
            check = function () return SPDBRK_Lever == 0 end
        },
        [4] = {
            item = "APU",
            step_desition = true,
            check = function () return APU_STATE == 1 end,
        },
        [5] = {
            state = "AVAIL",
            step_desition = true,
            to_step_desition = true,
        },
        [6] = {
            state = "STARTING_APU",
            step_desition = true,
            to_step_desition = true,
        },
        [7] = {
            item = "WEATHER_RADAR",
            state = "OFF",
            check = function () return RADAR_SYS_SW == 1 end
        },
        [8] = {
            item = "PWS",
            state = "OFF",
            check = function () return PWS_SW == 0 end
        },
        [9] = {
            item = "CHECKLIST_COMPLETED"
        },
    },
    Parking_checklist = {
        [1] = {
            item = "PARKING_CHECKLIST"
        },
        [2] = {
            item = "APU_BLEED",
            state = "ON",
            check = function () return APU_BLEED_STATE == 1 end
        },
        [3] = {
            item = "ENGINES",
            state = "OFF",
            check = function () return ENG_1_Master == 0 and ENG_2_Master == 0 end
        },
        [4] = {
            item = "SEAT_BELTS",
            state = "OFF",
            check = function () return SEATBELTS_SW == 0 end
        },
        [5] = {
            item = "EXTERIOR_LIGHTS",
            state = "SET",
        },
        [6] = {
            item = "FUEL_PUMPS",
            state = "OFF",
            check = function () return FPUMP_RTANK_1_STATE == 0 and
                   FPUMP_RTANK_2_STATE == 0 and
                   FPUMP_CTANK_1_STATE == 0 and
                   FPUMP_CTANK_2_STATE == 0 and
                   FPUMP_LTANK_1_STATE == 0 and
                   FPUMP_LTANK_2_STATE == 0 end
        },
        [7] = {
            item = "PARKING_BRAKE",
            state = "SET",
        },
        [8] = {
            item = "EFB",
            state = "SET",
        },
        [9] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
    Securing_checklist = {
        [1] = {
            item = "SECURING_CHECKLIST"
        },
        [2] = {
            item = "ADIRS",
            state = "OFF",
            check = function () return ADIR_1_STATE == 0 and ADIR_2_STATE == 0 and ADIR_3_STATE == 0 end
        },
        [3] = {
            item = "OXYGEN",
            state = "OFF",
        },
        [4] = {
            item = "APU_BLEED",
            state = "OFF",
            check = function () return APU_BLEED_STATE == 0 end
        },
        [5] = {
            item = "EMERGENCY_EXIT_LIGHTS",
            state = "OFF",
        },
        [6] = {
            item = "NO_PORTABLE_SIGNS",
            state = "OFF",
        },
        [7] = {
            item = "APU_AND_BATTERY",
            state = "OFF",
        },
        [8] = {
            item = "EFB",
            state = "OFF",
        },
        [9] = {
            item = "CHECKLIST_COMPLETED"
        }
    },
}