local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local useItemRemote = ReplicatedStorage
    :WaitForChild("requests")
    :WaitForChild("character")
    :WaitForChild("use_item")

local Worthiness = player:WaitForChild("PlayerData")
    :WaitForChild("SlotData")
    :WaitForChild("Worthiness")

local running = false

-- ใช้ Stand Arrow ครั้งเดียว
local function useStandArrow()
    useItemRemote:FireServer("Stand Arrow")
end

-- Loop ใช้ Stand Arrow
local function rollStand()

    while running do
        
        local value = Worthiness.Value

        -- หยุดเมื่อ Worthiness = 19 หรือ 0
        if value == 19 or value == 0 then
            print("Stop rolling - Worthiness:", value)
            running = false
            break
        end

        useItemRemote:FireServer("Stand Arrow")

        task.wait(0.6)
    end

end


UserInputService.InputBegan:Connect(function(input, gpe)

    if gpe then return end

    -- ปุ่ม 1
    if input.KeyCode == Enum.KeyCode.One then
        useStandArrow()

    -- ปุ่ม 2 Toggle
    elseif input.KeyCode == Enum.KeyCode.Two then
        
        running = not running
        
        if running then
            print("Auto Roll ON")
            task.spawn(rollStand)
        else
            print("Auto Roll OFF")
        end

    end

end)
