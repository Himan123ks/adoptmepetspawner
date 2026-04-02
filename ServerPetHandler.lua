-- ServerPetHandler.lua

-- Secure Pet Spawning
local PetSpawner = {}

function PetSpawner:SpawnPet(petType)
    -- Implement security checks here
    local pet = Instance.new(petType)
    -- Set pet parent and initial properties
    local success, err = pcall(function() 
        pet.Parent = game.Workspace
    end)
    if not success then
        warn("Failed to spawn pet: " .. err)
    end
end

-- Inventory Management
local Inventory = {}

function Inventory:AddPet(pet)
    table.insert(self, pet)
end

function Inventory:RemovePet(pet)
    for i, v in ipairs(self) do
        if v == pet then
            table.remove(self, i)
            return
        end
    end
end

-- DataStore Integration
local DataStoreService = game:GetService("DataStoreService")
local PetDataStore = DataStoreService:GetDataStore("PetData")

function SavePetsToDataStore(player)
    -- Save player's pets database
    local success, err = pcall(function() 
        PetDataStore:SetAsync(player.UserId, player.Inventory)
    end)
    if not success then
        warn("Failed to save pets: " .. err)
    end
end

function LoadPetsFromDataStore(player)
    -- Load player's pets database
    local success, data = pcall(function() 
        return PetDataStore:GetAsync(player.UserId)
    end)
    if success then
        player.Inventory = data or {}
    else
        warn("Failed to load pets: " .. data)
    end
end

-- RemoteEvent Handling
local RemoteEvent = Instance.new("RemoteEvent", game.ReplicatedStorage)
RemoteEvent.Name = "PetSpawnerEvent"

RemoteEvent.OnServerEvent:Connect(function(player, petType)
    PetSpawner:SpawnPet(petType)
    SavePetsToDataStore(player)
end)

return PetSpawner