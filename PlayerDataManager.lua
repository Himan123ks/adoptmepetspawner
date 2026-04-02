-- PlayerDataManager.lua

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local playerDataStore = DataStoreService:GetDataStore("PlayerDataStore")

-- Function to load player data
local function loadPlayerData(player)
    local success, data = pcall(function()
        return playerDataStore:GetAsync(player.UserId)
    end)

    if success then
        if data then
            -- Load player inventory or other data
            player:LoadCharacter()  -- Example to load character
        else
            print("No data found for player: " .. player.Name)
        end
    else
        warn("Failed to load data for player: " .. player.Name .. " - " .. tostring(data))
    end
end

-- Function to save player data
local function savePlayerData(player)
    local success, errorMessage = pcall(function()
        -- Get player data to save
        local playerData = {} -- populate this table with necessary player data
        playerDataStore:SetAsync(player.UserId, playerData)
    end)

    if not success then
        warn("Failed to save data for player: " .. player.Name .. " - " .. tostring(errorMessage))
    end
end

-- Player joining
Players.PlayerAdded:Connect(function(player)
    print("Player joined: " .. player.Name)
    loadPlayerData(player)
end)

-- Player leaving
Players.PlayerRemoving:Connect(function(player)
    print("Player left: " .. player.Name)
    savePlayerData(player)
end)
