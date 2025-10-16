if not Config.World.Enabled then return end

local isLoggedIn = false

RegisterNetEvent('TMC:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    StartWorldThread()
end)

RegisterNetEvent('TMC:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

local function StartWorldThread()
    CreateThread(function()
        while isLoggedIn do
            Wait(5)

            if Config.World.DisableDistantCopSirens then
                DistantCopCarSirens(false)
            end
            
            if Config.World.DisableStaticEmitters then
                for _, emitter in ipairs(Config.World.StaticEmitters) do
                    SetStaticEmitterEnabled(emitter, false)
                end
            end
        end
    end)
end
