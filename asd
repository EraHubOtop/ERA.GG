--> Made by NG/Leshaun Dinglenut/Jonah Peterson/Johan Peterson/Zuaify/Zua

--// Utillities
local HandshakeRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes").CharacterSoundEvent
local HandshakeString = nil
local HandshakeArguments = nil
local ShuffleFunction = nil

local OldSpoof
OldSpoof = hookfunction(debug.info, function(...)
    local Args = {...}
    
    if Args[1] == 2 and Args[2] == "s" then
        return "LocalScript"
    end

    return OldSpoof(...)
end)

local OldGrab
OldGrab = hookmetamethod(game, '__namecall', function(Self, ...)
    local Method = getnamecallmethod()
    local Args = {...}

    if not checkcaller() and Method == "fireServer" and Self == HandshakeRemote then
        if string.find(Args[1], "AC") then
            if type(Args[2]) == "table" then
                if not HandshakeString and not HandshakeArguments then
                    HandshakeString = Args[1]
                    HandshakeArguments = Args[2]
                else
                    return
                end

                if getrawmetatable(Args[2]).__tostring then
                    getrawmetatable(Args[2]).__tostring = nil
                end

                if getrawmetatable(Args[2]).__call then
                    getrawmetatable(Args[2]).__call = function(p1, p2, p3, p4, p5, p6)
                        if 
                            (p2 ~= 660 and p3 ~= 759 and p4 ~= 751 and p5 ~= 863 and p6 ~= 771) or
                            (p2 ~= 665 and p3 ~= 775 and p4 ~= 724 and p5 ~= 633 and p6 ~= 891) or
                            (p2 ~= 760 and p3 ~= 760 and p4 ~= 771 and p5 ~= 665 and p6 ~= 898) 
                        then
                            return
                        end
                    end
                end
            end

            if Args[2] == nil then
                return
            end
        end
    end

    return OldGrab(Self, ...)
end)

task.wait(3)

local ReplicateHandshake = function()
    if HandshakeArguments ~= nil and HandshakeString ~= nil then
        return HandshakeRemote:fireServer(HandshakeString, HandshakeArguments, nil) 
    end
end

local Thread = task.spawn(function() 
    while task.wait(0.4) do 
        local Success, Error = pcall(ReplicateHandshake) 

        if Success then 
        else
            return warn("Bypass timed out.")
        end
    end
end)

for i, v in pairs(getgc()) do
    if type(v) == "function" then
        if getinfo(v).source:find("PlayerModule.LocalScript") then
            for i2, v2 in pairs(getconstants(v)) do
                if v2 == 4000001 then
                    setconstant(v, i2, 1)
                end
            end
        end
    end
end

warn("Loading...")

for i, v in pairs(getgc()) do
    if type(v) == "function" then
        if getinfo(v).source:find("PlayerModule.LocalScript") then
            hookfunction(v, function() end)
            --warn("Hooked : ", v)
            getinfo(v).source = nil
            getfenv(v).script:Destroy()
        end
    end
end


game:FindFirstChild("LocalScript", true):Destroy()

warn("W")






local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Era.GG", Color3.fromRGB(135, 206, 250), Enum.KeyCode.RightControl)


local tab = win:Tab("Catching")

local tab2 = win:Tab("physics")


local plr = game.Players.LocalPlayer
local rs = game:GetService("RunService")

local magnetEnabled = false

-- Function to toggle the magnet
local function toggleMagnet(enabled)
    magnetEnabled = enabled
end

-- Function to magnetize the ball
local function magBall(ball)
    if ball and plr.Character then
        local leftArm = plr.Character:FindFirstChild("Left Arm")
        if leftArm then
            firetouchinterest(leftArm, ball, 0)
            task.wait()
            firetouchinterest(leftArm, ball, 1)
        end
    end
end

-- Connect the toggle to the magnet behavior
tab:Toggle("Magnet", false, function(enabled)
    toggleMagnet(enabled)
end)

-- Connect RunService to handle magnet behavior
rs.Heartbeat:Connect(function()
    if magnetEnabled then
        local footballs = workspace:FindPartsInRegion3(
            Region3.new(
                plr.Character.HumanoidRootPart.Position - Vector3.new(50, 50, 50),
                plr.Character.HumanoidRootPart.Position + Vector3.new(50, 50, 50)
            ),
            nil,
            math.huge
        )
        for _, football in ipairs(footballs) do
            if football.Name == "Football" and football:IsA("BasePart") and (football.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 50 then
                magBall(football)
            end
        end
    end
end)


tab:Slider("Magnet Range",0,30,0, function(t)
print(t)
end)

tab:Dropdown("Magent Type",{"Legit","League","Regular","Blatant","Brute"}, function(t)
local formulas = {
    ["Legit"] = function(power)
        return 2 + (power / 2.5)
    end,
    ["Regular"] = function()
        return 12
    end,
    ["Blatant"] = function()
        return 25
    end,
    ["League"] = function(power)
        return 1.45 + (power / 3.25)
    end,
}
end)


tab2:Toggle("Anti Jam", false, function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local collisionEnabled = false -- Set to false initially

    local function setCharacterCollision(enabled)
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                for _, part in ipairs(otherPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = enabled
                    end
                end
            end
        end
    end

    local function checkProximity()
        while true do -- Infinite loop to continuously check proximity
            wait(0.1)
            if collisionEnabled then -- Only perform checks if collision is enabled
                local characters = workspace:GetChildren()
                for _, otherCharacter in ipairs(characters) do
                    if otherCharacter:IsA("Model") and otherCharacter:FindFirstChild("HumanoidRootPart") then
                        local distance = (humanoidRootPart.Position - otherCharacter.HumanoidRootPart.Position).magnitude
                        if distance <= 5 then
                            setCharacterCollision(false)
                            wait(2)
                            setCharacterCollision(true)
                        end
                    end
                end
            end
        end
    end

    -- Start or stop the checkProximity function based on toggle state
    if state then
        task.spawn(checkProximity)
    end
end)

local autoswatv = 0
local enabledd = false
local connection

local function autoswatfunction()
    if enabledd then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local RunService = game:GetService("RunService")

        local function checkDistance(part)
            local distance = (part.Position - humanoidRootPart.Position).Magnitude
            if distance <= autoswatv then
                keypress(0x52) -- Press 'R' key
                keyrelease(0x52) -- Release 'R' key
                task.wait()
            end
        end
        
        local function updateDistances()
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Football" and v:IsA("BasePart") then
                    checkDistance(v)
                end
            end
        end
        
        connection = RunService.Heartbeat:Connect(updateDistances)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

local ToggleAutoSwat = tab2:Toggle("Auto Swat", false, function(state)
    enabledd = state
    autoswatfunction()
end)

local SliderAutoSwatRange = tab2:Slider("Auto Swat Range", 0, 45, 0, function(value)
    autoswatv = value
end)

local TeleportToNearestPlayerToggle = tab2:Toggle("Auto Click Aimbot", false, function(state)
    TeleportToNearestPlayerEnabled = state
end)


