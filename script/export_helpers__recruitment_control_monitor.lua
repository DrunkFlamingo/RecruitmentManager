--updates the values on an event: RecruiterManagerGroupCountUpdated
--Self-hides on recruitment panel closed event.
--auotdisplays whenever value is updated and rec panel is visible. 
local rm = _G.rm
local GROUP_KEY_TO_UIC = {} --:map<string, CA_UIC>

local group_image_paths = {
    ["special"] = {"ui/custom/recruitment_controls/special_units_1.png", "Special"},
    ["rare"] = {"ui/custom/recruitment_controls/rare_units_1.png", "Rare"}
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
--helpers
--do small stuff for the UI

--v function(uic: CA_UIC, rec_char: RECRUITER_CHARACTER, groupID: string)
local function update_display(uic, rec_char, groupID)

    local image = nil --:string
    local name = nil --:string
    for k,v in pairs(group_image_paths) do
        if groupID:find(k) then
            image = v[1]
            name = v[2]
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
        local tt_string = "You have used "..tostring(quantity).." of the "..tostring(cap).." "..name.." points available to this force!"
        uic:SetTooltipText(tt_string)
    end
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
                local uic = find_uicomponent(uicParent, "dy_"..groupID)
                if not uic then
                    local uicSibling = find_uicomponent(uicParent, "dy_upkeep")
                    if uicSibling then
                        local new_uic = UIComponent(uicSibling:CopyComponent("dy_"..groupID))
                        created_uic[#created_uic+1] = "dy_"..groupID
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