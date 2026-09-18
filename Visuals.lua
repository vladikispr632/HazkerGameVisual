-- ═══════════════════════════════════════════════════════════
-- VISUAL HUB 67 — Part 1/3
-- Только визуалы, Byfron-safe
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local state = {
    skyActive = false,
    music67 = false,
    emojiHack = false,
    rgbUI = false,
    particles = false,
    rainOf67 = false,
    spinningSky = false,
    screenShake = false,
    colorInvert = false,
    blur = false,
    neonMode = false,
    bigHead = false,
    rainbowName = false,
    trail67 = false,
    lightSword = false,
    blackScreen = false,
    flashMode = false,
    matrixMode = false,
    glowMode = false,
    staticMode = false,
}

-- ═══════════════════════════════════════════════════════════
-- ХЕЛПЕРЫ
-- ═══════════════════════════════════════════════════════════
local function char()
    return LP.Character
end

local function hum()
    local c = char()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function root()
    local c = char()
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function notify(t, txt, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = t, Text = txt, Duration = dur or 2
        })
    end)
end

local function clearSounds()
    for _, s in ipairs(SoundService:GetChildren()) do
        if s.Name:find("67Sound") then s:Destroy() end
    end
end

local function play67Sound(id, loop)
    pcall(function()
        local s = Instance.new("Sound")
        s.Name = "67Sound"
        s.SoundId = "rbxassetid://" .. id
        s.Volume = 0.5
        s.Looped = loop or false
        s.Parent = SoundService
        s:Play()
    end)
end-- ═══════════════════════════════════════════════════════════
-- VISUAL HUB 67 — Part 2/3
-- Функции визуалов
-- ═══════════════════════════════════════════════════════════

-- ═════ 1. СМЕНА НЕБА НА 67 ═════
local originalSky = nil
local function toggleSky67()
    if state.skyActive then
        if originalSky then
            originalSky.Parent = Lighting
        end
        local newSky = Lighting:FindFirstChild("67Sky")
        if newSky then newSky:Destroy() end
        state.skyActive = false
    else
        originalSky = Lighting:FindFirstChildOfClass("Sky")
        if originalSky then originalSky.Parent = nil end
        local sky = Instance.new("Sky")
        sky.Name = "67Sky"
        sky.SkyboxBk = "rbxassetid://131144332"   -- замени на ID неба 67
        sky.SkyboxDn = "rbxassetid://131144332"
        sky.SkyboxFt = "rbxassetid://131144332"
        sky.SkyboxLf = "rbxassetid://131144332"
        sky.SkyboxRt = "rbxassetid://131144332"
        sky.SkyboxUp = "rbxassetid://131144332"
        sky.Parent = Lighting
        state.skyActive = true
    end
end

-- ═════ 2. МУЗЫКА 67676767 ═════
local function toggleMusic67()
    state.music67 = not state.music67
    if state.music67 then
        -- замени ID на нужный звук 67
        play67Sound(1837879084, true)
    else
        clearSounds()
    end
end

-- ═════ 3. ЭМОДЗИ-ХАКИНГ (101010 на 3 экранах) ═════
local emojiFrames = {}
local function toggleEmojiHack()
    state.emojiHack = not state.emojiHack
    if state.emojiHack then
        for i = 1, 3 do
            local f = Instance.new("Frame")
            f.Size = UDim2.new(0, 400, 0, 300)
            f.Position = UDim2.new(0.5, -200 + (i-2)*250, 0.5, -150)
            f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            f.BorderSizePixel = 0
            f.Parent = PG

            local t = Instance.new("TextLabel")
            t.Size = UDim2.new(1, 0, 1, 0)
            t.BackgroundTransparency = 1
            t.Text = "10101010101010\n01010101010101\n10101010101010\n01010101010101\n10101010101010\n01010101010101"
            t.TextColor3 = Color3.fromRGB(0, 255, 0)
            t.TextSize = 14
            t.Font = Enum.Font.Code
            t.TextWrapped = true
            t.Parent = f

            table.insert(emojiFrames, f)

            -- Анимация мигания
            task.spawn(function()
                while state.emojiHack and f.Parent do
                    t.TextColor3 = Color3.fromRGB(
                        math.random(0, 255),
                        math.random(0, 255),
                        math.random(0, 255)
                    )
                    task.wait(0.1)
                end
            end)
        end
    else
        for _, f in ipairs(emojiFrames) do
            if f then f:Destroy() end
        end
        emojiFrames = {}
    end
end

-- ═════ 4. RGB ИНТЕРФЕЙС ═════
local function startRGBUI()
    task.spawn(function()
        while state.rgbUI do
            local c = Color3.fromHSV(tick() % 1, 1, 1)
            for _, g in ipairs(PG:GetChildren()) do
                if g:IsA("ScreenGui") and g.Name == "VisualHub67" then
                    for _, d in ipairs(g:GetDescendants()) do
                        if d:IsA("TextLabel") or d:IsA("TextButton") then
                            d.TextColor3 = c
                        end
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end

-- ═════ 5. ЧАСТИЦЫ ВОКРУГ ═════
local particleEmitter = nil
local function toggleParticles()
    state.particles = not state.particles
    local r = root()
    if not r then return end
    if state.particles then
        particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxassetid://243098098"
        particleEmitter.Rate = 50
        particleEmitter.Lifetime = NumberRange.new(1, 2)
        particleEmitter.Speed = NumberRange.new(2, 4)
        particleEmitter.Size = NumberSequence.new(1)
        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 0, 255))
        particleEmitter.Parent = r
    else
        if particleEmitter then particleEmitter:Destroy() particleEmitter = nil end
    end
end

-- ═════ 6. ДОЖДЬ ИЗ 67 ═════
local rain67 = {}
local function toggleRain67()
    state.rainOf67 = not state.rainOf67
    if state.rainOf67 then
        for i = 1, 20 do
            task.spawn(function()
                while state.rainOf67 do
                    local p = Instance.new("Part")
                    p.Size = Vector3.new(2, 2, 0.2)
                    p.Anchored = false
                    p.CanCollide = false
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(255, 100, 255)
                    local r = root()
                    if r then
                        p.Position = r.Position + Vector3.new(math.random(-30,30), 40, math.random(-30,30))
                    end
                    p.Parent = workspace
                    table.insert(rain67, p)
                    task.wait(0.3)
                    game:GetService("Debris"):AddItem(p, 3)
                end
            end)
        end
    else
        for _, p in ipairs(rain67) do
            if p and p.Parent then p:Destroy() end
        end
        rain67 = {}
    end
end

-- ═════ 7. ВРАЩЕНИЕ НЕБА ═════
local function startSpinningSky()
    task.spawn(function()
        while state.spinningSky do
            local sky = Lighting:FindFirstChild("67Sky")
            if sky then
                sky.Orientation = Vector3.new(0, tick() * 30 % 360, 0)
            end
            task.wait(0.05)
        end
    end)
end

-- ═════ 8. ТРЯСКА ЭКРАНА ═════
local function startScreenShake()
    task.spawn(function()
        while state.screenShake do
            local cam = workspace.CurrentCamera
            if cam then
                cam.CFrame = cam.CFrame * CFrame.new(
                    math.random(-3,3)/100,
                    math.random(-3,3)/100,
                    0
                )
            end
            task.wait(0.05)
        end
    end)
end

-- ═════ 9. ИНВЕРСИЯ ЦВЕТОВ ═════
local function toggleColorInvert()
    state.colorInvert = not state.colorInvert
    if state.colorInvert then
        pcall(function()
            local cc = Instance.new("ColorCorrectionEffect")
            cc.Name = "67Invert"
            cc.Saturation = -1
            cc.Contrast = 1
            cc.Parent = Lighting
        end)
    else
        local cc = Lighting:FindFirstChild("67Invert")
        if cc then cc:Destroy() end
    end
end

-- ═════ 10. РАЗМЫТИЕ ═════
local function toggleBlur()
    state.blur = not state.blur
    if state.blur then
        pcall(function()
            local b = Instance.new("BlurEffect")
            b.Name = "67Blur"
            b.Size = 20
            b.Parent = Lighting
        end)
    else
        local b = Lighting:FindFirstChild("67Blur")
        if b then b:Destroy() end
    end
end-- ═══════════════════════════════════════════════════════════
-- VISUAL HUB 67 — Part 3/3
-- Остальные функции + GUI
-- ═══════════════════════════════════════════════════════════

-- ═════ 11. НЕОН-РЕЖИМ ═════
local function toggleNeonMode()
    state.neonMode = not state.neonMode
    if state.neonMode then
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "67Neon"
        cc.Saturation = 2
        cc.Contrast = 1.5
        cc.Brightness = 0.3
        cc.Parent = Lighting
    else
        local cc = Lighting:FindFirstChild("67Neon")
        if cc then cc:Destroy() end
    end
end

-- ═════ 12. БОЛЬШАЯ ГОЛОВА ═════
local function toggleBigHead()
    state.bigHead = not state.bigHead
    local c = char()
    if not c then return end
    local head = c:FindFirstChild("Head")
    if head then
        if state.bigHead then
            head.Size = Vector3.new(3, 3, 3)
            head.Mesh.Scale = Vector3.new(3, 3, 3)
        else
            head.Size = Vector3.new(1, 1, 1)
            head.Mesh.Scale = Vector3.new(1, 1, 1)
        end
    end
end

-- ═════ 13. РАДУЖНОЕ ИМЯ ═════
local function startRainbowName()
    task.spawn(function()
        while state.rainbowName do
            local c = char()
            if c then
                local hl = c:FindFirstChildOfClass("Humanoid")
                if hl then
                    local c3 = Color3.fromHSV(tick() % 1, 1, 1)
                    pcall(function()
                        if c:FindFirstChild("Head") then
                            c.Head.Color = c3
                        end
                    end)
                end
            end
            task.wait(0.1)
        end
    end)
end

-- ═════ 14. ТРЕЙЛ 67 ═════
local trail67 = nil
local function toggleTrail67()
    state.trail67 = not state.trail67
    local r = root()
    if not r then return end
    if state.trail67 then
        trail67 = Instance.new("Trail")
        trail67.Attachment0 = Instance.new("Attachment", r)
        trail67.Attachment1 = Instance.new("Attachment", r)
        trail67.Color = ColorSequence.new(Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255))
        trail67.Lifetime = 1
        trail67.Parent = r
    else
        if trail67 then trail67:Destroy() trail67 = nil end
    end
end

-- ═════ 15. СВЕТОВОЙ МЕЧ ═════
local light67 = nil
local function toggleLightSword()
    state.lightSword = not state.lightSword
    local r = root()
    if not r then return end
    if state.lightSword then
        light67 = Instance.new("PointLight")
        light67.Brightness = 10
        light67.Range = 30
        light67.Color = Color3.fromRGB(255, 0, 255)
        light67.Parent = r
    else
        if light67 then light67:Destroy() light67 = nil end
    end
end

-- ═════ 16. ЧЁРНЫЙ ЭКРАН ═════
local function toggleBlackScreen()
    state.blackScreen = not state.blackScreen
    if state.blackScreen then
        local f = Instance.new("Frame")
        f.Name = "67Black"
        f.Size = UDim2.new(1, 0, 1, 0)
        f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        f.BorderSizePixel = 0
        f.ZIndex = 999
        f.Parent = PG
    else
        local f = PG:FindFirstChild("67Black")
        if f then f:Destroy() end
    end
end

-- ═════ 17. FLASH-РЕЖИМ ═════
local function startFlash()
    task.spawn(function()
        while state.flashMode do
            local f = PG:FindFirstChild("67Flash")
            if f then f:Destroy() end
            f = Instance.new("Frame")
            f.Name = "67Flash"
            f.Size = UDim2.new(1, 0, 1, 0)
            f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            f.BorderSizePixel = 0
            f.ZIndex = 998
            f.Parent = PG
            task.wait(0.1)
            if f then f:Destroy() end
            task.wait(0.1)
        end
        local f = PG:FindFirstChild("67Flash")
        if f then f:Destroy() end
    end)
end

-- ═════ 18. MATRIX ═════
local matrixFrames = {}
local function toggleMatrix()
    state.matrixMode = not state.matrixMode
    if state.matrixMode then
        for i = 1, 5 do
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, 0, 1, 0)
            f.Position = UDim2.new(0, i*40, 0, 0)
            f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            f.BackgroundTransparency = 0.7
            f.BorderSizePixel = 0
            f.Parent = PG
            table.insert(matrixFrames, f)

            task.spawn(function()
                while state.matrixMode and f.Parent do
                    local t = Instance.new("TextLabel")
                    t.Size = UDim2.new(1, 0, 0, 20)
                    t.Position = UDim2.new(0, 0, math.random(), 0)
                    t.BackgroundTransparency = 1
                    t.Text = string.rep(tostring(math.random(0,1)), 10)
                    t.TextColor3 = Color3.fromRGB(0, 255, 0)
                    t.TextSize = 14
                    t.Font = Enum.Font.Code
                    t.Parent = f
                    game:GetService("Debris"):AddItem(t, 1.5)
                    task.wait(0.1)
                end
            end)
        end
    else
        for _, f in ipairs(matrixFrames) do
            if f then f:Destroy() end
        end
        matrixFrames = {}
    end
end

-- ═════ 19. СВЕЧЕНИЕ ═════
local function toggleGlow()
    state.glowMode = not state.glowMode
    if state.glowMode then
        local b = Instance.new("BloomEffect")
        b.Name = "67Glow"
        b.Intensity = 3
        b.Size = 30
        b.Parent = Lighting
    else
        local b = Lighting:FindFirstChild("67Glow")
        if b then b:Destroy() end
    end
end

-- ═════ 20. СТАТИК ═════
local function toggleStatic()
    state.staticMode = not state.staticMode
    if state.staticMode then
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "67Static"
        cc.Brightness = -0.5
        cc.Contrast = 3
        cc.Parent = Lighting
    else
        local cc = Lighting:FindFirstChild("67Static")
        if cc then cc:Destroy() end
    end
end

-- ═════ GUI ═════
local old = PG:FindFirstChild("VisualHub67")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "VisualHub67"
gui.ResetOnSpawn = false
gui.Parent = PG

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 320, 0, 500)
panel.Position = UDim2.new(0.5, -160, 0.5, -250)
panel.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
panel.BorderSizePixel = 0
panel.Active = true
panel.Draggable = true
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
titleBar.BorderSizePixel = 0
titleBar.Parent = panel
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 20)
titleFix.Position = UDim2.new(0, 0, 1, -20)
titleFix.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌈 VISUAL HUB 67"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeX = Instance.new("TextButton")
closeX.Size = UDim2.new(0, 30, 0, 30)
closeX.Position = UDim2.new(1, -38, 0, 10)
closeX.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeX.Text = "✖"
closeX.TextColor3 = Color3.fromRGB(255, 255, 255)
closeX.TextSize = 14
closeX.Font = Enum.Font.GothamBold
closeX.BorderSizePixel = 0
closeX.Parent = titleBar
Instance.new("UICorner", closeX).CornerRadius = UDim.new(0, 8)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -60)
scroll.Position = UDim2.new(0, 5, 0, 55)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 1100)
scroll.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local function makeBtn(text, col, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 36)
    b.BackgroundColor3 = col
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = scroll
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

-- 20 функций
makeBtn("🌌 1. НЕБО 67: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleSky67()
    b.Text = state.skyActive and "🌌 1. НЕБО 67: ВКЛ" or "🌌 1. НЕБО 67: ВЫКЛ"
end)

makeBtn("🎵 2. МУЗЫКА 67: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleMusic67()
    b.Text = state.music67 and "🎵 2. МУЗЫКА 67: ВКЛ" or "🎵 2. МУЗЫКА 67: ВЫКЛ"
end)

makeBtn("😈 3. ЭМОДЗИ ХАК 101010: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleEmojiHack()
    b.Text = state.emojiHack and "😈 3. ЭМОДЗИ ХАК 101010: ВКЛ" or "😈 3. ЭМОДЗИ ХАК 101010: ВЫКЛ"
end)

makeBtn("🌈 4. RGB ИНТЕРФЕЙС: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    state.rgbUI = not state.rgbUI
    if state.rgbUI then startRGBUI() end
    b.Text = state.rgbUI and "🌈 4. RGB ИНТЕРФЕЙС: ВКЛ" or "🌈 4. RGB ИНТЕРФЕЙС: ВЫКЛ"
end)

makeBtn("✨ 5. ЧАСТИЦЫ: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleParticles()
    b.Text = state.particles and "✨ 5. ЧАСТИЦЫ: ВКЛ" or "✨ 5. ЧАСТИЦЫ: ВЫКЛ"
end)

makeBtn("☔ 6. ДОЖДЬ 67: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleRain67()
    b.Text = state.rainOf67 and "☔ 6. ДОЖДЬ 67: ВКЛ" or "☔ 6. ДОЖДЬ 67: ВЫКЛ"
end)

makeBtn("🌀 7. ВРАЩЕНИЕ НЕБА: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    state.spinningSky = not state.spinningSky
    if state.spinningSky then startSpinningSky() end
    b.Text = state.spinningSky and "🌀 7. ВРАЩЕНИЕ НЕБА: ВКЛ" or "🌀 7. ВРАЩЕНИЕ НЕБА: ВЫКЛ"
end)

makeBtn("📳 8. ТРЯСКА ЭКРАНА: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    state.screenShake = not state.screenShake
    if state.screenShake then startScreenShake() end
    b.Text = state.screenShake and "📳 8. ТРЯСКА ЭКРАНА: ВКЛ" or "📳 8. ТРЯСКА ЭКРАНА: ВЫКЛ"
end)

makeBtn("🎨 9. ИНВЕРСИЯ: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleColorInvert()
    b.Text = state.colorInvert and "🎨 9. ИНВЕРСИЯ: ВКЛ" or "🎨 9. ИНВЕРСИЯ: ВЫКЛ"
end)

makeBtn("💧 10. РАЗМЫТИЕ: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleBlur()
    b.Text = state.blur and "💧 10. РАЗМЫТИЕ: ВКЛ" or "💧 10. РАЗМЫТИЕ: ВЫКЛ"
end)

makeBtn("💡 11. НЕОН: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleNeonMode()
    b.Text = state.neonMode and "💡 11. НЕОН: ВКЛ" or "💡 11. НЕОН: ВЫКЛ"
end)

makeBtn("🗣 12. БОЛЬШАЯ ГОЛОВА: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleBigHead()
    b.Text = state.bigHead and "🗣 12. БОЛЬШАЯ ГОЛОВА: ВКЛ" or "🗣 12. БОЛЬШАЯ ГОЛОВА: ВЫКЛ"
end)

makeBtn("🌈 13. РАДУЖНОЕ ИМЯ: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    state.rainbowName = not state.rainbowName
    if state.rainbowName then startRainbowName() end
    b.Text = state.rainbowName and "🌈 13. РАДУЖНОЕ ИМЯ: ВКЛ" or "🌈 13. РАДУЖНОЕ ИМЯ: ВЫКЛ"
end)

makeBtn("💫 14. ТРЕЙЛ 67: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleTrail67()
    b.Text = state.trail67 and "💫 14. ТРЕЙЛ 67: ВКЛ" or "💫 14. ТРЕЙЛ 67: ВЫКЛ"
end)

makeBtn("⚔️ 15. СВЕТОВОЙ МЕЧ: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleLightSword()
    b.Text = state.lightSword and "⚔️ 15. СВЕТОВОЙ МЕЧ: ВКЛ" or "⚔️ 15. СВЕТОВОЙ МЕЧ: ВЫКЛ"
end)

makeBtn("⬛ 16. ЧЁРНЫЙ ЭКРАН: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleBlackScreen()
    b.Text = state.blackScreen and "⬛ 16. ЧЁРНЫЙ ЭКРАН: ВКЛ" or "⬛ 16. ЧЁРНЫЙ ЭКРАН: ВЫКЛ"
end)

makeBtn("⚡ 17. FLASH: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    state.flashMode = not state.flashMode
    if state.flashMode then startFlash() end
    b.Text = state.flashMode and "⚡ 17. FLASH: ВКЛ" or "⚡ 17. FLASH: ВЫКЛ"
end)

makeBtn("🟢 18. MATRIX: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleMatrix()
    b.Text = state.matrixMode and "🟢 18. MATRIX: ВКЛ" or "🟢 18. MATRIX: ВЫКЛ"
end)

makeBtn("🌟 19. СВЕЧЕНИЕ: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleGlow()
    b.Text = state.glowMode and "🌟 19. СВЕЧЕНИЕ: ВКЛ" or "🌟 19. СВЕЧЕНИЕ: ВЫКЛ"
end)

makeBtn("📺 20. СТАТИК: ВЫКЛ", Color3.fromRGB(60, 60, 90), function(b)
    toggleStatic()
    b.Text = state.staticMode and "📺 20. СТАТИК: ВКЛ" or "📺 20. СТАТИК: ВЫКЛ"
end)

closeX.MouseButton1Click:Connect(function() panel.Visible = false end)

notify("🌈 Visual Hub 67", "20 визуальных функций")
print("[VisualHub67] Загружено.")
