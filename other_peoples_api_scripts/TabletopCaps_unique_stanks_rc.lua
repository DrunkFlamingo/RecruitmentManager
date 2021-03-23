local rm = _G.rm

local zombiestanks = {
    {"wh_emp_steam_tank_deliverance", "emp_rare", 3},
    {"wh_emp_steam_tank_alter", "emp_rare", 3},
    {"wh_emp_steam_tank_sigmar", "emp_rare", 3},
    {"wh_emp_steam_tank_implacable", "emp_rare", 3},
    {"wh_emp_steam_tank_invincible", "emp_rare", 3},
    {"wh2_skv_rat_tank", "skv_rare", 3}
    ,
    {"cr_emp_veh_von_zeppels", "emp_rare", 3},
    {"cr_emp_veh_halftank", "emp_rare", 3},
    {"cr_emp_veh_unextinguishable", "emp_rare", 3}
    }--:vector<{string, string, number?}>


if not not rm then
    rm:add_units_in_table_to_tabletop_groups(zombiestanks)
end