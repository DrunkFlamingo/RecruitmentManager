--updates the values on an event: RecruiterManagerGroupCountUpdated
--Self-hides on recruitment panel closed event.
--auotdisplays whenever value is updated and rec panel is visible. 
local rm = _G.rm
local GROUP_KEY_TO_UIC = {} --:map<string, CA_UIC>

local group_image_paths = {
    ["special"] = {"ui/custom/recruitment_controls/special_units_1.png", "ttc_group_name_special"},
    ["rare"] = {"ui/custom/recruitment_controls/rare_units_1.png", "ttc_group_name_rare"}
}--:map<string, vector<string>>



local created_uic = {} --:vector<string>

local prefix_to_subculture = {
    bst = "wh_dlc03_sc_bst_beastmen",
    wef = "wh_dlc05_sc_wef_wood_elves",
    brt = "wh_main_sc_brt_bretonnia",
    chs = "wh_main_sc_chs_chaos",
    dwf = "wh_main_sc_dwf_dwarfs",
    emp = "wh_main_sc_emp_empire",
    grn = "wh_main_sc_grn_greenskins",
    nor = "wh_main_sc_nor_norsca",
    vmp = "wh_main_sc_vmp_vampire_counts",
    tmb = "wh2_dlc09_sc_tmb_tomb_kings",
    def = "wh2_main_sc_def_dark_elves",
    hef = "wh2_main_sc_hef_high_elves",
    lzd = "wh2_main_sc_lzd_lizardmen",
    skv = "wh2_main_sc_skv_skaven",
    cst = "wh2_dlc11_sc_cst_vampire_coast"
}--:map<string, string>
local subculture_to_prefix = {} --:map<string, string>
--this is really lazy but I don't want to rewrite this table
for k, v in pairs(prefix_to_subculture) do
    subculture_to_prefix[v] = k
end
--overrides for some subcultures. 
subculture_to_prefix["wh_main_sc_teb_teb"] = "emp"
subculture_to_prefix["wh_main_sc_ksl_kislev"] = "emp"
subculture_to_prefix["wh_main_sc_grn_savage_orcs"] = "grn"

local prefix_to_subculture = nil

local main_unit_to_land_units = {
    ["wh_dlc07_brt_peasant_mob_0"] = "wh_dlc07_brt_inf_peasant_mob_0",
    ["wh_dlc08_nor_mon_warwolves_0"] = "wh_dlc08_nor_mon_marauder_warwolves_0",
    ["wh_dlc08_nor_veh_marauder_warwolves_chariot_0"] = "wh_dlc08_nor_cav_marauder_warwolves_chariot_0",
    ["wh_dlc15_grn_mon_arachnarok_spider_waaagh_0"] = "wh2_dlc15_grn_mon_arachnarok_spider_waaagh_0",
    ["wh_main_brt_shp_buccaneer"] = "wh_main_brt_inf_peasant_bowmen",
    ["wh_main_brt_shp_corsair"] = "wh_main_brt_inf_men_at_arms",
    ["wh_main_brt_shp_galleon"] = "wh_main_brt_inf_spearmen_at_arms",
    ["wh_main_brt_shp_galleon_general"] = "wh_main_brt_cha_lord_0",
    ["wh_main_chs_cha_chaos_sorcerer_death_9"] = "wh_dlc06_chs_cha_chaos_sorcerer_death_9",
    ["wh_main_chs_cha_chaos_sorcerer_fire_9"] = "wh_dlc06_chs_cha_chaos_sorcerer_fire_9",
    ["wh_main_chs_cha_chaos_sorcerer_metal_9"] = "wh_dlc06_chs_cha_chaos_sorcerer_metal_9",
    ["wh_main_chs_shp_bloodship"] = "wh_main_chs_inf_chosen_0",
    ["wh_main_chs_shp_bloodship_general"] = "wh_main_chs_cha_chaos_lord_0",
    ["wh_main_chs_shp_deathgalley"] = "wh_main_chs_inf_chaos_marauders_0",
    ["wh_main_chs_shp_norscan_longship"] = "wh_main_chs_inf_chaos_warriors_0",
    ["wh_main_dwf_shp_dreadnaught"] = "wh_main_dwf_inf_slayers",
    ["wh_main_dwf_shp_dreadnaught_general"] = "wh_main_dwf_cha_lord_0",
    ["wh_main_dwf_shp_ironclad"] = "wh_main_dwf_inf_hammerers",
    ["wh_main_dwf_shp_monitor"] = "wh_main_dwf_inf_dwarf_warrior_0",
    ["wh_main_emp_shp_greatship"] = "wh_main_emp_inf_greatswords",
    ["wh_main_emp_shp_greatship_general"] = "wh_main_emp_cha_general_0",
    ["wh_main_emp_shp_wargalley"] = "wh_main_emp_inf_spearmen_0",
    ["wh_main_emp_shp_wolfship"] = "wh_main_emp_inf_swordsmen",
    ["wh_main_emp_veh_steam_tank"] = "wh_main_emp_veh_steam_tank_driver",
    ["wh_main_grn_shp_bigchukka"] = "wh_main_grn_inf_orc_boyz",
    ["wh_main_grn_shp_drillakilla"] = "wh_main_grn_inf_goblin_spearmen",
    ["wh_main_grn_shp_hulk"] = "wh_main_grn_inf_black_orcs",
    ["wh_main_grn_shp_hulk_general"] = "wh_main_grn_cha_orc_warboss_0",
    ["wh_main_ksl_shp_greatship"] = "wh_main_emp_inf_greatswords",
    ["wh_main_ksl_shp_greatship_general"] = "wh_main_ksl_cha_general_0",
    ["wh_main_ksl_shp_wargalley"] = "wh_main_emp_inf_spearmen_0",
    ["wh_main_ksl_shp_wolfship"] = "wh_main_emp_inf_swordsmen",
    ["wh_main_nor_shp_bloodship"] = "wh_main_nor_inf_chaos_marauders_1",
    ["wh_main_nor_shp_bloodship_general"] = "wh_main_nor_cha_marauder_chieftan_0",
    ["wh_main_nor_shp_deathgalley"] = "wh_main_nor_inf_chaos_marauders_0",
    ["wh_main_nor_shp_norscan_longship"] = "wh_main_nor_inf_chaos_marauders_0",
    ["wh_main_teb_shp_greatship"] = "wh_main_emp_inf_greatswords",
    ["wh_main_teb_shp_greatship_general"] = "wh_main_teb_cha_general_0",
    ["wh_main_teb_shp_wargalley"] = "wh_main_emp_inf_spearmen_0",
    ["wh_main_teb_shp_wolfship"] = "wh_main_emp_inf_swordsmen",
    ["wh_main_vmp_shp_direwolf_ship"] = "wh_main_vmp_inf_crypt_ghouls",
    ["wh_main_vmp_shp_griefship"] = "wh_main_vmp_inf_grave_guard_0",
    ["wh_main_vmp_shp_griefship_general"] = "wh_main_vmp_cha_vampire_lord_0",
    ["wh_main_vmp_shp_vargalley"] = "wh_main_vmp_inf_zombie",
    ["wh2_dlc09_tmb_veh_khemrian_warsphinx_0"] = "wh2_dlc09_tmb_mon_khemrian_warsphinx_0",
    ["wh2_dlc11_cst_cha_cylostra_direfin_0"] = "wh2_dlc11_cst_cha_cylostra_0",
    ["wh2_dlc11_cst_cha_cylostra_direfin_1"] = "wh2_dlc11_cst_cha_cylostra_1",
    ["wh2_dlc11_cst_inf_count_noctilus_0"] = "wh2_dlc11_cst_cha_count_noctilus_0",
    ["wh2_dlc11_cst_inf_count_noctilus_1"] = "wh2_dlc11_cst_cha_count_noctilus_1",
    ["wh2_dlc12_lzd_mon_ancient_stegadon_1_nakai"] = "wh2_dlc12_lzd_mon_ancient_stegadon_1",
    ["wh2_dlc12_lzd_mon_bastiladon_3_nakai"] = "wh2_dlc12_lzd_mon_bastiladon_3",
    ["wh2_dlc13_emp_art_great_cannon_imperial_supply"] = "wh_main_emp_art_great_cannon",
    ["wh2_dlc13_emp_art_helblaster_volley_gun_imperial_supply"] = "wh_main_emp_art_helblaster_volley_gun",
    ["wh2_dlc13_emp_art_helstorm_rocket_battery_imperial_supply"] = "wh_main_emp_art_helstorm_rocket_battery",
    ["wh2_dlc13_emp_cav_demigryph_knights_0_imperial_supply"] = "wh_main_emp_cav_demigryph_knights_0",
    ["wh2_dlc13_emp_cav_demigryph_knights_1_imperial_supply"] = "wh_main_emp_cav_demigryph_knights_1",
    ["wh2_dlc13_emp_cav_empire_knights_imperial_supply"] = "wh_main_emp_cav_empire_knights",
    ["wh2_dlc13_emp_cav_knights_blazing_sun_0_imperial_supply"] = "wh_dlc04_emp_cav_knights_blazing_sun_0",
    ["wh2_dlc13_emp_cav_outriders_1_imperial_supply"] = "wh_main_emp_cav_outriders_1",
    ["wh2_dlc13_emp_cav_pistoliers_1_imperial_supply"] = "wh_main_emp_cav_pistoliers_1",
    ["wh2_dlc13_emp_cav_reiksguard_imperial_supply"] = "wh_main_emp_cav_reiksguard",
    ["wh2_dlc13_emp_inf_greatswords_imperial_supply"] = "wh_main_emp_inf_greatswords",
    ["wh2_dlc13_emp_inf_halberdiers_imperial_supply"] = "wh_main_emp_inf_halberdiers",
    ["wh2_dlc13_emp_inf_handgunners_imperial_supply"] = "wh_main_emp_inf_handgunners",
    ["wh2_dlc13_emp_inf_huntsmen_0_imperial_supply"] = "wh2_dlc13_emp_inf_huntsmen_0",
    ["wh2_dlc13_emp_veh_luminark_of_hysh_0_imperial_supply"] = "wh_main_emp_veh_luminark_of_hysh_0",
    ["wh2_dlc13_emp_veh_steam_tank_imperial_supply"] = "wh_main_emp_veh_steam_tank_driver",
    ["wh2_dlc13_emp_veh_steam_tank_ror_0"] = "wh2_dlc13_emp_veh_steam_tank_driver_ror_0",
    ["wh2_dlc13_emp_veh_war_wagon_0_imperial_supply"] = "wh2_dlc13_emp_veh_war_wagon_0",
    ["wh2_dlc13_emp_veh_war_wagon_1_imperial_supply"] = "wh2_dlc13_emp_veh_war_wagon_1",
    ["wh2_dlc13_lzd_mon_sacred_kroxigors_0_nakai"] = "wh2_dlc13_lzd_mon_sacred_kroxigors_0",
    ["wh2_dlc15_hef_cha_alastair_1"] = "wh2_dlc15_hef_cha_alastar_1",
    ["wh2_dlc16_skv_inf_skavenslave_spearmen_0_flesh_lab"] = "wh2_main_skv_inf_skavenslave_spearmen_0",
    ["wh2_dlc16_skv_inf_skavenslaves_0_flesh_lab"] = "wh2_main_skv_inf_skavenslaves_0",
    ["wh2_dlc16_skv_mon_brood_horror_0_flesh_lab"] = "wh2_dlc16_skv_mon_brood_horror_0",
    ["wh2_dlc16_skv_mon_hell_pit_abomination_flesh_lab"] = "wh2_main_skv_mon_hell_pit_abomination",
    ["wh2_dlc16_skv_mon_rat_ogre_mutant_flesh_lab"] = "wh2_dlc16_skv_mon_rat_ogre_mutant",
    ["wh2_dlc16_skv_mon_rat_ogres_flesh_lab"] = "wh2_main_skv_mon_rat_ogres",
    ["wh2_dlc16_skv_mon_wolf_rats_0_flesh_lab"] = "wh2_dlc16_skv_mon_wolf_rats_0",
    ["wh2_dlc16_skv_mon_wolf_rats_1_flesh_lab"] = "wh2_dlc16_skv_mon_wolf_rats_1",
    ["wh2_main_def_cha_dreadlord_0_black_ark"] = "wh2_main_def_cha_dreadlord_0",
    ["wh2_main_def_mon_war_hydra"] = "wh2_main_def_mon_war_hydra_0",
    ["wh2_main_hef_cha_alastair_0"] = "wh2_main_hef_cha_alastar_0",
    ["wh2_main_hef_cha_alastair_3"] = "wh2_main_hef_cha_alastar_3",
    ["wh2_main_hef_cha_alastair_4"] = "wh2_main_hef_cha_alastar_4",
    ["wh2_main_hef_cha_alastair_5"] = "wh2_main_hef_cha_alastar_5",
    ["wh2_main_lzd_cav_cold_one_spearmen_1"] = "wh2_main_lzd_cav_cold_one_spearriders_1",
    ["wh2_main_lzd_cav_horned_ones_0_nakai"] = "wh2_main_lzd_cav_horned_ones_0",
    ["wh2_main_lzd_inf_temple_guards_nakai"] = "wh2_main_lzd_inf_temple_guards",
    ["wh2_main_lzd_mon_kroxigors_nakai"] = "wh2_main_lzd_mon_kroxigors"    
}--:map<string, string>


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
            local rec_unit = rm:get_unit(unit_key, rec_char)
            if rec_unit:has_group(groupID) then
                local num_points = (num_units + (rec_char._queueCounts[unit_key] or 0)) * rec_unit:weight()
                tt_string = tt_string .. rec_unit:get_localised_string() .. ":  [[col:green]]" .. tostring(num_points) .. "[[/col]]\n"
            end
        end
        for unit_key, num_units in pairs(rec_char._queueCounts) do
            if rec_char._armyCounts[unit_key] == 0 and num_units > 0 then
                local rec_unit = rm:get_unit(unit_key, rec_char)
                if rec_unit:has_group(groupID) then
                    local num_points = num_units * rec_unit:weight()
                    tt_string = tt_string .. rec_unit:get_localised_string() .. ":  [[col:green]]" .. tostring(num_points) .. "[[/col]]\n"
                end
            end
        end
        uic:SetTooltipText(tt_string, true)
    end
end

cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = function(context) 

    for main_unit_key, land_unit_key in pairs(main_unit_to_land_units) do
        rm:get_unit(main_unit_key):set_land_unit(land_unit_key)
    end

    core:add_listener(
        "RecruiterManagerGroupCountUpdated",
        "RecruiterManagerGroupCountUpdated",
        function(context)
            return context:character():faction():is_human()
        end,
        function(context)
            local rec_char = rm:get_character_by_cqi(context:character():command_queue_index())
            local subculture_prefix = subculture_to_prefix[context:character():faction():subculture()]
            --first, lets make sure we have at least default entries for all of this stuff.
            if not subculture_prefix then
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
                            rm:check_all_units_on_character(rec_char)
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
            rm:check_all_units_on_character(rm:current_character())
            rm:enforce_all_units_on_current_character()
        end,
        true
    )

end