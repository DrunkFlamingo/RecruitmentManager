recruiter_unit = {} --# assume recruiter_unit: RECRUITER_UNIT

local override_group_additions = {} --:map<string, map<string, boolean>>
-- map group name to unit name to added.

--v function( manager: RECRUITER_MANAGER, main_unit_key: string, base_unit: RECRUITER_UNIT?) --> RECRUITER_UNIT
function recruiter_unit.create_record(manager, main_unit_key, base_unit)
   local self = {}
   setmetatable(self, {
       __index = recruiter_unit,
       __tostring = function() return "RECRUITER_UNIT" end
   }) --# assume self: RECRUITER_UNIT

   self._key = main_unit_key
   self._manager = manager
   --weight refers to the value a unit is assigned in calculations. 
   self._weight = 1 --:number
   --links a unit to a group key 
   --check comes here to check whether a group is valid for the unit being checked.
   self._groups = {} --:map<string, boolean>
   --Marks the unit as an overriden unit. 
   self._isOverride = not not base_unit
   --points to the base unit an override is based upon. Its ? typed, because it will be nil if the unit is a base!
   self._baseUnit = base_unit
   --holds the default UI profile for a unit. 
   --Override entries hold their own profiles so no profile overrides are needed at the character level.
   self._UIPip = nil --:string
   self._UIText = nil  --:string
   -- unit localisation is based on the land unit key, but the script can only work with main unit keys.
   -- this lets us manually set a land unit for where the key isn't identical to main unit.
   self._landUnit = nil --:string
   return self
end

--v function(self: RECRUITER_UNIT, text: string)
function recruiter_unit.log(self, text)
   self._manager:log(text)
end

--v function(self: RECRUITER_UNIT) --> string
function recruiter_unit.key(self)
   return self._key
end


--sets the UI profile that a unit uses when unlocked. 
--This is an arbitrary type with a text and image path in a table.
--v function(self: RECRUITER_UNIT, text: string, path_to_pip: string)
function recruiter_unit.add_ui_profile(self, text, path_to_pip)
   self._UIPip = path_to_pip 
   self._UIText = text  
end

--v function(self: RECRUITER_UNIT, weight: number)
function recruiter_unit.set_unit_weight(self, weight)
   self._weight = weight
end

--v function(self: RECRUITER_UNIT) --> number
function recruiter_unit.weight(self)
   return self._weight
end

--v function(self: RECRUITER_UNIT, land_unit: string)
function recruiter_unit.set_land_unit(self, land_unit)
   self._landUnit = land_unit
end

--v function(self: RECRUITER_UNIT) --> string
function recruiter_unit.get_localised_string(self)
   if self._landUnit then
      return effect.get_localised_string("land_units_onscreen_name_"..self._landUnit)
   elseif self._isOverride and self._baseUnit._landUnit then
      return effect.get_localised_string("land_units_onscreen_name_"..self._baseUnit._landUnit)
   else
      return effect.get_localised_string("land_units_onscreen_name_"..self._key)
   end
end

--v function(self: RECRUITER_UNIT, groupID: string)
function recruiter_unit.add_group_to_unit(self, groupID)
   self._groups[groupID] = true
   if not self._isOverride then
       --normal unit.
       self._manager._groupToUnits[groupID] = self._manager._groupToUnits[groupID] or {}
       table.insert(self._manager._groupToUnits[groupID], self._key)
   elseif self._baseUnit then
       local base = self._baseUnit --# assume base: RECRUITER_UNIT!
       --we only need to add this unit to this group if it isn't already present.
       --if it has the same group as it's base unit, it's already present in the check vector.
       if not base._groups[groupID] then 
           --otherwise, we keep a record of where we put unit keys for override units.
           override_group_additions[groupID] = override_group_additions[groupID] or {}
           if not override_group_additions[groupID][self._key] then
               self._manager._groupToUnits[groupID] = self._manager._groupToUnits[groupID] or {}
               table.insert(self._manager._groupToUnits[groupID], self._key)
               override_group_additions[groupID][self._key] = true
           end
       end
   else
       self:log("Something went wrong adding group to a unit object: Unit was not added to check vector!")
   end
end

--v function(self: RECRUITER_UNIT, groupID: string) --> boolean
function recruiter_unit.has_group(self, groupID)
   return not not self._groups[groupID]
end

--v function(self: RECRUITER_UNIT) --> map<string, boolean>
function recruiter_unit.groups(self)
   return self._groups
end


