local rm = _G.rm

local units = {
	{"zayli_brt_foot_squires_hammer", "brt_special", 1},
	{"zayli_brt_foot_squires_spear", "brt_special", 1},
	{"zayli_brt_men_at_arms_heavyshot", "brt_special", 1},
	{"zayli_brt_men_at_arms_longbow", "brt_core"},
	{"zayli_brt_men_at_arms_crossbow", "brt_core"},
	{"zayli_brt_royal_spearmen_at_arms", "brt_core"},
	{"zayli_brt_swords_of_crn", "brt_core"},
	{"zayli_brt_relic_hunters", "brt_special", 1},
	{"zayli_brt_royal_longbowmen", "brt_special", 1},
    {"zayli_brt_royarch_guard", "brt_rare", 1},
    {"zayli_brt_royal_foot_squires", "brt_special", 1},
    {"zayli_brt_crescentia", "brt_rare", 1},
    {"zayli_brt_crescentia_retributer", "brt_rare", 1}
}--:vector<{string, string, number?}>

local vanilla_units_changed = {
    {"wh_dlc07_brt_inf_battle_pilgrims_0", "brt_core"},
    {"wh_dlc07_brt_inf_grail_reliquae_0", "brt_special", 1},
    {"wh_main_brt_cav_grail_knights", "brt_rare", 1},
    {"wh_dlc07_brt_cav_grail_guardians_0", "brt_rare", 1}
}


if not not rm then
    rm:add_units_in_table_to_tabletop_groups(units)
    rm:override_default_settings_for_vanilla_units(vanilla_units_changed)
end