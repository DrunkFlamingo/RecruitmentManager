local rm = core:get_static_object("recruitment_manager") 

local ovn_subcultures = {
  "wh_main_sc_nor_warp",
  "wh_main_sc_nor_fimir",
  "wh_main_sc_nor_troll",
  "wh_main_sc_lzd_amazon",
  "wh_main_sc_emp_araby",
  "wh_main_sc_nor_albion"
} 

local ship_subtypes = {
    "arb_golden_magus"
}


local prefix_to_subculture = {
    wrp = "wh_main_sc_nor_warp",
    fim = "wh_main_sc_nor_fimir",
    trl = "wh_main_sc_nor_troll",
    amz = "wh_main_sc_lzd_amazon",
    arb = "wh_main_sc_emp_araby",
    alb = "wh_main_sc_nor_albion"
}



local main_unit_to_land_units = {
    ["ovn_boglar_no_garrison"] = "ovn_boglar",
    ["ovn_shearl_no_garrison"] = "ovn_shearl",
    ["wh_dlc01_chs_inf_chaos_warriors_2_no_garrison"] = "wh_dlc01_chs_inf_chaos_warriors_2",
    ["wh_main_chs_inf_chaos_warriors_1_no_garrison"] = "wh_main_chs_inf_chaos_warriors_1",
    ["wh_main_nor_cav_marauder_horsemen_0_no_garrison"] = "wh_main_nor_cav_marauder_horsemen_0",
    ["wh_dlc01_chs_inf_forsaken_0_no_garrison"] = "wh_dlc01_chs_inf_forsaken_0",
    ["elo_albion_warriors_no_garrison"] = "elo_albion_warriors",
    ["elo_albion_warriors_spears_no_garrison"] = "elo_albion_warriors_spears",
    ["wh2_dlc15_grn_mon_river_trolls_0_no_scrap"] = "wh2_dlc15_grn_mon_river_trolls_0",
    ["wh2_dlc15_grn_mon_stone_trolls_0_no_scrap"] = "wh2_dlc15_grn_mon_stone_trolls_0",
    ["ovn_troll_mon_wyvern"] = "wh2_dlc15_grn_mon_wyvern_waaagh_0"
}--:map<string, string>



if not not rm then
    for prefix, subculture in pairs(prefix_to_subculture) do
      rm:set_group_prefix_for_subculture(subculture, prefix)
    end
    
  rm:add_post_setup_callback(function()
    for i = 1, #ovn_subcultures do
      rm:add_subculture_path_filter(ovn_subcultures [i], "NormalFaction")
    end
    for i = 1, #ship_subtypes do
      rm:add_subtype_path_filter(ship_subtypes[i], "CharBoundHordeWithGlobal")
    end
    for main_unit_key, land_unit_key in pairs(main_unit_to_land_units) do
      rm:get_unit(main_unit_key):set_land_unit(land_unit_key)
    end
  end)
end