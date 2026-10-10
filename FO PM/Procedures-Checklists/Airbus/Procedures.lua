----------------------
-- FO/PM PROCEDURES --
----------------------

-- EVERY PROCEDURE IS A LIST OF STEPS. THE ENGINE IT IS ASSIGNED TO (ENG1 / ENG2, SEE
-- Engine_Assingment IN FO-PM.lua) RUNS THEM IN ORDER. FIELDS OF A STEP:
--
-- NAME OF THE STEP (ONE OF THEM). IT IS ALSO THE KEY OF ITS HANDLER, IF IT HAS ONE
--   item                VOICE SAID WHEN THE STEP STARTS (A KEY OF FO_voices_directory),
--                       THEN THE ENGINE WAITS FOR IT. IF THE STEP WAITS ON A check, IT IS
--                       SAID AGAIN EVERY 10 s
--   int_item            SILENT NAME, A fo_speed PAUSE, NO VOICE
--   nodelay_item        SILENT NAME, NO PAUSE. A DECISION WITH IT IS CHECKED EVERY FRAME
--
-- VOICE
--   state               VOICE SAID WHEN THE STEP IS DONE (A KEY OF FO_voices_directory).
--                       ON A STEP NAMED "FLAPS": state = "POS" SAYS THE FLAPS POSITION,
--                       state = "CONF" SAYS THE TAKEOFF CONFIG
--   essential           item AND state ARE SAID EVEN WITH SPEAK ONLY ESSENTIALS. WITHOUT
--                       IT THEY BECOME A SILENT fo_speed PAUSE
--
-- WAIT
--   check               function, THE STEP WAITS UNTIL IT RETURNS true. IF THE STEP ALSO
--                       HAS action = {complex_action = true}, THAT HANDLER RUNS WHEN check
--                       PASSES (ANY OTHER action IS IGNORED ON A STEP WITH check)
--   action_check        DONE EVERY 0.9 s WHILE check IS false: {dataref = V} OR {command = CMD}
--
-- ACTIONS
--   action_pre_check    DONE WHEN THE STEP STARTS: {dataref = V} OR {command = CMD}
--                       (NOT ON A to_step_desition BRANCH)
--   action              DONE ONCE ON A STEP WITHOUT check. ONE OF:
--                         dataref = V            WRITTEN TO dataref_name
--                         command = CMD          OR A LIST {CMD_A, CMD_B}
--                         command_begin = CMD    command_end = CMD
--                         complex_action = true  RUNS complex_action OF THE STEP'S HANDLER
--                         delay = SECONDS        WAIT BEFORE THE NEXT STEP
--   dataref_name        NAME OF THE DATAREF VARIABLE. IN action IT CAN BE A LIST {"A", "B"}
--
-- DECISIONS
--   step_desition       DECISION STEP. ITS check() IS ASKED ONCE AND THE HANDLER answeryes /
--                       answerno RUNS. THE ENGINE DOES NOT MOVE ON BY ITSELF: THE HANDLER
--                       MOVES THE STEP. A MISSING answer KEEPS THE STEP REPEATING (POLLING)
--   to_step_desition    BRANCH OF A DECISION. THE FIRST BRANCH REACHED RUNS AS A NORMAL STEP,
--                       THE NEXT CONSECUTIVE BRANCHES ARE SKIPPED. ANY NON BRANCH STEP CLOSES
--                       THE DECISION
--
-- HANDLERS (FOPM_proc_handlers.<PROCEDURE>.<STEP NAME>)
--   answeryes / answerno    DECISION RESULT, MOVES THE STEP
--   complex_action          LOGIC THE PACK CAN NOT EXPRESS WITH FIELDS. THE ENGINE MOVES
--                           THE STEP AFTER IT
--   ALWAYS REACH THE ENGINE THROUGH Engine_Assingment, NEVER BY ENGINE NAME:
--     FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.<PROC>.."_STEP"]  STEP OF THE LIST
--     FOPM_STEP_VARIABLE[FOPM_Procedures_Control.Engine_Assingment.<PROC>.."_STEP"] = 3       ENDS THE PROCEDURE
--                                                                                         IF THE STEP IS PAST THE LAST
--     FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.<PROC>]   ENGINE WAIT
--
-- WHEN THE LAST STEP IS DONE THE ENGINE SAYS "READY" (NOT WITH SPEAK ONLY ESSENTIALS) AND SETS
-- FOPM_TL_COMPLETED_PROC.<PROCEDURE> = true.
-- A NEW PROCEDURE ALSO NEEDS ITS ENGINE IN Engine_Assingment AND ITS FLAG IN FOPM_TL_COMPLETED_PROC
-- (FO-PM.lua), AND SOMETHING TO START IT:
--   FOPM_Procedures_Control.UNASSIGN_PROC = "<PROCEDURE>"
--   proc_assignment()   (IGNORED WHILE ITS ENGINE IS BUSY)

FOPM_proc_config_name = "Airbus"

FOPM_proc_handlers = {
    Pre_cockpit_preparation = {
        EXTERNAL_CHECK = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Pre_cockpit_preparation.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Pre_cockpit_preparation.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Pre_cockpit_preparation.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Pre_cockpit_preparation.."_STEP"] + 2
            end
        }
    },
    After_start_procedure = {
        PITCHTRM = {
            complex_action = function ()
                FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION = string.match(MCDU2_BLINE_3, "([UPDN]+)")
                FOPM_CONFIG_VARIABLE.PT_TO_ANGLE = tonumber(string.match(MCDU2_BLINE_3, "/.-[UPDN]+(%d+%.%d+)"))
                FOPM_CONFIG_VARIABLE.FLAP_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_1, "(%d+)"))
                FOPM_CONFIG_VARIABLE.SLAT_RETRACT_SPEED = tonumber(string.match(MCDU2_GLINE_2, "(%d+)"))
                FOPM_CONFIG_VARIABLE.GREENDOT = tonumber(string.match(MCDU2_GLINE_3,"(%d+)"))
            end
        },
        TRIM_CHECK = {
            answeryes = function ()
                FOPM_CONFIG_VARIABLE.PT_TO_CONFIG = FOPM_CONFIG_VARIABLE.PT_TO_ANGLE * 1
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_CONFIG_VARIABLE.PT_TO_CONFIG = FOPM_CONFIG_VARIABLE.PT_TO_ANGLE * -1
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] + 2
            end
        },
        TRIM_STOP = {
            answeryes = function ()
                command_end(PITCH_TRIM_DN)
                command_end(PITCH_TRIM_UP)
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] + 1
            end
        },
        OETD_CHECK = {
            answeryes = function ()
                FOPM_Procedures_Control.UNASSIGN_PROC = "One_engine_taxi_DEP"
                proc_assignment()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] + 1
                FOPM_STEP_VARIABLE[FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] = 3
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] + 1
                FOPM_STEP_VARIABLE[FOPM_Procedures_Control.Engine_Assingment.After_start_procedure.."_STEP"] = 3
            end
        }
    },
    Taxi_procedure = {
        OETD_CHECK = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] + 2
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] + 1
            end
        },
        FLTCTLCHK = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] + 1
            end,
            answerno = function ()
                flt_ctl_chk()
            end
        },
        WEATHER_RADAR = {
            answeryes = function ()
                local number = math.random(2)
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] + number
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] + 3
            end
        },
        ON_OETD = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] + 3
                FOPM_STEP_VARIABLE[FOPM_Procedures_Control.Engine_Assingment.Taxi_procedure.."_STEP"] = 3
            end
        }
    },
    Before_takeoff_proc = {
        BRAKE_TEMP = {
            answeryes = function ()
                local rindex = math.random(3)
                FOPM_PlaySound(BRAKE_WARNINGS[rindex])
                FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc] = TIME + (FOPM_Duration(BRAKE_WARN, rindex))
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] + 2
            end
        },
        TEMP_CHECK = {
            answeryes = function ()
                local rindex = math.random(5)
                FOPM_PlaySound(READY[rindex])
                FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc] = TIME + (RDY[rindex].del) + fo_speed
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] - 1
            end
        },
        ENGINE_MODE_SELECTOR = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] + 2
            end
        },
        PACKS = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] + 4
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] + 1
            end
        },
        PACKS_OFF = {
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] + 2
                FOPM_STEP_VARIABLE[FOPM_Procedures_Control.Engine_Assingment.Before_takeoff_proc.."_STEP"] = 3
            end
        }
    },
    Ten_thousand_feet_CLB = {
        TEN_THAUSAND_FEET = {
            answeryes = function ()
                local speech = FOPM_procedure.Ten_thousand_feet_CLB[FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_CLB.."_STEP"]].int_item
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_CLB] = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_CLB.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_CLB.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_CLB.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_CLB.."_STEP"] + 1
            end
        }
    },
    Ten_thousand_feet_DES = {
        TEN_THAUSAND_FEET = {
            answeryes = function ()
                local speech = FOPM_procedure.Ten_thousand_feet_DES[FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"]].int_item
                FOPM_PlaySound(FOPM_Talk[speech])
                FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES] = TIME + (FO_voices_directory[speech].del)
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] + 1
            end
        },
        LS = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] + 2
            end
        },
        ENGINE_MODE_SELECTOR = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.Ten_thousand_feet_DES.."_STEP"] + 2
            end
        },
    },
    After_landing_proc = {
        FLAPS = {
            answeryes = function ()
                FOPM_CONFIG_VARIABLE.F_TARGET = 0.25
                FOPM_CONFIG_VARIABLE.F_ATARGET = FLAPS_LEVER_State
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_landing_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_landing_proc.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_CONFIG_VARIABLE.F_TARGET = 0
                FOPM_CONFIG_VARIABLE.F_ATARGET = FLAPS_LEVER_State
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_landing_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_landing_proc.."_STEP"] + 1
            end
        },
        FLAPS_RET = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_landing_proc.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_landing_proc.."_STEP"] + 1
            end,
            answerno = function ()
                command_once(FLAPS_1UP)
                FOPM_CONFIG_VARIABLE.F_ATARGET = FOPM_CONFIG_VARIABLE.F_ATARGET - 0.25
                FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.After_landing_proc] = TIME + fo_speed + 0.25
            end
        }
    },
    Parking_proc = {
        IAE_CHECK = {
            complex_action = function ()
                if ENG_MODEL == 0 then
                    FOPM_CONFIG_VARIABLE.IAE_SD_TIME = math.floor(TIME)
                end
            end
        }
    },
    One_engine_taxi_DEP = {
        APU_BLEED = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 4
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 1
            end
        },
        APU_OFF_SKIP = {
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 2
            end
        },
        ANTI_ICE = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 2
            end
        },
        After_Start_Checklist = {
            answeryes = function ()
                FOPM_TL_CHECKLIST.After_start_checklist = false
                FOPM_TL_CHECKLIST.ACT_CL = "After_start_checklist"
                FOPM_TL_CHECKLIST.EXECUTE_CL = true
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 1
            end
        },
        WAIT_CL = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 1
            end
        },
        FLTCTLCHK = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 1
            end,
            answerno = function ()
                flt_ctl_chk()
            end
        },
        PROC_COMP = {
            complex_action = function ()
                local rindex = math.random(5)
                FOPM_PlaySound(READY[rindex])
                FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP] = TIME + (FOPM_Duration(RDY, rindex))
            end
        },
        ENG_COMP = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 3
            end
        },
        IAE_CHECK_TIME = {
            answeryes = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 1
            end,
            answerno = function ()
                FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] = FOPM_STEP_VARIABLE["PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP.."_STEP"] + 2
            end
        },
        TIME_COMP = {
            complex_action = function ()
                local rindex = math.random(3)
                FOPM_PlaySound(READY_FOR_TO[rindex])
                FOPM_DELAY_VARIABLE["DELAY_PROC_"..FOPM_Procedures_Control.Engine_Assingment.One_engine_taxi_DEP] = TIME + (FOPM_Duration(RDY_TO_DIR, rindex))
            end
        }
    }
}

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
            state = "POS",
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
        [23] = {
            int_item = "FO FLPLN",
            action = {command = MCDU_FO_KEY_Fpln}
        }
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
            state = "CONF",
            action_check = {command = FLAPS_1DOWN},
            check = function () return ((math.floor(FLAPS_LEVER_State * 100)/100) * 4) == FLAPS_TO_CONFIG end
        },
        [4] = {
            item = "PITCHTRM",
            action_pre_check = {command = MCDU_FO_KEY_Perf},
            action = {complex_action = true}
        },
        [5] = {
            int_item = "TRIM_CHECK",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.PT_TO_DIRECTION == "UP" end
        },
        [6] = {
            nodelay_item = "START_TRIM_UP",
            step_desition = true,
            to_step_desition = true,
            action = {command_begin = PITCH_TRIM_UP}
        },
        [7] = {
            nodelay_item = "START_TRIM_DOWN",
            step_desition = true,
            to_step_desition = true,
            action = {command_begin = PITCH_TRIM_DN}
        },
        [8] = {
            nodelay_item = "TRIM_STOP",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.PT_TO_CONFIG == math.floor(PITCH_TRIM * 10) / 10 end
        },
        [9] = {
            state = "SET"
        },
        [10] = {
            item = "ECAM_STATUS",
            state = "CHECK"
        },
        [11] = {
            int_item = "FO FLPLN",
            action = {command = MCDU_FO_KEY_Fpln}
        },
        [12] = {
            int_item = "FLAPS",
            essential = true,
            state = "CONF",
            check = function () return FLAPS_State == -1 end
        },
        [13] = {
            int_item = "OETD_CHECK",
            step_desition = true,
            check = function () return FOPM_Procedures_Control.ONEENG_TAXI_DEP end
        },
    },
    Taxi_procedure = {
        [1] = {
            int_item = "OETD_CHECK",
            step_desition = true,
            check = function () return FOPM_Procedures_Control.ONEENG_TAXI_DEP end
        },
        [2] = {
            nodelay_item = "FLTCTLCHK",
            step_desition = true,
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end,
        },
        [3] = {
            item = "WEATHER_RADAR",
            step_desition = true,
            check = function () return RADAR_SYS_SW == 1 end
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
            check = function() return not FOPM_Procedures_Control.ONEENG_TAXI_DEP end,
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
            int_item = "BRAKE_TEMP",
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
            int_item = "PACKS_OFF",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.PACKS_FOR_TO or FOPM_CONFIG_VARIABLE.APU_TO_PACKS end
        },
        [12] = {
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
            check = function () return FOPM_TL_FLT_PHASE.TAXI_IN or STROBE_SW == 2 end,
            action_check = {dataref = 2},
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
            int_item = "TEN_THAUSAND_FEET",
            step_desition = true,
            check = function () return fo_autoperform end
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
            action = {dataref = 3},
            dataref_name = "EFIS_RNG"
        },
        [7] = {
            -- TERRAIN
            action = {command = TERRAIN_FO_PB}
        },
    },
    Ten_thousand_feet_DES = {
        [1] = {
            int_item = "TEN_THAUSAND_FEET",
            step_desition = true,
            check = function () return fo_autoperform end
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
            action = {dataref = 1},
            dataref_name = "EFIS_RNG"
        },
        [7] = {
            -- TERRAIN
            action = {command = TERRAIN_FO_PB}
        },
        [8] = {
            item = "LS",
            step_desition = true,
            check = function () return FOPM_TL_APP_TYPE.ILS_APP or FOPM_TL_APP_TYPE.MLS_APP or FOPM_TL_APP_TYPE.LDA_APP or FOPM_TL_APP_TYPE.FLS end
        },
        [9] = {
            nodelay_item = "LS ON",
            step_desition = true,
            to_step_desition = true,
            action = {command = LS_FO_PB}
        },
        [10] = {
            item = "ENGINE_MODE_SELECTOR",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and ENG_MODEL ~= 0 end
        },
        [11] = {
            state = "IGNITION",
            step_desition = true,
            to_step_desition = true,
            action = {dataref = 2},
            dataref_name = "ENG_Mode"
        },
        [12] = {
            state = "NORMAL",
            step_desition = true,
            to_step_desition = true,
            action = {dataref = 1},
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
            check = function () return OAT >= 500 end
        },
        [7] = {
            int_item = "FLAPS_RET",
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.F_ATARGET == FOPM_CONFIG_VARIABLE.F_TARGET end,
        },
        [8] = {
            int_item = "FLAPS",
            state = "POS",
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
            int_item = "IAE_CHECK",
            action = {complex_action = true}
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
            int_item = "APU_OFF_SKIP",
            essential = true,
            step_desition = true,
            check = function () return FOPM_CONFIG_VARIABLE.APU_TO_PACKS end
        },
        [18] = {
            step_desition = true,
            to_step_desition = true,
            essential = true,
            state = "ON",
        },
        [19] = {
            item = "CROSS_BLEED",
            essential = true,
            state = "AUTO",
            action = {dataref = 1},
            dataref_name = "XBLEED_SW"
        },
        [20] = {
            item = "ECAM_STATUS",
            essential = true,
            state = "CHECK",
        },
        [21] = {
            item = "ENGINE2",
            essential = true,
        },
        [22] = {
            item = "ANTI_ICE",
            step_desition = true,
            essential = true,
            check = function () return FOPM_CONFIG_VARIABLE.RAINING and OAT < 10 end
        },
        [23] = {
            step_desition = true,
            to_step_desition = true,
            essential = true,
            state = "SET",
            action = {command = ANTI_ICE_ENG2_PB}
        },
        [24] = {
            step_desition = true,
            to_step_desition = true,
            essential = true,
            state = "SET",
        },
        [25] = {
            nodelay_item = "After_Start_Checklist",
            step_desition = true,
            check = function () return not FOPM_TL_CHECKLIST.EXECUTE_CL end
        },
        [26] = {
            nodelay_item = "WAIT_CL",
            step_desition = true,
            check = function () return FOPM_TL_CHECKLIST.After_start_checklist end
        },
        [27] = {
            nodelay_item = "FLTCTLCHK",
            step_desition = true,
            check = function () return FOPM_TL_COMPLETED_PROC.FLTCTL_CHK end,
        },
        [28] = {
            item = "AUTOBRAKES",
            essential = true,
            state = "MAX",
            action = {command = AUTOBRK_MAX_PB},
        },
        [29] = {
            int_item = "TO_CONFIG",
            action = {command = TO_CONFIG_PB},
        },
        [30] = {
            int_item = "PROC_COMP",
            action = {complex_action = true}
        },
        [31] = {
            int_item = "ENG_COMP",
            step_desition = true,
            check = function () return ENG_MODEL == 0 end
        },
        [32] = {
            int_item = "IAE_CHECK_TIME",
            step_desition = true,
            check = function () return (TIME - FOPM_CONFIG_VARIABLE.IAE_SD_TIME) > 7200 end
        },
        [33] = {
            int_item = "TIME_COMP",
            step_desition = true,
            to_step_desition = true,
            check = function () return CRONO >= 300 end,
            action = {complex_action = true}
        },
        [34] = {
            int_item = "TIME_COMP",
            step_desition = true,
            to_step_desition = true,
            check = function () return CRONO >= 120 end,
            action = {complex_action = true}
        },
        [35] = {
            int_item = "STOP_CHRONO",
            action = {command = CRONO_SET_PB}
        },
        [36] = {
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