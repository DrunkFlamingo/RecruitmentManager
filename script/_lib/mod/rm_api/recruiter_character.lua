recruiter_character = {} --# assume recruiter_character: RECRUITER_CHARACTER
--ui utility to get the names of the units in the queue by reading the UI.


--v function(manager: RECRUITER_MANAGER, cqi: CA_CQI) --> RECRUITER_CHARACTER
function recruiter_character.new(manager, cqi)
    local self = {}
    setmetatable(self, {
        __index = recruiter_character,
        __tostring = function() return "RECRUITER_CHARACTER" end
    })--# assume self: RECRUITER_CHARACTER

    self._cqi = cqi --stores the cqi identifier of the character
    self._character = cm:get_character_by_cqi(cqi)
    self._factionKey = self._character:faction():name()
    self._isHuman = self._character:faction():is_human()
    self._manager = manager  -- stores the associated rm
    self._armyCounts = {} --:map<string, number> --stores the current number of each unit in the army
    self._queueCounts = {} --:map<string, number> --same as above but for queues
    -- stores the units currently restricted for the character
    self._restrictedUnits = {} --:map<string, boolean> 
    -- stores the units currently hidden for the character
    self._hiddenUnits = {} --:map<string, boolean>
    -- stores any overriden units applied to this char. 
    --These are thrown onto the character during the model loadup during first tick.
    self._ownedUnits = {} --:map<string, RECRUITER_UNIT> 
    --stores the string to explain why a unit is locked.
    self._UILockTexts = {} --:map<string, string> 
    self._staleQueueFlag = true --:boolean -- flags for the queue needing to be refreshed entirely.
    self._staleArmyFlag = true --:boolean --flags for the army needing to be refreshed entirely.

    --new 10/07/19
    --stores how much of each category is possessed.
    self._groupCounts = {} --:map<string, number>
    --stores how much of each category is allowed.
    self._groupMax = {} --:map<string, number>

    --new 10/15/19
    --stores the mercenary queue
    self._mercenaryQueue = {} --:vector<string>
    --the mercenary queue never persists, so it doesn't require flagging!
    --it also has consistent ordering in an array form, so we can track it as a simpler Vector.

    self._UIPathSet = nil --:RECRUITER_PATHSET

    return self
end


--return the cqi
--v function(self: RECRUITER_CHARACTER) --> CA_CQI
function recruiter_character.command_queue_index(self)
    return self._cqi
end

--v function(self: RECRUITER_CHARACTER) --> string
function recruiter_character.cqi_as_str(self)
    return tostring(self._cqi)
end

--return the faction object of the character
--v function(self: RECRUITER_CHARACTER) --> CA_FACTION
function recruiter_character.faction(self)
    return self._character:faction()
end

--return the rm
--v function(self: RECRUITER_CHARACTER) --> RECRUITER_MANAGER
function recruiter_character.manager(self)
    return self._manager
end

--log text to file.
--v function(self: RECRUITER_CHARACTER, text: any) 
function recruiter_character.log(self, text)
    self:manager():log(text)
end

--get the army counts map
--v function(self: RECRUITER_CHARACTER) --> map<string, number>
function recruiter_character.get_army_counts(self)
    return self._armyCounts
end

--get the queue counts map
--v function(self: RECRUITER_CHARACTER) --> map<string, number>
function recruiter_character.get_queue_counts(self)
    return self._queueCounts
end

--get the restricted units map
--v function(self: RECRUITER_CHARACTER) --> map<string, boolean>
function recruiter_character.get_unit_restrictions(self)
    return self._restrictedUnits
end

----------------------
-------UI TEXTS-------
----------------------

--get the lock text for a unit
--v function(self: RECRUITER_CHARACTER, unitID: string) --> string
function recruiter_character.get_unit_lock_string(self, unitID)
    if not self._UILockTexts[unitID] then
        return "Available for Recruitment"
    end
    return self._UILockTexts[unitID]
end

--v function(self: RECRUITER_CHARACTER, unitID: string, lock_reason: string) 
function recruiter_character.add_lock_text(self, unitID, lock_reason)
    if self._UILockTexts[unitID] then
        if not string.find(self._UILockTexts[unitID], lock_reason) then
            self._UILockTexts[unitID] = self._UILockTexts[unitID] .. "\n" .. lock_reason
        end
    else
        self._UILockTexts[unitID] = lock_reason
    end
end

---------------------------------
----OWNED UNITS FOR OVERRIDES----
---------------------------------

--v function(self: RECRUITER_CHARACTER, unitID: string) --> boolean
function recruiter_character.has_own_unit(self, unitID)
    return not not self._ownedUnits[unitID]
end

--v function(self: RECRUITER_CHARACTER, unitID: string) --> RECRUITER_UNIT
function recruiter_character.get_owned_unit(self, unitID)
    return self._ownedUnits[unitID]
end

--v function(self: RECRUITER_CHARACTER, unitID: string, rec_unit: RECRUITER_UNIT)
function recruiter_character.add_overriden_unit_entry(self, unitID, rec_unit)
    self._ownedUnits[unitID] = rec_unit
end



-------------------------------------
-------QUEUE AND ARMY TRACKING-------
-------------------------------------

--returns the stale flag for queue
--v function(self: RECRUITER_CHARACTER) --> boolean
function recruiter_character.is_queue_stale(self)
    return self._staleQueueFlag
end

--returns the stale flag for armies
--v function(self: RECRUITER_CHARACTER) --> boolean
function recruiter_character.is_army_stale(self)
    return self._staleArmyFlag
end

--marks the queue for a refresh
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.set_queue_stale(self)
    --[[ --TODO: Unit Pools
    for unit, count in pairs(self._queueCounts) do
        if self:manager():unit_has_pool(unit) then
            self:manager():change_unit_pool(unit, cm:get_character_by_cqi(self:command_queue_index()):faction():name(),  count)
        end
    end
    self._rawQueueFlag = false 
    cm:set_saved_value("RMSavedFreshness|"..tostring(self._cqi), true)
    --]]
    self._staleQueueFlag = true
end

--marks the army for a refresh
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.set_army_stale(self)
    self._staleArmyFlag = true
end

--called after the refresh so it doesn't get called repeatedly.
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.set_queue_fresh(self)
    self._staleQueueFlag = false
    --TODO unit pools saving
    --cm:set_saved_value("RMSavedFreshness|"..tostring(self._cqi), false)
end

--called after the refresh so it doesn't get called repeatedly.
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.set_army_fresh(self)
    self._staleArmyFlag = false
end

--remove all units from queue
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.wipe_queue(self)
    self:log("wiped Queue for ["..tostring(self:command_queue_index()).."] ")
    --loop through the queue, setting each unit entry to 0
    for unit, _ in pairs(self:get_queue_counts()) do 
        self._queueCounts[unit] = 0
    end
end

--remove all units from the army
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.wipe_army(self)
    self:log("wiped Army for ["..tostring(self:command_queue_index()).."] ")
    --loop through the army, setting each unit entry to 0
    for unit, _ in pairs(self:get_army_counts()) do
        self._armyCounts[unit] = 0 --note, tested performance using allocation to reset this
        --its actually pretty much faster this way.
    end
end

--add a unit to the army
--v function(self: RECRUITER_CHARACTER, unitID: string)
function recruiter_character.add_unit_to_army(self, unitID)
    if self._armyCounts[unitID] == nil then
        --if that unit hasn't been used yet, give it a default value.
        self._armyCounts[unitID] = 0 
    end
    self._armyCounts[unitID] = self._armyCounts[unitID] + 1;
    self:log("Added unit ["..unitID.."] to the army of ["..tostring(self:command_queue_index()).."]")
end



--add a unit to the queue
--v function(self: RECRUITER_CHARACTER, unitID: string)
function recruiter_character.add_unit_to_queue(self, unitID)
    --[[--TODO: Unit Pools
    if self:manager():unit_has_pool(unitID) then
        self:manager():change_unit_pool(unitID, cm:get_character_by_cqi(self:command_queue_index()):faction():name(),  -1)
    end--]]
    if self._queueCounts[unitID] == nil then
        self._queueCounts[unitID] = 0 
        --if that unit hasn't been used yet, give it a default value.
    end
    self._queueCounts[unitID] = self._queueCounts[unitID] + 1;
    self:log("Added unit ["..unitID.."] to the queue of ["..tostring(self:command_queue_index()).."]")
end


--refresh the army of the character
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.refresh_army(self)
    --remove the old army before starting
    self:wipe_army()
    self:log("Freshening up the army of ["..tostring(self:command_queue_index()).."]")
    --get unit list for that character's force.
    local army = self._character:military_force():unit_list()
    for i = 0, army:num_items() - 1 do
        local unitID = army:item_at(i):unit_key()
        self:add_unit_to_army(unitID)
    end
    --set army fresh
    self:set_army_fresh()
end


--refresh the queue of the character
--v function(self: RECRUITER_CHARACTER)
function recruiter_character.refresh_queue(self)
    --remove the old queue before we start
    --[[ --TODO Unit Pools
    if self._rawQueueFlag == true then
        for unit, count in pairs(self._queueCounts) do
            if self:manager():unit_has_pool(unit) then
                self:manager():change_unit_pool(unit, cm:get_character_by_cqi(self:command_queue_index()):faction():name(), count)
            end
        end
        self._rawQueueFlag = false;
    end--]]
    self:wipe_queue() 
    if self._isHuman == false then
        self:set_queue_fresh()
        return
    end
    self:log("Freshening up the queue of ["..tostring(self:command_queue_index()).."]")
    --check if the unit panel is open so that we can see the army. If it isn't, the function can abort with a failure message.
    --the queue will be evaluated again next time as we never set the queue fresh
    local unitPanel = find_uicomponent(core:get_ui_root(), "main_units_panel")
    if not unitPanel then
        self:log("Failed to find the main_units_panel UI element while refreshing the queue of ["..tostring(self:command_queue_index()).."] ")
        return
    end
    
    --UI is written in C++, so we loop from 0
    for i = 0, 18 do
        --grab the unit ID from the queued unit tooltips url.
        local unitID = self:manager():GetQueuedUnit(i, "QueuedLandUnit ") 
        --if we find a unit successfully, add to queue. Otherwise, abort the loop. 
        if unitID then
            self:add_unit_to_queue(unitID)
        else
            self:log("Found no unit at ["..i.."], ending the refresh queue loop!")
            break
        end
    end
    --UI is written in C++, so we loop from 0
    for i = 0, 18 do
        --grab the unit ID from the queued unit tooltips url.
        local unitID = self:manager():GetQueuedUnit(i, "temp_merc_") 
        --if we find a unit successfully, add to queue. Otherwise, abort the loop. 
        if unitID then
            self:add_unit_to_queue(unitID)
        else
            self:log("Found no unit at ["..i.."], ending the refresh queue loop!")
            break
        end
    end

    --set the queue fresh
    self:set_queue_fresh()
end


--remove a unit from the queue (used by the queue listener)
--v function(self: RECRUITER_CHARACTER, unitID: string) --> boolean
function recruiter_character.remove_unit_from_queue(self, unitID)
    --[[--TODO: Unit Pools
    if self:manager():unit_has_pool(unitID) then
        self:manager():change_unit_pool(unitID, cm:get_character_by_cqi(self:command_queue_index()):faction():name(), 1)
    end
    --]]
    if self._staleQueueFlag == true then
        --if the queue is stale we shouldn't be doing anything with it. 
        self:refresh_queue()
        return true
    end
    if self._queueCounts[unitID] == nil then
        self:log("Called for the removal of unit ["..unitID.."] for the queue of ["..tostring(self:command_queue_index()).."] but this unit isn't in that queue?!?!")
        return false
    end
    if self._queueCounts[unitID] == 0 then
        self:log("Called for the removal of unit ["..unitID.."] for the queue of ["..tostring(self:command_queue_index()).."] but the count for this unit is 0!")  
        return false 
    end
    self._queueCounts[unitID] = self._queueCounts[unitID] - 1;
    self:log("Removed unit ["..unitID.."] to the queue of ["..tostring(self:command_queue_index()).."]")
    return true
end
    
--remove a unit from the army (used by disband listener)
--v function(self: RECRUITER_CHARACTER, unitID: string)
function recruiter_character.remove_unit_from_army(self, unitID)
    if self._staleArmyFlag == true then
        self:refresh_army()
        return
    end
    if self._armyCounts[unitID] == nil then
        self:log("Called for the removal of unit ["..unitID.."] for the army of ["..tostring(self:command_queue_index()).."] but this unit isn't in that army?!?!")
        return
    end
    self._armyCounts[unitID] = self._armyCounts[unitID] - 1;
    self:log("Removed unit ["..unitID.."] to the army of ["..tostring(self:command_queue_index()).."]")
end



--get a unit count from the army of the character
--v function(self:RECRUITER_CHARACTER, unitID: string) --> number
function recruiter_character.get_unit_count_in_army(self, unitID)
    if self._staleArmyFlag == true then
        self:refresh_army()
    end
    if self._armyCounts[unitID] == nil then
        --if the unit hasn't been used yet, give it a default value.
        return 0
    end
    return self:get_army_counts()[unitID]
end

--get the unit count from the queue of the character
--v function(self:RECRUITER_CHARACTER, unitID: string) --> number
function recruiter_character.get_unit_count_in_queue(self, unitID)
    if self:get_queue_counts()[unitID] == nil then
        --if the unit hasn't been used yet, give it a default value.
        self._queueCounts[unitID] = 0
    end
    if self:is_queue_stale() then
        --if the queue is stale, we're going to return nothing because the queue we have isn't reliable!
        self:log("get_unit_count_in_queue for called for ["..unitID.."] on character ["..tostring(self:command_queue_index()).."], but the queue is stale!")
        return 0 
    end
    return self:get_queue_counts()[unitID]
end

--get a boolean whether you have a specific unit
--v function(self: RECRUITER_CHARACTER, unitID: string) --> boolean
function recruiter_character.has_unit_in_raw_queue(self, unitID)
    return (not not self._queueCounts[unitID]) and self._queueCounts[unitID] > 0
end


-------------------------------------------
-------TEMP MERCENARY QUEUE TRACKING-------
-------------------------------------------

--v function(self: RECRUITER_CHARACTER, unitID: string)
function recruiter_character.queue_mercenary(self, unitID)
    self:log("Added ["..unitID.."] to the MercQueue of ["..self:cqi_as_str().."] at ["..tostring(#self._mercenaryQueue).."] ")
    table.insert(self._mercenaryQueue,unitID)
end

--v function(self: RECRUITER_CHARACTER, Position: int) --> string
function recruiter_character.remove_merc_at_position_returning_key(self, Position)
    if not self._mercenaryQueue[Position] then
        self:log("Warning: Asked to remove a mercenary who doesn't exist!")
        return ""
    end
    local unitID = self._mercenaryQueue[Position]
    table.remove(self._mercenaryQueue, Position)
    self:log("Removed ["..unitID.."] from  the MercQueue of ["..self:cqi_as_str().."] ")
    return unitID
end

--v function(self: RECRUITER_CHARACTER, did_recruit: boolean)
function recruiter_character.clear_mercenary_queue(self, did_recruit)
    self._mercenaryQueue = {}
    if did_recruit then
        self:refresh_army()
    end
end

--v function(self: RECRUITER_CHARACTER, unitID: string) --> number
function recruiter_character.get_mercenary_count(self, unitID)
    if #self._mercenaryQueue == 0 then
        return 0
    end
    local ret = 0
    for i = 1, #self._mercenaryQueue do
        if self._mercenaryQueue[i] == unitID then
            ret = ret + 1
        end
    end
    return ret
end


--checks for stale information, refreshes it, then returns the total count accross both queue and army
--v function(self: RECRUITER_CHARACTER, unitID: string) --> number
function recruiter_character.get_unit_count(self, unitID)
    --if our queue is stale, ask for a refresh.
    if self:is_queue_stale() then
        self:refresh_queue()
    end
    --will not provide any information about the queue if the queue is stale and the queue refresh fails.
    local queue_count = self:get_unit_count_in_queue(unitID)
    --if the army is stale, ask for a refresh
    if self:is_army_stale() then
        self:refresh_army() 
    end
    local army_count = self:get_unit_count_in_army(unitID)
    local merc_count = self:get_mercenary_count(unitID)
    --return the sum of both counts
    --self:log("get unit count for ["..unitID.."] returning ["..tostring(army_count + queue_count).."] ")
    return army_count + queue_count + merc_count
end

--set a unit to be restricted for a character
--v function(self: RECRUITER_CHARACTER, unitID: string, restricted: boolean, reason: string?)
function recruiter_character.set_unit_restriction(self, unitID, restricted, reason)
    self._restrictedUnits[unitID] = restricted
    if not restricted then
        self._UILockTexts[unitID] = nil
    elseif restricted and reason then
        --# assume reason: string
        self:add_lock_text(unitID, reason)
    end
end

--return whether a unit is restricted for a character
--v function(self: RECRUITER_CHARACTER, unitID: string) --> boolean
function recruiter_character.is_unit_restricted(self, unitID)
    if self:manager():is_unit_faction_restricted(unitID, self._factionKey) then
        return true
    end
    local unit_restrictions = self._restrictedUnits
    self:log("is unit restricted returning ["..tostring(not not unit_restrictions[unitID]).."] for unit ["..unitID.."]")
    return not not self._restrictedUnits[unitID]
end

--set a unit to be hidden for a character
--v function(self: RECRUITER_CHARACTER, unitID: string, hidden: boolean)
function recruiter_character.set_unit_hiding(self, unitID, hidden)
    self:log("Set the unit hiding on character with cqi ["..tostring(self:command_queue_index()).."] to ["..tostring(hidden).."] for unit ["..unitID.."]")
    self._hiddenUnits[unitID] = hidden
end

--return whether a unit is hidden for a character
--v function(self: RECRUITER_CHARACTER, unitID: string) --> boolean
function recruiter_character.is_unit_hidden(self, unitID)
    return not not self._hiddenUnits[unitID]
end

-------------------------------------
-----MAXIMUM QUANTITY VARIABLES------
-------------------------------------

--v [NO_CHECK] function(self: RECRUITER_CHARACTER, groupID: string) --> number
function recruiter_character.get_quantity_limit_for_group(self, groupID)
    --for now, this just returns a pointer to where the default value is stored in the model for all characters.
    --in the future, this will allow me to insert code here to add or subtract capacity based on the character's subtype, traits, skills or effects.
    --TODO Character cap increases or penalties
    return self:manager():get_base_quantity_limit_for_group(groupID)
end


-------------------------------------
----GROUP RESTRICTION CHECKS---------
-------------------------------------

--v function(self: RECRUITER_CHARACTER, groupID: string, quantity: number)
function recruiter_character.cache_group_counts_on_character(self, groupID, quantity)
    self:log("Character ["..self:cqi_as_str().."] cached the group quantity on ["..groupID.."] as ["..tostring(quantity).."]")
    self._groupCounts[groupID] = quantity
end

--v function(self: RECRUITER_CHARACTER, groupID: string) --> number
function recruiter_character.get_group_counts_on_character(self, groupID)
    if not self._groupCounts[groupID] then
        self._groupCounts[groupID] = 0
        --set a default
    end
    return self._groupCounts[groupID] 
end


--v function(self: RECRUITER_CHARACTER) --> CA_CHAR
function recruiter_character.get_character(self)
    return cm:get_character_by_cqi(self._cqi)
end