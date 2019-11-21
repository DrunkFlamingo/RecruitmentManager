local rm = _G.rm


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
    "wh_dlc03_sc_bst_beastmen",
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
    "wh2_main_sc_lzd_lizardmen"
}--:vector<string>

for i = 1, #pseudohorde_enabled_cultures do
    rm:add_subculture_path_filter(pseudohorde_enabled_cultures[i], "CharBoundHordeNoScroll")
end


--implementation for subtype and subculture filters on creation

--implement the UIPathAssignment
core:add_listener(
    "UIRecruiterCharacterCreatedUIPathAssignment",
    "UIRecruiterCharacterCreated",
    function(context)
        return true
    end,
    function(context)
        local char = context:character()
        local rec_char = rm._recruiterCharacters[char:command_queue_index()]
        --this is a raw get because if it went through the rm:get_character_by_cqi() method it could cause infinite loop, if RM somehow passes wrong character
        local pathset = rm:evaluate_path_set_for_character(char)
        if pathset then
            rm:log("Pathset for character ["..tostring(char:command_queue_index()).."] found")
            rec_char._UIPathSet = pathset
        end
    end,
    true
)

core:add_listener(
    "UIRecruiterCharacterCreatedUIPathAssignment",
    "UIRecruiterCharacterCreated",
    function(context)
        return true
    end,
    function(context)
        local char = context:character() --:CA_CHAR
        local subtype = char:character_subtype_key()
        if rm._overrideSubtypeFilters[subtype] then
            for i = 1, #rm._overrideSubtypeFilters[subtype] do
                local abstractionID = rm._overrideSubtypeFilters[subtype][i]
                local abstraction = rm._overrideUnits[abstractionID]
                if abstraction then
                    rm:get_character_by_cqi(char:command_queue_index()):add_overriden_unit_entry(abstraction:key(), abstraction)
                end
            end
        end
    end,
    true
)

local RECIEVED_SKILLS = {} --:map<string, vector<string>>

--v function(cqi: CA_CQI, skill: string)
local function RecruiterCharacterSkillGained(cqi, skill)
    local cqi_as_string = tostring(cqi)
    if not RECIEVED_SKILLS[cqi_as_string] then
        RECIEVED_SKILLS[cqi_as_string] = {}
    end
    RECIEVED_SKILLS[cqi_as_string][(#RECIEVED_SKILLS[cqi_as_string])+1] = skill
end

--v function(cqi_as_string: string)
local function RecruiterCharacterSkillsLoaded(cqi_as_string)
    local cqi = tonumber(cqi_as_string) --# assume cqi: CA_CQI
    local char = cm:get_character_by_cqi(cqi)
    local subtype = char:character_subtype_key()
    local overrides = rm._overrideSkillRequirements[subtype] 
    local skills = RECIEVED_SKILLS[tostring(cqi)]
    for i = 1, #skills do
        local skill = skills[i]
        local abstraction = rm._overrideUnits[overrides[skill]]
        if char:has_skill(skill) and abstraction then
            rm:log("Loaded RM relevent skill: "..skill)
            rm:get_character_by_cqi(char:command_queue_index()):add_overriden_unit_entry(abstraction:key(), abstraction)
        end
    end
end

cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("RM_RECIEVED_SKILLS", RECIEVED_SKILLS, context);
	end
);
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			RECIEVED_SKILLS = cm:load_named_value("RM_RECIEVED_SKILLS", RECIEVED_SKILLS, context);
        end
	end
);



cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = function(context)
    for k, v in pairs(RECIEVED_SKILLS) do
        RecruiterCharacterSkillsLoaded(k)
    end
end

core:add_listener(
    "RecruiterCharacterSkillPointAllocatedGenerator",
    "CharacterSkillPointAllocated",
    function(context)
        local subtype_entry = rm._overrideSkillRequirements[context:character():character_subtype_key()]
        return (not not subtype_entry) and not not subtype_entry[context:skill_point_spent_on()]
    end,
    function(context)
        local char = context:character() --:CA_CHAR
        local subtype = char:character_subtype_key()
        local overrides = rm._overrideSkillRequirements[subtype] 
        local skill = context:skill_point_spent_on()
        local abstractionID = overrides[skill]
        local abstraction = rm._overrideUnits[abstractionID]
        if abstraction then
            rm:log("Gained RM relevent skill: "..skill)
            rm:get_character_by_cqi(char:command_queue_index()):add_overriden_unit_entry(abstraction:key(), abstraction)
            RecruiterCharacterSkillGained(char:command_queue_index(), skill)
        end
    end,
    true
)