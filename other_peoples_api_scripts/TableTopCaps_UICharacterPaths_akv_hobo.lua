

local rm = _G.rm


local ship_subtypes = {
        "vmp_heinrich_kemmler",
        "AK_hobo_kemmy_wounded",
        "AK_hobo_nameless",
        "AK_hobo_draesca",
        "AK_hobo_priestess"
}


if not not rm then
  rm:set_group_prefix_for_subculture("hobo_kemmy", "vmp")
  rm:add_post_setup_callback(function()
    rm:add_subculture_path_filter("hobo_kemmy", "NormalFaction")
    for i = 1, #ship_subtypes do
      rm:add_subtype_path_filter(ship_subtypes[i], "CharBoundHordeWithGlobal")
    end
        

  end)
end