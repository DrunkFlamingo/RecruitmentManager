local rm = core:get_static_object("recruitment_manager") 
--# assume rm: RECRUITER_MANAGER


local units = {

    
    ---------------------------------------------------------------
    --EMPIRE
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_main_emp_cav_empire_knights", "emp_core"},
    {"wh_main_emp_inf_halberdiers", "emp_core"},
    {"wh_main_emp_inf_handgunners", "emp_core"},
    {"wh_main_emp_inf_spearmen_0", "emp_core"},
    {"wh_main_emp_inf_spearmen_1", "emp_core"},
    {"wh_main_emp_inf_swordsmen", "emp_core"},
    {"wh_main_emp_inf_crossbowmen", "emp_core"},
    {"wh_dlc04_emp_inf_free_company_militia_0", "emp_core"},
    {"wh2_dlc13_emp_inf_archers_0", "emp_core"},
    --SPECIAL
    {"wh_main_emp_cav_demigryph_knights_0", "emp_special", 3},
    {"wh_main_emp_cav_demigryph_knights_1", "emp_special", 3},
    {"wh_main_emp_cav_outriders_0", "emp_special", 1},
    {"wh_main_emp_cav_outriders_1", "emp_special", 2},
    {"wh_main_emp_cav_pistoliers_1", "emp_special", 1},
    {"wh_main_emp_cav_reiksguard", "emp_special", 2},
    {"wh_main_emp_art_great_cannon", "emp_special", 2},
    {"wh_main_emp_art_mortar", "emp_special", 2},
    {"wh_main_emp_inf_greatswords", "emp_special", 1},
    {"wh_dlc04_emp_cav_knights_blazing_sun_0", "emp_special", 2},
    {"wh_dlc04_emp_inf_flagellants_0", "emp_special", 1},
    {"wh2_dlc13_emp_inf_huntsmen_0", "emp_special", 1},
    {"wh2_dlc13_emp_veh_war_wagon_0", "emp_special", 2},
    {"wh2_dlc13_emp_veh_war_wagon_1", "emp_special", 3},
    --RARE
    {"wh_main_emp_art_helblaster_volley_gun", "emp_rare", 2},
    {"wh_main_emp_art_helstorm_rocket_battery", "emp_rare", 2},
    {"wh_main_emp_veh_luminark_of_hysh_0", "emp_rare", 3},
    {"wh_main_emp_veh_steam_tank", "emp_rare", 3},
    {"wh2_dlc13_emp_veh_war_wagon_ror_0", "emp_rare", 1},
    
    -------ROR-------
    --CORE
    {"wh2_dlc13_emp_inf_archers_ror_0", "emp_core"},
    {"wh_dlc04_emp_inf_sigmars_sons_0", "emp_core"},
    {"wh_dlc04_emp_inf_silver_bullets_0", "emp_core"},
    {"wh_dlc04_emp_inf_stirlands_revenge_0", "emp_core"},
    --SPECIAL
    {"wh_dlc04_emp_inf_tattersouls_0", "emp_special", 1},
    {"wh_dlc04_emp_cav_zintlers_reiksguard_0", "emp_special", 2},
    {"wh_dlc04_emp_cav_royal_altdorf_gryphites_0", "emp_special", 3},
    {"wh_dlc04_emp_art_hammer_of_the_witches_0", "emp_special", 2},
    {"wh2_dlc13_emp_inf_huntsmen_ror_0", "emp_special", 1},
    --RARE
    {"wh_dlc04_emp_art_sunmaker_0", "emp_rare", 2},
    {"wh_dlc04_emp_veh_templehof_luminark_0", "emp_rare", 3},
    
    
    -------ELECTOR COUNTSHIP-------
    --CORE
    {"wh2_dlc13_emp_inf_handgunners_ror_0", "emp_core"},
    {"wh2_dlc13_emp_inf_swordsmen_ror_0", "emp_core"},
    {"wh2_dlc13_emp_inf_halberdiers_ror_0", "emp_core"},
    {"wh2_dlc13_emp_inf_spearmen_ror_0", "emp_core"},
    {"wh2_dlc13_emp_inf_crossbowmen_ror_0", "emp_core"},
    {"wh2_dlc13_emp_cav_empire_knights_ror_0", "emp_special", 1},
    {"wh2_dlc13_emp_cav_empire_knights_ror_2", "emp_special", 1},
    --SPECIAL
    {"wh2_dlc13_emp_cav_pistoliers_ror_0", "emp_special", 1},
    {"wh2_dlc13_emp_inf_greatswords_ror_0", "emp_special", 1},
    {"wh2_dlc13_emp_cav_empire_knights_ror_1", "emp_special", 1},
    {"wh2_dlc13_emp_art_mortar_ror_0", "emp_special", 1},
    {"wh2_dlc13_emp_cav_outriders_ror_0", "emp_special", 2},
    --RARE
    {"wh2_dlc13_emp_veh_steam_tank_ror_0", "emp_rare", 3},
    
    -------MARKUS WULFHART IMPERIAL SUPPLY-------
    --CORE
    {"wh2_dlc13_emp_inf_halberdiers_imperial_supply", "emp_core"},
    {"wh2_dlc13_emp_inf_handgunners_imperial_supply", "emp_core"},
    {"wh2_dlc13_emp_cav_empire_knights_imperial_supply", "emp_special", 1},
    --SPECIAL
    {"wh2_dlc13_emp_cav_demigryph_knights_0_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_emp_cav_demigryph_knights_1_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_emp_art_great_cannon_imperial_supply", "emp_special", 2},
    {"wh2_dlc13_emp_cav_knights_blazing_sun_0_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_emp_cav_outriders_1_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_emp_cav_pistoliers_1_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_emp_cav_reiksguard_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_emp_inf_greatswords_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_emp_inf_huntsmen_0_imperial_supply", "emp_special", 1},
    {"wh2_dlc13_huntmarshall_veh_obsinite_gyrocopter_0_mercenary", "emp_special", 2},
    --RARE
    {"wh2_dlc13_emp_art_helblaster_volley_gun_imperial_supply", "emp_rare", 2},
    {"wh2_dlc13_emp_art_helstorm_rocket_battery_imperial_supply","emp_rare", 2},
    {"wh2_dlc13_emp_veh_luminark_of_hysh_0_imperial_supply", "emp_rare", 3},
    {"wh2_dlc13_emp_veh_steam_tank_imperial_supply", "emp_rare", 3},
    {"wh2_dlc13_emp_veh_war_wagon_0_imperial_supply", "emp_rare", 1},
    {"wh2_dlc13_emp_veh_war_wagon_1_imperial_supply", "emp_rare", 2},
    
    ---------------------------------------------------------------
    --DWARFS
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_main_dwf_inf_dwarf_warrior_0", "dwf_core"},
    {"wh_main_dwf_inf_dwarf_warrior_1", "dwf_core"},
    {"wh_main_dwf_inf_longbeards", "dwf_core"},
    {"wh_main_dwf_inf_longbeards_1", "dwf_core"},
    {"wh_main_dwf_inf_miners_0", "dwf_core"},
    {"wh_main_dwf_inf_miners_1", "dwf_core"},
    {"wh_main_dwf_inf_quarrellers_0", "dwf_core"},
    {"wh_main_dwf_inf_quarrellers_1", "dwf_core"},
    {"wh_main_dwf_inf_thunderers_0", "dwf_core"},
    --SPECIAL
    {"wh_main_dwf_art_cannon", "dwf_special", 2},
    {"wh_main_dwf_art_grudge_thrower", "dwf_special", 1},
    {"wh_main_dwf_inf_hammerers", "dwf_special", 2},
    {"wh_main_dwf_inf_ironbreakers", "dwf_special", 2},
    {"wh_main_dwf_veh_gyrobomber", "dwf_special", 2},
    {"wh_main_dwf_veh_gyrocopter_0", "dwf_special", 2},
    {"wh_main_dwf_veh_gyrocopter_1", "dwf_special", 2},
    {"wh_main_dwf_inf_slayers", "dwf_special", 1},
    {"wh_dlc06_dwf_art_bolt_thrower_0", "dwf_special", 1},
    {"wh_dlc06_dwf_inf_bugmans_rangers_0", "dwf_special", 2},
    {"wh_dlc06_dwf_inf_rangers_0", "dwf_special", 1},
    {"wh_dlc06_dwf_inf_rangers_1", "dwf_special", 1},
    {"wh2_dlc10_dwf_inf_giant_slayers", "dwf_special", 2},
    --RARE
    {"wh_main_dwf_art_flame_cannon", "dwf_rare", 2},
    {"wh_main_dwf_art_organ_gun", "dwf_rare", 2},
    {"wh_main_dwf_inf_irondrakes_0", "dwf_rare", 2},
    {"wh_main_dwf_inf_irondrakes_2", "dwf_rare", 2},
    
    -------ROR-------
    --CORE
    {"wh_dlc06_dwf_inf_ekrund_miners_0", "dwf_core"},
    {"wh_dlc06_dwf_inf_warriors_dragonfire_pass_0", "dwf_core"},
    {"wh_dlc06_dwf_old_grumblers_0", "dwf_core"},
    --SPECIAL
    {"wh_dlc06_dwf_inf_dragonback_slayers_0", "dwf_special", 1},
    {"wh_dlc06_dwf_inf_peak_gate_guard_0", "dwf_special", 2},
    {"wh_dlc06_dwf_inf_norgrimlings_ironbreakers_0", "dwf_special", 2},
    {"wh_dlc06_dwf_inf_ulthars_raiders_0", "dwf_special", 1},
    {"wh_dlc06_dwf_veh_skyhammer_0", "dwf_special", 2},
    {"wh_dlc06_dwf_art_gob_lobber_0", "dwf_special", 1},
    --RARE
    {"wh_dlc06_dwf_inf_norgrimlings_irondrakes_0", "dwf_rare", 1},
    
    
    ---------------------------------------------------------------
    --VAMPIRE COUNTS
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_main_vmp_inf_crypt_ghouls", "vmp_core"},
    {"wh_main_vmp_inf_skeleton_warriors_0", "vmp_core"},
    {"wh_main_vmp_inf_skeleton_warriors_1", "vmp_core"},
    {"wh_main_vmp_inf_zombie", "vmp_core"},
    {"wh_main_vmp_mon_fell_bats", "vmp_core"},
    {"wh_main_vmp_mon_dire_wolves", "vmp_core"},
    --SPECIAL
    {"wh_main_vmp_cav_hexwraiths", "vmp_special", 2},
    {"wh_main_vmp_inf_grave_guard_0", "vmp_special", 1},
    {"wh_main_vmp_inf_grave_guard_1", "vmp_special", 1},
    {"wh_main_vmp_mon_crypt_horrors", "vmp_special", 2},
    {"wh_main_vmp_cav_black_knights_0", "vmp_special", 2},
    {"wh_main_vmp_cav_black_knights_3", "vmp_special", 2},
    {"wh_main_vmp_mon_vargheists", "vmp_special", 2},
    {"wh_dlc04_vmp_veh_corpse_cart_0", "vmp_special", 2},
    {"wh_dlc04_vmp_veh_corpse_cart_1", "vmp_special", 3},
    {"wh_dlc04_vmp_veh_corpse_cart_2", "vmp_special", 3},
    --RARE
    {"wh_main_vmp_inf_cairn_wraiths", "vmp_rare", 1},
    {"wh_main_vmp_mon_terrorgheist", "vmp_rare", 3},
    {"wh_main_vmp_mon_varghulf", "vmp_rare", 2},
    {"wh_main_vmp_veh_black_coach", "vmp_rare", 2},
    {"wh_dlc02_vmp_cav_blood_knights_0", "vmp_rare", 2},
    {"wh_dlc04_vmp_veh_mortis_engine_0", "vmp_rare", 3},
    
    -------BLOODLINE REWARDS-------
    --SPECIAL
    {"wh2_dlc11_vmp_inf_crossbowmen", "vmp_special", 1},
    --RARE
    {"wh2_dlc11_vmp_inf_handgunners", "vmp_rare", 1},
    
    -------ROR-------
    --CORE
    {"wh_dlc04_vmp_inf_tithe_0", "vmp_core"},
    {"wh_dlc04_vmp_inf_konigstein_stalkers_0", "vmp_core"},
    {"wh_dlc04_vmp_inf_feasters_in_the_dusk_0", "vmp_core"},
    {"wh_dlc04_vmp_mon_direpack_0", "vmp_core"},
    --SPECIAL
    {"wh_dlc04_vmp_inf_sternsmen_0", "vmp_special", 1},
    {"wh_dlc04_vmp_cav_vereks_reavers_0", "vmp_special", 2},
    {"wh_dlc04_vmp_cav_chillgheists_0", "vmp_special", 2},
    {"wh_dlc04_vmp_mon_devils_swartzhafen_0", "vmp_special", 2},
    --RARE
    {"wh_dlc04_vmp_veh_claw_of_nagash_0", "vmp_rare", 3},
    
    ---------------------------------------------------------------
    --BRETONNIA
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_main_brt_cav_knights_of_the_realm", "brt_core"},
    {"wh_main_brt_cav_mounted_yeomen_0", "brt_core"},
    {"wh_main_brt_cav_mounted_yeomen_1", "brt_core"},
    {"wh_main_brt_inf_men_at_arms", "brt_core"},
    {"wh_main_brt_inf_peasant_bowmen", "brt_core"},
    {"wh_main_brt_inf_spearmen_at_arms", "brt_core"},
    {"wh_dlc07_brt_cav_knights_errant_0", "brt_core"},
    {"wh_dlc07_brt_inf_men_at_arms_1", "brt_core"},
    {"wh_dlc07_brt_inf_men_at_arms_2", "brt_core"},
    {"wh_dlc07_brt_inf_peasant_bowmen_1", "brt_core"},
    {"wh_dlc07_brt_inf_peasant_bowmen_2", "brt_core"},
    {"wh_dlc07_brt_inf_spearmen_at_arms_1", "brt_core"},
    {"wh_dlc07_brt_peasant_mob_0", "brt_core"},
    --SPECIAL
    {"wh_main_brt_cav_pegasus_knights", "brt_special", 2},
    {"wh_dlc07_brt_cav_questing_knights_0", "brt_special", 2},
    {"wh_dlc07_brt_inf_battle_pilgrims_0", "brt_special", 1},
    {"wh_dlc07_brt_inf_foot_squires_0", "brt_special", 1},
    {"wh_dlc07_brt_inf_grail_reliquae_0", "brt_special", 2},
    --RARE
    {"wh_main_brt_art_field_trebuchet", "brt_rare", 1},
    {"wh_main_brt_cav_grail_knights", "brt_rare", 2},
    {"wh_dlc07_brt_art_blessed_field_trebuchet_0", "brt_rare", 2},
    {"wh_dlc07_brt_cav_grail_guardians_0", "brt_rare", 2},
    {"wh_dlc07_brt_cav_royal_hippogryph_knights_0", "brt_rare", 2},
    {"wh_dlc07_brt_cav_royal_pegasus_knights_0", "brt_rare", 2},
    
    -------ROR-------
    --CORE
    {"wh_pro04_brt_inf_battle_pilgrims_ror_0", "brt_core"},
    {"wh_pro04_brt_cav_mounted_yeomen_ror_0", "brt_core"},
    --SPECIAL
    {"wh_pro04_brt_inf_foot_squires_ror_0", "brt_special", 1},
    {"wh_pro04_brt_cav_knights_errant_ror_0", "brt_special", 1},
    {"wh_pro04_brt_cav_knights_of_the_realm_ror_0", "brt_special", 1},
    {"wh_pro04_brt_cav_questing_knights_ror_0", "brt_special", 2},
    
    ---------------------------------------------------------------
    --GREENSKINS
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_main_grn_cav_forest_goblin_spider_riders_0", "grn_core"},
    {"wh_main_grn_cav_forest_goblin_spider_riders_1", "grn_core"},
    {"wh_main_grn_cav_goblin_wolf_riders_0", "grn_core"},
    {"wh_main_grn_cav_goblin_wolf_riders_1", "grn_core"},
    {"wh_main_grn_inf_goblin_archers", "grn_core"},
    {"wh_main_grn_inf_goblin_spearmen", "grn_core"},
    {"wh_main_grn_inf_night_goblin_archers", "grn_core"},
    {"wh_main_grn_inf_night_goblin_fanatics", "grn_core"},
    {"wh_main_grn_inf_night_goblin_fanatics_1", "grn_core"},
    {"wh_main_grn_inf_night_goblins", "grn_core"},
    {"wh_main_grn_inf_orc_arrer_boyz", "grn_core"},
    {"wh_main_grn_inf_orc_big_uns", "grn_core"},
    {"wh_main_grn_inf_orc_boyz", "grn_core"},
    {"wh_main_grn_inf_savage_orc_arrer_boyz", "grn_core"},
    {"wh_main_grn_inf_savage_orc_big_uns", "grn_core"},
    {"wh_main_grn_inf_savage_orcs", "grn_core"},
    {"wh_dlc06_grn_inf_nasty_skulkers_0", "grn_core"},

    --SPECIAL
    {"wh_main_grn_cav_goblin_wolf_chariot", "grn_special", 1},
    {"wh_main_grn_cav_orc_boar_boy_big_uns", "grn_special", 2},
    {"wh_main_grn_cav_orc_boar_boyz", "grn_special", 1},
    {"wh_main_grn_cav_orc_boar_chariot", "grn_special", 2},
    {"wh_main_grn_cav_savage_orc_boar_boy_big_uns", "grn_special", 2},
    {"wh_main_grn_cav_savage_orc_boar_boyz", "grn_special", 1},
    {"wh_main_grn_inf_black_orcs", "grn_special", 2},
    {"wh_main_grn_mon_trolls", "grn_special", 1},
    {"wh_dlc06_grn_cav_squig_hoppers_0", "grn_special", 2},
    {"wh_dlc06_grn_inf_squig_herd_0", "grn_special", 1},
    {"wh2_dlc15_grn_mon_river_trolls_0", "grn_special", 2},
    {"wh2_dlc15_grn_mon_stone_trolls_0", "grn_special", 2},
    {"wh2_dlc15_grn_veh_snotling_pump_wagon_0", "grn_special", 1},

    --RARE
    {"wh_main_grn_art_doom_diver_catapult", "grn_rare", 2},
    {"wh_main_grn_art_goblin_rock_lobber", "grn_rare", 1},
    {"wh_main_grn_mon_arachnarok_spider_0", "grn_rare", 3},
    {"wh_main_grn_mon_giant", "grn_rare", 2},
    {"wh2_dlc15_grn_mon_rogue_idol_0", "grn_rare", 3},
    {"wh2_dlc15_grn_veh_snotling_pump_wagon_0", "grn_rare", 1},
    {"wh2_dlc15_grn_veh_snotling_pump_wagon_flappas_0", "grn_rare", 1},
    {"wh2_dlc15_grn_veh_snotling_pump_wagon_roller_0", "grn_rare", 1},
    
    -------ROR-------
    --CORE
    {"wh_dlc06_grn_inf_da_warlords_boyz_0", "grn_core"},
    {"wh_dlc06_grn_inf_da_eight_peaks_loonies_0", "grn_core"},
    {"wh_dlc06_grn_cav_moon_howlers_0", "grn_core"},
    {"wh_dlc06_grn_cav_mogrubbs_marauders_0", "grn_core"},
    {"wh_dlc06_grn_cav_deff_creepers_0", "grn_core"},
    {"wh_dlc06_grn_cav_teef_robbers_0", "grn_core"},
    --SPECIAL
    {"wh_dlc06_grn_inf_krimson_killerz_0", "grn_special", 2},
    {"wh_dlc06_grn_inf_da_rusty_arrers_0", "grn_special", 1},
    {"wh_dlc06_grn_cav_durkits_squigs_0", "grn_special", 2},
    {"wh_dlc06_grn_cav_broken_tusks_mob_0", "grn_special", 2},
    {"wh2_dlc15_grn_mon_river_trolls_ror_0", "grn_special", 2},
    --RARE
    {"wh_dlc06_grn_mon_venom_queen_0", "grn_rare", 3},
    {"wh_dlc06_grn_art_hammer_of_gork_0", "grn_rare", 1},
    {"wh2_dlc15_grn_mon_rogue_idol_ror_0", "grn_rare", 3},
    {"wh2_dlc15_grn_veh_snotling_pump_wagon_ror_0", "grn_rare", 1},

    -------WAAAGH UNITS-------
    --CORE
    {"wh2_dlc15_grn_cav_forest_goblin_spider_riders_waaagh_0", "grn_core"},
    {"wh_dlc06_grn_inf_squig_explosive_0", "grn_core"},
    --SPECIAL
    {"wh2_dlc15_grn_cav_squig_hoppers_waaagh_0", "grn_special", 2},
   --RARE
    {"wh2_dlc15_grn_mon_feral_hydra_waaagh_0", "grn_rare", 2},
    {"wh2_dlc15_grn_mon_wyvern_waaagh_0", "grn_rare", 1},
    {"wh_dlc15_grn_mon_arachnarok_spider_waaagh_0", "grn_rare", 3},


    ---------------------------------------------------------------
    --WARRIORS OF CHAOS
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_main_chs_mon_chaos_warhounds_0", "chs_core"},
    {"wh_main_chs_mon_chaos_warhounds_1", "chs_core"},
    {"wh_main_chs_cav_marauder_horsemen_0", "chs_core"},
    {"wh_main_chs_cav_marauder_horsemen_1", "chs_core"},
    {"wh_main_chs_inf_chaos_marauders_0", "chs_core"},
    {"wh_main_chs_inf_chaos_marauders_1", "chs_core"},
    {"wh_main_chs_inf_chaos_warriors_0", "chs_core"},
    {"wh_main_chs_inf_chaos_warriors_1", "chs_core"},
    {"wh_main_chs_cav_chaos_chariot", "chs_core"},
    {"wh_dlc01_chs_inf_chaos_warriors_2", "chs_core"},
    {"wh_dlc01_chs_inf_forsaken_0", "chs_core"},
    {"wh_dlc06_chs_cav_marauder_horsemasters_0", "chs_core"},
    --SPECIAL
    {"wh_main_chs_mon_trolls", "chs_special", 1},
    {"wh_main_chs_inf_chosen_0", "chs_special", 2},
    {"wh_main_chs_inf_chosen_1", "chs_special", 2},
    {"wh_main_chs_cav_chaos_knights_0", "chs_special", 2},
    {"wh_main_chs_cav_chaos_knights_1", "chs_special", 2},
    {"wh_dlc01_chs_cav_gorebeast_chariot", "chs_special", 1},
    {"wh_dlc01_chs_mon_dragon_ogre", "chs_special", 2},
    {"wh_dlc01_chs_mon_trolls_1", "chs_special", 1},
    {"wh_dlc01_chs_inf_chosen_2", "chs_special", 2},
    {"wh_dlc06_chs_feral_manticore", "chs_special", 2},
    {"wh_dlc06_chs_inf_aspiring_champions_0", "chs_special", 1},
    --RARE
    {"wh_main_chs_art_hellcannon", "chs_rare", 2},
    {"wh_main_chs_mon_chaos_spawn", "chs_rare", 1},
    {"wh_main_chs_mon_giant", "chs_rare", 2},
    {"wh_dlc01_chs_mon_dragon_ogre_shaggoth", "chs_rare", 3},
    
    -------ROR-------
    --CORE
    {"wh_pro04_chs_inf_chaos_warriors_ror_0", "chs_core"},
    {"wh_pro04_chs_inf_forsaken_ror_0", "chs_core"},
    --SPECIAL
    {"wh_pro04_chs_cav_chaos_knights_ror_0", "chs_special", 2},
    {"wh_pro04_chs_mon_dragon_ogre_ror_0", "chs_special", 2},
    --RARE
    {"wh_pro04_chs_mon_chaos_spawn_ror_0", "chs_rare", 1},
    {"wh_pro04_chs_art_hellcannon_ror_0", "chs_rare", 2},
    
    
    ---------------------------------------------------------------
    --BEASTMEN
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_dlc03_bst_inf_chaos_warhounds_0", "bst_core"},
    {"wh_dlc03_bst_inf_chaos_warhounds_1", "bst_core"},
    {"wh_dlc03_bst_inf_ungor_raiders_0", "bst_core"},
    {"wh_dlc03_bst_inf_gor_herd_0", "bst_core"},
    {"wh_dlc03_bst_inf_gor_herd_1", "bst_core"},
    {"wh_dlc03_bst_inf_ungor_herd_1", "bst_core"},
    {"wh_dlc03_bst_inf_ungor_spearmen_0", "bst_core"},
    {"wh_dlc03_bst_inf_ungor_spearmen_1", "bst_core"},
    {"wh2_dlc17_bst_cav_tuskgor_chariot_0", "bst_core"},
    --SPECIAL
    {"wh_dlc03_bst_inf_minotaurs_0", "bst_special", 2},
    {"wh_dlc03_bst_inf_minotaurs_1", "bst_special", 2},
    {"wh_dlc03_bst_inf_minotaurs_2", "bst_special", 2},
    {"wh_dlc05_bst_mon_harpies_0", "bst_special", 1},
    {"wh_dlc03_bst_inf_razorgor_herd_0", "bst_special", 1},
    {"wh_dlc03_bst_feral_manticore", "bst_special", 2},
    {"wh_dlc03_bst_inf_bestigor_herd_0", "bst_special", 1},
    {"wh_dlc03_bst_inf_centigors_0", "bst_special", 1},
    {"wh_dlc03_bst_inf_centigors_1", "bst_special", 1},
    {"wh_dlc03_bst_inf_centigors_2", "bst_special", 1},
    {"wh_dlc03_bst_cav_razorgor_chariot_0", "bst_special", 2},
    --RARE
    {"wh_dlc03_bst_mon_chaos_spawn_0", "bst_rare", 1},
    {"wh_dlc03_bst_mon_giant_0", "bst_rare", 2},
    {"wh_dlc03_bst_inf_cygor_0", "bst_rare", 3},
    {"wh2_dlc17_bst_mon_ghorgon_0", "bst_rare", 3},
    {"wh2_dlc17_bst_mon_jabberslythe_0", "bst_rare", 3},
    
    -------ROR-------
    --CORE
    {"wh_pro04_bst_inf_ungor_spearmen_ror_0", "bst_core"},
    {"wh_pro04_bst_inf_gor_herd_ror_0", "bst_core"},
    --SPECIAL
    {"wh_pro04_bst_inf_bestigor_herd_ror_0", "bst_special", 1},
    {"wh_pro04_bst_inf_centigors_ror_0", "bst_special", 1},
    {"wh_pro04_bst_inf_minotaurs_ror_0", "bst_special", 2},
    {"wh2_dlc17_bst_inf_centigors_ror_1", "bst_special", 2},
    {"wh2_dlc17_bst_mon_ghorgon_ror_0", "bst_rare", 3},
    --RARE
    {"wh2_dlc17_bst_mon_jabberslythe_ror_0", "bst_rare", 3},
    {"wh_pro04_bst_inf_cygor_ror_0", "bst_rare", 3},
    ---------------------------------------------------------------
    --WOOD ELVES
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_dlc05_wef_inf_glade_guard_0", "wef_core"},
    {"wh_dlc05_wef_inf_glade_guard_1", "wef_core"},
    {"wh_dlc05_wef_inf_glade_guard_2", "wef_core"},
    {"wh_dlc05_wef_cav_glade_riders_0", "wef_core"},
    {"wh_dlc05_wef_cav_glade_riders_1", "wef_core"},
    {"wh_dlc05_wef_inf_dryads_0", "wef_core"},
    {"wh_dlc05_wef_inf_eternal_guard_0", "wef_core"},
    {"wh_dlc05_wef_inf_eternal_guard_1", "wef_core"},
    {"wh2_dlc16_wef_cav_glade_riders_2", "wef_core"},
    {"wh2_dlc16_wef_inf_malicious_dryads_0", "wef_core"},
    {"wh2_dlc16_wef_mon_cave_bats", "wef_core"},
    {"wh2_dlc16_wef_mon_spider_hatchlings_0", "wef_core"},
    --SPECIAL
    {"wh_dlc05_wef_inf_deepwood_scouts_0", "wef_special", 1},
    {"wh_dlc05_wef_inf_deepwood_scouts_1", "wef_special", 1},
    {"wh_dlc05_wef_mon_treekin_0", "wef_special", 2},
    {"wh_dlc05_wef_mon_great_eagle_0", "wef_special", 2},
    {"wh_dlc05_wef_cav_hawk_riders_0", "wef_special", 2},
    {"wh_dlc05_wef_inf_wardancers_0", "wef_special", 1},
    {"wh_dlc05_wef_inf_wardancers_1", "wef_special", 1},
    {"wh_dlc05_wef_inf_wildwood_rangers_0", "wef_special", 2},
    {"wh_dlc05_wef_cav_wild_riders_0", "wef_special", 2},
    {"wh_dlc05_wef_cav_wild_riders_1", "wef_special", 2},
    {"wh2_dlc16_wef_inf_bladesingers_0", "wef_special", 2},
    {"wh2_dlc16_wef_mon_giant_spiders_0", "wef_special", 1},
    {"wh2_dlc16_wef_mon_feral_manticore", "wef_special", 2},
    {"wh2_dlc16_wef_mon_harpies_0", "wef_special", 1},
    {"wh2_dlc16_wef_mon_hawks_0", "wef_special", 1},
    {"wh2_dlc16_wef_mon_malicious_treekin_0", "wef_special", 2},
    {"wh2_dlc16_wef_mon_wolves_0", "wef_special", 1},
    --RARE
    {"wh_dlc05_wef_forest_dragon_0", "wef_rare", 3},
    {"wh_dlc05_wef_mon_treeman_0", "wef_rare", 3},
    {"wh_dlc05_wef_inf_waywatchers_0", "wef_rare", 1},
    {"wh_dlc05_wef_cav_sisters_thorn_0", "wef_rare", 1},
    {"wh2_dlc16_wef_cav_great_stag_knights_0", "wef_rare", 1},
    {"wh2_dlc16_wef_mon_malicious_treeman_0", "wef_rare", 3},
    {"wh2_dlc16_wef_mon_zoats", "wef_rare", 1},
    -------ROR-------
    --CORE
    {"wh_pro04_wef_inf_eternal_guard_ror_0", "wef_core"},
    {"wh2_dlc16_wef_inf_dryads_ror_0", "wef_core"},
    --SPECIAL
    {"wh_pro04_wef_inf_wildwood_rangers_ror_0", "wef_special", 2},
    {"wh_pro04_wef_inf_wardancers_ror_0", "wef_special", 1},
    {"wh_pro04_wef_inf_waywatchers_ror_0", "wef_rare", 1},
    {"wh_pro04_wef_cav_wild_riders_ror_0", "wef_special", 2},
    {"wh_pro04_wef_mon_treekin_ror_0", "wef_special", 2},
    --RARE
    {"wh2_dlc16_wef_cav_great_stag_knights_ror_0", "wef_rare", 2},
    {"wh2_dlc16_wef_mon_zoats_ror_0", "wef_rare", 1},
    
    
    ---------------------------------------------------------------
    --NORSCA
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh_main_nor_mon_chaos_warhounds_0", "nor_core"},
    {"wh_main_nor_mon_chaos_warhounds_1", "nor_core"},
    {"wh_main_nor_cav_marauder_horsemen_1", "nor_core"},
    {"wh_main_nor_inf_chaos_marauders_0", "nor_core"},
    {"wh_main_nor_inf_chaos_marauders_1", "nor_core"},
    {"wh_main_nor_cav_marauder_horsemen_0", "nor_core"},
    {"wh_main_nor_cav_chaos_chariot", "nor_core"},
    {"wh_dlc08_nor_inf_marauder_spearman_0", "nor_core"},
    {"wh_dlc08_nor_inf_marauder_hunters_0", "nor_core"},
    {"wh_dlc08_nor_inf_marauder_hunters_1", "nor_core"},
    {"wh_dlc08_nor_cav_marauder_horsemasters_0", "nor_core"},
    --SPECIAL
    {"wh_main_nor_mon_chaos_trolls", "nor_special", 2},
    {"wh_dlc08_nor_mon_warwolves_0", "nor_special", 1},
    {"wh_dlc08_nor_mon_norscan_ice_trolls_0", "nor_special", 2},
    {"wh_dlc08_nor_feral_manticore", "nor_special", 1},
    {"wh_dlc08_nor_inf_marauder_berserkers_0", "nor_special", 1},
    {"wh_dlc08_nor_inf_marauder_champions_0", "nor_special", 2},
    {"wh_dlc08_nor_inf_marauder_champions_1", "nor_special", 2},
    {"wh_dlc08_nor_mon_skinwolves_0", "nor_special", 2},
    {"wh_dlc08_nor_mon_skinwolves_1", "nor_special", 2},
    {"wh_dlc08_nor_veh_marauder_warwolves_chariot_0", "nor_special", 2},
    --RARE
    {"wh_dlc08_nor_mon_fimir_0", "nor_rare", 1},
    {"wh_dlc08_nor_mon_fimir_1", "nor_rare", 1},
    {"wh_dlc08_nor_mon_frost_wyrm_0", "nor_rare", 3},
    {"wh_dlc08_nor_mon_norscan_giant_0", "nor_rare", 2},
    {"wh_dlc08_nor_mon_war_mammoth_0", "nor_rare", 2},
    {"wh_dlc08_nor_mon_war_mammoth_1", "nor_rare", 3},
    {"wh_dlc08_nor_mon_war_mammoth_2", "nor_rare", 3},
    
    ------- MONSTER HUNTS / GOD ALLEGIANCE REWARDS-------
    --RARE
    {"wh_dlc08_nor_mon_frost_wyrm_ror_0", "nor_rare", 2},
    {"wh_dlc08_nor_mon_war_mammoth_ror_1", "nor_rare", 2},
    {"wh_dlc08_nor_art_hellcannon_battery", "nor_rare", 3},
    
    -------ROR-------
    --CORE
    {"wh_pro04_nor_inf_chaos_marauders_ror_0", "nor_core"},
    {"wh_pro04_nor_mon_marauder_warwolves_ror_0", "nor_core"},
    --SPECIAL
    {"wh_pro04_nor_inf_marauder_berserkers_ror_0", "nor_special", 1},
    {"wh_pro04_nor_mon_skinwolves_ror_0", "nor_special", 2},
    --RARE
    {"wh_pro04_nor_mon_fimir_ror_0", "nor_rare", 1},
    {"wh_pro04_nor_mon_war_mammoth_ror_0", "nor_rare", 3},
    
    
    ---------------------------------------------------------------
    --LIZARDMEN
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh2_main_lzd_inf_skink_cohort_1", "lzd_core"},
    {"wh2_main_lzd_inf_skink_skirmishers_0", "lzd_core"},
    {"wh2_main_lzd_inf_saurus_spearmen_0", "lzd_core"},
    {"wh2_main_lzd_inf_saurus_spearmen_1", "lzd_core"},
    {"wh2_main_lzd_inf_saurus_warriors_0", "lzd_core"},
    {"wh2_main_lzd_inf_saurus_warriors_1", "lzd_core"},
    {"wh2_main_lzd_inf_skink_cohort_0", "lzd_core"},
    {"wh2_main_lzd_cav_cold_ones_feral_0", "lzd_core"},
    {"wh2_dlc12_lzd_inf_skink_red_crested_0", "lzd_core"},
    --SPECIAL
    {"wh2_main_lzd_mon_kroxigors", "lzd_special", 2},
    {"wh2_main_lzd_cav_terradon_riders_0", "lzd_special", 1},
    {"wh2_main_lzd_cav_terradon_riders_1", "lzd_special", 1},
    {"wh2_main_lzd_mon_bastiladon_0", "lzd_special", 1},
    {"wh2_main_lzd_mon_bastiladon_1", "lzd_special", 2},
    {"wh2_main_lzd_mon_bastiladon_2", "lzd_special", 2},
    {"wh2_main_lzd_mon_stegadon_0", "lzd_special", 2},
    {"wh2_main_lzd_mon_stegadon_1", "lzd_special", 2},
    {"wh2_main_lzd_inf_chameleon_skinks_0", "lzd_special", 1},
    {"wh2_main_lzd_inf_temple_guards", "lzd_special", 1},
    {"wh2_main_lzd_cav_cold_one_spearmen_1", "lzd_special", 1},
    {"wh2_main_lzd_cav_cold_ones_1", "lzd_special", 1},
    {"wh2_main_lzd_cav_horned_ones_0", "lzd_special", 2},
    {"wh2_dlc12_lzd_mon_salamander_pack_0", "lzd_special", 2},
    {"wh2_dlc12_lzd_mon_bastiladon_3", "lzd_special", 2},
    {"wh2_dlc12_lzd_cav_ripperdactyl_riders_0", "lzd_special", 1},
    {"wh2_dlc13_lzd_mon_razordon_pack_0", "lzd_special", 2},
    {"wh2_dlc13_lzd_mon_sacred_kroxigors_0", "lzd_special", 2},
    --RARE
    {"wh2_main_lzd_mon_ancient_stegadon", "lzd_rare", 3},
    {"wh2_main_lzd_mon_carnosaur_0", "lzd_rare", 2},
    {"wh2_dlc12_lzd_mon_ancient_salamander_0", "lzd_rare", 1},
    {"wh2_dlc12_lzd_mon_ancient_stegadon_1", "lzd_rare", 3},
    {"wh2_dlc13_lzd_mon_dread_saurian_0", "lzd_rare", 2},
    {"wh2_dlc13_lzd_mon_dread_saurian_1", "lzd_rare", 3},
    {"wh2_dlc17_lzd_inf_chameleon_stalkers_0", "lzd_rare", 1},
    {"wh2_dlc17_lzd_mon_coatl_0", "lzd_rare", 2},
    {"wh2_dlc17_lzd_mon_troglodon_0", "lzd_rare", 2},
    
    -------BLESSED-------
    --CORE
    {"wh2_main_lzd_inf_skink_skirmishers_blessed_0", "lzd_core"},
    {"wh2_main_lzd_inf_saurus_spearmen_blessed_1", "lzd_core"},
    {"wh2_main_lzd_inf_saurus_warriors_blessed_1", "lzd_core"},
    --SPECIAL
    {"wh2_main_lzd_mon_kroxigors_blessed", "lzd_special", 2},
    {"wh2_main_lzd_cav_terradon_riders_blessed_1", "lzd_special", 1},
    {"wh2_main_lzd_mon_bastiladon_blessed_2", "lzd_special", 2},
    {"wh2_main_lzd_mon_stegadon_blessed_1", "lzd_special", 2},
    {"wh2_main_lzd_inf_chameleon_skinks_blessed_0", "lzd_special", 1},
    {"wh2_main_lzd_inf_temple_guards_blessed", "lzd_special", 1},
    {"wh2_main_lzd_cav_cold_one_spearriders_blessed_0", "lzd_special", 1},
    {"wh2_main_lzd_cav_horned_ones_blessed_0", "lzd_special", 2},
    --RARE
    {"wh2_main_lzd_mon_carnosaur_blessed_0", "lzd_rare", 2},
    
    -------NAKAI'S OWN-------
    --SPECIAL
    {"wh2_main_lzd_mon_kroxigors_nakai", "lzd_special", 1},
    {"wh2_main_lzd_inf_temple_guards_nakai", "lzd_special", 1},
    {"wh2_main_lzd_cav_horned_ones_0_nakai", "lzd_special", 2},
    {"wh2_dlc13_lzd_mon_sacred_kroxigors_0_nakai", "lzd_special", 2},
    --RARE
    {"wh2_dlc12_lzd_mon_ancient_stegadon_1_nakai", "lzd_rare", 3},
    {"wh2_dlc12_lzd_mon_bastiladon_3_nakai", "lzd_special", 2},
    
    -------ROR-------
    --SPECIAL
    {"wh2_dlc12_lzd_inf_skink_red_crested_ror_0", "lzd_special", 1},
    {"wh2_dlc12_lzd_inf_saurus_warriors_ror_0", "lzd_special", 1},
    {"wh2_dlc12_lzd_inf_temple_guards_ror_0", "lzd_special", 1},
    {"wh2_dlc12_lzd_mon_salamander_pack_ror_0", "lzd_special", 2},
    {"wh2_dlc12_lzd_cav_cold_one_spearriders_ror_0", "lzd_special", 1},
    {"wh2_dlc12_lzd_cav_ripperdactyl_riders_ror_0", "lzd_special", 1},
    {"wh2_dlc12_lzd_cav_terradon_riders_ror_0", "lzd_special", 1},
    {"wh2_dlc13_lzd_mon_razordon_pack_ror_0", "lzd_special", 2},
    {"wh2_dlc13_lzd_mon_sacred_kroxigors_ror_0", "lzd_special", 2},
    --RARE
    {"wh2_dlc12_lzd_mon_ancient_stegadon_ror_0", "lzd_rare", 3},
    {"wh2_dlc13_lzd_mon_dread_saurian_ror_0", "lzd_rare", 3},
    {"wh2_dlc17_lzd_mon_carnosaur_ror_0", "lzd_rare", 2},
    {"wh2_dlc17_lzd_mon_coatl_ror_0", "lzd_rare", 3},
    {"wh2_dlc17_lzd_mon_troglodon_ror_0", "lzd_rare", 2},
    
    ---------------------------------------------------------------
    --SKAVEN
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh2_main_skv_inf_clanrat_spearmen_0", "skv_core"},
    {"wh2_main_skv_inf_clanrat_spearmen_1", "skv_core"},
    {"wh2_main_skv_inf_clanrats_0", "skv_core"},
    {"wh2_main_skv_inf_clanrats_1", "skv_core"},
    {"wh2_main_skv_inf_skavenslave_spearmen_0", "skv_core"},
    {"wh2_main_skv_inf_skavenslaves_0", "skv_core"},
    {"wh2_main_skv_inf_night_runners_0", "skv_core"},
    {"wh2_main_skv_inf_night_runners_1", "skv_core"},
    {"wh2_main_skv_inf_skavenslave_slingers_0", "skv_core"},
    --SPECIAL
    {"wh2_main_skv_mon_rat_ogres", "skv_special", 2},
    {"wh2_main_skv_inf_death_runners_0", "skv_special", 1},
    {"wh2_main_skv_inf_gutter_runner_slingers_0", "skv_special", 1},
    {"wh2_main_skv_inf_gutter_runner_slingers_1", "skv_special", 1},
    {"wh2_main_skv_inf_gutter_runners_0", "skv_special", 1},
    {"wh2_main_skv_inf_gutter_runners_1", "skv_special", 1},
    {"wh2_main_skv_inf_poison_wind_globadiers", "skv_special", 2},
    {"wh2_main_skv_inf_warpfire_thrower", "skv_special", 1},
    {"wh2_main_skv_inf_plague_monk_censer_bearer", "skv_special", 2},
    {"wh2_main_skv_inf_plague_monks", "skv_special", 1},
    {"wh2_main_skv_inf_stormvermin_0", "skv_special", 1},
    {"wh2_main_skv_inf_stormvermin_1", "skv_special", 1},
    {"wh2_dlc12_skv_inf_ratling_gun_0", "skv_special", 1},
    {"wh2_dlc12_skv_inf_warplock_jezzails_0", "skv_special", 2},
    {"wh2_dlc12_skv_veh_doom_flayer_0", "skv_special", 2},
    {"wh2_dlc14_skv_inf_eshin_triads_0", "skv_special", 1},
    {"wh2_dlc14_skv_inf_poison_wind_mortar_0", "skv_special", 2},
    {"wh2_dlc14_skv_inf_warp_grinder_0", "skv_special", 1},
    {"wh2_dlc16_skv_mon_rat_ogre_mutant", "skv_special", 3},
    {"wh2_dlc16_skv_mon_wolf_rats_0", "skv_special", 1},
    {"wh2_dlc16_skv_mon_wolf_rats_1", "skv_special", 1},
    --RARE
    {"wh2_main_skv_art_plagueclaw_catapult", "skv_rare", 2},
    {"wh2_main_skv_art_warp_lightning_cannon", "skv_rare", 2},
    {"wh2_main_skv_veh_doomwheel", "skv_rare", 2},
    {"wh2_main_skv_mon_hell_pit_abomination", "skv_rare", 3},
    {"wh2_main_skv_inf_death_globe_bombardiers", "skv_rare", 1},
    {"wh2_dlc16_skv_mon_brood_horror_0", "skv_rare", 2},
    
    -------IKIT CLAW FORBIDDEN WORKSHOP ROR-------
    --SPECIAL
    {"wh2_dlc12_skv_veh_doom_flayer_ror_tech_lab_0", "skv_special", 2},
    {"wh2_dlc12_skv_inf_warpfire_thrower_ror_tech_lab_0", "skv_special", 1},
    {"wh2_dlc12_skv_inf_ratling_gun_ror_tech_lab_0",  "skv_special", 1},
    {"wh2_dlc12_skv_art_warplock_jezzails_ror_tech_lab_0", "skv_special", 2},
    --RARE
    {"wh2_dlc12_skv_veh_doomwheel_ror_tech_lab_0", "skv_rare", 2},
    
    -------THROT'S FLESH LAB ROR-------
    --CORE
    {"wh2_dlc16_skv_inf_skavenslaves_0_flesh_lab", "skv_core"},
    {"wh2_dlc16_skv_inf_skavenslave_spearmen_0_flesh_lab", "skv_core"},
    --SPECIAL
    {"wh2_dlc16_skv_mon_rat_ogre_mutant_flesh_lab", "skv_special", 3},
    {"wh2_dlc16_skv_mon_wolf_rats_0_flesh_lab", "skv_special", 1},
    {"wh2_dlc16_skv_mon_wolf_rats_1_flesh_lab", "skv_special", 1},
    {"wh2_dlc16_skv_mon_rat_ogres_flesh_lab", "skv_special", 1},
    --RARE
    {"wh2_dlc16_skv_mon_brood_horror_0_flesh_lab", "skv_rare", 2},
    {"wh2_dlc16_skv_mon_hell_pit_abomination_flesh_lab", "skv_rare", 3},
    
    -------ROR-------
    --CORE
    {"wh2_dlc12_skv_inf_clanrats_ror_0", "skv_core"},
    --SPECIAL
    {"wh2_dlc12_skv_inf_plague_monk_censer_bearer_ror_0", "skv_special", 2},
    {"wh2_dlc12_skv_inf_stormvermin_ror_0", "skv_special", 1},
    {"wh2_dlc12_skv_inf_ratling_gun_ror_0", "skv_special", 1},
    {"wh2_dlc12_skv_inf_warplock_jezzails_ror_0", "skv_special", 2},
    {"wh2_dlc12_skv_veh_doom_flayer_ror_0", "skv_special", 2},
    {"wh2_dlc14_skv_inf_eshin_triads_ror_0", "skv_special", 1},
    {"wh2_dlc14_skv_inf_poison_wind_mortar_ror_0", "skv_special", 2},
    {"wh2_dlc14_skv_inf_death_runners_ror_0", "skv_special", 2},
    {"wh2_dlc16_skv_mon_rat_ogre_mutant_ror_0", "skv_special", 3},
    {"wh2_dlc16_skv_mon_rat_ogres_ror_0", "skv_special", 2},
    --RARE
    {"wh2_dlc12_skv_art_warp_lightning_cannon_ror_0", "skv_rare", 2},
    {"wh2_dlc12_skv_veh_doomwheel_ror_0", "skv_rare", 2},
    {"wh2_dlc16_skv_mon_hell_pit_abomination_ror_0", "skv_rare", 3},
    
    
    ---------------------------------------------------------------
    --HIGH ELVES
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh2_main_hef_inf_archers_0", "hef_core"},
    {"wh2_main_hef_inf_archers_1", "hef_core"},
    {"wh2_main_hef_inf_lothern_sea_guard_0", "hef_core"},
    {"wh2_main_hef_inf_lothern_sea_guard_1", "hef_core"},
    {"wh2_main_hef_cav_ellyrian_reavers_1", "hef_core"},
    {"wh2_main_hef_inf_spearmen_0", "hef_core"},
    {"wh2_main_hef_cav_ellyrian_reavers_0", "hef_core"},
    {"wh2_main_hef_cav_silver_helms_0", "hef_core"},
    {"wh2_main_hef_cav_silver_helms_1", "hef_core"},
    {"wh2_dlc15_hef_inf_rangers_0", "hef_core"},
    --SPECIAL
    {"wh2_main_hef_inf_phoenix_guard", "hef_special", 2},
    {"wh2_main_hef_inf_swordmasters_of_hoeth_0", "hef_special", 2},
    {"wh2_main_hef_inf_white_lions_of_chrace_0", "hef_special", 1},
    {"wh2_main_hef_cav_dragon_princes", "hef_special", 2},
    {"wh2_main_hef_cav_ithilmar_chariot", "hef_special", 2},
    {"wh2_main_hef_cav_tiranoc_chariot", "hef_special", 1},
    {"wh2_main_hef_mon_great_eagle", "hef_special", 2},
    {"wh2_dlc10_hef_inf_shadow_warriors_0", "hef_special", 1},
    {"wh2_dlc15_hef_inf_silverin_guard_0", "hef_special", 1},
    {"wh2_dlc15_hef_mon_war_lions_of_chrace_0", "hef_special", 1},
    {"wh2_dlc15_hef_veh_lion_chariot_of_chrace_0", "hef_special", 2},
    --RARE
    {"wh2_main_hef_art_eagle_claw_bolt_thrower", "hef_rare", 1},
    {"wh2_main_hef_mon_moon_dragon", "hef_rare", 2},
    {"wh2_main_hef_mon_phoenix_flamespyre", "hef_rare", 1},
    {"wh2_main_hef_mon_phoenix_frostheart", "hef_rare", 1},
    {"wh2_main_hef_mon_star_dragon", "hef_rare", 3},
    {"wh2_main_hef_mon_sun_dragon", "hef_rare", 2},
    {"wh2_dlc10_hef_inf_sisters_of_avelorn_0", "hef_rare", 1},
    {"wh2_dlc15_hef_mon_arcane_phoenix_0", "hef_rare", 2},
    
    -------FACTION UNIQUES-------
    --CORE
    {"wh2_dlc10_hef_inf_dryads_0", "hef_core"}, --ALARIELLE UNIQUE
    --SPECIAL
    {"wh2_dlc10_hef_mon_treekin_0", "hef_special", 2}, --ALARIELLE UNIQUE
    {"wh2_dlc10_hef_inf_shadow_walkers_0", "hef_special", 2}, --ALITH ANAR UNIQUE
    {"wh2_dlc15_hef_inf_mistwalkers_faithbearers_0", "hef_special", 1},  --ELTHARION UNIQUE
    {"wh2_dlc15_hef_inf_mistwalkers_sentinels_0", "hef_special", 1}, --ELTHARION UNIQUE
    {"wh2_dlc15_hef_inf_mistwalkers_skyhawks_0", "hef_special", 1}, --ELTHARION UNIQUE
    {"wh2_dlc15_hef_inf_mistwalkers_spireguard_0", "hef_special", 1}, --ELTHARION UNIQUE
    --RARE
    {"wh2_dlc10_hef_mon_treeman_0", "hef_rare", 3}, --ALARIELLE UNIQUE
    {"wh2_dlc15_hef_inf_mistwalkers_griffon_knights_0", "hef_rare", 3}, --ELTHARION UNIQUE
    {"wh2_dlc15_hef_mon_black_dragon_imrik", "hef_rare", 3}, --IMRIK UNIQUE
    {"wh2_dlc15_hef_mon_forest_dragon_imrik", "hef_rare", 3}, --IMRIK UNIQUE
    {"wh2_dlc15_hef_mon_moon_dragon_imrik", "hef_rare", 3}, --IMRIK UNIQUE
    {"wh2_dlc15_hef_mon_star_dragon_imrik", "hef_rare", 3}, --IMRIK UNIQUE
    {"wh2_dlc15_hef_mon_sun_dragon_imrik", "hef_rare", 2}, --IMRIK UNIQUE
    
    -------ROR-------
    --CORE
    {"wh2_dlc10_hef_inf_the_scions_of_mathlann_ror_0", "hef_core"},
    {"wh2_dlc10_hef_inf_the_storm_riders_ror_0", "hef_core"},
    {"wh2_dlc15_hef_inf_archers_ror_0", "hef_core"},
    --SPECIAL
    {"wh2_dlc10_hef_inf_the_silverpelts_ror_0", "hef_special", 1},
    {"wh2_dlc10_hef_inf_keepers_of_the_flame_ror_0", "hef_special", 2},
    {"wh2_dlc10_hef_inf_the_grey_ror_0", "hef_special", 1},
    {"wh2_dlc10_hef_cav_the_fireborn_ror_0", "hef_special", 2},
    {"wh2_dlc10_hef_cav_the_heralds_of_the_wind_ror_0", "hef_special", 1},
    {"wh2_dlc15_hef_mon_war_lions_of_chrace_ror_0", "hef_special", 1},
    --RARE
    {"wh2_dlc10_hef_inf_everqueens_court_guards_ror_0", "hef_rare", 1},
    {"wh2_dlc15_hef_mon_arcane_phoenix_ror_0", "hef_rare", 2},
    
    
    ---------------------------------------------------------------
    --DARK ELVES
    ---------------------------------------------------------------
    
    -------NORMAL UNITS-------
    --CORE
    {"wh2_main_def_inf_black_ark_corsairs_0", "def_core"},
    {"wh2_main_def_inf_black_ark_corsairs_1", "def_core"},
    {"wh2_main_def_inf_darkshards_0", "def_core"},
    {"wh2_main_def_inf_darkshards_1", "def_core"},
    {"wh2_main_def_cav_dark_riders_2", "def_core"},
    {"wh2_main_def_inf_bleakswords_0", "def_core"},
    {"wh2_main_def_inf_dreadspears_0", "def_core"},
    {"wh2_main_def_inf_witch_elves_0", "def_core"},
    {"wh2_main_def_cav_dark_riders_0", "def_core"},
    {"wh2_main_def_cav_dark_riders_1", "def_core"},
    {"wh_twa03_def_inf_squig_explosive_0", "def_core"}, --RAKARTH UNIQUE
    --SPECIAL
    {"wh2_main_def_inf_harpies", "def_special", 1},
    {"wh2_dlc10_def_mon_feral_manticore_0", "def_special", 2},
    {"wh2_main_def_inf_shades_0", "def_special", 1},
    {"wh2_main_def_inf_shades_1", "def_special", 2},
    {"wh2_main_def_inf_shades_2", "def_special", 2},
    {"wh2_main_def_inf_black_guard_0", "def_special", 2},
    {"wh2_main_def_cav_cold_one_knights_0", "def_special", 1},
    {"wh2_main_def_cav_cold_one_knights_1", "def_special", 2},
    {"wh2_main_def_inf_har_ganeth_executioners_0", "def_special", 2},
    {"wh2_main_def_cav_cold_one_chariot", "def_special", 2},
    {"wh2_dlc10_def_cav_doomfire_warlocks_0", "def_special", 2},
    {"wh2_dlc14_def_cav_scourgerunner_chariot_0", "def_special", 2},
    {"wh2_twa03_def_mon_wolves_0", "def_special", 1}, --RAKARTH UNIQUE
    --RARE
    {"wh2_main_def_art_reaper_bolt_thrower", "def_rare", 1},
    {"wh2_main_def_mon_black_dragon", "def_rare", 3},
    {"wh2_main_def_mon_war_hydra", "def_rare", 2},
    {"wh2_dlc10_def_mon_kharibdyss_0", "def_rare", 2},
    {"wh2_dlc14_def_mon_bloodwrack_medusa_0", "def_rare", 1},
    {"wh2_dlc14_def_veh_bloodwrack_shrine_0", "def_rare", 2},
    {"wh2_twa03_def_mon_war_mammoth_0", "def_rare", 2}, --RAKARTH UNIQUE
    
    -------ROR-------
    --CORE
    {"wh2_dlc10_def_inf_the_bolt_fiends_ror_0", "def_core"},
    {"wh2_dlc10_def_inf_the_hellebronai_ror_0", "def_core"},
    {"wh2_dlc10_def_inf_sisters_of_the_singing_doom_ror_0", "def_core"}, 
    {"wh2_dlc10_def_cav_raven_heralds_ror_0", "def_core"},
    {"wh2_dlc14_def_inf_harpies_ror_0", "def_core"},
    --SPECIAL
    {"wh2_dlc10_def_inf_blades_of_the_blood_queen_ror_0", "def_special", 2},
    {"wh2_dlc10_def_cav_slaanesh_harvesters_ror_0", "def_special", 2},
    {"wh2_dlc10_def_cav_knights_of_the_ebon_claw_ror_0", "def_special", 2},
    {"wh2_dlc14_def_cav_scourgerunner_chariot_ror_0", "def_special", 2},
    --RARE
    {"wh2_dlc10_def_mon_chill_of_sontar_ror_0", "def_rare", 2},
    {"wh2_dlc10_def_inf_sisters_of_slaughter", "def_rare", 1},
    {"wh2_dlc14_def_mon_bloodwrack_medusa_ror_0", "def_rare", 2},

    
    ---------------------------------------------------------------
    --TOMB KINGS
    ---------------------------------------------------------------
    
    -------NORMAL UNITS------
    --CORE
    {"wh2_dlc09_tmb_inf_nehekhara_warriors_0", "tmb_core"},
    {"wh2_dlc09_tmb_inf_skeleton_archers_0", "tmb_core"},
    {"wh2_dlc09_tmb_inf_skeleton_spearmen_0", "tmb_core"},
    {"wh2_dlc09_tmb_inf_skeleton_warriors_0", "tmb_core"},
    {"wh2_dlc09_tmb_veh_skeleton_archer_chariot_0", "tmb_core"},
    {"wh2_dlc09_tmb_veh_skeleton_chariot_0", "tmb_core"},
    {"wh2_dlc09_tmb_cav_skeleton_horsemen_0", "tmb_core"},
    {"wh2_dlc09_tmb_cav_skeleton_horsemen_archers_0", "tmb_core"},
    --SPECIAL
    {"wh2_dlc09_tmb_inf_tomb_guard_0", "tmb_special", 1},
    {"wh2_dlc09_tmb_inf_tomb_guard_1", "tmb_special", 1},
    {"wh2_dlc09_tmb_mon_carrion_0", "tmb_special", 1},
    {"wh2_dlc09_tmb_mon_sepulchral_stalkers_0", "tmb_special", 2},
    {"wh2_dlc09_tmb_mon_ushabti_0", "tmb_special", 2},
    {"wh2_dlc09_tmb_mon_ushabti_1", "tmb_special", 2},
    {"wh2_dlc09_tmb_cav_necropolis_knights_0", "tmb_special", 2},
    {"wh2_dlc09_tmb_cav_necropolis_knights_1", "tmb_special", 2},
    {"wh2_dlc09_tmb_cav_nehekhara_horsemen_0", "tmb_special", 1},
    --RARE
    {"wh2_dlc09_tmb_mon_tomb_scorpion_0", "tmb_rare", 1},
    {"wh2_dlc09_tmb_mon_heirotitan_0", "tmb_rare", 3},
    {"wh2_dlc09_tmb_mon_necrosphinx_0", "tmb_rare", 3},
    {"wh2_dlc09_tmb_art_casket_of_souls_0", "tmb_rare", 1},
    {"wh2_dlc09_tmb_art_screaming_skull_catapult_0", "tmb_rare", 1},
    {"wh2_dlc09_tmb_veh_khemrian_warsphinx_0", "tmb_rare", 2},
    {"wh2_pro06_tmb_mon_bone_giant_0", "tmb_rare", 2},
    
    -------ARKHAN UNDEAD-------
    --CORE
    {"wh2_dlc09_tmb_mon_dire_wolves", "tmb_core"},
    {"wh2_dlc09_tmb_mon_fell_bats", "tmb_core"},
    {"wh2_dlc09_tmb_inf_crypt_ghouls", "tmb_core"},
    --SPECIAL
    {"wh2_dlc09_tmb_cav_hexwraiths", "tmb_special", 2},
    
    
    -------LEGIONS OF LEGEND-------
    --SPECIAL
    {"wh2_dlc09_tmb_mon_carrion_ror", "tmb_special", 1},
    {"wh2_dlc09_tmb_cav_necropolis_knights_ror", "tmb_special", 2},
    {"wh2_dlc09_tmb_cav_nehekhara_horsemen_ror", "tmb_special", 1},
    {"wh2_dlc09_tmb_inf_nehekhara_warriors_ror", "tmb_tmb_special", 1},
    
    -------ROR-------
    --CORE
    {"wh2_dlc09_tmb_inf_skeleton_spearmen_ror", "tmb_core"},
    {"wh2_dlc09_tmb_inf_skeleton_archers_ror", "tmb_core"},
    --SPECIAL
    {"wh2_dlc09_tmb_inf_tomb_guard_ror", "tmb_special", 1},
    {"wh2_dlc09_tmb_mon_ushabti_ror", "tmb_special", 2},
    {"wh2_dlc09_tmb_mon_sepulchral_stalkers_ror", "tmb_special", 2},
    --RARE
    {"wh2_dlc09_tmb_mon_necrosphinx_ror", "tmb_rare", 3},
    
    
    
    ---------------------------------------------------------------
    --VAMPIRE COAST
    ---------------------------------------------------------------
    
    -------NORMAL UNITS------
    --CORE
    {"wh2_dlc11_cst_inf_sartosa_free_company_0", "cst_core"}, --ARANESSA UNIQUE
    {"wh2_dlc11_cst_inf_sartosa_militia_0", "cst_core"}, --ARANESSA UNIQUE
    {"wh2_dlc11_cst_inf_zombie_deckhands_mob_0", "cst_core"},
    {"wh2_dlc11_cst_inf_zombie_deckhands_mob_1", "cst_core"},
    {"wh2_dlc11_cst_inf_zombie_gunnery_mob_0", "cst_core"},
    {"wh2_dlc11_cst_inf_zombie_gunnery_mob_1", "cst_core"},
    {"wh2_dlc11_cst_inf_zombie_gunnery_mob_2", "cst_core"},
    {"wh2_dlc11_cst_inf_zombie_gunnery_mob_3", "cst_core"},
    {"wh2_dlc11_cst_mon_bloated_corpse_0", "cst_core"},
    {"wh2_dlc11_cst_mon_fell_bats", "cst_core"},
    {"wh2_dlc11_cst_mon_scurvy_dogs", "cst_core"},
    --SPECIAL
    {"wh2_dlc11_cst_art_carronade", "cst_special", 2},
    {"wh2_dlc11_cst_art_mortar", "cst_special", 2},
    {"wh2_dlc11_cst_cav_deck_droppers_0", "cst_special", 1},
    {"wh2_dlc11_cst_cav_deck_droppers_1", "cst_special", 1},
    {"wh2_dlc11_cst_cav_deck_droppers_2", "cst_special", 1},
    {"wh2_dlc11_cst_inf_deck_gunners_0", "cst_special", 1},
    {"wh2_dlc11_cst_inf_depth_guard_0", "cst_special", 2},
    {"wh2_dlc11_cst_inf_depth_guard_1", "cst_special", 2},
    {"wh2_dlc11_cst_inf_syreens", "cst_special", 2},
    {"wh2_dlc11_cst_mon_animated_hulks_0", "cst_special", 1},
    {"wh2_dlc11_cst_mon_rotting_prometheans_0", "cst_special", 2},
    {"wh2_dlc11_cst_mon_rotting_prometheans_gunnery_mob_0", "cst_special", 2},
    --RARE
    {"wh2_dlc11_cst_mon_mournguls_0", "cst_rare", 1},
    {"wh2_dlc11_cst_mon_necrofex_colossus_0", "cst_rare", 3},
    {"wh2_dlc11_cst_mon_rotting_leviathan_0", "cst_rare", 3},
    {"wh2_dlc11_cst_mon_terrorgheist", "cst_rare", 3},
    
    -------ROR-------
    --CORE
    {"wh2_dlc11_cst_inf_zombie_deckhands_mob_ror_0", "cst_core"},
    --SPECIAL
    {"wh2_dlc11_cst_inf_depth_guard_ror_0", "cst_special", 2},
    {"wh2_dlc11_cst_inf_zombie_gunnery_mob_ror_0", "cst_special", 1},
    {"wh2_dlc11_cst_inf_deck_gunners_ror_0", "cst_special", 1},
    {"wh2_dlc11_cst_cav_deck_droppers_ror_0", "cst_special", 1},
    {"wh2_dlc11_cst_mon_rotting_prometheans_gunnery_mob_ror", "cst_special", 2},
    --RARE
    {"wh2_dlc11_cst_mon_mournguls_ror_0", "cst_rare", 1},
    {"wh2_dlc11_cst_mon_necrofex_colossus_ror_0", "cst_rare", 3},

    ---------------------------------------------------------------
    --OGRE MERCENARIES
    ---------------------------------------------------------------
    {"wh2_twa05_ogr_cav_mournfang_cavalry_0", "emp_rare", 2},
    {"wh2_twa05_ogr_inf_maneaters_2", "emp_rare", 2},
    {"wh2_twa05_ogr_inf_maneaters_3", "emp_rare", 2},
    {"wh2_twa05_ogr_inf_ogres_0", "emp_special", 1},
    {"wh2_twa05_ogr_inf_ogres_1", "emp_special", 1}
    
} --:vector<{string, string, number?}> 

local unit_text_overrides = {
    ["wh2_main_lzd_mon_kroxigors_nakai"]  = {
        _text =  "Nakai the Wanderer grants your faction a discount to this unit.\nThis unit is a Special Unit and costs[[col:green]] 1 [[/col]]points.\n Armies may have an unlimited number of Core Units.",
        _image = "ui/custom/recruitment_controls/special_units_1.png"
    }
}--:map<string, RM_UIPROFILE>

--assign units to empire then load to this table to make a unit universal.
local all_other_subcultures = {"wh_dlc03_sc_bst_beastmen", "wh_dlc05_sc_wef_wood_elves", "wh_main_sc_brt_bretonnia", "wh_main_sc_chs_chaos", "wh_main_sc_dwf_dwarfs", "wh_main_sc_grn_greenskins", "wh_main_sc_ksl_kislev", "wh_main_sc_nor_norsca", "wh_main_sc_teb_teb", "wh_main_sc_vmp_vampire_counts", "wh2_dlc09_sc_tmb_tomb_kings", "wh2_main_sc_def_dark_elves", 
"wh2_main_sc_hef_high_elves", "wh2_main_sc_lzd_lizardmen", "wh2_main_sc_skv_skaven", "wh2_dlc11_sc_cst_vampire_coast"}

local loaned_units = {
    {"wh2_main_lzd_cav_cold_ones_feral_0", "wh2_main_sc_def_dark_elves", "def_core"},
    {"wh2_main_lzd_mon_stegadon_0", "wh2_main_sc_def_dark_elves", "def_special", 3},
    {"wh2_main_lzd_mon_carnosaur_0", "wh2_main_sc_def_dark_elves", "def_rare", 2},
    {"wh2_twa05_ogr_cav_mournfang_cavalry_0", all_other_subcultures, "rare", 2},
    {"wh2_twa05_ogr_inf_maneaters_2",all_other_subcultures, "rare", 2},
    {"wh2_twa05_ogr_inf_maneaters_3", all_other_subcultures, "rare", 2},
    {"wh2_twa05_ogr_inf_ogres_0", all_other_subcultures, "special", 1},
    {"wh2_twa05_ogr_inf_ogres_1", all_other_subcultures, "special", 1}
}--:vector<{string, string|vector<string>, string, number?}>

---info tables end---




rm:add_units_in_table_to_tabletop_groups(units, unit_text_overrides)
rm:add_loaned_units_in_table(loaned_units)

            
rm:add_post_setup_callback(function()
    --this gives skrolk core plague monks
    rm:create_unit_override("wh2_main_skv_inf_plague_monks", "core_plague_monks")
    rm:add_subtype_filter_for_unit_override("wh2_main_skv_lord_skrolk", "core_plague_monks")
    rm:set_ui_profile_for_unit_override("core_plague_monks", "[[col:yellow]]Special Rule: [[/col]] Lord Skrolk can recruit Plague Monks as Core units in his armies. \n Armies may have an unlimited number of Core Units.", "ui/custom/recruitment_controls/common_units.png")
    rm:log("Added Skrolk Special Rule")
    --this sets up the AI
    local subculture_defaults = {
        ["wh_main_sc_emp_empire"] = {"wh_dlc04_emp_inf_free_company_militia_0", "wh_main_emp_cav_empire_knights", "wh_main_emp_inf_halberdiers", "wh_main_emp_inf_handgunners", "wh_main_emp_inf_spearmen_1", "wh_main_emp_inf_swordsmen", "wh2_dlc13_emp_inf_archers_0", "wh_main_emp_inf_crossbowmen"},
        ["wh_main_sc_dwf_dwarfs"] = {"wh_main_dwf_inf_longbeards", "wh_main_dwf_inf_thunderers_0", "wh_main_dwf_inf_dwarf_warrior_0", "wh_main_dwf_inf_dwarf_warrior_1", "wh_main_dwf_inf_quarrellers_0", "wh_main_dwf_inf_miners_1"},
        ["wh_dlc03_sc_bst_beastmen"] = {"wh_dlc03_bst_inf_gor_herd_0", "wh_dlc03_bst_inf_ungor_raiders_0",  "wh_dlc03_bst_inf_ungor_spearmen_1", "wh_dlc03_bst_inf_gor_herd_0", "wh_dlc03_bst_inf_gor_herd_0"},
        ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_inf_eternal_guard_1", "wh_dlc05_wef_inf_glade_guard_0", "wh_dlc05_wef_inf_dryads_0"},
        ["wh_main_sc_brt_bretonnia"] = {"wh_main_brt_cav_knights_of_the_realm", "wh_dlc07_brt_inf_men_at_arms_2", "wh_main_brt_inf_peasant_bowmen", "wh_main_brt_cav_knights_of_the_realm"},
        ["wh_main_sc_chs_chaos"] = {"wh_main_chs_inf_chaos_warriors_0", "wh_main_chs_cav_chaos_chariot", "wh_main_chs_inf_chaos_warriors_0", "wh_main_chs_inf_chaos_warriors_0", "wh_dlc01_chs_inf_forsaken_0"},
        ["wh_main_sc_grn_greenskins"] = {"wh_main_grn_inf_orc_big_uns", "wh_dlc06_grn_inf_nasty_skulkers_0", "wh_main_grn_inf_orc_arrer_boyz", "wh_main_grn_inf_orc_boyz"},
        ["wh_main_sc_grn_savage_orcs"] = {"wh_main_grn_inf_savage_orc_big_uns","wh_main_grn_inf_savage_orc_arrer_boyz", "wh_main_grn_inf_savage_orcs"},
        ["wh_main_sc_nor_norsca"] = {"wh_main_nor_inf_chaos_marauders_0", "wh_dlc08_nor_inf_marauder_hunters_1", "wh_main_nor_inf_chaos_marauders_0", "wh_dlc08_nor_inf_marauder_spearman_0", "wh_main_nor_cav_marauder_horsemen_0"},
        ["wh_main_sc_vmp_vampire_counts"] = {"wh_main_vmp_inf_crypt_ghouls", "wh_main_vmp_inf_skeleton_warriors_0", "wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_inf_zombie", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_mon_dire_wolves"},
        ["wh2_dlc09_sc_tmb_tomb_kings"] = {"wh2_dlc09_tmb_inf_nehekhara_warriors_0", "wh2_dlc09_tmb_inf_skeleton_archers_0", "wh2_dlc09_tmb_veh_skeleton_archer_chariot_0", "wh2_dlc09_tmb_inf_nehekhara_warriors_0"},
        ["wh2_main_sc_def_dark_elves"] = {"wh2_main_def_inf_black_ark_corsairs_0","wh2_main_def_inf_darkshards_0", "wh2_main_def_inf_dreadspears_0"},
        ["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_inf_spearmen_0", "wh2_main_hef_inf_spearmen_0", "wh2_main_hef_inf_archers_1", "wh2_main_hef_cav_silver_helms_0", "wh2_main_hef_inf_lothern_sea_guard_1"},
        ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_inf_saurus_warriors_1", "wh2_main_lzd_inf_saurus_spearmen_0", "wh2_main_lzd_inf_saurus_warriors_1", "wh2_main_lzd_inf_skink_cohort_1"},
        ["wh2_main_sc_skv_skaven"]  = {"wh2_main_skv_inf_clanrats_1", "wh2_main_skv_inf_clanrat_spearmen_1", "wh2_main_skv_inf_night_runners_1", "wh2_main_skv_inf_skavenslave_slingers_0"},
        ["wh2_dlc11_sc_cst_vampire_coast"] = {"wh2_dlc11_cst_inf_zombie_gunnery_mob_0", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", "wh2_dlc11_cst_inf_zombie_gunnery_mob_1", "wh2_dlc11_cst_mon_bloated_corpse_0", "wh2_dlc11_cst_inf_zombie_deckhands_mob_1"}
    } --:map<string, vector<string>>

    for subculture, unit_vector in pairs(subculture_defaults) do
        rm:add_ai_units_for_subculture_with_table(subculture, unit_vector)
    end
end)


