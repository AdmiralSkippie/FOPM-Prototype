----------------------
-- FO/PM PROCEDURES --
----------------------

FOPM_proc_config_name = "Avianca"

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
            check = function () return PT_TO_DIRECTION == "UP" end
        },
        [6] = {
            int_item = "TRIM_STOP",
            step_desition = true,
            check = function () return PT_TO_CONFIG == (math.floor(PITCH_TRIM * 10) / 10) end
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
            state = CONFIG_VOICE_SRCH,
            check = function () return FLAPS_State ~= -1 end
        },
        [10] = {
            int_item = "OETD CHECK",
            step_desition = true,
            check = function () return ONEENG_TAXI_DEP end
        },
        [11] = {
            int_item = "FLTCTLCHK",
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end,
            action_check = {func = flt_ctl_chk}
        }
    }
}