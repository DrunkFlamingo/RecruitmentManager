--adds new units to Drunk Flamingo's TT-based unit caps script


rm = _G.rm;

local ctt_ovn_all_units = {

    ---------------------------------------------------------------
    --ALBION
    ---------------------------------------------------------------

    {"elo_albion_warriors", "alb_core"},
    {"elo_albion_warriors_spears", "alb_core"},
    {"elo_albion_warriors_2h", "alb_core"},
    {"elo_youngbloods", "alb_core"},
    {"albion_huntresses", "alb_core"},
    {"albion_riders", "alb_core"},
    {"albion_riders_javelins", "alb_core"},
    {"albion_riders_spear", "alb_core"},
    {"elo_bloodhounds", "alb_core"},
    {"ovn_barrow_wight", "alb_special", 1},
    {"albion_hearthguard", "alb_special", 1},
    {"albion_hearthguard_halberd", "alb_special", 1},
    {"albion_hearthguard_2h", "alb_special", 1},
    {"elo_woadraider", "alb_special", 1},
    {"albion_swordmaiden", "alb_special", 1},
    {"alb_cav_noble", "alb_special", 1},
    {"alb_cav_noble_spear", "alb_special", 1},
    {"albion_centaurs", "alb_special", 1},
    {"alb_viridian_champ", "alb_special", 2},
    {"albion_chariot", "alb_special", 2},
    {"albion_half_giants", "alb_special", 2},
    {"druid_neophytes", "alb_special", 3},
    {"elo_fenbeast", "alb_rare", 1},
    {"elo_albion_gryphon", "alb_rare", 1},
    {"wh2_dlc16_wef_mon_zoats", "alb_rare", 1},
    {"albion_giant", "alb_rare", 2},
    {"ovn_alb_inf_stone_throw_giant", "alb_rare", 2},
    {"albion_stonethrower", "alb_rare", 2},
    {"albion_fenhulk", "alb_rare", 3},
    
    {"albion_warriors_lugh", "alb_core"},
    {"albion_woadraider_sworn_ror", "alb_special", 1},
    {"albion_shieldmaiden_ror", "alb_special", 1},
    {"albion_highlander_ror", "alb_special", 1},
    {"albion_huntresses_warden_ror", "alb_core"},
    {"alb_cav_noble_first_ror", "alb_special", 1},
    {"albion_centaur_hunter_ror", "alb_special", 1},
    {"elo_fly_infested_rotwood", "alb_rare", 1},
    {"albion_bologs_giant_ror", "alb_rare", 2},
    {"albion_cachtorr_stonethrower", "alb_rare", 2},

    ---------------------------------------------------------------
    --ARABY
    ---------------------------------------------------------------

    {"ovn_slave", "arb_core"},
    {"OtF_khemri_spearmen", "arb_core"},
    {"OtF_khemri_swordsmen", "arb_core"},
    {"ovn_corsairs", "arb_core"},
    {"OtF_khemri_archers", "arb_core"},
    {"ovn_yeoman", "arb_core"},
    {"OtF_khemri_knights", "arb_core"},
    {"ovn_yeomanarchers", "arb_core"},
    {"ovn_jag", "arb_special", 1},
    {"ovn_glad", "arb_special", 1},
    {"OtF_khemri_elite_guard", "arb_special", 1},
    {"ovn_southlander", "arb_special", 1},
    {"OtF_khemri_kepra_guard", "arb_special", 1},
    {"OtF_khemri_rangers", "arb_special", 1},
    {"ovn_arb_cav_lancer_camel", "arb_special", 1}, 
    {"ovn_arb_cav_archer_camel", "arb_special", 1},
    {"wh_main_arb_cav_magic_carpet_0", "arb_special", 1},
    {"ovn_jez", "arb_special", 2},
    {"ovn_cat_knights", "arb_special", 2},
    {"ovn_arb_cav_jezzail_camel", "arb_special", 2},
    {"sr_ogre_arb", "arb_special", 2},
    {"ovn_ifreet", "arb_rare", 1},
    {"ovn_scor", "arb_rare", 1},
    {"akp_brt_ballista", "arb_rare", 1},
    {"ovn_arb_art_trebuchet", "arb_rare", 1},
    {"ovn_arb_mon_genie", "arb_rare", 1},
    {"ovn_arb_cav_scorpion", "arb_rare", 2},
    {"ovn_arb_art_grand_bombard", "arb_rare", 2},
    {"wh_main_arb_mon_elephant", "arb_rare", 2},
    {"wh_main_arb_mon_war_elephant", "arb_rare", 2},
    {"ovn_prometheans", "arb_special", 2},
    {"hous_nec", "arb_rare", 3},

    {"ovn_knights_ror", "arb_core"},
    {"ovn_jag_ror", "arb_special", 1},
    {"ovn_jez_ror", "arb_special", 2},
    {"ovn_cat_knights_ror", "arb_special", 2},
    {"ovn_bom_ror", "arb_rare", 2},
    {"ovn_elephant_ror", "arb_rare", 2},
    {"ovn_arb_mon_war_elephant_ror", "arb_rare", 3},

    ---------------------------------------------------------------
    --BLOOD DRAGONS
    ---------------------------------------------------------------
    
    {"dismounted_blood_knights_shield", "vmp_rare", 1},
    {"dismounted_blood_knights", "vmp_rare", 1},
    {"ovn_vmp_mon_skeleton_giant", "vmp_rare", 2},

    ---------------------------------------------------------------
    --CHAOS DWARFS
    ---------------------------------------------------------------
    
    {"goblin_slaves", "wrp_core"},
    {"hobgoblin_cuthroats", "wrp_core"},
    {"hobgoblin_sneaky_gits", "wrp_core"},
    {"orc_slaves", "wrp_core"},
    {"chaos_dwarf_warriors", "wrp_core"},
    {"chaos_dwarf_warriors_great_weapons", "wrp_core"},
    {"infernal_guard", "wrp_core"},
    {"infernal_guard_great_weapons", "wrp_core"},
    {"hobgoblin_archers", "wrp_core"},
    {"chaos_dwarf_warriors_quarrellers", "wrp_core"},
    {"chaos_dwarf_warriors_rifles", "wrp_core"},
    {"hobgoblin_wolf_spears", "wrp_core"},
    {"hobgoblin_wolf_bow_raider", "wrp_core"},
    {"black_orc_slaves_dual", "wrp_special", 1},
    {"immortals", "wrp_special", 1},
    {"hobgoblin_hobhound_ravagers", "wrp_special", 1},
    {"bull_centaur_render", "wrp_special", 1},
    {"hobgoblin_bolt_thrower", "wrp_special", 1},
    {"infernal_guard_zealot", "wrp_special", 1},
    {"infernal_guard_acolytes", "wrp_special", 2},
    {"infernal_guard_deathmask_naphta", "wrp_special", 2},
    {"chaos_dwarf_annihilators", "wrp_special", 2},
    {"slave_ogre", "wrp_special", 2},
    {"lava_troll", "wrp_special", 2},
    {"k'daai_fireborn", "wrp_special", 2},
    {"bull_centaur_ba'hal", "wrp_special", 2},
    {"magma_cannon", "wrp_special", 2},
    {"deathshrieker_rocket_launcher", "wrp_special", 2},
    {"great_taurus", "wrp_rare", 1},
    {"bull_centaur_render_great_weapons", "wrp_rare", 2},
    {"lammasu", "wrp_rare", 2},
    {"cr_chd_mon_siege_giant", "wrp_rare", 2},
    {"iron_daemon", "wrp_rare", 2},
    {"k'daai_destroyer", "wrp_rare", 3},
    {"dreadquake_mortar", "wrp_rare", 3},

    {"chaos_dwarf_warriors_horde", "wrp_core"},
    {"ironsworn", "wrp_special", 1},
    {"granite_guard", "wrp_special", 1},
    {"magma_beasts", "wrp_special", 2},
    {"bull_centaur_ba'hal_guardians", "wrp_special", 2},

    ---------------------------------------------------------------
    --CITADEL OF DUSK
    ---------------------------------------------------------------

    {"ovn_hef_inf_archers_sea", "hef_core"},
    {"ovn_hef_inf_archers_fire", "hef_core"},
    {"ovn_hef_inf_archers_wind", "hef_core"},
    {"ovn_hef_inf_spearmen_falcon", "hef_core"},
    {"ovn_hef_inf_spearmen_sapphire", "hef_core"},
    {"ovn_hef_cav_ellyrian_reavers_shore", "hef_core"},

    ---------------------------------------------------------------
    --DREAD KING
    ---------------------------------------------------------------

    {"elo_dread_inf_grave_guard_0", "tmb_special", 1},
    {"elo_dread_mummy", "tmb_special", 2},
    {"elo_tomb_guardian", "tmb_special", 2},
    {"elo_tomb_guardian_archers", "tmb_special", 2},
    {"elo_tomb_guardian_spears", "tmb_special", 2},
    {"elo_tomb_guardian_2h_waepons", "tmb_special", 3},
    {"black_grail_knights_tmb", "tmb_rare", 1},
    {"ovn_dkl_mon_skeleton_giant", "tmb_rare", 2},

    ---------------------------------------------------------------
    --FIMIR
    ---------------------------------------------------------------

    {"ovn_boglar", "fim_core"},
    {"ovn_boglar_no_garrison", "fim_core"},
    {"ovn_shearl", "fim_core"},
    {"ovn_shearl_no_garrison", "fim_core"},
    {"ovn_marsh_hounds", "fim_core"},
    {"ovn_death_quest", "fim_core"},
    {"ovn_fim_mon_javelin_0", "fim_core"},
    {"ovn_finmor", "fim_special", 1},
    {"ovn_fim_mon_caster_0", "fim_special", 1},
    {"ovn_fim_cav_bog_beast_riders_0", "fim_special", 2},
    {"ovn_fimm", "fim_special", 3},
    {"ovn_fianna_fimm", "fim_special", 3},
    {"ovn_mistmor", "fim_rare", 1},
    {"ovn_zoat", "fim_rare", 2},

    {"ovn_killing_eye", "fim_core"},
    {"ovn_finmor_belakor", "fim_special", 1},
    {"ovn_gharnus_demon", "fim_special", 3},

    ---------------------------------------------------------------
    --FIMIR -- HARBINGER EXTRAS --
    ---------------------------------------------------------------

    {"Great_Deamon1_unit", "fim_rare", 3},
    
    ---------------------------------------------------------------
    --GRUDGEBRINGERS -- OMEN UNITS ONLY --
    ---------------------------------------------------------------

    {"grudgebringer_cavalry", "emp_core"},
    {"grudgebringer_infantry", "emp_core"},
    {"grudgebringer_crossbow", "emp_core"},
    {"grudgebringer_cannon", "emp_special", 2},
    {"azguz_bloodfist_dwarf_warriors", "emp_core"},
    {"dargrimm_firebeard_dwarf_warriors", "emp_core"},
    {"carlsson_cavalry", "emp_core"},
    {"carlsson_guard", "emp_core"},
    {"keelers_longbows", "emp_core"},
    {"helmgart_bowmen", "emp_core"},
    {"countess_guard", "emp_core"},
    {"elrod_wood_elf_glade_guards", "emp_core"},
    {"galed_elf_archers", "emp_core"},
    {"ragnar_wolves", "emp_special", 1},
    {"black_avangers", "emp_special", 1},
    {"vannheim_75th", "emp_special", 2},
    {"urblab_rotgut_mercenary_ogres", "emp_special", 2},
    {"treeman_knarlroot", "emp_rare", 2},
    {"treeman_gnarl_fist", "emp_rare", 2},

    ---------------------------------------------------------------
    --HALFLINGS
    ---------------------------------------------------------------

    {"halfling_militia", "emp_core"},
    {"halfling_milittia_arch", "emp_core"},
    {"halfling_milittia_great", "emp_core"}, 
    {"halfling_spear", "emp_core"},
    {"elo_bloodhounds", "emp_core"},
    {"half_pig", "emp_core"},
    {"halfling_archer", "emp_special", 1},
    {"halfling_cook", "emp_special", 1},
    {"halfling_inf", "emp_special", 1},
    {"halfling_thief", "emp_special", 1},
    {"halfling_warden_great", "emp_special", 1}, 
    {"ovn_mtl_cav_poultry_riders_0", "emp_special", 1},
    {"ovn_mtl_cav_swine_riders_0", "emp_special", 1},
    {"sr_ogre", "emp_special", 2},
    {"elo_supply_wagon", "emp_rare", 1},
    {"hlf_roast_pig", "emp_rare", 1},
    {"ovn_mtl_art_hotpot", "emp_rare", 1},
    {"wh_main_mtl_veh_soupcart", "emp_rare", 2},
    {"hlf_baby_dragon", "emp_rare", 2},

    {"halfling_warfoot", "emp_special", 1}, 
    {"halfling_cock", "emp_special", 1},
    {"halfling_cook_ror", "emp_special", 1}, 
    {"sr_ogre_ror", "emp_special", 2},
    {"halfling_cat_ror", "emp_rare", 1},
    {"ovn_mtl_art_hotpot_ror", "emp_rare", 1},

    ---------------------------------------------------------------
    --ROTBLOOD
    ---------------------------------------------------------------
    
    {"ovn_rbt_ch_blightstormer", "wrp_special", 2},
    {"CTT_skv_inf_stormvermin_1", "wrp_special", 1},
    {"CTT_skv_inf_ratling_gun_0", "wrp_special", 1},
    {"CTT_skv_inf_death_globe_bombardiers", "wrp_rare", 1},
    {"CTT_skv_inf_warpfire_thrower", "wrp_special", 1},

    ---------------------------------------------------------------
    --TROLLS
    ---------------------------------------------------------------

    {"elo_carrion_gobbo_bow", "trl_core"},
    {"elo_carrion_gobbo_melee", "trl_core"},
    {"elo_southern_trolls", "trl_core"},
    {"elo_river_trolls", "trl_core"},
    {"elo_carrion_squig_hoppers", "trl_special", 1},
    {"elo_forest_trolls", "trl_special", 1},
    {"ovn_trl_inf_stone_throw_troll", "trl_special", 1},
    {"elo_armoured_icetrolls", "trl_special", 2},
    {"elo_lava_trolls", "trl_special", 2},
    {"elo_mountain_trolls", "trl_special", 3},
    {"elo_bile_trolls", "trl_rare", 2},
    {"elo_snow_troll", "trl_rare", 2},
    {"ovn_troll_mon_wyvern", "trl_rare", 2},

    {"elo_red_avalanche", "trl_special", 2},
    {"elo_shipwreckers", "trl_special", 2},
    {"elo_warpstone_trolls", "trl_special", 3},
    {"elo_night_trolls_ror", "trl_rare", 1},
    {"elo_kin", "trl_rare", 2},
    
    {"elo_river_trolls_erengrad", "trl_core"},
    {"elo_forest_trolls_erengrad", "trl_special", 1},
    {"elo_armoured_icetrolls_erengrad", "trl_special", 2},
    {"elo_mountain_trolls_erengrad", "trl_special", 3},
    {"elo_snow_troll_erengrad", "trl_rare", 2}
                }


local ctt_ovn_all_loaned_units = {

    ---------------------------------------------------------------
    --ARABY
    ---------------------------------------------------------------

    {"teb_muktar", "wh_main_sc_emp_araby", "arb_core"},

    {"wh_main_grn_mon_giant", "wh_main_sc_emp_araby", "arb_rare", 2},

    {"wh2_dlc11_cst_mon_animated_hulks_0", "wh_main_sc_emp_araby", "arb_special", 1},
    {"wh2_dlc11_cst_mon_bloated_corpse_0", "wh_main_sc_emp_araby", "arb_core"},

    {"wh_main_chs_inf_chaos_warriors_0", "wh_main_sc_emp_araby", "arb_special", 1},
    {"wh_dlc06_chs_inf_aspiring_champions_0", "wh_main_sc_emp_araby", "arb_special", 2},
    {"wh_main_chs_cav_chaos_knights_0", "wh_main_sc_emp_araby", "arb_special", 2},
    {"wh_main_chs_mon_chaos_spawn", "wh_main_sc_emp_araby", "arb_rare", 2},
    {"wh2_dlc09_tmb_veh_skeleton_chariot_0", "wh_main_sc_emp_araby", "arb_special", 1},
    {"wh2_dlc09_tmb_inf_nehekhara_warriors_0", "wh_main_sc_emp_araby", "arb_special", 1},
    {"wh2_dlc09_tmb_inf_tomb_guard_1", "wh_main_sc_emp_araby", "arb_special", 2},
    {"wh2_dlc09_tmb_cav_necropolis_knights_0", "wh_main_sc_emp_araby", "arb_special", 2},
    {"wh2_dlc09_tmb_mon_ushabti_0", "wh_main_sc_emp_araby", "arb_special", 2},

    ---------------------------------------------------------------
    --CHAOS DWARFS
    ---------------------------------------------------------------

    {"elo_lava_trolls", "wh_main_sc_nor_warp", "wrp_special", 2},

    ---------------------------------------------------------------
    --FIMIR
    ---------------------------------------------------------------

    {"wh2_dlc11_cst_mon_bloated_corpse_0", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh2_dlc15_grn_mon_river_trolls_0_no_scrap", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_dlc08_nor_mon_fimir_0", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_dlc08_nor_mon_fimir_1", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_dlc08_nor_mon_norscan_ice_trolls_0", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_dlc08_nor_mon_frost_wyrm_0", "wh_main_sc_nor_fimir", "fim_rare", 2},
    {"ovn_fenbeast", "wh_main_sc_nor_fimir", "fim_rare", 1},
    {"ovn_fenhulk", "wh_main_sc_nor_fimir", "fim_rare", 3},

    {"wh_pro04_nor_mon_fimir_ror_0", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_pro04_chs_mon_chaos_spawn_ror_0", "wh_main_sc_nor_fimir", "fim_rare", 2},

    {"wh_dlc01_chs_inf_chaos_warriors_2_no_garrison", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_dlc01_chs_inf_forsaken_0_no_garrison", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_dlc08_nor_inf_marauder_hunters_1", "wh_main_sc_nor_fimir", "fim_special", 1},
    {"wh_main_chs_inf_chaos_marauders_0", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_main_chs_inf_chaos_warriors_0", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_main_chs_inf_chaos_warriors_1_no_garrison", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_main_nor_cav_marauder_horsemen_0_no_garrison", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_main_chs_mon_chaos_warhounds_0", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_main_chs_mon_chaos_warhounds_1", "wh_main_sc_nor_fimir", "fim_core"},
    {"wh_main_chs_mon_trolls", "wh_main_sc_nor_fimir", "fim_special", 1},
    {"wh_main_chs_inf_chosen_0", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_main_chs_mon_giant", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_main_chs_art_hellcannon", "wh_main_sc_nor_fimir", "fim_rare", 2},
    {"wh_main_chs_mon_chaos_spawn", "wh_main_sc_nor_fimir", "fim_rare", 2},
    {"wh_dlc06_chs_feral_manticore", "wh_main_sc_nor_fimir", "fim_special", 2},
    {"wh_pro04_nor_mon_marauder_warwolves_ror_0", "wh_main_sc_nor_fimir", "fim_core"},

    {"rbt_nurgle_daemon", "wh_main_sc_nor_fimir", "fim_special", 1},
    {"kho_bloodletter", "wh_main_sc_nor_fimir", "fim_special", 1},

    {"albion_riders_javelins_no_garrison", "wh_main_sc_nor_fimir", "fim_core"},
    {"elo_albion_warriors_no_garrison", "wh_main_sc_nor_fimir", "fim_core"},
    {"elo_albion_warriors_spears_no_garrison", "wh_main_sc_nor_fimir", "fim_core"},
    {"albion_centaurs", "wh_main_sc_nor_fimir", "fim_special", 1},

    ---------------------------------------------------------------
    --HALFLINGS
    ---------------------------------------------------------------

    {"wh2_dlc10_hef_inf_dryads_0", "wh_main_sc_emp_empire", "emp_core"},
    {"wh2_dlc10_hef_mon_treekin_0", "wh_main_sc_emp_empire", "emp_special", 2},
    {"wh2_dlc10_hef_mon_treeman_0", "wh_main_sc_emp_empire", "emp_rare", 3},
    {"wh2_main_hef_mon_great_eagle", "wh_main_sc_emp_empire", "emp_rare", 1},

    ---------------------------------------------------------------
    --ROTBLOOD
    ---------------------------------------------------------------

    {"wh_main_nor_mon_chaos_warhounds_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_main_nor_inf_chaos_marauders_0", "wh_main_sc_nor_warp", "wrp_rare", 3},
    {"wh_dlc08_nor_inf_marauder_hunters_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_main_nor_cav_marauder_horsemen_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_dlc08_nor_inf_marauder_berserkers_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_dlc08_nor_inf_marauder_hunters_1", "wh_main_sc_nor_warp", "wrp_special", 1},
    {"wh_main_nor_cav_marauder_horsemen_1", "wh_main_sc_nor_warp", "wrp_special", 1},
    {"wh_dlc08_nor_mon_warwolves_0", "wh_main_sc_nor_warp", "wrp_special", 1},
    {"wh_main_nor_mon_chaos_trolls", "wh_main_sc_nor_warp", "wrp_special", 1},
    {"wh_dlc08_nor_mon_norscan_ice_trolls_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_dlc08_nor_cav_marauder_horsemasters_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_dlc08_nor_mon_frost_wyrm_0", "wh_main_sc_nor_warp", "wrp_rare", 2},

    {"elo_bile_trolls", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"rbt_nurgle_daemon", "wh_main_sc_nor_warp", "wrp_special", 1},

    {"wh_main_chs_inf_chaos_marauders_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_main_chs_inf_chaos_warriors_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_main_chs_inf_chaos_warriors_1", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_dlc01_chs_inf_chaos_warriors_2", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_dlc01_chs_inf_forsaken_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_main_chs_mon_chaos_warhounds_1", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_main_chs_cav_chaos_chariot", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh_main_chs_mon_trolls", "wh_main_sc_nor_warp", "wrp_special", 1},
    {"wh_main_chs_inf_chosen_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_main_chs_inf_chosen_1", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_dlc01_chs_inf_chosen_2", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_dlc06_chs_inf_aspiring_champions_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_dlc06_chs_feral_manticore", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_main_chs_cav_chaos_knights_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_main_chs_cav_chaos_knights_1", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_dlc01_chs_mon_dragon_ogre", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh_dlc01_chs_mon_dragon_ogre_shaggoth", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh_main_chs_mon_chaos_spawn", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh_main_chs_mon_giant", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh_main_chs_art_hellcannon", "wh_main_sc_nor_warp", "wrp_rare", 2},

    {"wh2_main_skv_inf_clanrat_spearmen_1", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh2_main_skv_inf_clanrats_1", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh2_main_skv_inf_skavenslave_spearmen_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh2_main_skv_inf_skavenslaves_0", "wh_main_sc_nor_warp", "wrp_core"},
    {"wh2_main_skv_mon_rat_ogres", "wh_main_sc_nor_warp", "wrp_special", 2},

    {"wh2_dlc12_skv_inf_warplock_jezzails_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh2_dlc12_skv_veh_doom_flayer_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh2_dlc14_skv_inf_eshin_triads_0", "wh_main_sc_nor_warp", "wrp_rare", 3},
    {"wh2_dlc14_skv_inf_poison_wind_mortar_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh2_dlc14_skv_inf_warp_grinder_0", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh2_main_skv_art_plagueclaw_catapult", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh2_main_skv_art_warp_lightning_cannon", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh2_main_skv_inf_death_runners_0", "wh_main_sc_nor_warp", "wrp_rare", 1},
    {"wh2_main_skv_inf_plague_monk_censer_bearer", "wh_main_sc_nor_warp", "wrp_special", 2},
    {"wh2_main_skv_inf_plague_monks", "wh_main_sc_nor_warp", "wrp_special", 1},
    {"wh2_main_skv_inf_poison_wind_globadiers", "wh_main_sc_nor_warp", "wrp_special", 1},
    {"wh2_main_skv_mon_hell_pit_abomination", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh2_main_skv_veh_doomwheel", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh2_dlc16_skv_mon_brood_horror_0", "wh_main_sc_nor_warp", "wrp_rare", 2},
    {"wh2_dlc16_skv_mon_rat_ogre_mutant", "wh_main_sc_nor_warp", "wrp_special", 2},

    ---------------------------------------------------------------
    --TROLLS
    ---------------------------------------------------------------

    {"wh_dlc08_nor_mon_norscan_ice_trolls_0", "wh_main_sc_nor_troll", "trl_special", 1},
    {"wh_main_chs_mon_trolls", "wh_main_sc_nor_troll", "trl_special", 1},
    {"wh_main_nor_mon_chaos_trolls", "wh_main_sc_nor_troll", "trl_special", 1},
    {"wh_main_grn_mon_trolls", "wh_main_sc_nor_troll", "trl_special", 1},
    {"wh_dlc01_chs_mon_trolls_1", "wh_main_sc_nor_troll", "trl_special", 2},
    {"wh2_dlc15_grn_mon_river_trolls_0_no_scrap", "wh_main_sc_nor_troll", "trl_rare", 1},
    {"wh2_dlc15_grn_mon_stone_trolls_0_no_scrap", "wh_main_sc_nor_troll", "trl_rare", 1}

}--:vector<{string, string, string, number?}>

if not not rm then
    rm:add_units_in_table_to_tabletop_groups(ctt_ovn_all_units)
    rm:add_loaned_units_in_table(ctt_ovn_all_loaned_units)
end