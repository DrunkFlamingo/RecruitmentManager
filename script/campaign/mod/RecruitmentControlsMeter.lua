--updates the values on an event: RecruiterManagerGroupCountUpdated
--Self-hides on recruitment panel closed event.
--auotdisplays whenever value is updated and rec panel is visible. 
local rm = core:get_static_object("recruitment_manager") 
--# assume rm: RECRUITER_MANAGER
local GROUP_KEY_TO_UIC = {} --:map<string, CA_UIC>

local group_image_paths = {
    ["special"] = {"ui/custom/recruitment_controls/special_units_1.png", "ttc_group_name_special"},
    ["rare"] = {"ui/custom/recruitment_controls/rare_units_1.png", "ttc_group_name_rare"}
}--:map<string, vector<string>>



local created_uic = {} --:vector<string>


--overrides for some subcultures. 




--helpers
--do small stuff for the UI
--v function(loc: string, ...: string) --> string
local function fill_loc(loc, ...)
    local output = loc
    for i = 1, arg.n do
        local f = i - 1
        local gsub_text = f..f..f..f
        output = string.gsub(output, gsub_text, arg[i])
    end
    return output
end


--v function(uic: CA_UIC, rec_char: RECRUITER_CHARACTER, groupID: string)
local function update_display(uic, rec_char, groupID)
    local loc_meter_tooltip = effect.get_localised_string("ttc_meter_tooltip")
    local loc_points = effect.get_localised_string("ttc_measurement_name")
    local image = nil --:string
    local name = nil --:string
    for k,v in pairs(group_image_paths) do
        if groupID:find(k) then
            image = v[1]
            name = effect.get_localised_string(v[2])
            break
        end
    end
    local quantity = rec_char:get_group_counts_on_character(groupID)
    local cap = rec_char:get_quantity_limit_for_group(groupID)
    if image then
        uic:SetImagePath(image, 1)
    end
    if quantity and cap then
        uic:SetStateText(tostring(cap - quantity))
        uic:SetVisible(true)
    end
    local col = "dark_g"
    if quantity >= cap then
        col = "red"
    end
    if name and quantity and cap then
        local tt_string = fill_loc(loc_meter_tooltip, tostring(quantity), tostring(cap), name, loc_points)
        for unit_key, num_units in pairs(rec_char._armyCounts) do
            local rec_unit = rec_char:get_unit(unit_key)
            if rec_unit:has_group(groupID) then
                local num_points = (num_units + (rec_char._queueCounts[unit_key] or 0)) * rec_unit:weight()
                local unit_loc = rec_unit:get_localised_string()
                if unit_loc == "" then
                    unit_loc = unit_key .. "(MISSING LAND UNIT LOCALISATION)"
                end
                tt_string = tt_string .. unit_loc .. ":  [[col:green]]" .. tostring(num_points) .. "[[/col]]\n"
            end
        end
        for unit_key, num_units in pairs(rec_char._queueCounts) do
            if (not rec_char._armyCounts[unit_key]) and num_units > 0 then
                local rec_unit = rec_char:get_unit(unit_key)
                if rec_unit:has_group(groupID) then
                    local num_points = num_units * rec_unit:weight()
                    tt_string = tt_string .. rec_unit:get_localised_string() .. ":  [[col:green]]" .. tostring(num_points) .. "[[/col]]\n"
                end
            end
        end
        local mercs = {} --:map<RECRUITER_UNIT, number>
        for k = 1, #rec_char._mercenaryQueue do
            local rec_unit = rec_char._mercenaryQueue[k]
            mercs[rec_unit] = mercs[rec_unit] or 0
            mercs[rec_unit] = mercs[rec_unit] + 1
        end
        for rec_unit, num_units in pairs(mercs) do
            local unit_key = rec_unit:key()
            if rec_unit:has_group(groupID) then
                local num_points = num_units * rec_unit:weight()
                tt_string = tt_string .. rec_unit:get_localised_string() .. ":  [[col:green]]" .. tostring(num_points) .. "[[/col]]\n"
            end
        end
        uic:SetTooltipText(tt_string, true)
    end
end

cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = function(context) 



    core:add_listener(
        "RecruiterManagerGroupCountUpdated",
        "RecruiterManagerGroupCountUpdated",
        function(context)
            return context:character():faction():is_human() and rm._isEnforcementEnabled
        end,
        function(context)
            local subculture = context:character():faction():subculture()
            local rec_char = rm:get_character_by_cqi(context:character():command_queue_index())
            local subculture_prefix = rm._subculturePrefixes[subculture]
            --first, lets make sure we have at least default entries for all of this stuff.
            if not subculture_prefix then
                rm:log("No subculture prefix found for "..subculture)
                return
            end
            for suffix, _ in pairs(group_image_paths) do
                local groupID = subculture_prefix.."_"..suffix
                local uicParent = find_uicomponent(core:get_ui_root(),"units_panel", "main_units_panel", "icon_list")
                if uicParent then
                    local uic = find_uicomponent(uicParent, "rm_display_"..groupID)
                    if not uic then
                        local uicSibling = find_uicomponent(uicParent, "dy_upkeep")
                        if uicSibling then
                            local new_uic = UIComponent(uicSibling:CopyComponent("rm_display_"..groupID))
                            created_uic[#created_uic+1] = "rm_display_"..groupID
                            --[[local header_bar = find_uicomponent(core:get_ui_root(),"units_panel", "main_units_panel", "header")
                            if header_bar then
                                local current_x, current_y = header_bar:Position()
                                local current_h = header_bar:Height()
                                local element_pos_x, element_pos_y = new_uic:Position()
                                local mov = header_bar:IsMoveable()
                                header_bar:SetMoveable(true)
                                header_bar:MoveTo(current_x, element_pos_y - current_h)
                                header_bar:SetMoveable(mov)
                            end--]] --this doesn't work very well. Its functional though.
                            update_display(new_uic, rec_char, groupID)
                        end
                    else
                        update_display(uic, rec_char, groupID)
                    end
                end
            end
            if rec_char._queueNum > 0 then
                local can_auth = true --:boolean
                cm:remove_callback("RMauth")
                cm:callback(function() 
                    local queue_element = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units", "QueuedLandUnit "..rec_char._queueNum - 1)
                    if can_auth and not queue_element then
                        rm:log("Queue Authentication failed!")
                        can_auth = false 
                        cm:callback(function() 
                            rec_char:set_queue_stale()
                            rm:enforce_all_units_on_current_character()
                            can_auth = true
                        end, 0.1, "RMauth2")
                    end
                end, 0.1, "RMauth")
            end
        end,
        true
    )

    core:add_listener(
        "CharacterSelectedMonitorUI",
        "CharacterSelected",
        function(context)
            return (not context:character():has_military_force()) or (context:character():faction():name() ~= cm:get_local_faction(true))
        end,
        function(context)
            cm:callback(function()
                for i = 1, #created_uic do
                    local uicParent = find_uicomponent(core:get_ui_root(),"units_panel", "main_units_panel", "icon_list")
                    if uicParent then
                        local uic = find_uicomponent(uicParent, created_uic[i])
                        if uic then
                            uic:SetVisible(false)
                        end
                    end
                end
            end, 0.1)
        end,
        true)

    core:add_listener(
        "RefreshCharacterHack",
        "ComponentLClickUp",
        function(context)
            return not not string.find(context.string, "rm_display_")
        end,
        function(context)
            rm:enforce_all_units_on_current_character()
        end,
        true
    )

end