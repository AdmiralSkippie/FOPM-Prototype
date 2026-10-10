    local ACT_PROC = FOPM_Procedures_Control.ENG2_ACT_PROC
    if FOPM_STEP_VARIABLE.ENG2_STEP == 0 then
        FOPM_STEP_VARIABLE.ENG2_STEP = 1
        FOPM_STEP_VARIABLE.PROC_ENG2_STEP = 1
    elseif FOPM_STEP_VARIABLE.ENG2_STEP == 1 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 then
            if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].step_desition then
                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].to_step_desition then
                    if FOPM_STEP_VARIABLE.DES_MADED2 then
                        FOPM_STEP_VARIABLE.PROC_ENG2_STEP = FOPM_STEP_VARIABLE.PROC_ENG2_STEP + 1
                    else
                        if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item then
                            if not speak_only_essencials then
                                local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                            else
                                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                                    local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item
                                    FOPM_PlaySound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                                end
                            end
                        elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item then
                            FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                        end
                        FOPM_STEP_VARIABLE.DES_MADED2 = true
                        FOPM_STEP_VARIABLE.ENG2_STEP = 2
                    end
                else
                    if FOPM_STEP_VARIABLE.DES_MADED2 then
                        FOPM_STEP_VARIABLE.DES_MADED2 = false
                    end
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item then
                        if not speak_only_essencials then
                            local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                        else
                            if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                                local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                            end
                        end
                    elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item then
                        FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                    end
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check then
                        if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.dataref then
                            local dataref_name = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.dataref
                        elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.command then
                            command_once(FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.command)
                        end
                    end
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].check then
                        local handler_item = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item or FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item or FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].nodelay_item
                        if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].check() then
                            if FOPM_proc_handlers[ACT_PROC][handler_item].answeryes then
                                FOPM_proc_handlers[ACT_PROC][handler_item].answeryes()
                            end
                        else
                            if FOPM_proc_handlers[ACT_PROC][handler_item].answerno then
                                FOPM_proc_handlers[ACT_PROC][handler_item].answerno()
                            end
                        end
                    end
                end
            else
                if FOPM_STEP_VARIABLE.DES_MADED2 then
                    FOPM_STEP_VARIABLE.DES_MADED2 = false
                end
                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item then
                    if not speak_only_essencials then
                        local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                    else
                        if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                            local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                        else
                            FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                        end
                    end
                elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item then
                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                end
                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check then
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.dataref then
                        local dataref_name = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].dataref_name
                        _G[dataref_name] = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.dataref
                    elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.command then
                        command_once(FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_pre_check.command)
                    end
                end
                FOPM_STEP_VARIABLE.ENG2_STEP = 2
            end
        end
    elseif FOPM_STEP_VARIABLE.ENG2_STEP == 2 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 then
            if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].check then
                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].check() then
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state then
                        if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item == "FLAPS" or FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item == "FLAPS" then
                            local speech = ""
                            local flap_dir = FLAP_POS
                            if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state == "POS" then
                                speech = FL_VOICE_SRCH
                            elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state == "CONF" then
                                speech = CONFIG_VOICE_SRCH
                                flap_dir = FLAP_CONFIG
                            end
                            if not speak_only_essencials then
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (flap_dir[speech].del)
                            else
                                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                                    FOPM_PlaySound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (flap_dir[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                                end
                            end
                        else
                            if not speak_only_essencials then
                                local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                            else
                                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                                    local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state
                                    FOPM_PlaySound(FOPM_Talk[speech])
                                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                                else
                                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                                end
                            end
                        end
                    else
                        FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                    end
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action and FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action.complex_action then
                        local handler_item = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item or FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item
                        FOPM_proc_handlers[ACT_PROC][handler_item].complex_action()
                    end
                    FOPM_STEP_VARIABLE.ENG2_STEP = 3
                    FOPM_STEP_VARIABLE.PROC_ENG2_STEP = FOPM_STEP_VARIABLE.PROC_ENG2_STEP + 1
                else
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_check then
                        if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_check.dataref then
                            local dataref_name = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].dataref_name
                            _G[dataref_name] = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_check.dataref
                        elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_check.command then
                            command_once(FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action_check.command)
                        end
                        FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + 0.9
                    else
                        if TIME >= FOPM_DELAY_VARIABLE.DELAY_CHECK then
                            if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item then
                                local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_CHECK = TIME + (FO_voices_directory[speech].del) + 10
                            end
                        end
                    end
                end
            elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action then
                local PROC_ACTION = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].action
                if not FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].nodelay_item then
                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                end
                if PROC_ACTION.dataref then
                    local dataref_name = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].dataref_name
                    if type(dataref_name) == "table" then
                        for _, name in ipairs(dataref_name) do
                            _G[name] = PROC_ACTION.dataref
                        end
                    else
                        _G[dataref_name] = PROC_ACTION.dataref
                    end
                elseif PROC_ACTION.command then
                    if type(PROC_ACTION.command) == "table" then
                        for _, cmd in ipairs(PROC_ACTION.command) do
                            command_once(cmd)
                        end
                    else
                        command_once(PROC_ACTION.command)
                    end
                elseif PROC_ACTION.command_begin then
                    command_begin(PROC_ACTION.command_begin)
                elseif PROC_ACTION.command_end then
                    command_end(PROC_ACTION.command_end)
                elseif PROC_ACTION.complex_action then
                    local handler_item = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item or FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item
                    FOPM_proc_handlers[ACT_PROC][handler_item].complex_action()
                elseif PROC_ACTION.delay then
                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + PROC_ACTION.delay
                end
                if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state then
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].item == "FLAPS" or FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].int_item == "FLAPS" then
                        local speech = ""
                        local flap_dir = FLAP_POS
                        if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state == "POS" then
                            speech = FL_VOICE_SRCH
                        elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state == "CONF" then
                            speech = CONFIG_VOICE_SRCH
                            flap_dir = FLAP_CONFIG
                        end
                        if not speak_only_essencials then
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (flap_dir[speech].del)
                        else
                            if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (flap_dir[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                            end
                        end
                    else
                        if not speak_only_essencials then
                            local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state
                            FOPM_PlaySound(FOPM_Talk[speech])
                            FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                        else
                            if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                                local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state
                                FOPM_PlaySound(FOPM_Talk[speech])
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                            else
                                FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                            end
                        end
                    end
                end
                FOPM_STEP_VARIABLE.ENG2_STEP = 3
                FOPM_STEP_VARIABLE.PROC_ENG2_STEP = FOPM_STEP_VARIABLE.PROC_ENG2_STEP + 1
            elseif FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state then
                if not speak_only_essencials then
                    local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state
                    FOPM_PlaySound(FOPM_Talk[speech])
                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                else
                    if FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].essential then
                        local speech = FOPM_procedure[ACT_PROC][FOPM_STEP_VARIABLE.PROC_ENG2_STEP].state
                        FOPM_PlaySound(FOPM_Talk[speech])
                        FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (FO_voices_directory[speech].del)
                    else
                        FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + fo_speed
                    end
                end
                FOPM_STEP_VARIABLE.ENG2_STEP = 3
                FOPM_STEP_VARIABLE.PROC_ENG2_STEP = FOPM_STEP_VARIABLE.PROC_ENG2_STEP + 1
            else
                FOPM_STEP_VARIABLE.ENG2_STEP = 3
                FOPM_STEP_VARIABLE.PROC_ENG2_STEP = FOPM_STEP_VARIABLE.PROC_ENG2_STEP + 1
            end
        end
    elseif FOPM_STEP_VARIABLE.ENG2_STEP == 3 then
        if TIME >= FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 then
            if FOPM_STEP_VARIABLE.PROC_ENG2_STEP > #FOPM_procedure[ACT_PROC] then
                if not speak_only_essencials then
                    local rindex = math.random(5)
                    FOPM_PlaySound(READY[rindex])
                    FOPM_DELAY_VARIABLE.DELAY_PROC_ENG2 = TIME + (RDY[rindex].del)
                end
                FOPM_STEP_VARIABLE.ENG2_STEP = 0
                FOPM_STEP_VARIABLE.PROC_ENG2_STEP = 0
                FOPM_TL_COMPLETED_PROC[ACT_PROC] = true
                FOPM_Procedures_Control.EXECUTE_ENG2 = false
                NEED_SAVE = true
            else
                FOPM_STEP_VARIABLE.ENG2_STEP = 1
            end
        end
    end