if not Config.SelectSit.Enabled then return end

local TMC = exports.core:getCoreObject()

local ped = nil
local sitting = false
local heading = 0.0
local currentCoords = nil

local function RequestAnimDictionary(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(1)
    end
end

local function StartSittingThread()
    sitting = true
    TMC.Functions.Notify({
        message = "Press [X] to cancel",
        id = 'sit_xcancel',
        persist = true,
        notifType = 'info'
    })
    CreateThread(function()
        while sitting do
            Wait(1)
            if IsControlJustPressed(0, 73) then
                sitting = false
                TMC.Functions.StopNotify("sit_xcancel")
                ClearPedTasksImmediately(PlayerPedId())
                return
            end
        end
    end)
end

local function stopPlacing()
    if ped then
        DeleteEntity(ped)
    end
    ped = nil
    heading = 0.0
    currentCoords = nil
    TMC.Functions.StopNotify("sit_info")
end

local function MakePedSitDown(coords, heading, animData)
    stopPlacing()
    TaskGoToCoordAnyMeans(PlayerPedId(), coords.x, coords.y, coords.z, 1.0, 0, 0, 786603, 0xbf800000)
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    TMC.Functions.Notify({
        message = "Press [Right Click] to cancel",
        id = 'sit_rcancel',
        persist = true,
        notifType = 'info'
    })
    while #(PlayerCoords - coords) > 1.5 do
        Wait(1)
        PlayerCoords = GetEntityCoords(PlayerPedId())
        if IsControlJustPressed(0, 177) then
            TMC.Functions.StopNotify("sit_rcancel")
            ClearPedTasksImmediately(PlayerPedId())
            return
        end
    end
    TMC.Functions.StopNotify("sit_rcancel")
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, false)
    TaskPlayAnimAdvanced(PlayerPedId(), animData.dict, animData.anim, coords.x, coords.y, coords.z, 0, 0, heading, 3.0,
        3.0, -1, 2, 1.0, false, false)
    StartSittingThread()
end

local function RotationToDirection(rotation)
    local adjustedRotation =
    {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction =
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

local function Camera(ped)
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination =
    {
        x = cameraCoord.x + direction.x * 10.0,
        y = cameraCoord.y + direction.y * 10.0,
        z = cameraCoord.z + direction.z * 10.0
    }

    local sphereCast = StartShapeTestSweptSphere(
        cameraCoord.x,
        cameraCoord.y,
        cameraCoord.z,
        destination.x,
        destination.y,
        destination.z,
        0.2,
        339,
        ped,
        4
    )
    return GetShapeTestResultIncludingMaterial(sphereCast)
end

local function startPlacing()
    local _, hit, endCoords, _, _, _ = Camera(ped)
    if hit then
        currentCoords = endCoords
    end
end

local function PlacingThread(animData)
    if ped == nil then
        local playerPed = PlayerPedId()
        ped = ClonePed(playerPed, false, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityAlpha(ped, 0)
        RequestAnimDictionary(animData.dict)
        TaskPlayAnim(ped, animData.dict, animData.anim, 8.0, 8.0, -1, 1, 0, false, false, false)
        SetEntityCollision(ped, false, false)
        SetEntityAlpha(ped, 100)

        heading = GetEntityHeading(playerPed) + 90.0
        TMC.Functions.Notify({
            message = '-- Sit --<br>[E] Sit<br>[X / Right Click] Cancel<br>[SCROLL] Rotate<br>',
            id = 'sit_info',
            persist = true,
            notifType = 'info'
        })
        CreateThread(function()
            local lastCamRot = nil
            while ped ~= nil do
                Wait(1)
                DisableControlAction(0, 22, true)
                startPlacing()
                if currentCoords then
                    SetEntityCoords(ped, currentCoords.x, currentCoords.y, currentCoords.z)
                    SetEntityHeading(ped, heading)
                end
                if IsDisabledControlJustPressed(0, 14) then
                    heading = heading + 5
                    if heading > 360 then heading = 0.0 end
                end

                if IsDisabledControlJustPressed(0, 15) then
                    heading = heading - 5
                    if heading < 0 then heading = 360.0 end
                end
                if IsControlJustPressed(0, 38) then
                    if #(GetEntityCoords(PlayerPedId()) - currentCoords) < 5.0 then
                        MakePedSitDown(GetEntityCoords(ped), GetEntityHeading(ped), animData)
                    else
                        TMC.Functions.SimpleNotify('You are too far', 'error')
                    end
                end
                if IsControlJustPressed(0, 177) then
                    stopPlacing()
                end
            end
        end)
    else
        DeleteObject(ped)
        ped = nil
        stopPlacing()
        return
    end
end

RegisterCommand("selectsit", function(source, args)
    if not Config.SelectSit.Anims or not Config.SelectSit.Anims[tonumber(args[1])] then
        local animCount = Config.SelectSit.Anims and #Config.SelectSit.Anims or 0
        TMC.Functions.SimpleNotify('Invalid value chosen. Usage: /selectsit [1-' .. animCount .. ']', 'error')
        return
    end
    PlacingThread(Config.SelectSit.Anims[tonumber(args[1])])
end)

TriggerEvent('chat:addSuggestion', '/selectsit', 'Select and place a sitting animation.', {{name = "number", help = "Animation ID (1-" .. #Config.SelectSit.Anims .. ")"}})
