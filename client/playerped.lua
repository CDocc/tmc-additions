if not Config.Player.Enabled then return end

local isLoggedIn = false

CreateThread(function()
    while true do
        Wait(Config.Player.ConfigUpdateInterval)
        
        local ped = PlayerPedId()

        if not Config.Player.DisableRelaxedMode then
            SetPedConfigFlag(ped, 424, true)
        end

        if Config.Player.DisableAutoReload then
            SetWeaponsNoAutoreload(true)
        end
    end
end)

RegisterNetEvent('TMC:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    StartLoggedInThread()
end)

RegisterNetEvent('TMC:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

local function StartLoggedInThread()
    CreateThread(function()
        while isLoggedIn do
            Wait(0)
            
            local ped = PlayerPedId()

            if Config.Player.DisableHeadshots then
                SetPedSuffersCriticalHits(ped, false)
            end
        end
    end)
end
