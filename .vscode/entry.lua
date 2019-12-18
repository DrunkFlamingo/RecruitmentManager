package.path = "script/campaign/mod/?.lua;script/_lib/mod/?.lua;script/campaign/main_warhammer/mod/?.lua;script/?.lua;"


require("RecruitmentControls")
require("AICharacterRecruitmentControls")
require("RecruitmentPanelUIImplementation")
require("UICharacterPathSettings")

--export helpers
require("export_helpers__recruitment_control_monitor")
require("export_helpers__tt_groups")
require("export_helpers__custom_unit_template")

