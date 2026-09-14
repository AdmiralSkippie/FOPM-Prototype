----------------------
-- FO/PM PROCEDURES --
----------------------

-- EVERY PROCEDURE IS A LIST OF STEPS THE PROCEDURE ENGINE RUNS IN ORDER. FIELDS OF A STEP:
--   item                VOICE SAID WHEN THE STEP STARTS (A KEY OF THE VOICE PACK). IF THE
--                       STEP WAITS ON A check, IT IS SAID AGAIN EVERY 10 s
--   int_item            SILENT NAME, ONLY TO TELL THE STEP APART (A SHORT PAUSE, NO VOICE)
--   state               VOICE SAID WHEN THE STEP IS DONE ("FLAPS" SAYS THE FLAPS POSITION)
--   essential           SAID EVEN WITH SPEAK ONLY ESSENTIALS
--   condition           function, THE STEP IS SKIPPED WHILE IT RETURNS false
--   check               function, THE STEP WAITS UNTIL IT RETURNS true
--   action              DONE ONCE WHEN THE STEP ENDS
--   action_check        DONE WHILE check IS false, THEN check IS ASKED AGAIN
--   action_pre_check    DONE WHEN THE STEP STARTS
--                       AN ACTION CAN HOLD dataref = VALUE (WRITTEN TO dataref_name),
--                       command = CMD, run = function, delay = SECONDS TO WAIT AFTER IT.
--                       command AND dataref_name ALSO TAKE A LIST: {CMD_A, CMD_B}
--   dataref_name        NAME OF THE DATAREF VARIABLE, OR A LIST OF NAMES
--   step_desition       DECISION STEP, ITS LOGIC IS A HANDLER OF THE PROCEDURE (FO-PM.lua)
--   to_step_desition    BRANCH OF A DECISION, SKIPPED IF ANOTHER BRANCH OF IT ALREADY RAN
--   recovery_step       (ONE ENGINE TAXI DEP) STEP TO RESUME FROM IF RECOVERED HERE
-- A NEW PROCEDURE ALSO NEEDS ITS ENTRY IN FOPM_PROC_CFG (FO-PM.lua) AND SOMETHING TO START IT.

FOPM_proc_config_name = "Avianca 2022"

FOPM_procedure = {
    Pre_cockpit_preparation = {
        [1] = {
            item = "ENGINE_MASTERS",
            state = "OFF",
            check = function () return ENG_1_Master == 0 and ENG_2_Master == 0 end
        },
        [2] = {
            item = "ENGINE_MODE_SELECTOR",
            state = "NORMAL",
            check = function () return ENG_Mode == 1 end
        },
        [3] = {
            item = "WEATHER_RADAR",
            state = "OFF",
            check = function () return RADAR_SYS_SW == 1 end
        },
        [4] = {
            item = "LANDING_GEAR",
            state = "DOWN",
            check = function () return LG_Lever == 1 end,
        },
        [5] = {
            item = "WIPERS",
            state = "OFF",
            check = function () return LWipers_Mode == 0 and RWipers_Mode == 0 end,
        },
        [6] = {
            item = "BATTERIES",
            state = "ON",
            check = function () return BAT_1_State == 1 and BAT_2_State == 1 end,
        },
        [7] = {
            int_item = "EXTERNAL_CHECK",
            step_desition = true,
            check = function () return EXTPWR_State ~= 0 end,
        },
        [8] = {
            item = "EXTERNAL_POWER",
            state = "ON",
            step_desition = true,
            to_step_desition = true,
            check = function () return EXTPWR_State == 1 end,
        },
        [9] = {
            item = "APU",
            state = "AVAIL",
            step_desition = true,
            to_step_desition = true,
            check = function () return APU_STATE == 1 end,
        },
        [10] = {
            item = "ECAM_RCLL",
            state = "NORMAL",
            action_pre_check = {command = ECAM_Recall_PB}
        },
        [11] = {
            item = "SYSTEMS_CHECK",
        },
        [12] = {
            item = "OXYGEN",
            state = "CHECK",
            action_pre_check = {command = ECAM_DOOR_PB}
        },
        [13] = {
            item = "HYDRAULICS",
            state = "CHECK",
            action_pre_check = {command = ECAM_HYD_PB},
            check = function () return Y_HYD_RESVR >= 0.8 and G_HYD_RESVR >= 0.8 and B_HYD_RESVR >= 0.75 end,
        },
        [14] = {
            item = "OIL_QUANTITY",
            state = "CHECK",
            action_pre_check = {command = ECAM_ENG_PB},
        },
        [15] = {
            int_item = "ECAM_RESET",
            action = {command = ECAM_ENG_PB},
        },
        [16] = {
            item = "FLAPS",
            state = "CHECK", -- REVISAR CON LA CONFIGURACION
            check = function () return FLAPS_LEVER_State <= 0.25 end,
        },
        [17] = {
            item = "SPEED_BRAKE",
            state = "RETRACT_AND_DISARM",
            check = function () return SPDBRK_Lever == 0 end,
        },
        [18] = {
            item = "PARKING_BRAKE",
            state = "ON",
            check = function () return PRKBRK_SW == 1 end,
            action_check = {dataref = 1},
            dataref_name = "PRKBRK_SW",
        },
        [19] = {
            item = "BRAKE_ACCUMULATOR",
            state = "CHECK",
            check = function () return BRK_ACCU_Press >= 0.9 end,
        },
        [20] = {
            item = "ALTERNATE_BRAKES",
            state = "CHECK",
            check = function () return LBRAKE_Press > 0.65 and RBRAKE_Press > 0.65 end,
        },
        [21] = {
            int_item = "FO FD",
            check = function () return FO_FD_STATE == 1 end,
            action_check = {command = FD_FO_PB}
        },
        [22] = {
            int_item = "FO CSTR",
            check = function () return FO_CSTR_STATE == 1 end,
            action_check = {command = FO_ND_CSTR_PB}
        },
    },
    After_start_procedure = {
        [1] = {
            item = "GROUND_SPOILERS",
            state = "ARM",
            action = {dataref = -0.5},
            dataref_name = "SPDBRK_Lever"
        },
        [2] = {
            item = "RUDDER_TRIM",
            state = "N0",
            action = {command = RUDDER_TRIM_RESET},
        },
        [3] = {
            item = "FLAPS",
            state = "CHECK",
            action_check = {command = FLAPS_1DOWN},
            check = function () return ((math.floor(FLAPS_LEVER_State * 100)/100) * 4) == FLAPS_TO_CONFIG end
        },
        [4] = {
            item = "PITCHTRM",
            action_pre_check = {command = MCDU_FO_KEY_Perf},
        },
        [5] = {
            int_item = "TRIM_CHECK",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION == "UP" end
        },
        [6] = {
            int_item = "TRIM_STOP",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.PT_TO_CONFIG == math.floor(PITCH_TRIM * 10) / 10 end
        },
        [7] = {
            state = "SET"
        },
        [8] = {
            item = "ECAM_STATUS",
            state = "CHECK"
        },
        [9] = {
            int_item = "FLAPS",
            essential = true,
            state = "CHECK",
            check = function () return FLAPS_State == -1 end
        },
        [10] = {
            int_item = "OETD CHECK",
            step_desition = true,
            check = function () return FOPM_Procedures_Control.ONEENG_TAXI_DEP end
        },
    },
    Taxi_procedure = {
        [1] = {
            int_item = "OETD CHECK",
            step_desition = true,
            check = function () return FOPM_Procedures_Control.ONEENG_TAXI_DEP end
        },
        [2] = {
            int_item = "FLTCTLCHK",
            step_desition = true,
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end,
        },
        [3] = {
            item = "WEATHER_RADAR",
            step_desition = true,
            check = function () return radar_pos == 1 end
        },
        [4] = {
            state = "ON",
            step_desition = true,
            to_step_desition = true,
            action = {dataref = 0},
            dataref_name = "RADAR_SYS_SW"
        },
        [5] = {
            state = "ON",
            step_desition = true,
            to_step_desition = true,
            action = {dataref = 2},
            dataref_name = "RADAR_SYS_SW"
        },
        [6] = {
            item = "PWS",
            state = "AUTO",
            action = {dataref = 2},
            dataref_name = "PWS_SW"
        },
        [7] = {
            item = "TERRAIN",
            state = "ON",
            action = {command = TERRAIN_FO_PB},
        },
        [8] = {
            int_item = "ON_OETD",
            step_desition = true,
            check = function() return not FOPM_Procedures_Control.EXECUTE_OETD end,
        },
        [9] = {
            item = "AUTOBRAKES",
            state = "MAX",
            check = function() return AUTOBRK_MAX == 1 end,
            action_check = {command = AUTOBRK_MAX_PB},
        },
        [10] = {
            int_item = "TO_CONFIG",
            action = {command = TO_CONFIG_PB},
        },
    },
    Before_takeoff_proc = {
        [1] = {
            item = "BRAKE_TEMP",
            step_desition = true,
            check = function () return BRAKE1_TEMP > 150 and BRAKE2_TEMP > 150 and BRAKE3_TEMP > 150 and BRAKE4_TEMP > 150 end
        },
        [2] = {
            int_item = "TEMP_CHECK",
            step_desition = true,
            check = function() return BRAKE1_TEMP < 150 and BRAKE2_TEMP < 150 and BRAKE3_TEMP < 150 and BRAKE4_TEMP < 150 end,
        },
        [3] = {
            state = "CHECK",
            step_desition = true,
            to_step_desition = true,
            check = function() return BRKFAN_State == 0 end,
            action_check = {command = BRKFAN_PB},
        },
        [4] = {
            item = "TCAS",
            state = "TA_RA",
            check = function () return TCAS_SW == 4 end,
            action_check = {dataref = 4},
            dataref_name = "TCAS_SW"
        },
        [5] = {
            item = "ENGINE_MODE_SELECTOR",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end
        },
        [6] = {
            state = "IGNITION",
            step_desition = true,
            to_step_desition = true,
            action = {dataref = 2},
            dataref_name = "ENG_Mode"
        },
        [7] = {
            state = "NORMAL",
            step_desition = true,
            to_step_desition = true,
            action = {dataref = 1},
            dataref_name = "ENG_Mode"
        },
        [8] = {
            item = "PACKS",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.PACKS_FOR_TO or FOPM_CONFIG_VARIABLE.APU_TO_PACKS end
        },
        [9] = {
            int_item = "PACK1 OFF",
            step_desition = true,
            to_step_desition = true,
            check = function () return PACK_1_STATE == 0 end,
            action_check = {command = PACK_1_PB}
        },
        [10] = {
            int_item = "PACK2 OFF",
            state = "OFF",
            check = function () return PACK_2_STATE == 0 end,
            action_check = {command = PACK_2_PB}
        },
        [11] = {
            state = "ON",
            step_desition = true,
            to_step_desition = true
        }
    },
    Enter_runway_proc = {
        [1] = {
            -- DELAY
            action = {delay = 1}
        },
        [2] = {
            item = "EXTERIOR_LIGHTS",
        },
        [3] = {
            -- STROBE, NOT WHEN CROSSING A RUNWAY AFTER LANDING
            condition = function () return not FOPM_TL_FLT_PHASE.TAXI_IN end,
            action = {dataref = 2},
            dataref_name = "STROBE_SW"
        },
        [4] = {
            -- LANDING LIGHTS
            action = {dataref = 2},
            dataref_name = {"LANDLT_L_SW", "LANDLT_R_SW"}
        },
        [5] = {
            -- TAXI LIGHTS
            action = {dataref = 2},
            dataref_name = "TAXILT_SW"
        },
        [6] = {
            state = "SET"
        },
        [7] = {
            item = "TCAS",
            state = "SET",
            action = {dataref = 4},
            dataref_name = "TCAS_SW"
        },
    },
    Vacating_runway_proc = {
        [1] = {
            -- DELAY
            action = {delay = 1}
        },
        [2] = {
            item = "EXTERIOR_LIGHTS",
        },
        [3] = {
            -- LANDING LIGHTS
            action = {dataref = 0},
            dataref_name = {"LANDLT_L_SW", "LANDLT_R_SW"}
        },
        [4] = {
            -- STROBE
            action = {dataref = 1},
            dataref_name = "STROBE_SW"
        },
        [5] = {
            -- TAXI LIGHTS
            state = "SET",
            action = {dataref = 1},
            dataref_name = "TAXILT_SW"
        },
        [6] = {
            item = "TCAS",
            state = "SET",
            action = {dataref = 2},
            dataref_name = "TCAS_SW"
        },
    },
    Ten_thousand_feet_CLB = {
        [1] = {
            item = "TEN_THAUSAND_FEET",
            essential = true,
            condition = function () return fo_autoperform end
        },
        [2] = {
            item = "EXTERIOR_LIGHTS",
        },
        [3] = {
            -- RUNWAY TURN OFF LIGHTS
            action = {dataref = 0},
            dataref_name = "RWYTOLT_SW"
        },
        [4] = {
            -- LANDING LIGHTS
            action = {dataref = 0},
            dataref_name = {"LANDLT_L_SW", "LANDLT_R_SW"}
        },
        [5] = {
            -- TAXI LIGHTS
            state = "OFF",
            action = {dataref = 0},
            dataref_name = "TAXILT_SW"
        },
        [6] = {
            -- ND RANGE
            action = {dataref = 3, delay = 0.7},
            dataref_name = "EFIS_RNG"
        },
        [7] = {
            -- TERRAIN
            action = {command = TERRAIN_FO_PB, delay = 1}
        },
    },
    Ten_thousand_feet_DES = {
        [1] = {
            item = "TEN_THAUSAND_FEET",
            essential = true,
            condition = function () return fo_autoperform end
        },
        [2] = {
            item = "EXTERIOR_LIGHTS",
        },
        [3] = {
            -- RUNWAY TURN OFF LIGHTS
            action = {dataref = 1},
            dataref_name = "RWYTOLT_SW"
        },
        [4] = {
            -- LANDING LIGHTS
            action = {dataref = 2},
            dataref_name = {"LANDLT_L_SW", "LANDLT_R_SW"}
        },
        [5] = {
            -- TAXI LIGHTS
            state = "ON",
            action = {dataref = 2},
            dataref_name = "TAXILT_SW"
        },
        [6] = {
            -- ND RANGE
            action = {dataref = 1, delay = 0.7},
            dataref_name = "EFIS_RNG"
        },
        [7] = {
            -- TERRAIN
            action = {command = TERRAIN_FO_PB, delay = 0.5}
        },
        [8] = {
            item = "LS",
            condition = function () return FOPM_TL_APP_TYPE.ILS_APP or FOPM_TL_APP_TYPE.MLS_APP or FOPM_TL_APP_TYPE.LDA_APP or FOPM_TL_APP_TYPE.FLS end,
            action = {command = LS_FO_PB}
        },
        [9] = {
            item = "ENGINE_MODE_SELECTOR",
            state = "IGNITION",
            condition = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end,
            action = {dataref = 2},
            dataref_name = "ENG_Mode"
        },
    },
    After_landing_proc = {
        [1] = {
            -- DELAY
            action = {delay = 0.5}
        },
        [2] = {
            item = "CHECK_TIME",
            essential = true,
            action = {command = CRONO_SET_PB}
        },
        [3] = {
            item = "WEATHER_RADAR",
            state = "OFF",
            action = {dataref = 1},
            dataref_name = "RADAR_SYS_SW"
        },
        [4] = {
            item = "PWS",
            state = "OFF",
            action = {dataref = 0},
            dataref_name = "PWS_SW"
        },
        [5] = {
            item = "ENGINE_MODE_SELECTOR",
            state = "NORMAL",
            action = {dataref = 1},
            dataref_name = "ENG_Mode"
        },
        [6] = {
            item = "FLAPS",
            step_desition = true,
            check = function () return OAT >= 29 end
        },
        [7] = {
            int_item = "FLAPS_RET",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.F_ATARGET == FOPM_CONFIG_VARIABLE.F_TARGET end,
        },
        [8] = {
            int_item = "FLAPS",
            state = "FLAPS",
            check = function () return FLAPS_LEVER_State == FOPM_CONFIG_VARIABLE.F_TARGET end
        },
        [9] = {
            item = "APU_MASTER",
            action = {command = APU_MASTER_PB}
        },
        [10] = {
            -- DELAY
            action = {delay = 5}
        },
        [11] = {
            state = "STARTING_APU",
            action = {command = APU_START_PB}
        },
        [12] = {
            item = "TERRAIN",
            state = "OFF",
            action = {command = TERRAIN_FO_PB}
        },
        [13] = {
            int_item = "FO_FD",
            check = function () return FO_FD_STATE == 0 end,
            action_check = {command = FD_FO_PB}
        },
        [14] = {
            int_item = "FO_LS",
            check = function () return LS_FO_State == 0 end,
            action_check = {command = LS_FO_PB}
        },
        [15] = {
            int_item = "FO_HDGTRK",
            check = function () return HDGTRK_MODE == 0 end,
            action_check = {command = HDGTRK_TOGGLE}
        },
    },
    Parking_proc = {
        [1] = {
            -- IAE ENGINES SHUTDOWN TIME, USED BY THE NEXT ONE ENGINE TAXI DEP
            action = {
                run = function ()
                    if ENG_MODEL == 0 then
                        FOPM_CONFIG_VARIABLE.IAE_SD_TIME = math.floor(TIME)
                    end
                end,
                delay = 1
            }
        },
        [2] = {
            item = "APU_BLEED",
            state = "ON",
            action = {command = APU_BLEED_PB}
        },
        [3] = {
            item = "FUEL_PUMPS",
            action = {command = {FPUMP_LTANK_1_PB, FPUMP_LTANK_2_PB}}
        },
        [4] = {
            action = {command = {FPUMP_CTANK_1_PB, FPUMP_CTANK_2_PB}}
        },
        [5] = {
            state = "OFF",
            action = {command = {FPUMP_RTANK_1_PB, FPUMP_RTANK_2_PB}}
        },
        [6] = {
            item = "ATC",
            state = "SET",
            action = {dataref = 0},
            dataref_name = "TCAS_SW"
        },
        [7] = {
            -- CHRONO
            action = {command = CRONO_SET_PB}
        },
        [8] = {
            action = {command = CRONO_RESET_PB}
        },
    },
    One_engine_taxi_DEP = {
        [1] = {
            int_item = "INIT",
            check = function () return TAXILT_SW ~= 0 end
        },
        [2] = {
            item = "YELLOW_HYDRAULIC_PUMP",
            essential = true,
            state = "ON",
            action = {dataref = 1},
            dataref_name = "Y_ELEC_PUMP_PB"
        },
        [3] = {
            int_item = "START_COMMAND",
            check = function () return FOPM_Procedures_Control.START_ENG2 end
        },
        [4] = {
            int_item = "STRAIGHT_LINE",
            check = function () return STEARING_DEGREES <= 2 and STEARING_DEGREES >= -2 end
        },
        [5] = {
            item = "YELLOW_HYDRAULIC_PUMP",
            essential = true,
            state = "OFF",
            action = {dataref = 0},
            dataref_name = "Y_ELEC_PUMP_PB"
        },
        [6] = {
            item = "APU_BLEED",
            essential = true,
            state = "ON",
            check = function () return APU_BLEED_STATE == 1 end,
            action_check = {command = APU_BLEED_PB},
        },
        [7] = {
            item = "ENGINE_MODE_SELECTOR",
            essential = true,
            state = "IGNITION",
            action = {dataref = 2},
            dataref_name = "ENG_Mode"
        },
        [8] = {
            -- DELAY
            action = {delay = 10 - fo_speed}
        },
        [9] = {
            state = "STARTING_NUMBER_2",
            essential = true,
            action = {dataref = 1},
            dataref_name = "ENG_2_Master"
        },
        [10] = {
            int_item = "ENG_2_AVAIL",
            check = function () return ENG_2_AVAIL == 1 end
        },
        [11] = {
            item = "ENGINE2",
            state = "AVAIL",
            essential = true
        },
        [12] = {
            item = "CHECK_TIME",
            essential = true,
            action_pre_check = {command = CRONO_SET_PB},
        },
        [13] = {
            item = "ENGINE_MODE_SELECTOR",
            essential = true,
            state = "NORMAL",
            action = {dataref = 1},
            dataref_name = "ENG_Mode"
        },
        [14] = {
            item = "APU_BLEED",
            essential = true,
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.APU_TO_PACKS end
        },
        [15] = {
            step_desition = true,
            to_step_desition = true,
            essential = true,
            state = "OFF",
            action = {command = APU_BLEED_PB}
        },
        [16] = {
            item = "APU_MASTER",
            essential = true,
            state = "OFF",
            action = {command = APU_MASTER_PB},
        },
        [17] = {
            step_desition = true,
            to_step_desition = true,
            essential = true,
            state = "ON",
        },
        [18] = {
            item = "CROSS_BLEED",
            essential = true,
            state = "AUTO",
            action = {dataref = 1},
            dataref_name = "XBLEED_SW"
        },
        [19] = {
            item = "ECAM_STATUS",
            essential = true,
            state = "CHECK",
        },
        [20] = {
            item = "ENGINE2",
            essential = true,
        },
        [21] = {
            item = "ANTI_ICE",
            step_desition = true,
            essential = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and OAT < 10 end
        },
        [22] = {
            step_desition = true,
            to_step_desition = true,
            essential = true,
            state = "SET",
            action = {command = ANTI_ICE_ENG2_PB}
        },
        [23] = {
            step_desition = true,
            to_step_desition = true,
            essential = true,
            state = "SET",
        },
        [24] = {
            int_item = "After Start Checklist",
            step_desition = true,
            check = function () return not FOPM_TL_CHECKLIST.EXECUTE_CL end
        },
        [25] = {
            -- A RELOAD STOPS THE CHECKLIST, SO A RECOVERY HERE LAUNCHES IT AGAIN
            recovery_step = 24,
            check = function () return FOPM_TL_CHECKLIST.After_start_checklist end
        },
        [26] = {
            int_item = "FLTCTLCHK",
            step_desition = true,
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end,
        },
        [27] = {
            item = "AUTOBRAKES",
            essential = true,
            state = "MAX",
            action = {command = AUTOBRK_MAX_PB},
        },
        [28] = {
            int_item = "TO_CONFIG",
            action = {command = TO_CONFIG_PB},
        },
        [29] = {
            int_item = "PROC_COMP",
            step_desition = true,
            check = function () return FOPM_STEP_VARIABLE.PROC_OE_STEP == 29 end
        },
        [30] = {
            int_item = "ENG_COMP",
            step_desition = true,
            check = function () return ENG_MODEL == 0 end
        },
        [31] = {
            int_item = "IAE_CHECK_TIME",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.IAE_SD_TIME > 7200 end
        },
        [32] = {
            int_item = "TIME_COMP",
            step_desition = true,
            to_step_desition = true,
            state = "READY_FOR_TO",
            essential = true,
            check = function () return CRONO >= 300 end
        },
        [33] = {
            int_item = "TIME_COMP",
            step_desition = true,
            to_step_desition = true,
            state = "READY_FOR_TO",
            essential = true,
            check = function () return CRONO >= 120 end
        },
        [34] = {
            int_item = "STOP_CHRONO",
            action = {command = CRONO_SET_PB}
        },
        [35] = {
            int_item = "STOP_CHRONO",
            action = {command = CRONO_RESET_PB}
        }
    },
    One_engine_taxi_ARR = {
        [1] = {
            int_item = "APU_AVAIL",
            check = function () return APU_STATE == 1 end
        },
        [2] = {
            item = "ENGINE_2_SHUTDOWN",
            essential = true,
            action = {dataref = 0},
            dataref_name = "ENG_2_Master"
        },
        [3] = {
            item = "YELLOW_HYDRAULIC_PUMP",
            essential = true,
            state = "ON",
            action = {dataref = 1},
            dataref_name = "Y_ELEC_PUMP_PB"
        },
    }
}