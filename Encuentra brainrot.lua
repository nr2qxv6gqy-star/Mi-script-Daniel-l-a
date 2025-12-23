-- 🧠 Encuentra un Brainrot | Delta
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- ===== CONFIG =====
local flySpeed = 60
local speedValue = 90

-- ===== ESTADOS =====
local speedOn = false
local flying = false
local noclip = false

-- ===== LISTA DE BRAINROTS =====
local Brainrots = {
    "Elefante de Fresa",
    "Dragón Caneloni",
    "Garaman Madundun",
    "Los Mobilis",
    "La OG Combinación",
    "Meowl",
    "Capitáno Mobile",
    "Tralalero Tralala"
}

-- ===== VELOCIDAD =====
local function toggleSpeed()
    speedOn = not speedOn
    hum.WalkSpeed = speedOn and speedValue or 16
end

-- ===== NOCLIP =====
RunService.Stepped:Connect(function()
    if noclip then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

local function toggleNoclip()
    noclip = not noclip
end

-- ===== FLY =====
local bg, bv
local function toggleFly()
    flying = not flying
    if flying then
        bg = Instance.new("BodyGyro", hrp)
        bv = Instance.new("BodyVelocity", hrp)
        bg.P = 9e4
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)

        task.spawn(function()
            while flying do
                bg.CFrame = workspace.CurrentCamera.CFrame
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                task.wait()
            end
        end)
    else
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
    end
end

-- ===== SPAWN BRAINROT =====
local function spawnBrainrot(name)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = Vector3.new(3,3,3)
    p.Position = hrp.Position + Vector3.new(math.random(-5,5),5,math.random(-5,5))
    p.Anchored = false
    p.BrickColor = BrickColor.Random()
    p.Parent = workspace

    local bill = Instance.new("BillboardGui", p)
    bill.Size = UDim2.new(0,200,0,50)
    bill.AlwaysOnTop = true

    local txt = Instance.new("TextLabel", bill)
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.Text = name
    txt.TextScaled = true
    txt.TextColor3 = Color3.new(1,1,1)
end

-- ===== SPAWN TODOS =====
local function spawnAll()
    for _,name in ipairs(Brainrots) do
        spawnBrainrot(name)
        task.wait(0.1)
    end
end

-- ===== CONTROLES =====
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.One then
        toggleSpeed()       -- 1 Velocidad
    elseif input.KeyCode == Enum.KeyCode.Two then
        toggleFly()         -- 2 Fly
    elseif input.KeyCode == Enum.KeyCode.Three then
        toggleNoclip()      -- 3 Noclip
    elseif input.KeyCode == Enum.KeyCode.B then
        spawnAll()          -- B = Spawn TODOS
    elseif input.KeyCode == Enum.KeyCode.F then
        spawnBrainrot("Elefante de Fresa")
    elseif input.KeyCode == Enum.KeyCode.G then
        spawnBrainrot("Dragón Caneloni")
    elseif input.KeyCode == Enum.KeyCode.H then
        spawnBrainrot("Garaman Madundun")
    elseif input.KeyCode == Enum.KeyCode.J then
        spawnBrainrot("Los Mobilis")
    elseif input.KeyCode == Enum.KeyCode.K then
        spawnBrainrot("La OG Combinación")
    elseif input.KeyCode == Enum.KeyCode.L then
        spawnBrainrot("Meowl")
    elseif input.KeyCode == Enum.KeyCode.M then
        spawnBrainrot("Capitáno Mobile")
    elseif input.KeyCode == Enum.KeyCode.N then
        spawnBrainrot("Tralalero Tralala")
    end
end)

print("🧠 Brainrot Script Activo")
print("1 Velocidad | 2 Fly | 3 Noclip")
print("B = Spawn TODOS | F-G-H-J-K-L-M-N = Brainrots")
