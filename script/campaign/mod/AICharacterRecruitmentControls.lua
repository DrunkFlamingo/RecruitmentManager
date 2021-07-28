local rm = core:get_static_object("recruitment_manager") 
--# assume rm: RECRUITER_MANAGER


--ai systems to enforce a proxy of recruitment controls on the AI

--v function(unit_totals: map<string, number>, unitID: string)
local function increment_unit_total(unit_totals, unitID)
    if unit_totals[unitID] == nil then
        unit_totals[unitID] = 0
    end
    unit_totals[unitID] = unit_totals[unitID] + 1
end

--v function(group_totals: map<string, number>, groupID: string, weight: number)
local function increment_group_total(group_totals, groupID, weight)
    --rm:log("Incrementing a group total for ["..groupID.."] with weight ["..weight.."] ")
    if group_totals[groupID] == nil then
        group_totals[groupID] = 0
    end
    group_totals[groupID] = group_totals[groupID] + (1* weight)
end

--v function(character: CA_CHAR, groupID: string, difference: number)
local function limit_character(character, groupID, difference)
    if rm:ai_subculture_defaults()[character:faction():subculture()] == nil then
        return
    end
    local diff = difference
    local cqi = character:command_queue_index()

    rm:log("limiting character ["..tostring(cqi).."] in group ["..groupID.."] who has a difference of ["..diff.."] ")
    local unit_list = character:military_force():unit_list()
    for j = 0, unit_list:num_items() - 1 do
        local unit = unit_list:item_at(j):unit_key()
        local groups_list = rm:get_unit(unit):groups()
        for c_groupID, _ in pairs(groups_list) do
            if c_groupID == groupID then
                for l = 0, character:military_force():unit_list():num_items() - 1 do
                    local unit_obj = character:military_force():unit_list():item_at(l)
                    if unit_obj:unit_key() == unit then
                        cm:treasury_mod(unit_obj:faction():name(), unit_obj:get_unit_custom_battle_cost())
                    end
                end
                cm:remove_unit_from_character(cm:char_lookup_str(cqi), unit)
                local default_units = rm:ai_subculture_defaults()[character:faction():subculture()]
                local new_unit = default_units[cm:random_number(#default_units)]
                cm:grant_unit_to_character(cm:char_lookup_str(cqi), new_unit)
                rm:log("removed unit ["..unit.."] and granted ["..new_unit.."] as a replacement unit!")
                if rm:get_weight_for_unit(unit, rm:get_character_by_cqi(cqi)) >= diff then
                    rm:log("removed unit was sufficient!")
                    return
                end
                diff = diff - rm:get_weight_for_unit(unit, rm:get_character_by_cqi(cqi));
                rm:log("removed unit was insufficient, repeating!")
            end
        end
    end
end





--v function(character: CA_CHAR)
local function rm_ai_character(character)
    local rec_char = rm:get_character_by_cqi(character:command_queue_index())
    if cm:char_is_mobile_general_with_army(character) then
        local unit_list = character:military_force():unit_list()
        local unit_totals = {} --:map<string, number>
        local group_totals = {} --:map<string, number>
        for j = 0, unit_list:num_items() - 1 do
            local unit = unit_list:item_at(j):unit_key()
            local groups_list = rec_char:get_unit(unit):groups()
            for groupID, _ in pairs(groups_list) do
                increment_group_total(group_totals, groupID, rm:get_weight_for_unit(unit, rec_char))
            end
        end
        for groupID, quantity in pairs(group_totals) do
            local limit = rec_char:get_quantity_limit_for_group(groupID)
            if quantity > limit then
                limit_character(character, groupID, quantity - limit)
            end
        end
    end
end


--v function(faction:CA_FACTION)
local function rm_ai_evaluation(faction)
    if (faction:name() == "rebels") then
        return
    end

    rm:log("AI CHECKS ["..faction:name().."]")
    local character_list = faction:character_list()
    for i = 0, character_list:num_items() - 1 do
        local character = character_list:item_at(i)
        rm_ai_character(character)
    end

    cm:callback(function()
    for i = 0, character_list:num_items() - 1 do
        local character = character_list:item_at(i)
        local has_mf = character:has_military_force()
        local is_pol = character:is_politician()
        local has_gar_res = character:has_garrison_residence()
        if character:character_type("colonel") and not (has_mf or is_pol or has_gar_res) then
            cm:kill_character(character:command_queue_index(), true, true);
        end
    end
    end, 0.1)
end





cm:add_first_tick_callback(function()

core:add_listener(
    "RecruitmentControlsAI",
    "FactionTurnStart",
    function(context)
        return (not context:faction():is_human()) and rm:should_enforce_ai_restrictions()
    end,
    function(context)
        rm_ai_evaluation(context:faction())
    end,
    true
)
end)

--[[ --TODO unit pools
core:add_listener(
    "RecruitmentControlsAIUnitTrained",
    "UnitTrained",
    function(context)
        return (not context:unit():faction():is_human())
    end,
    function(context)
        local unit = context:unit() --:CA_UNIT
        if rm:unit_has_pool(unit:unit_key()) then
            rm:change_unit_pool(unit:unit_key(), unit:faction():name(), -1)
        end
    end,
    true
)--]]