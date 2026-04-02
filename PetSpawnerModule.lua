-- PetSpawnerModule.lua

local PetSpawnerModule = {}
PetSpawnerModule.__index = PetSpawnerModule

-- Sample Pet Data
local pets = {
    Cat = { id = 1, name = "Cat", breed = "Maine Coon", color = "Black", rarity = "Common" },
    Dog = { id = 2, name = "Dog", breed = "Labrador", color = "Yellow", rarity = "Common" },
    Unicorn = { id = 3, name = "Unicorn", breed = "Mythical", color = "White", rarity = "Rare" }
}

-- Local Inventory
local inventory = {}

-- DataStore integration (mock implementation)
local DataStoreService = game:GetService("DataStoreService")
local petDataStore = DataStoreService:GetDataStore("PetDataStore")

-- Validate pet 
local function validatePet(pet)
    return pets[pet] ~= nil
end

-- Add pet to inventory
function PetSpawnerModule:AddPetToInventory(pet)
    if validatePet(pet) then
        table.insert(inventory, pets[pet])
        print(pets[pet].name .. " added to inventory.")
    else
        print("Invalid pet.")
    end
end

-- Retrieve inventory
function PetSpawnerModule:GetInventory()
    return inventory
end

-- Save inventory to DataStore
function PetSpawnerModule:SaveInventory(playerId)
    local success, err = pcall(function()
        petDataStore:SetAsync(playerId, inventory)
    end)
    if success then
        print("Inventory saved successfully.")
    else
        warn(err)
    end
end

-- Load inventory from DataStore
function PetSpawnerModule:LoadInventory(playerId)
    local success, err = pcall(function()
        inventory = petDataStore:GetAsync(playerId) or {}
    end)
    if success then
        print("Inventory loaded successfully.")
    else
        warn(err)
    end
end

return PetSpawnerModule