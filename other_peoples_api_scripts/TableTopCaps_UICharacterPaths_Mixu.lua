local rm = core:get_static_object("recruitment_manager") 

  local ship_subtypes = {
      "emp_edward_van_der_kraal",
      "bst_slugtongue",
      "bst_ghorros_warhoof"
  }
  
  
  
  if not not rm then
    rm:add_post_setup_callback(function()
      for i = 1, #ship_subtypes do
        rm:add_subtype_path_filter(ship_subtypes[i], "CharBoundHordeWithGlobal")
      end
    end)
  end