local rm = core:get_static_object("recruitment_manager") 
--# assume rm: RECRUITER_MANAGER


rm:create_path_set(
    "CharBoundHordeWithGlobal", 
    {
        ["local_with_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "recruitment_pool_list", "list_clip", "list_box", "local1", "unit_list", "listview", "list_clip", "list_box"},
        ["global_with_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "recruitment_pool_list", "list_clip", "list_box", "global", "unit_list", "listview", "list_clip", "list_box"},
        ["horde_with_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "recruitment_pool_list", "list_clip", "list_box", "local2", "unit_list", "listview", "list_clip", "list_box"},
        ["local_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local1", "unit_list", "listview", "list_clip", "list_box"},
        ["global_no_scroll"] =  {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "global", "unit_list", "listview", "list_clip", "list_box"},
        ["horde_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local2", "unit_list", "listview", "list_clip", "list_box"}
    },
    {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "mercenary_display", "listview", "list_clip", "list_box"},
    function(ca_char)
        if find_uicomponent(core:get_ui_root(), "recruitment_pool_list"):Visible() then
            return {"local_with_scroll", "global_with_scroll", "horde_with_scroll"}
        else
            return {"local_no_scroll", "global_no_scroll", "horde_no_scroll"}
        end
    end
)

rm:create_path_set(
    "CharBoundHordeNoScroll", 
    {
        ["local_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local1", "unit_list", "listview", "list_clip", "list_box"},
        ["global_no_scroll"] =  {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "global", "unit_list", "listview", "list_clip", "list_box"},
        ["horde_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local2", "unit_list", "listview", "list_clip", "list_box"}
    },
    {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "mercenary_display", "listview", "list_clip", "list_box"})

rm:create_path_set(
    "NormalFaction",
    {
        ["local_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local1", "unit_list", "listview", "list_clip", "list_box"},
        ["global_no_scroll"] =  {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "global", "unit_list", "listview", "list_clip", "list_box"}
    },
    {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "mercenary_display", "listview", "list_clip", "list_box"}
)

rm:create_path_set(
    "NoGlobal",
    {
        ["local_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local1", "unit_list", "listview", "list_clip", "list_box"}
    },
    {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "mercenary_display", "listview", "list_clip", "list_box"}
)


rm:create_path_set(
    "NearbyHordeNoGlobal",
    {
        ["local_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local1", "unit_list", "listview", "list_clip", "list_box"},
        ["nearby_horde_no_scroll"] = {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox", "local2", "unit_list", "listview", "list_clip", "list_box"}
    },
    {"units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "mercenary_display", "listview", "list_clip", "list_box"}
)



local ship_subtypes = {
    "wh2_dlc11_cst_noctilus",
    "wh2_dlc11_cst_aranessa",
    "wh2_dlc11_cst_harkon",
    "wh2_dlc11_cst_cylostra",
    "wh2_dlc11_cst_admiral_tech_01",
    "wh2_dlc11_cst_admiral_tech_02",
    "wh2_dlc11_cst_admiral_tech_03",
    "wh2_dlc11_cst_admiral_tech_04"
}--:vector<string>

for i = 1, #ship_subtypes do
    rm:add_subtype_path_filter(ship_subtypes[i], "CharBoundHordeWithGlobal")
end

local default_cultures = {
    "wh_dlc05_sc_wef_wood_elves",
    "wh_main_sc_brt_bretonnia",
    "wh_main_sc_chs_chaos",
    "wh_main_sc_dwf_dwarfs",
    "wh_main_sc_emp_empire",
    "wh_main_sc_grn_greenskins",
    "wh_main_sc_grn_savage_orcs",
    "wh_main_sc_ksl_kislev",
    "wh_main_sc_nor_norsca",
    "wh_main_sc_teb_teb",
    "wh2_dlc09_sc_tmb_tomb_kings",
    "wh2_main_sc_hef_high_elves",
    "wh2_main_sc_skv_skaven",
    "wh2_dlc11_sc_cst_vampire_coast"
}--:vector<string>

for i = 1, #default_cultures do
    rm:add_subculture_path_filter(default_cultures[i], "NormalFaction")
end

local no_global_cultures = {
    "wh_main_sc_vmp_vampire_counts",
}--:vector<string>

for i = 1, #no_global_cultures do
    rm:add_subculture_path_filter(no_global_cultures[i], "NoGlobal")
end

local black_ark_cultures = {
    "wh2_main_sc_def_dark_elves"
}--:vector<string>

for i = 1, #black_ark_cultures do
    rm:add_subculture_path_filter(black_ark_cultures[i], "NearbyHordeNoGlobal")
end

local pseudohorde_enabled_cultures = {
    "wh2_main_sc_lzd_lizardmen",
    "wh_dlc03_sc_bst_beastmen"
}--:vector<string>

for i = 1, #pseudohorde_enabled_cultures do
    rm:add_subculture_path_filter(pseudohorde_enabled_cultures[i], "CharBoundHordeNoScroll")
end


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

for prefix, subculture in pairs(prefix_to_subculture) do
    rm:set_group_prefix_for_subculture(subculture, prefix)
end

rm:set_group_prefix_for_subculture("wh_main_sc_teb_teb", "emp")
rm:set_group_prefix_for_subculture("wh_main_sc_ksl_kislev", "emp")
rm:set_group_prefix_for_subculture("wh_main_sc_grn_savage_orcs", "grn")




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

rm:add_post_setup_callback(function()
    for main_unit_key, land_unit_key in pairs(main_unit_to_land_units) do
        rm:get_unit(main_unit_key):set_land_unit(land_unit_key)
    end
end)


