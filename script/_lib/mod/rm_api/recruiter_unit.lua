 recruiter_unit = {} --# assume recruiter_unit: RECRUITER_UNIT

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

--v function(self: RECRUITER_UNIT, groupID: string)
function recruiter_unit.add_group_to_unit(self, groupID)
    self._groups[groupID] = true
    self._manager._groupToUnits[groupID] = self._manager._groupToUnits[groupID] or {}
    table.insert(self._manager._groupToUnits[groupID], self._key)
end

--v function(self: RECRUITER_UNIT, groupID: string) --> boolean
function recruiter_unit.has_group(self, groupID)
    return not not self._groups[groupID]
end

--v function(self: RECRUITER_UNIT) --> map<string, boolean>
function recruiter_unit.groups(self)
    return self._groups
end


