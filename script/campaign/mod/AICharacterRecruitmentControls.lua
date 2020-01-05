local rm = _G.rm
local subculture_defaults = {
    ["wh_main_sc_emp_empire"] = {"wh_main_emp_inf_swordsmen", "wh_main_emp_inf_handgunners", "wh_main_emp_inf_halberdiers"},
    ["wh_main_sc_dwf_dwarfs"] = {"wh_main_dwf_inf_longbeards", "wh_main_dwf_inf_thunderers_0", "wh_main_dwf_inf_dwarf_warrior_0", "wh_main_dwf_inf_dwarf_warrior_1", "wh_main_dwf_inf_quarrellers_0"},
    ["wh_dlc03_sc_bst_beastmen"] = {"wh_dlc03_bst_inf_gor_herd_0", "wh_dlc03_bst_inf_ungor_raiders_0",  "wh_dlc03_bst_inf_ungor_spearmen_1", "wh_dlc03_bst_inf_gor_herd_0", "wh_dlc03_bst_inf_gor_herd_0"},
    ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_inf_eternal_guard_1", "wh_dlc05_wef_inf_glade_guard_0", "wh_dlc05_wef_inf_dryads_0"},
    ["wh_main_sc_brt_bretonnia"] = {"wh_main_brt_cav_knights_of_the_realm", "wh_dlc07_brt_inf_men_at_arms_2", "wh_main_brt_inf_peasant_bowmen", "wh_main_brt_cav_knights_of_the_realm"},
    ["wh_main_sc_chs_chaos"] = {"wh_main_chs_inf_chaos_warriors_0", "wh_main_chs_cav_chaos_chariot", "wh_main_chs_inf_chaos_warriors_0", "wh_main_chs_inf_chaos_warriors_0", "wh_dlc01_chs_inf_forsaken_0"},
    ["wh_main_sc_grn_greenskins"] = {"wh_main_grn_inf_orc_big_uns", "wh_dlc06_grn_inf_nasty_skulkers_0", "wh_main_grn_inf_orc_arrer_boyz"},
    ["wh_main_sc_grn_savage_orcs"] = {"wh_main_grn_inf_savage_orc_big_uns", "wh_main_grn_inf_savage_orc_arrer_boyz"},
    ["wh_main_sc_nor_norsca"] = {"wh_main_nor_inf_chaos_marauders_0", "wh_dlc08_nor_inf_marauder_hunters_1", "wh_main_nor_inf_chaos_marauders_0", "wh_dlc08_nor_inf_marauder_spearman_0", "wh_main_nor_cav_marauder_horsemen_0"},
    ["wh_main_sc_vmp_vampire_counts"] = {"wh_main_vmp_inf_crypt_ghouls", "wh_main_vmp_inf_skeleton_warriors_0", "wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_inf_zombie"}, 
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {"wh2_dlc09_tmb_inf_nehekhara_warriors_0", "wh2_dlc09_tmb_inf_skeleton_archers_0", "wh2_dlc09_tmb_veh_skeleton_archer_chariot_0", "wh2_dlc09_tmb_inf_nehekhara_warriors_0"},
    ["wh2_main_sc_def_dark_elves"] = {"wh2_main_def_inf_black_ark_corsairs_0","wh2_main_def_inf_darkshards_0", "wh2_main_def_inf_dreadspears_0","wh2_main_def_inf_darkshards_1", "wh2_main_def_inf_bleakswords_0"},
    ["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_inf_spearmen_0", "wh2_main_hef_inf_archers_0", "wh2_main_hef_inf_archers_1", "wh2_main_hef_cav_silver_helms_0", "wh2_main_hef_inf_lothern_sea_guard_1"},
    ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_inf_saurus_warriors_0", "wh2_main_lzd_inf_saurus_spearmen_0", "wh2_main_lzd_inf_saurus_warriors_1", "wh2_main_lzd_inf_skink_cohort_1"},
    ["wh2_main_sc_skv_skaven"]  = {"wh2_main_skv_inf_clanrats_1", "wh2_main_skv_inf_clanrat_spearmen_1", "wh2_main_skv_inf_night_runners_1"},
    ["wh2_dlc11_sc_cst_vampire_coast"] = {"wh2_dlc11_cst_inf_zombie_deckhands_mob_0", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", "wh2_dlc11_cst_inf_zombie_gunnery_mob_1", "wh2_dlc11_cst_inf_zombie_deckhands_mob_1"}
} --:map<string, vector<string>>

for subculture, unit_vector in pairs(subculture_defaults) do
    rm:add_ai_units_for_subculture_with_table(subculture, unit_vector, true)
end


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
    local force = character:military_force()
    local force_cqi = force:command_queue_index()

    rm:log("limiting character ["..tostring(cqi).."] in group ["..groupID.."] who has a difference of ["..diff.."] ")

    while diff > 0 do
        -- find all units in force belonging to group
        local unit_list = force:unit_list()
        local units_to_remove = {}
    for j = 0, unit_list:num_items() - 1 do
            local unit = unit_list:item_at(j)
            local groups_list = rm:get_unit(unit:unit_key()):groups()
            for group_key, _ in pairs(groups_list) do
                if group_key == groupID then
                    table.insert(units_to_remove,unit)
                    break
                    end
                end
        end
        -- pick one at random
        local unit_to_remove = units_to_remove[cm:random_number(#units_to_remove)]
        local unit_to_remove_key = unit_to_remove:unit_key()
        local pt_value = rm:get_weight_for_unit(unit_to_remove_key, rm:get_character_by_cqi(cqi))
        while pt_value > diff do
            unit_to_remove = units_to_remove[cm:random_number(#units_to_remove)]
            unit_to_remove_key = unit_to_remove:unit_key()
            pt_value = rm:get_weight_for_unit(unit_to_remove_key, rm:get_character_by_cqi(cqi))
        end
        -- get the force's value pre-removal
        local prior_value = cm:force_gold_value(force_cqi)
        -- remove it
        cm:remove_unit_from_character(cm:char_lookup_str(cqi), unit_to_remove_key)
        diff = diff - pt_value
        rm:log("removed unit ["..unit_to_remove_key.."] for ["..pt_value.."] points!")

        -- pick a random default unit
                local default_units = rm:ai_subculture_defaults()[character:faction():subculture()]
        local unit_to_add_idx = cm:random_number(#default_units)
        local unit_to_add = default_units[unit_to_add_idx]
        local tries = 1
        while not force:can_recruit_unit(unit_to_add) and tries < #default_units do
            -- retry
            unit_to_add_idx = (unit_to_add_idx % #default_units) + 1
            unit_to_add = default_units[unit_to_add_idx]
            tries = tries + 1
        end

        -- stop here if there's no default unit recruitable selected
        if unit_to_add == nil then
            rm:log("couldn't recruit any randomly selected core unit!")
        else
            -- add the selected default unit
            cm:grant_unit_to_character(cm:char_lookup_str(cqi), unit_to_add)
            rm:log("granted ["..unit_to_add.."] as a replacement unit")
        end
        -- refund reasury the lost gold value of the force
        local refund = prior_value - cm:force_gold_value(force_cqi)
        cm:treasury_mod(character:faction():name(), refund)
        rm:log("refunded "..refund.." for lost value")

        if diff > 0 then
            rm:log("removed unit was insufficient, repeating with diff of ["..diff.."]!")
        elseif diff < 0 then
            rm:log("removed unit was too much?! ERROR! diff of ["..diff.."]")
        else
                    rm:log("removed unit was sufficient!")
                end
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
            local groups_list = rm:get_unit(unit, rec_char):groups()
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
    --[[ TODO Unit Pools
    if not rm._unitPoolQuantities[faction:name()] == nil then
        for unit, quantity in pairs(rm._unitPoolQuantities[faction:name()]) do
            if quantity <= 0 then
                rm:log("AI Faction ["..faction:name().."] is out of unit "..unit.." ")
                cm:add_event_restricted_unit_record_for_faction(unit, faction:name())
            else
                cm:remove_event_restricted_unit_record_for_faction(unit, faction:name())
            end
        end
    end--]]
    --TODO clone colonel fix
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