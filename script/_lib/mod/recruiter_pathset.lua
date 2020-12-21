recruiter_pathset = {} --# assume recruiter_pathset: RECRUITER_PATHSET


--v function(paths: map<string, vector<string>>, merc_path: vector<string>, conditional_tests: (function(rec_char: RECRUITER_CHARACTER) --> vector<string>)?) --> RECRUITER_PATHSET
function recruiter_pathset.new_path(paths,merc_path, conditional_tests)
    local self = {}
    setmetatable(self, {
        __index = recruiter_pathset,
        __tostring = function() return "RECRUITER_PATHSET" end
    }) --# assume self: RECRUITER_PATHSET

    --all the paths, stored with an index key
    self._paths = paths
    --stores the keys and a list of functions to test the paths
    self._conditions = function(ca_char)
        return {}
    end --:function(rec_char: RECRUITER_CHARACTER) --> vector<string>
    self._hasConditions = false
    if conditional_tests then
        --# assume conditional_tests: function(rec_char: RECRUITER_CHARACTER) --> vector<string>
        self._conditions = conditional_tests
        self._hasConditions = true
    end
    self._defaultPaths = {} --:vector<string>
    --if we don't have any conditions, add all paths to the default list
    if not self._hasConditions then
        for subpathID, _ in pairs(self._paths) do
            table.insert(self._defaultPaths, subpathID)
        end
    end
    self._mercenaryPath = merc_path
    return self
end

--v function(self: RECRUITER_PATHSET, subpathID: string) --> vector<string>
function recruiter_pathset.get_path(self, subpathID)
    return self._paths[subpathID]
end

--v function(self: RECRUITER_PATHSET) --> vector<string>
function recruiter_pathset.mercenary_path(self)
    return self._mercenaryPath
end


--v function(self: RECRUITER_PATHSET, char: RECRUITER_CHARACTER) --> vector<string>
function recruiter_pathset.get_path_list(self, char)
    if self._hasConditions then
        return self._conditions(char)
    else
        return self._defaultPaths
    end
end

--v function(self: RECRUITER_PATHSET) --> boolean
function recruiter_pathset.has_conditional_paths(self)
    return self._hasConditions
end

