if not Config.Movement.Enabled then return end

local TMC = exports.core:getCoreObject()

-- Jump Fatigue System
if not Config.Movement.DisableJumpFatigue then
    local jumpCount = 0
    local lastJumpTime = 0
    
    CreateThread(function()
        while true do
            Wait(0)
            
            local ped = PlayerPedId()
            
            if IsPedOnFoot(ped) and not IsPedSwimming(ped) and not IsPedDiving(ped) and 
               (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and 
               IsPedJumping(ped) and not IsPedRagdoll(ped) then
                
                local currentTime = GetGameTimer()

                if currentTime - lastJumpTime > Config.Movement.JumpCooldownTime then
                    jumpCount = 0
                end
                
                jumpCount = jumpCount + 1
                lastJumpTime = currentTime
                
                if jumpCount >= Config.Movement.MaxJumpsBeforeRagdoll then
                    SetPedToRagdoll(ped, Config.Movement.RagdollDuration, Config.Movement.RagdollDuration, 0, true, true, false)
                    jumpCount = 0
                end
            else
                Wait(100)
            end
        end
    end)
    
    -- Export jump count
    exports('GetJumpCount', function()
        return jumpCount
    end)
end

-- Unlimited Sprint
if Config.Movement.SprintUnlimited then
    CreateThread(function()
        while true do
            Wait(0)
            RestorePlayerStamina(PlayerId(), 1.0)
        end
    end)
end

-- Sprint Speed Modifier
if Config.Movement.SprintSpeedMultiplier ~= 1.0 then
    CreateThread(function()
        while true do
            Wait(0)
            SetRunSprintMultiplierForPlayer(PlayerId(), Config.Movement.SprintSpeedMultiplier)
            SetSwimMultiplierForPlayer(PlayerId(), Config.Movement.SwimSpeed)
        end
    end)
end

-- Prone/Crawl System
if Config.Movement.ProneEnabled then
    local isProne = false
    
    local function ToggleProne()
        local ped = PlayerPedId()
        
        if not IsPedInAnyVehicle(ped, false) and not IsPedFalling(ped) and not IsPedSwimming(ped) then
            isProne = not isProne
            
            if isProne then
                RequestAnimSet("move_crawl")
                while not HasAnimSetLoaded("move_crawl") do
                    Wait(10)
                end
                SetPedMovementClipset(ped, "move_crawl", 0.25)
                SetPedStrafeClipset(ped, "move_crawl")
            else
                ResetPedMovementClipset(ped, 0.25)
                ResetPedStrafeClipset(ped)
            end
        end
    end
    
    RegisterCommand('+prone', function()
        ToggleProne()
    end, false)
    
    RegisterCommand('-prone', function()
        -- Key release (not used for toggle)
    end, false)
    
    RegisterKeyMapping('+prone', 'Toggle Prone', 'keyboard', Config.Movement.ProneKey)

    CreateThread(function()
        while true do
            Wait(500)
            if isProne then
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped, false) or IsPedFalling(ped) or IsPedRagdoll(ped) then
                    isProne = false
                    ResetPedMovementClipset(ped, 0.25)
                    ResetPedStrafeClipset(ped)
                end
            end
        end
    end)
    
    -- Export prone status
    exports('IsProne', function()
        return isProne
    end)
end

-- Movement Speed Modifiers
if Config.Movement.WalkSpeed ~= 1.0 or Config.Movement.RunSpeed ~= 1.0 then
    CreateThread(function()
        while true do
            Wait(0)
            local ped = PlayerPedId()
            
            if Config.Movement.WalkSpeed ~= 1.0 then
                SetPedMoveRateOverride(ped, Config.Movement.WalkSpeed)
            end
            
            if Config.Movement.RunSpeed ~= 1.0 then
                SetRunSprintMultiplierForPlayer(PlayerId(), Config.Movement.RunSpeed)
            end
        end
    end)
end

-- Climbing Speed Modifier
if Config.Movement.ClimbingSpeedMultiplier ~= 1.0 then
    CreateThread(function()
        while true do
            Wait(0)
            local ped = PlayerPedId()
            if IsPedClimbing(ped) then
                SetClimbingMoveRate(ped, Config.Movement.ClimbingSpeedMultiplier)
            else
                Wait(100)
            end
        end
    end)
end

-- Disable Vaulting
if Config.Movement.DisableVaulting then
    CreateThread(function()
        while true do
            Wait(0)
            DisableControlAction(0, 22, true) -- Disable space bar for vaulting
        end
    end)
end

-- Disable Idle Camera
if Config.Movement.DisableIdleCam then
    CreateThread(function()
        while true do
            Wait(10000) -- Check every 10 seconds
            InvalidateIdleCam()
            InvalidateVehicleIdleCam()
        end
    end)
end

-- Disable AFK Camera
if Config.Movement.DisableAFKCam then
    CreateThread(function()
        while true do
            Wait(0)
            DisableControlAction(0, 0, true) -- Disable cinematic cam
            DisableControlAction(0, 1, true) -- Disable camera pan
            DisableControlAction(0, 2, true) -- Disable camera tilt
        end
    end)
end

print('[Movement System] Loaded - Jump Fatigue: ' .. tostring(not Config.Movement.DisableJumpFatigue) .. ' | Prone: ' .. tostring(Config.Movement.ProneEnabled))

