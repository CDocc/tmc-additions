TMC = exports.core:getCoreObject()

local ComponentMap = {
    [1] = "mask",
    [4] = "pants",
    [5] = "bag",
    [6] = "shoes",
    [7] = "accessory",
    [8] = "t-shirt",
    [9] = "vest",
    [10] = "decals",
    [11] = "torso2",
}

local ArmsComponent = 3

local PropMap = {
    [0] = "hat",
    [1] = "glass",
    [2] = "ear",
    [6] = "watch",
    [7] = "bracelet",
}

TriggerEvent("chat:addSuggestion", "/copyoutfit", "Copy outfit data to clipboard for clothing config", {
    { name = "id", help = "Player ID (optional - defaults to yourself)" }
})

RegisterNetEvent("outfitcopier:copyOutfit", function(requestingPlayerId)
    local source = source
    if source == 0 then
        return
    end
    
    local currentPlayerId = GetPlayerServerId(PlayerId())
    
    if requestingPlayerId ~= currentPlayerId then
        return
    end
    
    local targetPed = PlayerPedId()
    local targetId = currentPlayerId
    
    local outfitData = {}
    
    for componentId, configKey in pairs(ComponentMap) do
        local drawable = GetPedDrawableVariation(targetPed, componentId)
        local texture = GetPedTextureVariation(targetPed, componentId)
        
        outfitData[configKey] = {
            item = drawable,
            texture = texture
        }
    end
    
    local armsDrawable = GetPedDrawableVariation(targetPed, ArmsComponent)
    local armsTexture = GetPedTextureVariation(targetPed, ArmsComponent)
    outfitData["arms"] = {
        item = armsDrawable,
        texture = armsTexture
    }
    
    for propId, configKey in pairs(PropMap) do
        local propDrawable = GetPedPropIndex(targetPed, propId)
        local propTexture = GetPedPropTextureIndex(targetPed, propId)
        
        if propDrawable == -1 then
            outfitData[configKey] = {
                item = -1,
                texture = 0
            }
        else
            outfitData[configKey] = {
                item = propDrawable,
                texture = propTexture
            }
        end
    end
    
    local formattedData = "                outfitData = {\n"
    
    local keyOrder = {"pants", "arms", "t-shirt", "vest", "torso2", "shoes", "decals", "accessory", "bag", "hat", "glass", "ear", "watch", "bracelet", "mask"}
    
    for _, key in ipairs(keyOrder) do
        local item = outfitData[key].item
        local texture = outfitData[key].texture
        formattedData = formattedData .. string.format('                    ["%s"]       = { item = %d, texture = %d},\n', key, item, texture)
    end
    
    formattedData = formattedData .. "                },"
    
    local title = string.format("Outfit Data (Player ID: %d)", targetId)
    TMC.Functions.Clipboard(formattedData, title)
    
    TMC.Functions.SimpleNotify("Outfit data copied to clipboard!", "success")
end)
