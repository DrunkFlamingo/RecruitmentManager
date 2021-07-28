local rm = core:get_static_object("recruitment_manager") 
--# assume rm: RECRUITER_MANAGER
local ast_line = "**********************************************************************\n"




cm:add_first_tick_callback(function()

    --localisations
    local loc_points = effect.get_localised_string("ttc_measurement_name")
    local loc_restriction = effect.get_localised_string("ttc_restriction_tooltip")

    --add unit added to queue listener
    core:add_listener(
        "RecruiterManagerOnRecruitOptionClicked",
        "ComponentLClickUp",
        true,
        function(context)
            --# assume context: CA_UIContext
            local uic = UIComponent(context.component)
            local unit_component_ID = tostring(uic:Id())
            local pin = find_uicomponent(uic, "pin_parent", "button_pin")
            if pin and string.find(pin:CurrentState(), "hover") then return end
            --is our clicked component a unit?
            if string.find(unit_component_ID, "_recruitable") and UIComponent(context.component):CurrentState() == "active" and (not UIComponent(context.component):GetTooltipText():find("col:red")) then
                --print_all_uicomponent_children(UIComponent(context.component))
                --its a unit! steal the users input so that they don't click more shit while we calculate.
                cm:steal_user_input(true);
                rm:log("Locking recruitment button for ["..unit_component_ID.."] temporarily");
                --reduce the string to get the name of the unit.
                local unitID = string.gsub(unit_component_ID, "_recruitable", "")
                --add the unit to queue so that our model knows it exists.
                local rec_char = rm:current_character()
                rec_char:add_unit_to_queue(unitID)
                rm:enforce_unit_and_grouped_units(unitID, rec_char)
                rm:output_state(rec_char)
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rec_char:command_queue_index()))
            end
        end,
        true);
    --add unit added to queue from mercenaries listener
    core:add_listener(
        "RecruiterManagerOnMercenaryOptionClicked",
        "ComponentLClickUp",
        true,
        function(context)
            --# assume context: CA_UIContext
            local uic = UIComponent(context.component)
            local unit_component_ID = tostring(uic:Id())
            local pin = find_uicomponent(uic, "pin_parent", "button_pin")
            if pin and string.find(pin:CurrentState(), "hover") then return end
            --is our clicked component a unit?
            if string.find(unit_component_ID, "_mercenary") and UIComponent(context.component):CurrentState() == "active" and (not UIComponent(context.component):GetTooltipText():find("col:red")) then
                --its a unit! steal the users input so that they don't click more shit while we calculate.
                cm:steal_user_input(true);
                rm:log("Locking recruitment button for ["..unit_component_ID.."] temporarily");
                --reduce the string to get the name of the unit.
                local unitID = string.gsub(unit_component_ID, "_mercenary", "")
                --add the unit to queue so that our model knows it exists.
                local rec_char = rm:current_character()
                rec_char:queue_mercenary(rec_char:get_unit(unitID))
                rm:enforce_unit_and_grouped_units(unitID, rec_char)
                rm:output_state(rec_char)
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rec_char:command_queue_index()))
            end
        end,
        true);

    --v function(queuedUnit: CA_UIC) --> string
    local function GetQueuedUnitClicked(queuedUnit)
        queuedUnit:SimulateMouseOn();
        local unitInfo = find_uicomponent(core:get_ui_root(), "UnitInfoPopup", "tx_unit-type");
        local rawstring = unitInfo:GetStateText();
        local infostart = string.find(rawstring, "unit/") + 5;
        local infoend = string.find(rawstring, "]]") - 1;
        local QueuedUnitName = string.sub(rawstring, infostart, infoend)
        return QueuedUnitName
    end


    --add queued unit clicked listener 
    core:add_listener(
    "RecruiterManagerOnQueuedUnitClicked",
    "ComponentLClickUp",
    true,
    function(context)
        --# assume context: CA_UIContext
        local component = UIComponent(context.component)
        local queue_component_ID = tostring(component:Id())
        if string.find(queue_component_ID, "QueuedLandUnit") then
            rm:log(ast_line.."\tPATH START: Component Clicked was a Queued Unit!")
            local unitID = GetQueuedUnitClicked(component)
            local current_character = rm:current_character()
            --if we got a unit name, we can just update the counts now.
            if not is_string(unitID) then
                rm:log("WARNING: could not find Queued Unit ID directly, setting queue stale and re-evaluating the UI.")
                current_character:set_queue_stale()
            end
            if not current_character:is_queue_stale() then --if we aren't stale, we must have a unit
                rm:log("Queued Unit name to be removed is: "..unitID)
                current_character:remove_unit_from_queue(unitID)
                rm:enforce_unit_and_grouped_units(unitID, rm:current_character())
                rm:output_state(current_character) -- will only fire when logging is enabled.
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
            else --backup route.    
                --if we are stale, we might have a unit, but we don't want to rely on anything here!.
                cm:remove_callback("RMOnQueue")
                cm:callback( function() -- we callback this because if we don't do it on a small delay, it will pick up the unit we just cancelled as existing!
                    --we want to re-evaluate the units who were previously in queue, they may have changed.
                    local queue_counts = current_character:get_queue_counts() 
                    rm:enforce_all_units_on_current_character()
                    rm:output_state(current_character)
                    core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
                end, 0.1, "RMOnQueue")
            end
        end
    end,
    true);
    --add queued mercenary clicked listener
    core:add_listener(
    "RecruiterManagerOnQueuedMercenaryClicked",
    "ComponentLClickUp",
    true,
    function(context)
        --# assume context: CA_UIContext
        local component = UIComponent(context.component)
        local queue_component_ID = tostring(component:Id())
        if string.find(queue_component_ID, "temp_merc_") then
            local position = queue_component_ID:gsub("temp_merc_", "")
            rm:log(ast_line.."\tPATH START: Component Clicked was a Queued Mercenary Unit @ ["..position.."]!")
            local current_character = rm:current_character()
            local int_pos = tonumber(position)+1 --# assume int_pos: int
            local unitID = current_character:remove_merc_at_position_returning_key(int_pos)
            --if we got a unit name, we can just update the counts now.
            if not unitID then
                return --no mercenary at this position, do nothing
            end
            rm:log("Queued Mercenary name to be removed is: "..unitID)
            rm:enforce_unit_and_grouped_units(unitID, rm:current_character())
            rm:output_state(current_character) -- will only fire when logging is enabled.
            core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
        end
    end,
    true);


    --add character battle completed listener
    core:add_listener(
    "RecruiterManagerPlayerCharacterBattled",
    "CharacterCompletedBattle",
    function(context)
        return context:character():faction():is_human() and rm:has_character(context:character():command_queue_index()) 
    end,
    function(context)
        rm:log("Player Character Completed Battle!")
        local character = context:character()
        --# assume character: CA_CHAR
        rm:get_character_by_cqi(character:command_queue_index()):set_army_stale()
        rm:get_character_by_cqi(character:command_queue_index()):set_queue_stale()
    end,
    true)



    --add character moved listener
    core:add_listener(
    "RecruiterManagerPlayerCharacterMoved",
    "CharacterFinishedMoving",
    function(context)
        return context:character():faction():is_human() and rm:has_character(context:character():command_queue_index())
    end,
    function(context)
        rm:log("Player Character moved!")
        local character = context:character()
        --# assume character: CA_CHAR
        --the character moved, so we're going to set both their army and their queue stale and force the script to re-evaluate them next time they are available.
        rm:get_character_by_cqi(character:command_queue_index()):set_army_stale()
        rm:get_character_by_cqi(character:command_queue_index()):set_queue_stale()
    end,
    true)

    --add unit trained listener
    core:add_listener(
    "RecruiterManagerPlayerFactionRecruitedUnit",
    "UnitTrained",
    function(context)
        return context:unit():faction():is_human() and rm:has_character(context:unit():force_commander():command_queue_index())
    end,
    function(context)
        local unit = context:unit()
        --# assume unit: CA_UNIT
        local char_cqi = unit:force_commander():command_queue_index();
        rm:log("Player faction recruited a unit!")
        local rec_char = rm:get_character_by_cqi(char_cqi)
        rec_char:clear_mercenary_queue(false)
        rm:get_character_by_cqi(char_cqi):set_queue_stale()
        rec_char:add_unit_to_army(unit:unit_key())
        core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
    end,
    true)

    --add character selected listener
    core:add_listener(
        "RecruiterManagerOnCharacterSelected",
        "CharacterSelected",
        function(context)
        return context:character():faction():is_human() and context:character():has_military_force()
        end,
        function(context)
            rm:log("Human Character Selected by player!")
            local character = context:character()
            --# assume character: CA_CHAR
            --tell RM which character is selected. This is core to the entire system.
            local current_character, was_created = rm:set_current_character(character:command_queue_index()) 
            cm:callback(function()
                if was_created then
                    --rm:check_all_units_on_character(current_character)
                    rm:enforce_all_units_on_current_character()
                elseif current_character:is_queue_stale() or current_character:is_army_stale() then
                    --rm:check_all_units_on_character(current_character)
                    rm:enforce_all_units_on_current_character()
                end
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
            end, 0.1)
        end,
        true)
    

    --add recruit panel open listener
    core:add_listener(
        "RecruiterManagerOnRecruitPanelOpened",
        "PanelOpenedCampaign",
        function(context) 
            local panel = (context.string == "units_recruitment")
            if rm:current_character() == nil then
                return false
            end
            return panel 
        end,
        function(context)
            local current_character = rm:current_character()
            cm:callback(function() --do this on a delay so the panel has time to fully open before the script tries to read it!
                --first, define a holder for our recruit options
                local rec_opt = {} --:map<string, boolean>
                --next, get the paths we need to get
                local pathset = current_character._UIPathSet
                local paths_to_check = pathset:get_path_list(current_character)
                for j = 1, #paths_to_check do
                    local recruitmentList = find_uicomponent_from_table(core:get_ui_root(), pathset:get_path(paths_to_check[j]))
                    if not not recruitmentList then
                        for i = 0, recruitmentList:ChildCount() - 1 do	
                            local recruitmentOption = UIComponent(recruitmentList:Find(i)):Id();
                            local unitID = string.gsub(recruitmentOption, "_recruitable", "")
                            rec_opt[unitID] = true
                        end
                    end
                end
               -- rm:check_all_ui_recruitment_options(current_character, rec_opt)
                rm:enforce_units_by_table(rec_opt, current_character)
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
                rm:output_state(rm:current_character())
            end, 0.1)
        end,
        true
    )

    --add mercenary panel open listener
    core:add_listener(
        "RecruiterManagerOnMercenaryPanelOpened",
        "PanelOpenedCampaign",
        function(context) 
            return context.string == "mercenary_recruitment"; 
        end,
        function(context)
            cm:callback(function() --do this on a delay so the panel has time to fully open before the script tries to read it!
                --check every unit which has a restriction against the character's lists. This will call refresh on queue and army further upstream when necessary!
                local recruitmentList = find_uicomponent(core:get_ui_root(), 
                "units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "mercenary_display", "listview", "list_clip", "list_box")
                local current_character = rm:current_character()
                local record = {} --:map<string, boolean>
                rm:log("PATH START: Looping through all recruitment options")
                for i = 0, recruitmentList:ChildCount() - 1 do	
                    local recruitmentOption = UIComponent(recruitmentList:Find(i)):Id();
                    local unitID = string.gsub(recruitmentOption, "_mercenary", "")
                    rm:enforce_ui_restriction_on_unit(rm:get_unit(unitID))
                end
                rm:output_state(rm:current_character())
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
            end, 0.1)
        end,
        true
    )

    --add listener for mercenary panel closing
    core:add_listener(
        "RecruiterManagerPanelClosedMercenaries",
        "PanelClosedCampaign",
        function(context)
            return context.string == "mercenary_recruitment"; 
        end,
        function(context)
            rm:current_character():clear_mercenary_queue(false)
        end,
        true
    )

    --add disbanded listener
    core:add_listener(
        "RecruiterManagerUnitDisbanded",
        "UnitDisbanded",
        function(context)
            return context:unit():faction():is_human() and rm:has_character(context:unit():force_commander():command_queue_index())
        end,
        function(context)
            rm:log("PATH START Human character disbanded a unit!")
            local unit = context:unit()
            --# assume unit: CA_UNIT
            --remove the unit from the army
            rm:get_character_by_cqi(unit:force_commander():command_queue_index()):remove_unit_from_army(unit:unit_key())
            --check the unit (+groups) again.
            cm:callback(function()
                rm:enforce_all_units_on_current_character()
                rm:output_state(rm:current_character())
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
            end, 0.1)
        end,
        true);
    --add merged listener
    core:add_listener(
        "RecruiterManagerUnitMerged",
        "UnitMergedAndDestroyed",
        function(context)
            return context:new_unit():faction():is_human() and rm:has_character(context:new_unit():force_commander():command_queue_index())
        end,
        function(context)
            rm:log("PATH START Human character merged a unit")
            local unit = context:new_unit():unit_key() --:string
            local cqi = context:new_unit():force_commander():command_queue_index() --:CA_CQI
            rm:get_character_by_cqi(cqi):remove_unit_from_army(unit)
            cm:remove_callback("RMMergeDestroy")
            cm:callback(function()
                rm:enforce_all_units_on_current_character()
                rm:output_state(rm:current_character())
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
            end, 0.2, "RMMergeDestroy")
        end,
        true)
end)

-------------
--transfers--
-------------
RM_TRANSFERS = {} --:map<string, CA_CQI>
--v function() --> CA_CQI
local function find_second_army()

    --v function(ax: number, ay: number, bx: number, by: number) --> number
    local function distance_2D(ax, ay, bx, by)
        return (((bx - ax) ^ 2 + (by - ay) ^ 2) ^ 0.5);
    end;

    local first_char = cm:get_character_by_cqi(rm._UICurrentCharacter)
    local char_list = first_char:faction():character_list()
    local closest_char --:CA_CHAR
    local last_distance = 50 --:number
    local ax = first_char:logical_position_x()
    local ay = first_char:logical_position_y()
    for i = 0, char_list:num_items() - 1 do
        local char = char_list:item_at(i)
        if cm:char_is_mobile_general_with_army(char) then
            if char:command_queue_index() == first_char:command_queue_index() then

            else
                local dist = distance_2D(ax, ay, char:logical_position_x(), char:logical_position_y())
                if dist < last_distance then
                    last_distance = dist
                    closest_char = char
                end
            end
        end
    end
    if closest_char then
        --the extra call is to force load the char into the model
        return rm:get_character_by_cqi(closest_char:command_queue_index()):command_queue_index()
    else
        rm:log("failed to find the other char!")
        return nil
    end
end

--v function(panel: string, index: number) --> (string, boolean)
local function GetUnitNameInExchange(panel, index)
    local Panel = find_uicomponent(core:get_ui_root(), "unit_exchange", panel)
    if not not Panel then
        local armyUnit = find_uicomponent(Panel, "units", "UnitCard" .. index);
        if not not armyUnit then
            armyUnit:SimulateMouseOn();
            local unitInfo = find_uicomponent(core:get_ui_root(), "UnitInfoPopup", "tx_unit-type");
            local rawstring = unitInfo:GetStateText();
            local infostart = string.find(rawstring, "unit/") + 5;
            local infoend = string.find(rawstring, "]]") - 1;
            local armyUnitName = string.sub(rawstring, infostart, infoend)
            rm:log("Found unit ["..armyUnitName.."] at ["..index.."] ")
            local is_transfered = false --:boolean
            local transferArrow = find_uicomponent(armyUnit, "exchange_arrow")
            if not not transferArrow then 
                is_transfered = transferArrow:Visible()
            end
            return armyUnitName, is_transfered
        else
            return nil, false
        end
    end
    return nil, false
end

--v function(reason: string)
local function LockExchangeButton(reason)
    local ok_button = find_uicomponent(core:get_ui_root(), "unit_exchange", "hud_center_docker", "ok_cancel_buttongroup", "button_ok")
    if not not ok_button then
        ok_button:SetInteractive(false)
        ok_button:SetImagePath("ui/custom/recruitment_controls/fuckoffbutton.png")
    else
        rm:log("ERROR: could not find the exchange ok button!")
    end
end

--v function()
local function UnlockExchangeButton()
    local ok_button = find_uicomponent(core:get_ui_root(), "unit_exchange", "hud_center_docker", "ok_cancel_buttongroup", "button_ok")
    if not not ok_button then
        ok_button:SetInteractive(true)
        ok_button:SetImagePath("ui/skins/default/icon_check.png")
    else
        rm:log("ERROR: could not find the exchange ok button!")
    end
end


--v function(army_count: map<string, number>, rec_char: RECRUITER_CHARACTER) --> (boolean, string)
local function check_individual_army_validity(army_count, rec_char)
    local groups = {} --:map<string, number>
    for unit, count in pairs(army_count) do 
       local rec_unit = rec_char:get_unit(unit)
       for groupID, _ in pairs(rec_unit:groups()) do
            groups[groupID] = (groups[groupID] or 0) + (rec_unit:weight() * count)
       end
    end
    for groupID, count in pairs(groups) do
        local limit = rec_char:get_quantity_limit_for_group(groupID)
        if count > limit then
            return false, "Too many "..rm:get_ui_name_for_group(groupID).." units in a single army! ("..count.."/"..limit..")"
        end
    end
    return true, "valid"
end



--v function(first_army_count: map<string, number>, second_army_count:map<string, number>) --> (boolean, string)
local function are_armies_valid(first_army_count, second_army_count)
    local first_result, first_string = check_individual_army_validity(first_army_count, rm:get_character_by_cqi(RM_TRANSFERS.first))
    if first_result == false then
        return first_result, first_string
    end
    local second_result, second_string = check_individual_army_validity(second_army_count, rm:get_character_by_cqi(RM_TRANSFERS.second))
    return second_result, second_string
end

--v function() --> (map<string, number>, map<string, number>)
local function count_armies()
    local first_army_count = {} --:map<string, number>
    local second_army_count = {} --:map<string, number>
    local clock = os.clock()
    for i = 1, 20 do
        local unitID, is_transfer = GetUnitNameInExchange("main_units_panel_1", i)
        if not not unitID then
            if is_transfer then
                if second_army_count[unitID] == nil then
                    second_army_count[unitID] = 0
                end
                second_army_count[unitID] = second_army_count[unitID] + 1
            else
                if first_army_count[unitID] == nil then
                    first_army_count[unitID] = 0
                end
                first_army_count[unitID] = first_army_count[unitID] + 1
            end
        end
    end
    rm:log("First army processed: ".. string.format("elapsed time: %.2f", os.clock() - clock))
    local clock = os.clock()
    for i = 1, 20 do
        local unitID, is_transfer = GetUnitNameInExchange("main_units_panel_2", i)
        if not not unitID then
            if not is_transfer then
                if second_army_count[unitID] == nil then
                    second_army_count[unitID] = 0
                end
                second_army_count[unitID] = second_army_count[unitID] + 1
            else
                if first_army_count[unitID] == nil then
                    first_army_count[unitID] = 0
                end
                first_army_count[unitID] = first_army_count[unitID] + 1
            end
        end
    end
    rm:log("Secondary army processed: ".. string.format("elapsed time: %.2f", os.clock() - clock))
    return first_army_count, second_army_count
end




cm:add_first_tick_callback(function()
    core:add_listener(
        "RecruiterManagerOnExchangePanelOpened",
        "PanelOpenedCampaign",
        function(context) 
            return rm._isEnforcementEnabled and context.string == "unit_exchange"; 
        end,
        function(context)
            cm:callback(function() --do this on a delay so the panel has time to fully open before the script tries to read it!
                -- print_all_uicomponent_children(find_uicomponent(core:get_ui_root(), "unit_exchange"))
                RM_TRANSFERS.first = rm._UICurrentCharacter
                RM_TRANSFERS.second = find_second_army()
                local first_army, second_army = count_armies()
                local valid_armies, reason = are_armies_valid(first_army, second_army)
                if valid_armies then
                    UnlockExchangeButton()
                else
                    rm:log("locking exchange button for reason ["..reason.."] ")
                    LockExchangeButton(reason)
                end
            end, 0.1)
        end,
        true
    )

    core:add_listener(
        "RecruiterManagerOnExchangeOptionClicked",
        "ComponentLClickUp",
        function(context)
            return not not string.find(context.string, "UnitCard") 
        end,
        function(context)
            cm:remove_callback("RMTransferReval")
            cm:callback(function()
                    rm:log("refreshing army validity")
                    local first_army, second_army = count_armies()
                    local valid_armies, reason = are_armies_valid(first_army, second_army)
                    if valid_armies then
                        UnlockExchangeButton()
                    else
                        rm:log("locking exchange button for reason ["..reason.."] ")
                        LockExchangeButton(reason)
                    end
            end, 0.1, "RMTransferReval")
        
        end,
        true);


    core:add_listener(
        "RecruiterManagerOnExchangePanelClosed",
        "PanelClosedCampaign",
        function(context)
            return context.string == "unit_exchange"
        end,
        function(context)
            rm:log("Exchange panel closed, setting armies stale!")
            for _, cqi in pairs(RM_TRANSFERS) do
                rm:get_character_by_cqi(cqi):set_army_stale()
                core:trigger_event("RecruiterManagerGroupCountUpdated", cm:get_character_by_cqi(rm:current_character():command_queue_index()))
            end
            CampaignUI.ClearSelection()
        end,
        true
    )
end)