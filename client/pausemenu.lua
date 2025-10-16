if not Config.PauseMenu.Enabled then return end

local function AddTextEntry(k, v)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), k, v)
end

CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', Config.PauseMenu.Title)
    AddTextEntry('PM_SCR_MAP', Config.PauseMenu.MapCategory)
    AddTextEntry('PM_SCR_GAM', Config.PauseMenu.GameCategory)
    AddTextEntry('PM_PANE_LEAVE', Config.PauseMenu.DisconnectSubMenu)
    AddTextEntry('PM_PANE_QUIT', Config.PauseMenu.CloseGameSubMenu)
    AddTextEntry('PM_SCR_INF', Config.PauseMenu.InfoCategory)
    AddTextEntry('PM_SCR_STA', Config.PauseMenu.StatisticsCategory)
    AddTextEntry('PM_SCR_SET', Config.PauseMenu.SettingsCategory)
    AddTextEntry('PM_PANE_CFX', Config.PauseMenu.FiveMKeysConfigCategory)
    AddTextEntry('PM_SCR_GAL', Config.PauseMenu.GalleryCategory)
    AddTextEntry('PM_SCR_RPL', Config.PauseMenu.RockstarEditorCategory)
end)
