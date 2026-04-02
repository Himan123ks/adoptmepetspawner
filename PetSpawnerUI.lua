-- PetSpawnerUI.lua

local Players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local PetButtonsFrame = Instance.new("Frame")
local CurrentPetDisplay = Instance.new("TextLabel")
local InventoryDisplay = Instance.new("Frame")
local Pets = {"Dog", "Cat", "Parrot"}
local SelectedPet = ""

-- Create UI Elements
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

PetButtonsFrame.Parent = MainFrame
PetButtonsFrame.Size = UDim2.new(1, 0, 0.3, 0)
PetButtonsFrame.Position = UDim2.new(0, 0, 0, 0)

CurrentPetDisplay.Parent = MainFrame
CurrentPetDisplay.Size = UDim2.new(1, 0, 0.2, 0)
CurrentPetDisplay.Position = UDim2.new(0, 0, 0.3, 0)
CurrentPetDisplay.Text = "Selected Pet: None"

InventoryDisplay.Parent = MainFrame
InventoryDisplay.Size = UDim2.new(1, 0, 0.5, 0)
InventoryDisplay.Position = UDim2.new(0, 0, 0.5, 0)
InventoryDisplay.BackgroundColor3 = Color3.fromRGB(220, 220, 220)

-- Create Category Buttons
for _, petName in ipairs(Pets) do
    local Button = Instance.new("TextButton")
    Button.Parent = PetButtonsFrame
    Button.Size = UDim2.new(0.3, 0, 1, 0)
    Button.Text = petName
    Button.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Button.MouseButton1Click:Connect(function()
        SelectedPet = petName
        CurrentPetDisplay.Text = "Selected Pet: " .. SelectedPet
    end)
end

-- Function to Display Inventory
local function DisplayInventory()
    local itemCountLabel = Instance.new("TextLabel")
    itemCountLabel.Parent = InventoryDisplay
    itemCountLabel.Size = UDim2.new(1, 0, 1, 0)
    itemCountLabel.Text = "Inventory: " .. table.concat(Pets, ", ")
    itemCountLabel.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
end

DisplayInventory()