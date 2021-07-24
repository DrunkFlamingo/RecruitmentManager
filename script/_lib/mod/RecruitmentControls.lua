--[[
New System Outline
Evaluation:
--characters store what units are locked for them.
--Characters also store information about their armies, queues.
--On evaluation triggers, grabs lists of units from armies, then
    --finds a record for the cost and category of the unit
        --if the record is generic, stored in the model
        --specific records for special rules can be stored on characters.       
    --Sums all group totals
    --applies restrictions for groups exceeding the total
Enforcement
--When enforcement is called, checks the character for a pathset
    --pathsets are applied to characters on creation, specify which recruitment UI the fation uses.
--Enforcement uses pathset to access listview objects for recruitment panels, 
--loops through the listview
--checks the unit keys 
--]]
--# assume debug.getinfo: function(WHATEVER) --> map<string, string>




--Log script to text
--v function(text: WHATEVER)
local function RCLOG(text)
    if not __write_output_to_logfile then
        return;
    end

    local logText = tostring(text)
    local logTimeStamp = os.date("%d, %m %Y %X")
    local popLog = io.open("warhammer_expanded_log.txt","a")
    --# assume logTimeStamp: string
    popLog :write("RM:  [".. logTimeStamp .. "]:  "..logText .. "  \n")
    popLog :flush()
    popLog :close()
end

--Reset the log at session start
--v function()
local function RCSESSIONLOG()
    if not __write_output_to_logfile then
        return;
    end
    local logTimeStamp = os.date("%d, %m %Y %X")
    --# assume logTimeStamp: string

    local popLog = io.open("warhammer_expanded_log.txt","w+")
    popLog :write("NEW LOG ["..logTimeStamp.."] \n")
    popLog :flush()
    popLog :close() 
end
RCSESSIONLOG()



--v [NO_CHECK] function()
function error_check()
    --Vanish's PCaller
    --All credits to vanish
    --v function(func: function) --> any
    function safeCall(func)
        --RCLOG("safeCall start");
        local status, result = pcall(func)
        if not status then
            RCLOG(tostring(result), "ERROR CHECKER")
            RCLOG(debug.traceback(), "ERROR CHECKER");
        end
        --RCLOG("safeCall end");
        return result;
    end
    
    --local oldTriggerEvent = core.trigger_event;
    
    --v [NO_CHECK] function(...: any)
    function pack2(...) return {n=select('#', ...), ...} end
    --v [NO_CHECK] function(t: vector<WHATEVER>) --> vector<WHATEVER>
    function unpack2(t) return unpack(t, 1, t.n) end
    
    --v [NO_CHECK] function(f: function(), argProcessor: function()) --> function()
    function wrapFunction(f, argProcessor)
        return function(...)
            --RCLOG("start wrap ");
            local someArguments = pack2(...);
            if argProcessor then
                safeCall(function() argProcessor(someArguments) end)
            end
            local result = pack2(safeCall(function() return f(unpack2( someArguments )) end));
            --for k, v in pairs(result) do
            --    RCLOG("Result: " .. tostring(k) .. " value: " .. tostring(v));
            --end
            --RCLOG("end wrap ");
            return unpack2(result);
            end
    end
    
    -- function myTriggerEvent(event, ...)
    --     local someArguments = { ... }
    --     safeCall(function() oldTriggerEvent(event, unpack( someArguments )) end);
    -- end
    
    --v [NO_CHECK] function(fileName: string)
    function tryRequire(fileName)
        local loaded_file = loadfile(fileName);
        if not loaded_file then
            RCLOG("Failed to find mod file with name " .. fileName)
        else
            RCLOG("Found mod file with name " .. fileName)
            RCLOG("Load start")
            local local_env = getfenv(1);
            setfenv(loaded_file, local_env);
            loaded_file();
            RCLOG("Load end")
        end
    end
    
    --v [NO_CHECK] function(f: function(), name: string)
    function logFunctionCall(f, name)
        return function(...)
            RCLOG("function called: " .. name);
            return f(...);
        end
    end
    
    --v [NO_CHECK] function(object: any)
    function logAllObjectCalls(object)
        local metatable = getmetatable(object);
        for name,f in pairs(getmetatable(object)) do
            if is_function(f) then
                RCLOG("Found " .. name);
                if name == "Id" or name == "Parent" or name == "Find" or name == "Position" or name == "CurrentState"  or name == "Visible"  or name == "Priority" or "Bounds" then
                    --Skip
                else
                    metatable[name] = logFunctionCall(f, name);
                end
            end
            if name == "__index" and not is_function(f) then
                for indexname,indexf in pairs(f) do
                    RCLOG("Found in index " .. indexname);
                    if is_function(indexf) then
                        f[indexname] = logFunctionCall(indexf, indexname);
                    end
                end
                RCLOG("Index end");
            end
        end
    end
    
    -- logAllObjectCalls(core);
    -- logAllObjectCalls(cm);
    -- logAllObjectCalls(game_interface);
    
    core.trigger_event = wrapFunction(
        core.trigger_event,
        function(ab)
            --RCLOG("trigger_event")
            --for i, v in pairs(ab) do
            --    RCLOG("i: " .. tostring(i) .. " v: " .. tostring(v))
            --end
            --RCLOG("Trigger event: " .. ab[1])
        end
    );
    
    cm.check_callbacks = wrapFunction(
        cm.check_callbacks,
        function(ab)
            --RCLOG("check_callbacks")
            --for i, v in pairs(ab) do
            --    RCLOG("i: " .. tostring(i) .. " v: " .. tostring(v))
            --end
        end
    )
    
    local currentAddListener = core.add_listener;
    --v [NO_CHECK] function(core: any, listenerName: any, eventName: any, conditionFunc: any, listenerFunc: any, persistent: any)
    function myAddListener(core, listenerName, eventName, conditionFunc, listenerFunc, persistent)
        local wrappedCondition = nil;
        if is_function(conditionFunc) then
            --wrappedCondition =  wrapFunction(conditionFunc, function(arg) RCLOG("Callback condition called: " .. listenerName .. ", for event: " .. eventName); end);
            wrappedCondition =  wrapFunction(conditionFunc);
        else
            wrappedCondition = conditionFunc;
        end
        currentAddListener(
            core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc), persistent
            --core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc, function(arg) RCLOG("Callback called: " .. listenerName .. ", for event: " .. eventName); end), persistent
        )
    end
    core.add_listener = myAddListener;
end
if __write_output_to_logfile then
    error_check()
end

--v function(loc: string, ...: string) --> string
local function fill_loc(loc, ...)
    local output = loc
    for i = 1, arg.n do
        local f = i - 1
        local gsub_text = f..f..f..f
        output = string.gsub(output, gsub_text, arg[i])
    end
    return output
end

--v [NO_CHECK] function(txt: string) --> string
local function getnumbersfromtext(txt)
    local str = "" --:string
    string.gsub(txt,"%d+",function(e)
     str = str .. e
    end)
    return str
end



local recruiter_manager = {} 
--# assume recruiter_manager: RECRUITER_MANAGER


--v function(supress_log:boolean?) --> RECRUITER_MANAGER
function recruiter_manager.init(supress_log)
    local self = {}
    setmetatable(self, {
        __index = recruiter_manager,
        __tostring = function() return "RECRUITER_MANAGER" end
    }) --# assume self: RECRUITER_MANAGER

    self.supress_log = supress_log or false
    --Stores path sets: used to find the way to the UI
    self._UIPaths = {} --:map<string, RECRUITER_PATHSET>
    self._subculturePathSets = {} --:map<string, string>
    self._subtypePathSets = {} --:map<string, string>

    --stores unit records.
    --unit records contain weights, groups and UI profiles.
    self._recruiterUnits = {} --:map<string, RECRUITER_UNIT>
    --stores copies of "fake" unit records for use by characters as overrides for information
    self._overrideUnits = {} --:map<string, RECRUITER_UNIT>
    --stores subtypes who get specific overriden unit records added to them at creation
    self._overrideSubtypeFilters = {} --:map<string, vector<string>>
    --stores subcultures who get specific overriden unit records added to them at creation, used for loaned units.
    self._overrideSubcultureFilters = {} --:map<string, vector<string>>
    --stores skills which add a specific overriden unit record to a character
    self._overrideSkillRequirements = {} --:map<string, map<string, string>>
    --same for traits
    self._overrideTraitRequirements = {} --:map<string, map<string, string>>
    --stores descriptive badgets for lord subtypes
    self._subtypeSpecialRules = {} --:map<string, string>


    --stores recruiter characters in some structures that are useful.
    self._recruiterCharacters =  {} --:map<CA_CQI, RECRUITER_CHARACTER>
    self._factionRecCharacters = {} --:map<string, map<CA_CQI, RECRUITER_CHARACTER>>
    --stores the current player character. 
    self._UICurrentCharacter = nil --:CA_CQI

    --stores faction wide restrictions, which prevent recruitment for a whole faction.
    self._factionWideRestrictions = {} --:map<string, map<string, boolean>>
    --stores the acompanying lock texts by faction for units
    self._UIFactionWideLockTexts = {} --:map<string, map<string, string>>

    --individual unit quantity limits
    self._characterUnitLimits = {} --:map<string, number>

    --Group UI names
    self._UIGroupNames = {} --:map<string, string>
    --unit group quantity limits
    self._groupUnitLimits = {} --:map<string, number>
    --grouped units
    self._groupToUnits = {} --:map<string, vector<string>>

    --stores default acceptible units for the AI to use
    self._AIDefaultUnits = {} --:map<string, vector<string>>


    --sets whether the mod is on or not
    self._isEnforcementEnabled = true
    --flags whether to enforce AI functionality
    self._AIEnforce = true --:boolean
    --stores settings for the points limits
    self._specialPointLimit = 10 --:int
    self._rarePointLimit = 5 --:int

    --this is used to find which groups we should be displaying on the meter UI.
    self._subculturePrefixes = {} --:map<string, string>

    --units are appended into these lists then added at the end.
    self._normalUnitsToAdd = {} --:vector<{string, string, number?}>
    self._overriddenUnitSettings = {} --:map<string, {string, string, number?}>
    self._loanedUnitsToAdd = {} --:vector<{string, string|vector<string>, string, number?}>
    self._unitTextOverrides = {} --:map<string, RM_UIPROFILE>
    self._postSetupCallbacks = {} --:vector<function()>


    return self
end

--log text
--v function(self: RECRUITER_MANAGER, text: any, echo: boolean?) 
function recruiter_manager.log(self, text, echo)
    if self.supress_log then
        return
    end
    RCLOG(tostring(text))
    if echo then
        out("RECRUITER_MANAGER: " ..tostring(text))
    end
end

--ui utility to get the names of the units in the queue by reading the UI.
--v function(self: RECRUITER_MANAGER, index: number, prefix: string) --> string
function recruiter_manager.GetQueuedUnit(self, index, prefix)
    local queuedUnit = find_uicomponent(core:get_ui_root(), "main_units_panel", "units", prefix.. tostring(index));
    if not not queuedUnit then
        queuedUnit:SimulateMouseOn();
        local unitInfo = find_uicomponent(core:get_ui_root(), "UnitInfoPopup", "tx_unit-type");
        local rawstring = unitInfo:GetStateText();
        local infostart = string.find(rawstring, "unit/") + 5;
        local infoend = string.find(rawstring, "]]") - 1;
        local QueuedUnitName = string.sub(rawstring, infostart, infoend)
        self:log("Found queued unit ["..QueuedUnitName.."] at ["..index.."] ")
        return QueuedUnitName
    else
        return nil
    end
end

---------------------------------
----FACTION WIDE RESTRICTIONS----
---------------------------------

--v function(self: RECRUITER_MANAGER, unitID: string, faction_name: string) --> boolean
function recruiter_manager.is_unit_faction_restricted(self, unitID, faction_name)
    if self._factionWideRestrictions[unitID] == nil then
        return false
    end
    return not not self._factionWideRestrictions[unitID][faction_name]
end

--v function(self: RECRUITER_MANAGER, unitID: string, faction_name: string, restrict: boolean)
function recruiter_manager.set_unit_restriction_for_faction(self, unitID, faction_name, restrict)
    self._factionWideRestrictions[unitID] = self._factionWideRestrictions[unitID] or {}
    self._factionWideRestrictions[unitID][faction_name] = restrict
    if not restrict then
        if self._UIFactionWideLockTexts[unitID] then
            self._UIFactionWideLockTexts[unitID][faction_name] = nil
        end
    end
end

--v function(self: RECRUITER_MANAGER, unitID: string, faction_name: string, lock_reason: string) 
function recruiter_manager.add_factionwide_lock_text(self, unitID, faction_name, lock_reason)
    self._UIFactionWideLockTexts[unitID] = self._UIFactionWideLockTexts[unitID] or {}
    if self._UIFactionWideLockTexts[unitID][faction_name] then
        self._UIFactionWideLockTexts[unitID][faction_name] = self._UIFactionWideLockTexts[unitID][faction_name] .. "\n" .. lock_reason
    else
        self._UIFactionWideLockTexts[unitID][faction_name] = lock_reason
    end
end


--group ui names--
------------------

--get the map of groups to UI names
--v function(self: RECRUITER_MANAGER) --> map<string, string>
function recruiter_manager.get_group_ui_names(self)
    return self._UIGroupNames
end

--get a specific UI name
--v function(self: RECRUITER_MANAGER, groupID: string) --> string
function recruiter_manager.get_ui_name_for_group(self, groupID)
    if self:get_group_ui_names()[groupID] == nil then
        self._UIGroupNames[groupID] = groupID
    end
    return self:get_group_ui_names()[groupID]
end

--set the UI name for a group
--publically available function
--v function(self: RECRUITER_MANAGER, groupID: string, UIname: string)
function recruiter_manager.set_ui_name_for_group(self, groupID, UIname)
    if not is_string(groupID) then
        self:log("ERROR: set_ui_name_for_group called but the provided group name is not a string!")
        return 
    end
    if not is_string(UIname) then
        self:log("ERROR: set_ui_name_for_group called but the provided unit key is not a string!")
        return 
    end
    self._UIGroupNames[groupID] = UIname
end



------------------------------
------------------------------
----------SUBOBJECTS----------
------------------------------
------------------------------
--TODO immport
cm:load_global_script("recruiter_pathset")
--# assume recruiter_pathset.new_path: function(paths: map<string, vector<string>>, merc_path: vector<string>, conditional_tests: (function(rec_char: RECRUITER_CHARACTER) --> vector<string>)?) --> RECRUITER_PATHSET
--------------------------
----SUBOBJECT HANDLERS----
--------------------------


--v function(self: RECRUITER_MANAGER,pathID: string, paths: map<string, vector<string>>, merc_path: vector<string>, conditional_tests: (function(rec_char: RECRUITER_CHARACTER) --> vector<string>)?) 
function recruiter_manager.create_path_set(self, pathID, paths, merc_path, conditional_tests)
    local new_path = recruiter_pathset.new_path(paths, merc_path, conditional_tests)
    self._UIPaths[pathID] = new_path
end

--v function(self: RECRUITER_MANAGER, pathID: string) --> RECRUITER_PATHSET
function recruiter_manager.get_path_set(self, pathID)
    return self._UIPaths[pathID]
end

-----------------------
----RECRUITER UNITS----
-----------------------
--TODO import
cm:load_global_script("recruiter_unit")
--# assume recruiter_unit.create_record: function( manager: RECRUITER_MANAGER, main_unit_key: string, base_unit: RECRUITER_UNIT?) --> RECRUITER_UNIT


--------------------------
----SUBOBJECT HANDLERS----
--------------------------


--v function(self: RECRUITER_MANAGER) --> map<string, RECRUITER_UNIT>
function recruiter_manager.units(self)
    return self._recruiterUnits
end


--v function(self: RECRUITER_MANAGER, unitID: string) --> RECRUITER_UNIT
function recruiter_manager.new_unit(self, unitID)
    if not is_string(unitID) then
        self:log("Asked new unit to return a non string key: ["..tostring(unitID).."] ")
        return nil
    end
    local new_unit = recruiter_unit.create_record(self, unitID)
    self._recruiterUnits[unitID] = new_unit
    return new_unit
end


--v function(self: RECRUITER_MANAGER, unitID: string) --> RECRUITER_UNIT
function recruiter_manager.get_unit(self, unitID)
    if self._recruiterUnits[unitID] then
        return self._recruiterUnits[unitID]
    else
        return self:new_unit(unitID)
    end
end

---------------------------
----RECRUITER CHARACTER----
---------------------------
--TODO import
cm:load_global_script("recruiter_character")
--# assume recruiter_character.new: function(manager: RECRUITER_MANAGER, cqi: CA_CQI) --> RECRUITER_CHARACTER



--------------------------
----SUBOBJECT HANDLERS----
--------------------------

--get all characters in the rm
--v function(self: RECRUITER_MANAGER) --> map<CA_CQI, RECRUITER_CHARACTER>
function recruiter_manager.characters(self)
    return self._recruiterCharacters
end

--create and return a new character in the rm
--v function(self: RECRUITER_MANAGER, cqi: CA_CQI) --> RECRUITER_CHARACTER
function recruiter_manager.new_character(self, cqi)
    local new_char = recruiter_character.new(self, cqi)
    local ca_char = cm:get_character_by_cqi(cqi)
    local faction = ca_char:faction():name()
    self._factionRecCharacters[faction] = self._factionRecCharacters[faction] or {}
    self._factionRecCharacters[faction][cqi] = new_char
    self._recruiterCharacters[cqi] = new_char
    self:log("Created character ["..tostring(cqi).."], firing UIEvent!")
    core:trigger_event("UIRecruiterCharacterCreated", ca_char)
    return new_char
end

--return whether a character exists in the rm
--v function(self: RECRUITER_MANAGER, cqi: CA_CQI) --> boolean
function recruiter_manager.has_character(self, cqi)
    return not not self._recruiterCharacters[cqi]
end

--get a character by cqi from the rm
--v function(self: RECRUITER_MANAGER, cqi: CA_CQI) --> RECRUITER_CHARACTER
function recruiter_manager.get_character_by_cqi(self, cqi)
    if cqi == nil then
        self:log("Warning, asked for a char with cqi [nil]")
        return nil
    end
    if self:has_character(cqi) then
        --if we already have that character, return it.
        return self._recruiterCharacters[cqi]
    else
        --otherwise, return a new character
        self:log("Requested character with ["..tostring(cqi).."] who does not exist, creating them!")
        return self:new_character(cqi)
    end
end

--return whether the current character has ever been set
--v function(self: RECRUITER_MANAGER) --> boolean
function recruiter_manager.has_currently_selected_character(self)
    return not not self._UICurrentCharacter
end



--return the current character's object
--v function(self: RECRUITER_MANAGER) --> RECRUITER_CHARACTER
function recruiter_manager.current_character(self)
    return self:get_character_by_cqi(self._UICurrentCharacter)
end

--set the current character by CQI
--v function(self: RECRUITER_MANAGER, cqi:CA_CQI) --> (RECRUITER_CHARACTER, boolean)
function recruiter_manager.set_current_character(self, cqi)
    self:log("Set the current character to cqi ["..tostring(cqi).."]")
    self._UICurrentCharacter = cqi
    if not self:has_character(cqi) then
        return self:new_character(cqi), true
    else 
        return self:get_character_by_cqi(cqi), false
    end
end





--------------------------------------------------
-----------LOGGING OUTPUT FOR SUBOJBECTS----------
--------------------------------------------------
--v function(self: RECRUITER_MANAGER, rec_char: RECRUITER_CHARACTER) 
function recruiter_manager.output_state(self, rec_char)
    if not __write_output_to_logfile then
        return
    end
    local char = rec_char:get_character()
    local dumpstring = "Information dump available: \n\tCharacter Subtype: "..char:character_subtype_key().."\n\tFaction: "..char:faction():name().."\n\tArmy:\n\t\t"

    for unitID, quantity in pairs(rec_char._armyCounts) do
        dumpstring = dumpstring .. unitID .. ": "..tostring(quantity) .. "\n\t\t"
    end
    dumpstring = string.sub(dumpstring, 1, dumpstring:len() - 1) .. "Queue:\n\t\t"
    for unitID, quantity in pairs(rec_char._queueCounts) do
        dumpstring = dumpstring .. unitID .. ": "..tostring(quantity) .. "\n\t\t"
    end
    dumpstring = string.sub(dumpstring, 1, dumpstring:len() - 1) .. "Mercs:\n\t\t"
    for i, rec_unit in ipairs(rec_char._mercenaryQueue) do
        dumpstring = dumpstring .. rec_unit:key() .. "@ "..tostring(i) .. "\n\t\t"
    end
    dumpstring = string.sub(dumpstring, 1, dumpstring:len() - 1) .. "Limits:\n\t\t"
    for groupID, quantity in pairs(rec_char._groupCounts) do
        dumpstring = dumpstring .. groupID .. ": "..tostring(quantity) .. " Owned; "..rec_char:get_quantity_limit_for_group(groupID).." Allowed \n\t\t"
    end
    dumpstring = string.sub(dumpstring, 1, dumpstring:len() - 1) .. "Special Rules:\n\t\t"
    for unitID, rec_unit in pairs(rec_char._ownedUnits) do
        dumpstring = dumpstring .. "Unique version of " .. unitID .. ": \n\t\t\t Weight: "..tostring(rec_unit:weight()) .. "\n\t\t\t Groups: "
        for groupID, _ in pairs(rec_unit:groups()) do
            dumpstring = dumpstring .. groupID .. ","
        end
        dumpstring = dumpstring .. "\n\t\t"
    end
    dumpstring = string.sub(dumpstring, 1, dumpstring:len() - 1) .. "Restriction Table:\n\t\t\t"
    for unitID, restricted in pairs(rec_char._restrictedUnits) do
        dumpstring = dumpstring .. unitID .. ": ["..tostring(restricted) .. "] \n\t\t\t"
    end
    self:log(dumpstring)
end


------------------------------------------------------------
-------------------END OF SUBOBJECT STUFF-------------------
------------------------------------------------------------

----UNIT WEIGHTING SYSTEM----
-----------------------------
--get the weight of a specific unit
--v function(self: RECRUITER_MANAGER, unitID: string, rec_char: RECRUITER_CHARACTER?) --> number
function recruiter_manager.get_weight_for_unit(self, unitID, rec_char)
    if rec_char then
        --# assume rec_char: RECRUITER_CHARACTER
       return rec_char:get_unit(unitID):weight()
    else
        return self:get_unit(unitID):weight()
    end
end

--set the weight for a unit within their groups.
--publically available function
--v function(self: RECRUITER_MANAGER, unitID: string, weight: number)
function recruiter_manager.set_weight_for_unit(self, unitID, weight)
    if not is_string(unitID) then
        self:log("set_weight_for_unit called with bad arg #1, unitID must be a string")
        return
    elseif not is_number(weight) then
        self:log("set_weight_for_unit called with bad arg #2, weight must be a number")
        return
    end

    self:get_unit(unitID):set_unit_weight(weight)
end

--v function(self: RECRUITER_MANAGER, abstractionID: string, weight: number)
function recruiter_manager.set_weight_for_overridden_unit(self, abstractionID, weight)
    if not is_string(abstractionID) then
        self:log("set_weight_for_overridden_unit called with bad arg #1, abstractionID must be a string")
        return
    elseif not self._overrideUnits[abstractionID] then
        self:log("set_weight_for_overridden_unit called with bad arg #1, abstractionID does not refer to any existing override abstraction")
        return
    elseif not is_number(weight) then
        self:log("set_weight_for_overriden_unit called with bad arg #2, weight must be a number")
        return
    end
    self._overrideUnits[abstractionID]:set_unit_weight(weight)

end

-----------------------------
----UNIT OVERRIDE OBJECTS----
-----------------------------

--v function(self: RECRUITER_MANAGER, unitID: string, abstractionID: string, new_group: string?, new_weight: number?) --> RECRUITER_UNIT
function recruiter_manager.create_unit_override(self, unitID, abstractionID, new_group, new_weight)
    local new_unit = recruiter_unit.create_record(self, unitID, self:get_unit(unitID))
    self._overrideUnits[abstractionID] = new_unit
    if is_string(new_group) and is_number(new_weight) then
        --# assume new_group: string
        --# assume new_weight: number
        new_unit:add_group_to_unit(new_group)
        new_unit:set_unit_weight(new_weight)
    end
    return new_unit
end

-----------------------
----UNIT GROUPS API----
-----------------------


--add a unit to a group
--v function(self: RECRUITER_MANAGER, unitID: string, groupID: string)
function recruiter_manager.add_unit_to_group(self, unitID, groupID)
    local unit = self:get_unit(unitID)
    unit:add_group_to_unit(groupID)
end

--get the list of units for a specific group
--v function(self: RECRUITER_MANAGER, groupID: string) --> vector<string>
function recruiter_manager.get_units_in_group(self, groupID)
    if self._groupToUnits[groupID] == nil then
        --if the group hasn't been used at all, give it a default blank list.
        self._groupToUnits[groupID] = {}
    end
    return self._groupToUnits[groupID]
end

----COMPARATOR HELPER----
--v function(unit: RECRUITER_UNIT, process_record: map<string, boolean>) --> boolean
local function has_unchecked_group(unit, process_record)
    for gid, _ in pairs(unit:groups()) do
        if not process_record[gid] then
            return true --if they have a group which is not processed.
        end
    end
    return false --if they don't.
end




-----------------------
------ENFORCEMENT------
-----------------------

--v function(self: RECRUITER_MANAGER, unitID: string, unitCard: CA_UIC, rec_char: RECRUITER_CHARACTER)
function recruiter_manager.enforce_caps_on_unit_uic(self, unitID, unitCard, rec_char)
    local loc_points = effect.get_localised_string("ttc_measurement_name")
    local loc_restriction = effect.get_localised_string("ttc_restriction_tooltip")

    local rec_unit = rec_char:get_unit(unitID)
    local is_restricted, restricted_groups = rec_char:is_unit_restricted(rec_unit)
    local restriction_text = ""

    if is_restricted then
        for k = 1, #restricted_groups do
            local groupID = restricted_groups[k].group
            local limit = restricted_groups[k].limit
            local quantity = restricted_groups[k].quantity
            restriction_text = restriction_text.. fill_loc(loc_restriction, tostring(rec_unit:weight()), self:get_ui_name_for_group(groupID), loc_points, tostring(limit - quantity), loc_points)
        end
    end
    self:log("Enforcing restrictions for Unit["..unitID.."] Restriction["..tostring(is_restricted).."] Character["..tostring(self._UICurrentCharacter).."] on player UI!")
    --if the unit is restricted, then

    if is_restricted and not unitCard:GetTooltipText():find("col:red") then
        self:log("Locking Unit ["..unitID.."]")
        unitCard:SetInteractive(false)
        local lockedOverlay = find_uicomponent(unitCard, "disabled_script");
        if not not lockedOverlay then
            lockedOverlay:SetVisible(true)
            lockedOverlay:SetImagePath("ui/custom/recruitment_controls/locked_unit.png")
            lockedOverlay:SetTooltipText(restriction_text, true)
            lockedOverlay:SetCanResizeHeight(true)
            lockedOverlay:SetCanResizeWidth(true)
            lockedOverlay:Resize(72, 89)
            lockedOverlay:SetCanResizeHeight(false)
            lockedOverlay:SetCanResizeWidth(false)
        end
    else
    --otherwise, set the card clickable
        self:log("Unlocking! Unit ["..unitID.."]")
        unitCard:SetInteractive(true)
        local lockedOverlay = find_uicomponent(unitCard, "disabled_script");
        if not not lockedOverlay then
            if rec_unit._UIPip then
                lockedOverlay:SetVisible(true)
                lockedOverlay:SetTooltipText(rec_unit._UIText, true)
                lockedOverlay:SetImagePath(rec_unit._UIPip)
                lockedOverlay:SetCanResizeHeight(true)
                lockedOverlay:SetCanResizeWidth(true)
                lockedOverlay:Resize(30, 30)
                lockedOverlay:SetCanResizeHeight(false)
                lockedOverlay:SetCanResizeWidth(false)
            else
                lockedOverlay:SetVisible(false)
            end
        end
    end
end

--applies the restrictions stored in the currently selected rec character to the UI directly.
--v function(self: RECRUITER_MANAGER, rec_unit: RECRUITER_UNIT)
function recruiter_manager.enforce_ui_restriction_on_unit(self, rec_unit)
    if not self._isEnforcementEnabled then
        self:log("Enforcement is disabled, aborting")
        cm:steal_user_input(false);
        return
    end
    local rec_char = self:get_character_by_cqi(self._UICurrentCharacter)
    local pathset = rec_char._UIPathSet
    if pathset == nil then
        self:log("PATHSET ERROR DURING ENFORCEMENT: \n\t\t NO VALID PATHSETS FOUND FOR THIS CHARACTER: ")
        local char = cm:get_character_by_cqi(rec_char:command_queue_index())
        cm:steal_user_input(false);
        self:log("ABORTING")
        return
    end
    local unitID = rec_unit._key
    
    --check if merc is open
    local path_to_mercs = pathset:mercenary_path()
    local mercenaryRecruitmentList = find_uicomponent_from_table(core:get_ui_root(), path_to_mercs);
    --if we got the panel, proceed
    if is_uicomponent(mercenaryRecruitmentList) and mercenaryRecruitmentList:Visible() then
        self:log("Checking mercenary list!")
        --attach the UI suffix onto the unit name to get the name of the recruit button.
        local unit_component_ID = unitID.."_mercenary"
        --find the unit card using that name
        local unitCard = find_uicomponent(mercenaryRecruitmentList, unit_component_ID)
        --if we got the unit card, proceed
        if is_uicomponent(unitCard) then
            self:enforce_caps_on_unit_uic(unitID, unitCard, rec_char)
        else 
            --do nothing
        end
    end
    --check the rest
    local paths_to_check = pathset:get_path_list(rec_char)
    for i = 1, #paths_to_check do
        local localUnitList = find_uicomponent_from_table(core:get_ui_root(), pathset:get_path(paths_to_check[i]));
        --self:log("Checking ["..paths_to_check[i].."] list!")
        --if we got the panel, proceed
        if is_uicomponent(localUnitList) then
            --attach the UI suffix onto the unit name to get the name of the recruit button.
            local unit_component_ID = unitID.."_recruitable"
            --find the unit card using that name
            local unitCard = find_uicomponent(localUnitList, unit_component_ID)
            --if we got the unit card, proceed
            if is_uicomponent(unitCard) then
                --first, check if the unit is supposed to be visible.
                self:enforce_caps_on_unit_uic(unitID, unitCard, rec_char)
            else 
                --do nothing
            end
        end
    end
    cm:steal_user_input(false);
end


--v function(self: RECRUITER_MANAGER)
function recruiter_manager.enforce_all_units_on_current_character(self)
    if not self._UICurrentCharacter then
        self:log("ENFORCEMENT BREAK: NO CHARACTER IS SELECTED!")
        cm:steal_user_input(false);
        return
    end
    local rec_char = self:get_character_by_cqi(self._UICurrentCharacter)
    local char_army = rec_char._armyCounts
    local char_queue = rec_char._queueCounts
    for unit_key, restricted in pairs(char_army) do
        self:enforce_ui_restriction_on_unit(rec_char:get_unit(unit_key))
    end
    for unit_key, restricted in pairs(char_queue) do
        self:enforce_ui_restriction_on_unit(rec_char:get_unit(unit_key))  
    end
end

--v function(self: RECRUITER_MANAGER, ui_table: map<string, boolean>, rec_char: RECRUITER_CHARACTER)
function recruiter_manager.enforce_units_by_table(self, ui_table, rec_char)
    for unit_key, _ in pairs(ui_table) do
        self:enforce_ui_restriction_on_unit(rec_char:get_unit(unit_key))
    end
end

--v function(self: RECRUITER_MANAGER, unitID: string, rec_char: RECRUITER_CHARACTER)
function recruiter_manager.enforce_unit_and_grouped_units(self, unitID, rec_char)
    local unit = rec_char:get_unit(unitID)
    self:enforce_ui_restriction_on_unit(unit)
    for groupID, _ in pairs(unit:groups()) do
        local grouped_units = self:get_units_in_group(groupID)
        for i = 1, #grouped_units do 
            if (grouped_units[i] ~= unitID) then
            local grouped_unit = rec_char:get_unit(grouped_units[i])
            self:enforce_ui_restriction_on_unit(grouped_unit)
            end
        end
    end
end

---------------------
----Unit Upgrades----
---------------------

--handlers for unit upgrade mechanics added by mods.
--units trigger UnitDisbanded when destroyed through the UI. 
--the grant_unit command is wrapped to pick up units added from script.
--v function(self: RECRUITER_MANAGER, character_cqi: CA_CQI, unitID: string, upgradedUnitID: string) --> boolean
function recruiter_manager.can_upgrade_unit_to_unit(self, character_cqi, unitID, upgradedUnitID)
    --self:log("Evaluating whether ["..tostring(character_cqi).."] can upgrade ["..unitID.."] into ["..upgradedUnitID.."]")
    --the mods which use this function tend to call it... often. Logs are commented out.
    local exceeds_cap = false --:boolean
    local rec_char = self:get_character_by_cqi(character_cqi)
    local rec_unit = rec_char:get_unit(unitID)
    local rec_unit_upgrade = rec_char:get_unit(upgradedUnitID)
    local upgrade_weight = rec_unit_upgrade:weight()
    for groupID, _ in pairs(rec_unit_upgrade:groups()) do
        local current_count = rec_char:get_group_counts_on_character(groupID)
        local limit = rec_char:get_quantity_limit_for_group(groupID)
        if rec_unit:has_group(groupID) then
            current_count = current_count - rec_unit:weight()
        end
        exceeds_cap = exceeds_cap or ((current_count + upgrade_weight) > limit)
        --self:log("Upgraded unit has group ["..groupID.."] with weight ["..upgrade_weight.."], count was ["..current_count.."] after removing current unit, limit is ["..limit.."]")
    end
    --self:log("Upgrade is valid: "..tostring(not exceeds_cap))
    return not exceeds_cap
end



----------------------------
----QUANTITY LIMITS API-----
----------------------------

--get the limit of a specific unit
--v function(self: RECRUITER_MANAGER, unitID: string) --> number
function recruiter_manager.get_quantity_limit_for_unit(self, unitID)
    if self._characterUnitLimits[unitID] == nil then
        return 999 --avoid clogging memoryu
    end
    return self._characterUnitLimits[unitID]
end



--adds a quantity check function to the stack of a single unit.
--v function(self: RECRUITER_MANAGER, unitID: string, quantity_limit: number)
function recruiter_manager.add_single_unit_quantity_limit(self, unitID, quantity_limit)
    --TODO implement single unit quantity restrictions if needed.
end


--get the quantity limit of a specific group
--v function(self: RECRUITER_MANAGER, groupID: string) -->number
function recruiter_manager.get_base_quantity_limit_for_group(self,groupID)
    if self._groupUnitLimits[groupID] == nil then
        return 999
    end
    return self._groupUnitLimits[groupID]
end

--add a quantity limit to the group. Must be called after all units are in the group already
--publically available function
--v function(self: RECRUITER_MANAGER, groupID: string, quantity_limit: number)
function recruiter_manager.add_character_quantity_limit_for_group(self, groupID, quantity_limit)
    --check for errors in API functions
    if not is_string(groupID) then
        self:log("add_character_quantity_limit_for_group called with bad arg #1, provided groupID is not a string!")
        return
    end
    if not is_number(quantity_limit) then
        self:log("add_character_quantity_limit_for_group called with bad arg #2, provided ququantity_limitantity is not a number!")
        return
    end
    --set the quantity limit
    self._groupUnitLimits[groupID] = quantity_limit
end

------------------------
----UI UNIT PROFILES----
------------------------

--set the UI profile for a unit.

--v function(self: RECRUITER_MANAGER, unitID: string, UIprofile: RM_UIPROFILE)
function recruiter_manager.set_ui_profile_for_unit(self, unitID, UIprofile)
    if not (is_string(UIprofile._image) and is_string(UIprofile._text)) then
        self:log("ERROR: set_ui_profile_for_unit called but the supplied profile table isn't properly formatted. /n It needs to have a _text and _image field which are both strings!")
        return
    end
    if (not is_string(unitID)) or (not self._recruiterUnits[unitID]) then
        self:log("ERROR set_ui_profile_for_unit called but supplied unit has no base entry, or isn't a string!")
        return
    end
    self:get_unit(unitID):add_ui_profile(UIprofile._text, UIprofile._image)
end

--sets the UI profile for an override unit
--v function(self: RECRUITER_MANAGER, abstractionID: string, text: string, image_path: string)
function recruiter_manager.set_ui_profile_for_unit_override(self, abstractionID, text, image_path)
    if not self._overrideUnits[abstractionID] then
        self:log("Tried to call set_ui_profile_for_unit_override for abtractionID ["..abstractionID.."] which isn't a valid unit override!")
    end
    self._overrideUnits[abstractionID]:add_ui_profile(text, image_path)

end

--------------------------
------NEW SUBCULTURES-----
--------------------------
--v function(self: RECRUITER_MANAGER, subculture: string, prefix: string)
function recruiter_manager.set_group_prefix_for_subculture(self, subculture, prefix)
    self._subculturePrefixes[subculture] = prefix
end

--------------------------
----PATH SET FILTERING----
--------------------------

--v function(self: RECRUITER_MANAGER, subtype_key: string, pathID: string)
function recruiter_manager.add_subtype_path_filter(self, subtype_key, pathID)
    self._subtypePathSets[subtype_key] = pathID
    if not self._UIPaths[pathID] then
        self:log("Added a subtype path set to ["..subtype_key.."] which doesn't exist ["..pathID.."]")
        self:log("Hopefully for you this a load order problem, because the script don't abort here.")
    else
        self:log("Added a subtype path set ["..pathID.."] to ["..subtype_key.."]")
    end
end

--v function(self: RECRUITER_MANAGER, subculture_key: string, pathID: string)
function recruiter_manager.add_subculture_path_filter(self, subculture_key, pathID)
    self._subculturePathSets[subculture_key] = pathID
    if not self._UIPaths[pathID] then
        self:log("Added a subculture default path set to ["..subculture_key.."] which doesn't exist ["..pathID.."]")
        self:log("Hopefully for you this a load order problem, because the script don't abort here.")
    else
        self:log("Added a subculture path set ["..pathID.."] to ["..subculture_key.."]")
    end
end

--v function(self: RECRUITER_MANAGER, character: CA_CHAR) --> RECRUITER_PATHSET
function recruiter_manager.evaluate_path_set_for_character(self, character)
    --first, check their subtype. This takes precedence over subcultural default
    if self._subtypePathSets[character:character_subtype_key()] then
        return self:get_path_set(self._subtypePathSets[character:character_subtype_key()])
    elseif self._subculturePathSets[character:faction():subculture()] then
        return self:get_path_set(self._subculturePathSets[character:faction():subculture()])
    end
    self:log("Found no valid path sets to match the character ["..tostring(character:command_queue_index()).."] returning a default path")
    return self:get_path_set("NormalFaction")
end

--------------------------
-------LOANED UNITS-------
--------------------------
--v function(self: RECRUITER_MANAGER, loaned_units_table: vector<{string, string|vector<string>, string, number?}>)
function recruiter_manager.add_loaned_units_in_table(self, loaned_units_table)
    for i = 1, #loaned_units_table do
        table.insert(self._loanedUnitsToAdd, loaned_units_table[i])
    end
    self:log("Queued "..tostring(#loaned_units_table).." units to be loaned.")
end

--------------------------
-----MASS GROUPING API----
--------------------------

--v function(self: RECRUITER_MANAGER, groups_table: vector<{string, string, number?}>, unit_text_overrides: map<string, RM_UIPROFILE>?) --> table
function recruiter_manager.add_units_in_table_to_tabletop_groups(self, groups_table, unit_text_overrides)
    for i = 1, #groups_table do
        table.insert(self._normalUnitsToAdd, groups_table[i])
    end
    if unit_text_overrides then
        --# assume unit_text_overrides : map<string, RM_UIPROFILE>
        for key, override in pairs(unit_text_overrides) do
            if self._unitTextOverrides[key] then
                self:log("CONTENT WARNING: "..key.." has more than one overriden text entry being added!")
            end
            self._unitTextOverrides[key] = override
        end
    end
    local calling_file = debug.getinfo(2).source
    self:log("Queued "..tostring(#groups_table).." units to be added from file "..calling_file)
    return {} --this returns a table to avoid breaking scripts when people are using the outdated API format. It doesn't do anything.
end

--v function(self: RECRUITER_MANAGER, groups_table: vector<{string, string, number?}>)
function recruiter_manager.override_default_settings_for_vanilla_units(self, groups_table)
    for i = 1, #groups_table do
        local unit = groups_table[i][1]
        if self._overriddenUnitSettings[unit] then
            self:log("CONTENT WARNING: "..unit.." has more than one overwrite of vanilla settings. More than one mod is trying to change them, so we're only accepting the first one we recieve")
        else
            self._overriddenUnitSettings[unit] = groups_table[i]
        end
    end
    local calling_file = debug.getinfo(2).source
    self:log("overwrote the default settings for "..tostring(#groups_table).." units. From "..calling_file)
end

--------------------------
----AI CAP REPLICATION----
--------------------------

--add a list of core units to use as the replacements for a subculture
--v function(self: RECRUITER_MANAGER, subculture: string, units: vector<string>, default: boolean?)
function recruiter_manager.add_ai_units_for_subculture_with_table(self, subculture, units, default)
    if self._AIDefaultUnits[subculture] == nil then
        self._AIDefaultUnits[subculture] = {}
    else
        if default then
            return 
        end
    end
    for i = 1, #units do
        table.insert(self._AIDefaultUnits[subculture], units[i])
    end
end

--v function(self: RECRUITER_MANAGER) --> boolean
function recruiter_manager.should_enforce_ai_restrictions(self)
    return self._AIEnforce
end

--v function(self: RECRUITER_MANAGER, enforce: boolean)
function recruiter_manager.enforce_ai_restrictions(self, enforce)
    self._AIEnforce = enforce
end

--ai function--
--v function(self: RECRUITER_MANAGER) --> map<string, vector<string>>
function recruiter_manager.ai_subculture_defaults(self)
    return self._AIDefaultUnits
end

---------------------------------------------
----SUBTYPE AND CHARACTER BASED OVERRIDES----
---------------------------------------------

--v function(self: RECRUITER_MANAGER, subtype_key: string, abstractionID: string)
function recruiter_manager.add_subtype_filter_for_unit_override(self, subtype_key, abstractionID)
    if not is_string(abstractionID) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #2, abstractionID must be a string!")
        return
    elseif not self._overrideUnits[abstractionID] then
        self:log("add_subtype_filter_for_unit_override called with bad arg #2, abstractionID must refer to a created unit override record!")
        return
    elseif not is_string(subtype_key) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #1, subtype key must be a string!")
        return
    end
    self._overrideSubtypeFilters[subtype_key] = self._overrideSubtypeFilters[subtype_key] or {}
    table.insert(self._overrideSubtypeFilters[subtype_key], abstractionID) 
end

--v function(self: RECRUITER_MANAGER, subtype_key: string, skill_key: string, abstractionID: string)
function recruiter_manager.add_skill_requirement_for_unit_override(self, subtype_key, skill_key, abstractionID)
    if not is_string(abstractionID) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #3, abstractionID must be a string!")
        return
    elseif not self._overrideUnits[abstractionID] then
        self:log("add_subtype_filter_for_unit_override called with bad arg #3, abstractionID must refer to a created unit override record!")
        return
    elseif not is_string(subtype_key) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #1, subtype key must be a string!")
        return
    elseif not is_string(skill_key) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #2, skill key must be a string!")
        return
    end
    self._overrideSkillRequirements[subtype_key] = self._overrideSkillRequirements[subtype_key]  or {}
    self._overrideSkillRequirements[subtype_key][skill_key] = abstractionID
end


--v function(self: RECRUITER_MANAGER, subtype_key: string, trait_key: string, abstractionID: string)
function recruiter_manager.add_trait_requirement_for_unit_override(self, subtype_key, trait_key, abstractionID)
    if not is_string(abstractionID) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #3, abstractionID must be a string!")
        return
    elseif not self._overrideUnits[abstractionID] then
        self:log("add_subtype_filter_for_unit_override called with bad arg #3, abstractionID must refer to a created unit override record!")
        return
    elseif not is_string(subtype_key) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #1, subtype key must be a string!")
        return
    elseif not is_string(trait_key) then
        self:log("add_subtype_filter_for_unit_override called with bad arg #2, trait key must be a string!")
        return
    end
    self._overrideTraitRequirements[subtype_key] = self._overrideTraitRequirements[subtype_key]  or {}
    self._overrideTraitRequirements[subtype_key][abstractionID] = trait_key
end


--v function(self: RECRUITER_MANAGER, callback: function())
function recruiter_manager.add_post_setup_callback(self, callback)
    table.insert(self._postSetupCallbacks, callback)
end


---DEPRECATED API-----
----------------------

--these still function normally, they just warn the modder
--v [NO_CHECK] function(self: RECRUITER_MANAGER, subtype: string) 
function recruiter_manager.register_subtype_as_char_bound_horde(self, subtype)
    self:log("register_subtype_as_char_bound_horde called from an API script!")
    self:log("WARNING: This API method is incomplete: It doesn't really capture all cases and more setup is sometimes involved getting custom char bound hordes to work!")
    self:log("\t ask DrunkFlamingo for help if you need it, but you should check the source code of the 'core' export helpers and try to match the situation your CBH fits best.")
    self:add_subtype_path_filter(subtype, "CharBoundHordeWithGlobal")
end

--these don't do anything, they just warn the modder
--v [NO_CHECK] function(self: RECRUITER_MANAGER, ...:any) 
function recruiter_manager.add_subtype_group_override(self, ...)
    self:log("OUTDATED API METHOD add_subtype_group_override")
end

--these don't do anything, they just warn the modder
--v [NO_CHECK] function(self: RECRUITER_MANAGER, ...:any) 
function recruiter_manager.whitelist_unit_for_subculture(self, ...)
    self:log("OUTDATED API METHOD whitelist_unit_for_subculture")
end



--v [NO_CHECK] function(rm: RECRUITER_MANAGER)
local function init_mct(rm)
    local mct = core:get_static_object("mod_configuration_tool")
    if mct then
        core:add_listener(
            "obr_MctInitialized",
            "MctInitialized",
            true,
            function(context)
                local ttc_mod = mct:get_mod_by_key("ttc")
                local enable_rm = ttc_mod:get_option_by_key("a_enable")
                enable_rm:set_read_only(true)
                if enable_rm:get_finalized_setting() == true then
                    local special_points = ttc_mod:get_option_by_key("b_special_points")
                    rm._specialPointLimit = special_points:get_finalized_setting()
                    special_points:set_read_only(true)
                    local rare_points = ttc_mod:get_option_by_key("b_rare_points")
                    rm._rarePointLimit = rare_points:get_finalized_setting()
                    rare_points:set_read_only(true)
                    local enforce_for_ai = ttc_mod:get_option_by_key("c_ai")
                    rm:enforce_ai_restrictions(enforce_for_ai:get_finalized_setting())
                    enforce_for_ai:set_read_only(true)
                else
                    rm._isEnforcementEnabled = false
                end
            end,
            true)
    end
end

--v [NO_CHECK] function(wrapper: WHATEVER, rm_instance: RECRUITER_MANAGER)
local function wrap_to_ignore_eh_files(wrapper, rm_instance)
    setmetatable(wrapper, {
        __index = function(t, k)
            if type(rm_instance[k]) == "function" then
                local source = debug.getinfo(2).source
                if string.find(debug.getinfo(2).source, "export_helper") then
                    rm_instance:log("Rejected a call from "..source)
                    rm_instance:log("Export helpers are not supported!")
                    local dummy_rm_copy = recruiter_manager.init(true)
                    return dummy_rm_copy[k]
                else
                    return rm_instance[k]
                end
            else
                return rm_instance[k]
            end
        end
    })
    _G.rm = wrapper
end

--institation 
if __game_mode == __lib_type_campaign then
    local rm = recruiter_manager.init()
    _G.rm = rm
    core:add_static_object("recruitment_manager", rm)
    local wrapper = {}
    --wrap_to_ignore_eh_files(wrapper, rm)
    init_mct(rm)

    rm:log("Adding Listeners and First Tick Callbacks", true)
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

    --implementation for subtype and subculture filters on creation
    core:add_listener(
        "UIRecruiterCharacterCreatedUIPathAssignment",
        "UIRecruiterCharacterCreated",
        function(context)
            return true
        end,
        function(context)
            local char = context:character() --:CA_CHAR
            local subculture = char:faction():subculture()
            if rm._overrideSubcultureFilters[subculture] then
                rm:log("New character has unit overrides from subculture: ")
                for i = 1, #rm._overrideSubcultureFilters[subculture] do
                    local abstractionID = rm._overrideSubcultureFilters[subculture][i]
                    local abstraction = rm._overrideUnits[abstractionID]
                    if abstraction then
                        rm:log("Added unit override "..abstractionID)
                        rm:get_character_by_cqi(char:command_queue_index()):add_overriden_unit_entry(abstraction:key(), abstraction)
                    else
                        rm:log("Error: Failed to add unit override. Could not find any object for "..abstractionID)
                    end
                end
            end
            local subtype = char:character_subtype_key()
            if rm._overrideSubtypeFilters[subtype] then
                rm:log("New character has unit overrides from subtype: ")
                for i = 1, #rm._overrideSubtypeFilters[subtype] do
                    local abstractionID = rm._overrideSubtypeFilters[subtype][i]
                    local abstraction = rm._overrideUnits[abstractionID]
                    if abstraction then
                        rm:log("Added unit override "..abstractionID)
                        rm:get_character_by_cqi(char:command_queue_index()):add_overriden_unit_entry(abstraction:key(), abstraction)
                    else
                        rm:log("Error: Failed to add unit override. Could not find any object for "..abstractionID)
                    end
                end
            end
        end,
        true)

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


    

    --v function(cm: CM, char_string: string, unit_key: string) 
    function new_grant_unit(cm, char_string, unit_key)
        local ok, err = pcall(function()
            if not is_string(char_string) then
                script_error("ERROR: grant_unit_to_character() called but supplied value char_string [" .. tostring(char_string) .. "] is not a string")
                return 
            end
            if not is_string(unit_key) then
                script_error("ERROR: grant_unit_to_character() called but supplied value unit_key [" .. tostring(unit_key) .. "] is not a string")
                return 
            end
            cm.game_interface:grant_unit_to_character(char_string, unit_key)    
            if string.find(char_string, "cqi:") then
                local cqi = tonumber(getnumbersfromtext(char_string)) --# assume cqi: CA_CQI
                local character = cm:get_character_by_cqi(cqi)
                if not character:is_null_interface() and character:faction():is_human() then
                    rm:log("GRANT UNIT COMMAND: ".. char_string.." resolved to cqi "..tostring(cqi))
                    local rec_char = rm:get_character_by_cqi(cqi)
                    rec_char:add_unit_to_army(unit_key)
                else
                    rm:log("GRANT UNIT COMMAND: ".. char_string.." resolved to cqi "..tostring(cqi)..", but returned a null interface.")
                end
            else
                rm:log("GRANT UNIT COMMAND: No CQI in char_string "..char_string)
            end
            return true
        end)
        if not ok then
            rm:log("GRANT UNIT COMMAND FAILED")
            rm:log("ERR MSG: "..tostring(err))
        end
    end
    
    cm.grant_unit_to_character = new_grant_unit
    cm:add_first_tick_callback(function()
        
        local groups = {} --:map<string, boolean>
        local units_already_added = {} --:map<string, boolean>
        --localisations
        local loc_core = effect.get_localised_string("ttc_group_name_core")
        local loc_special = effect.get_localised_string("ttc_group_name_special")
        local loc_rare = effect.get_localised_string("ttc_group_name_rare")
        local loc_points = effect.get_localised_string("ttc_measurement_name")
        local loc_limit = effect.get_localised_string("ttc_army_limited")
        local loc_unlimited = effect.get_localised_string("ttc_army_unlimited")
        local loc_unit_cost = effect.get_localised_string("ttc_unit_cost")
        local loc_unit_no_cost = effect.get_localised_string("ttc_unit_no_cost")
        local groups_table = rm._normalUnitsToAdd
        local loaned_units_table = rm._loanedUnitsToAdd
        local unit_text_overrides = rm._unitTextOverrides

        local ok, err = pcall(function()
            --this loads any changes from character skills in save games
            for k, v in pairs(RECIEVED_SKILLS) do
                RecruiterCharacterSkillsLoaded(k)
            end

            --this loop adds all basic units to the game.
            rm:log("Adding "..tostring(#groups_table).." units to the caps system", true)
            for i = 1, #groups_table do
                --# assume unit_text_overrides: map<string, RM_UIPROFILE>
                if groups_table[i][3] then
                    rm:set_weight_for_unit(groups_table[i][1], groups_table[i][3])
                end
                groups[groups_table[i][2]] = true;
                if rm._overriddenUnitSettings[groups_table[i][1]] then
                    if units_already_added[groups_table[i][1]] then
                        rm:log("Skipped "..groups_table[i][1].." because it's setting were overriden")
                    else
                        local info = rm._overriddenUnitSettings[groups_table[i][1]]
                        units_already_added[groups_table[i][1]] = true
                        rm:log("Overwrote "..groups_table[i][1].." in the tabletop caps system!")      
                        rm:add_unit_to_group(info[1],info[2])
                        local override = unit_text_overrides[info[1]]
                        if override then
                            rm:set_ui_profile_for_unit(info[1], override)
                        elseif string.find(info[2], "core") then
                            local textstring = fill_loc(loc_unit_no_cost, loc_core) .. " \n" ..fill_loc(loc_unlimited, loc_core)
                            rm:set_ui_profile_for_unit(info[1], {
                                _text = textstring,
                                _image = "ui/custom/recruitment_controls/common_units.png"
                            })
                        elseif string.find(info[2], "special") then
                            local weight = info[3] --# assume weight: number
                            local textstring = fill_loc(loc_unit_cost, loc_special) .. "[[col:green]] "..weight.." [[/col]]"..loc_points..". \n"..fill_loc(loc_limit, tostring(rm._specialPointLimit), loc_points, loc_special) 
                            rm:set_ui_profile_for_unit(info[1], {
                                _text = textstring,
                                _image = "ui/custom/recruitment_controls/special_units_"..weight..".png"
                            })
                        elseif string.find(info[2], "rare") then
                            local weight = info[3] --# assume weight: number
                            local textstring = fill_loc(loc_unit_cost, loc_rare) .. "[[col:green]] "..weight.." [[/col]]"..loc_points..". \n"..fill_loc(loc_limit, tostring(rm._rarePointLimit), loc_points, loc_rare) 
                            rm:set_ui_profile_for_unit(info[1], {
                                _text = textstring,
                                _image = "ui/custom/recruitment_controls/rare_units_"..weight..".png"
                            })
                        end
                    end        
                elseif units_already_added[groups_table[i][1]] then
                    rm:log("CONTENT WARNING: "..groups_table[i][1].." is added to the system twice!")
                else
                    units_already_added[groups_table[i][1]] = true
                    rm:log("Added "..groups_table[i][1].." to the tabletop caps system")
                
                    rm:add_unit_to_group(groups_table[i][1], groups_table[i][2])
                    local override = unit_text_overrides[groups_table[i][1]]
                    if override then
                        rm:set_ui_profile_for_unit(groups_table[i][1], override)
                    elseif string.find(groups_table[i][2], "core") then
                        local textstring = fill_loc(loc_unit_no_cost, loc_core) .. " \n" ..fill_loc(loc_unlimited, loc_core)
                        rm:set_ui_profile_for_unit(groups_table[i][1], {
                            _text = textstring,
                            _image = "ui/custom/recruitment_controls/common_units.png"
                        })
                    elseif string.find(groups_table[i][2], "special") then
                        local weight = groups_table[i][3] --# assume weight: number
                        local textstring = fill_loc(loc_unit_cost, loc_special) .. "[[col:green]] "..weight.." [[/col]]"..loc_points..". \n"..fill_loc(loc_limit, tostring(rm._specialPointLimit), loc_points, loc_special) 
                        rm:set_ui_profile_for_unit(groups_table[i][1], {
                            _text = textstring,
                            _image = "ui/custom/recruitment_controls/special_units_"..weight..".png"
                        })
                    elseif string.find(groups_table[i][2], "rare") then
                        local weight = groups_table[i][3] --# assume weight: number
                        local textstring = fill_loc(loc_unit_cost, loc_rare) .. "[[col:green]] "..weight.." [[/col]]"..loc_points..". \n"..fill_loc(loc_limit, tostring(rm._rarePointLimit), loc_points, loc_rare) 
                        rm:set_ui_profile_for_unit(groups_table[i][1], {
                            _text = textstring,
                            _image = "ui/custom/recruitment_controls/rare_units_"..weight..".png"
                        })
                    end
                end
            end
            rm:log("Finished adding units", true)
            rm._normalUnitsToAdd = {}

            --this loop adds all loaned units to the game.
            for i = 1, #loaned_units_table do
                local current_entry = loaned_units_table[i]
                local subcultures = current_entry[2]--:any
                local sc_was_table = false--:boolean
                if type(current_entry[2]) == "string" then
                    subcultures = {current_entry[2]}
                    sc_was_table = true
                end
                --# assume subcultures: vector<string>
                rm:log(current_entry[1].." is being loaned by "..tostring(#subcultures).. " subcultures") 
                local weight = current_entry[4] or 1
                for j = 1, #subcultures do
                    local subculture = subcultures[j]
                    local prefix = rm._subculturePrefixes[subculture]
                    local abstractionID = current_entry[1].."_"..subculture
                    local override_unit = rm:create_unit_override(current_entry[1], abstractionID)
                    override_unit:set_unit_weight(weight)   
                    if string.find(loaned_units_table[i][3], "core") then
                        local group = prefix.."_core"
                        override_unit:add_group_to_unit(group)
                        groups[group] = true
                        local textstring = fill_loc(loc_unit_no_cost, loc_core) .. " \n" ..fill_loc(loc_unlimited, loc_core)
                        rm:set_ui_profile_for_unit_override(abstractionID, 
                            textstring,
                            "ui/custom/recruitment_controls/common_units.png"
                        )
                    elseif string.find(loaned_units_table[i][3], "special") then
                        local group = prefix.."_special"
                        override_unit:add_group_to_unit(group)
                        groups[group] = true
                        local textstring = fill_loc(loc_unit_cost, loc_special) .. "[[col:green]] "..weight.." [[/col]]"..loc_points..". \n"..fill_loc(loc_limit, tostring(rm._specialPointLimit), loc_points, loc_special) 
                        rm:set_ui_profile_for_unit_override(abstractionID, 
                            textstring,
                            "ui/custom/recruitment_controls/special_units_"..weight..".png"
                        )
                    elseif string.find(loaned_units_table[i][3], "rare") then
                        local group = prefix.."_rare"
                        override_unit:add_group_to_unit(group)
                        groups[group] = true
                        local textstring = fill_loc(loc_unit_cost, loc_rare) .. "[[col:green]] "..weight.." [[/col]]"..loc_points..". \n"..fill_loc(loc_limit, tostring(rm._rarePointLimit), loc_points, loc_rare) 
                        rm:set_ui_profile_for_unit_override(abstractionID, 
                            textstring,
                            "ui/custom/recruitment_controls/rare_units_"..weight..".png"
                        )
                    end
                    rm._overrideSubcultureFilters[subculture] = rm._overrideSubcultureFilters[subculture] or {}
                    table.insert(rm._overrideSubcultureFilters[subculture], abstractionID) 
                    rm:log(subculture.." loaned unit "..current_entry[1].." into group with prefix "..prefix)
                end
            end
            --this loop sets up the groups and their limits.
            for name, _ in pairs(groups) do
                if string.find(name, "core") then
                    rm:set_ui_name_for_group(name, loc_core)
                    --rm:add_character_quantity_limit_for_group(name, 21)
                end
                if string.find(name, "special") then
                    rm:set_ui_name_for_group(name, loc_special)
                    rm:add_character_quantity_limit_for_group(name, rm._specialPointLimit)
                end
                if string.find(name, "rare") then
                    rm:set_ui_name_for_group(name, loc_rare)
                    rm:add_character_quantity_limit_for_group(name, rm._rarePointLimit)
                end
                rm:log("Set name and quantity limit for group: "..name)
            end
            rm._loanedUnitsToAdd = {}
        end)
        if not ok then
            rm:log(err, true)
        end
        for i = 1, #rm._postSetupCallbacks do
            local ok, err = pcall(rm._postSetupCallbacks[i])
            if not ok then
                rm:log(err, true)
            end
        end
        rm._postSetupCallbacks = {}
    end)
else
    RCLOG("Recruiter Manager did not load: gametype is not __lib_type_campaign")
end


