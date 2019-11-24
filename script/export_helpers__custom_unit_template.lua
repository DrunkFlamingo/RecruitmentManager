if not _G.rm then out("Tabletop Caps not present") else
    local rm = _G.rm
    
    local units = {
        {"wh_dlc04_emp_cav_royal_altdorf_gryphites_0", "emp_special", 3},
        --note the comma after entries that are not the final entry. Most common mistake is forgetting.
        {"wh_dlc04_emp_art_hammer_of_the_witches_0", "emp_special", 2}
        --these refer to the unit key, group key, and weight, respectively.
    } --:vector<{string, string, number}>
    
    --you don't need to touch this at all: it takes the table above and calls the necessary commands 
    for i = 1, #units do
        if units[i][3] then
            rm:set_weight_for_unit(units[i][1], units[i][3])
        end
        rm:add_unit_to_group(units[i][1], units[i][2])
        if string.find(units[i][2], "_core") then
            local prefix = string.gsub(units[i][2], "_core", "")
            rm:set_ui_profile_for_unit(units[i][1], {
                _text = "This unit is a Core Unit. \n Armies may have an unlimited number of Core Units.",
                _image = "ui/custom/recruitment_controls/common_units.png"
            })
        elseif string.find(units[i][2], "_special") then
            local prefix = string.gsub(units[i][2], "_special", "")
            local weight = units[i][3] --# assume weight: number
            rm:set_ui_profile_for_unit(units[i][1], {
                _text = "This unit is a Special Unit and costs[[col:green]] "..weight.." [[/col]]points. \n Armies may have up to 10 Points worth of Special Units. ",
                _image = "ui/custom/recruitment_controls/special_units_"..weight..".png"
            })
        elseif string.find(units[i][2], "_rare") then
            local prefix = string.gsub(units[i][2], "_rare", "")
            local weight = units[i][3] --# assume weight: number
            rm:set_ui_profile_for_unit(units[i][1], {
                _text = "This unit is a Rare Unit and costs[[col:green]] "..weight.." [[/col]]points. \n Armies may have up to 5 Points worth of Rare Units. ",
                _image = "ui/custom/recruitment_controls/rare_units_"..weight..".png"
            })
        end
    end
end 