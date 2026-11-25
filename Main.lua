if getgenv().BlackCatHubUI then
    pcall(function() getgenv().BlackCatHubUI:Destroy() end)
end

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

if writefile and makefolder and isfolder then
    if not isfolder("BlackCatHub") then makefolder("BlackCatHub") end
    if not isfolder("BlackCatHub/Saved") then makefolder("BlackCatHub/Saved") end
    if not isfolder("BlackCatHub/AutoExecFolder") then makefolder("BlackCatHub/AutoExecFolder") end
end

local savedSettings = {
    FPS = 60,
    BGColor = "0, 0, 0",
    CharcoalColor = "36, 36, 37",
    AccentColor = "255, 255, 255",
    AutoSave = true
}

if readfile and isfile and isfile("BlackCatHub/Settings.json") then
    local success, decoded = pcall(function()
        return HttpService:JSONDecode(readfile("BlackCatHub/Settings.json"))
    end)
    if success and type(decoded) == "table" then
        for k, v in pairs(decoded) do
            savedSettings[k] = v
        end
    end
end

local function saveCurrentSettings()
    if writefile and savedSettings.AutoSave then
        pcall(function()
            writefile("BlackCatHub/Settings.json", HttpService:JSONEncode(savedSettings))
        end)
    end
end

task.spawn(function()
    task.wait(2.8)
    if listfiles and readfile then
        pcall(function()
            for _, filePath in ipairs(listfiles("BlackCatHub/AutoExecFolder")) do
                local codeContent = readfile(filePath)
                if codeContent and codeContent ~= "" then
                    pcall(function()
                        local execFunc = loadstring(codeContent)
                        if execFunc then
                            execFunc()
                        end
                    end)
                end
            end
        end)
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlackCatHub"
ScreenGui.Parent = CoreGui
getgenv().BlackCatHubUI = ScreenGui

local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(0, 400, 0, 200)
IntroFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 8)
IntroCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(36, 36, 37)
IntroStroke.Thickness = 2
IntroStroke.Parent = IntroFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0.2, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BLACKCAT HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = IntroFrame

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, 0, 0, 30)
SubtitleLabel.Position = UDim2.new(0, 0, 0.38, 0)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "This executor by Sonicrzeznik | BlackCat Hub developer"
SubtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
SubtitleLabel.TextSize = 11
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.Parent = IntroFrame

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0, 320, 0, 6)
BarBackground.Position = UDim2.new(0.5, -160, 0.7, 0)
BarBackground.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = IntroFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(1, 0)
BarBgCorner.Parent = BarBackground

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBackground

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(1, 0)
BarFillCorner.Parent = BarFill

TweenService:Create(BarFill, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()

task.delay(2.6, function()
    local fadeInfo = TweenInfo.new(0.4)
    TweenService:Create(IntroFrame, fadeInfo, {Transparency = 1}):Play()
    for _, obj in ipairs(IntroFrame:GetDescendants()) do
        if obj:IsA("GuiObject") then
            pcall(function() TweenService:Create(obj, fadeInfo, {Transparency = 1}):Play() end)
        end
    end
    task.wait(0.4)
    IntroFrame:Destroy()

    local FloatingBtn = Instance.new("ImageButton")
FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
FloatingBtn.Position = UDim2.new(0, 20, 0.5, -22)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
FloatingBtn.BackgroundTransparency = 0
FloatingBtn.BorderSizePixel = 0
FloatingBtn.Image = "rbxassetid://13646695255"
FloatingBtn.ScaleType = Enum.ScaleType.Fit
FloatingBtn.Visible = false
FloatingBtn.Parent = ScreenGui
FloatingBtn.Draggable = true
local FloatingCorner = Instance.new("UICorner")
FloatingCorner.CornerRadius = UDim.new(0, 8)
FloatingCorner.Parent = FloatingBtn
        
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 680, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -340, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(36, 36, 37)
    MainStroke.Thickness = 2
    MainStroke.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 8)
    TopCorner.Parent = TopBar

    local FixBar = Instance.new("Frame")
    FixBar.Size = UDim2.new(1, 0, 0, 5)
    FixBar.Position = UDim2.new(0, 0, 1, -5)
    FixBar.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
    FixBar.BorderSizePixel = 0
    FixBar.Parent = TopBar

    local TitleMain = Instance.new("TextLabel")
    TitleMain.Size = UDim2.new(1, -60, 1, 0)
    TitleMain.Position = UDim2.new(0, 15, 0, 0)
    TitleMain.BackgroundTransparency = 1
    TitleMain.Text = "BlackCat Hub | Beta Version"
    TitleMain.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleMain.TextSize = 12
    TitleMain.Font = Enum.Font.GothamBold
    TitleMain.TextXAlignment = Enum.TextXAlignment.Left
    TitleMain.Parent = TopBar

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 24)
    MinimizeBtn.Position = UDim2.new(1, -35, 0.5, -12)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 16
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Parent = TopBar
    Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 4)

    MinimizeBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        FloatingBtn.Visible = true
    end)

    -- Sistema de arrastar e clique unificado para o botão minimizado (FloatingBtn)
    local fDragging, fDragInput, fDragStart, fStartPos

    FloatingBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            fDragging = true
            fDragStart = input.Position
            fStartPos = FloatingBtn.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then 
                    fDragging = false 
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            fDragInput = input
        end
    end)

    RunService.RenderStepped:Connect(function()
        if fDragging and fDragInput then
            local delta = fDragInput.Position - fDragStart
            FloatingBtn.Position = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y)
        end
    end)

    FloatingBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        FloatingBtn.Visible = false
    end)

    -- Sistema de arrastar unificado para a barra principal (TopBar)
    local dragging, dragInput, dragStart, startPos

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then 
                    dragging = false 
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local SideBar = Instance.new("ScrollingFrame")
    SideBar.Size = UDim2.new(0, 115, 1, -30)
    SideBar.Position = UDim2.new(0, 0, 0, 30)
    SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 16)
    SideBar.BorderSizePixel = 0
    SideBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    SideBar.ScrollBarThickness = 0
    SideBar.Parent = MainFrame

    local SideLayout = Instance.new("UIListLayout")
    SideLayout.FillDirection = Enum.FillDirection.Vertical
    SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SideLayout.Padding = UDim.new(0, 4)
    SideLayout.Parent = SideBar

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -125, 1, -40)
    ContentContainer.Position = UDim2.new(0, 120, 0, 35)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local pages = {}
    local tabButtons = {}
    local function createTab(name, order)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 38)
        tabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 16)
        tabBtn.BorderSizePixel = 0
        tabBtn.Text = name
        tabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        tabBtn.TextSize = 12
        tabBtn.Font = Enum.Font.GothamMedium
        tabBtn.LayoutOrder = order
        tabBtn.Parent = SideBar
        table.insert(tabButtons, tabBtn)

        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.ScrollBarThickness = 3
        page.Parent = ContentContainer
        pages[name] = page

        tabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(pages) do p.Visible = false end
            for _, b in ipairs(tabButtons) do b.TextColor3 = Color3.fromRGB(150, 150, 150) end
            page.Visible = true
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        return page
    end

    local tabExecutor = createTab("Executor", 1)
    local tabSaveCodes = createTab("SaveCodes", 2)
    local tabAutoExec = createTab("AutoExec", 3)
    local tabObfuscate = createTab("Obfuscate", 4)
    local tabSettings = createTab("Settings", 5)

    pages["Executor"].Visible = true
    tabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -135, 1, -25)
    textBox.Position = UDim2.new(0, 5, 0, 5)
    textBox.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    textBox.BorderSizePixel = 0
    textBox.MultiLine = true
    textBox.ClearTextOnFocus = false
    textBox.TextWrapped = true
    textBox.Text = ''
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 12
    textBox.Font = Enum.Font.Code
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.TextYAlignment = Enum.TextYAlignment.Top
    textBox.Parent = tabExecutor
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

    local execLinesLabel = Instance.new("TextLabel")
    execLinesLabel.Size = UDim2.new(1, -135, 0, 16)
    execLinesLabel.Position = UDim2.new(0, 5, 1, -18)
    execLinesLabel.BackgroundTransparency = 1
    execLinesLabel.Text = "Lines: 1"
    execLinesLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    execLinesLabel.TextSize = 11
    execLinesLabel.Font = Enum.Font.Gotham
    execLinesLabel.TextXAlignment = Enum.TextXAlignment.Left
    execLinesLabel.Parent = tabExecutor

    local codeBuffer = {}
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        local currentText = textBox.Text
        if #currentText > 3500 then
            table.insert(codeBuffer, currentText)
            textBox.Text = ""
        end
        local _, count = currentText:gsub("\n", "\n")
        execLinesLabel.Text = "Lines: " .. tostring(count + 1)
    end)

    local function createExecBtn(text, posY, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 115, 0, 32)
        btn.Position = UDim2.new(1, -120, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.Parent = tabExecutor
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    createExecBtn("Execute", 5, function()
        if textBox.Text ~= "" then table.insert(codeBuffer, textBox.Text) textBox.Text = "" end
        local fullCode = table.concat(codeBuffer, "\n")
        codeBuffer = {}
        pcall(function() loadstring(fullCode)() end)
    end)

    createExecBtn("Clear", 42, function()
        textBox.Text = ""
        codeBuffer = {}
        execLinesLabel.Text = "Lines: 1"
    end)

    local function createUploadPopup(parentTab, targetFolder, refreshCallback)
        local uploadModal = Instance.new("Frame")
        uploadModal.Size = UDim2.new(0, 320, 0, 220)
        uploadModal.Position = UDim2.new(0.5, -160, 0.5, -110)
        uploadModal.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
        uploadModal.BorderSizePixel = 0
        uploadModal.Visible = false
        uploadModal.ZIndex = 10
        uploadModal.Parent = parentTab
        Instance.new("UICorner", uploadModal).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", uploadModal).Color = Color3.fromRGB(50, 50, 55)

        local titleM = Instance.new("TextLabel")
        titleM.Size = UDim2.new(1, 0, 0, 30)
        titleM.Position = UDim2.new(0, 0, 0, 5)
        titleM.BackgroundTransparency = 1
        titleM.Text = "Upload Script"
        titleM.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleM.TextSize = 14
        titleM.Font = Enum.Font.GothamBold
        titleM.ZIndex = 10
        titleM.Parent = uploadModal

        local nameBox = Instance.new("TextBox")
        nameBox.Size = UDim2.new(1, -20, 0, 30)
        nameBox.Position = UDim2.new(0, 10, 0, 40)
        nameBox.BackgroundColor3 = Color3.fromRGB(15, 15, 16)
        nameBox.BorderSizePixel = 0
        nameBox.PlaceholderText = "Script name (e.g., my_script)"
        nameBox.Text = ""
        nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
        nameBox.TextSize = 12
        nameBox.Font = Enum.Font.Gotham
        nameBox.ZIndex = 10
        nameBox.Parent = uploadModal
        Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 4)

        local contentBox = Instance.new("TextBox")
        contentBox.Size = UDim2.new(1, -20, 0, 90)
        contentBox.Position = UDim2.new(0, 10, 0, 78)
        contentBox.BackgroundColor3 = Color3.fromRGB(15, 15, 16)
        contentBox.BorderSizePixel = 0
        contentBox.MultiLine = true
        contentBox.TextWrapped = true
        contentBox.PlaceholderText = "Paste script code here..."
        contentBox.Text = ""
        contentBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        contentBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
        contentBox.TextSize = 11
        contentBox.Font = Enum.Font.Code
        contentBox.TextYAlignment = Enum.TextYAlignment.Top
        contentBox.ZIndex = 10
        contentBox.Parent = uploadModal
        Instance.new("UICorner", contentBox).CornerRadius = UDim.new(0, 4)

        local confirmBtn = Instance.new("TextButton")
        confirmBtn.Size = UDim2.new(0, 140, 0, 28)
        confirmBtn.Position = UDim2.new(0, 10, 1, -36)
        confirmBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 60)
        confirmBtn.BorderSizePixel = 0
        confirmBtn.Text = "Save"
        confirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirmBtn.TextSize = 12
        confirmBtn.Font = Enum.Font.GothamBold
        confirmBtn.ZIndex = 10
        confirmBtn.Parent = uploadModal
        Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 4)

        local cancelBtn = Instance.new("TextButton")
        cancelBtn.Size = UDim2.new(0, 140, 0, 28)
        cancelBtn.Position = UDim2.new(1, -150, 1, -36)
        cancelBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
        cancelBtn.BorderSizePixel = 0
        cancelBtn.Text = "Cancel"
        cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        cancelBtn.TextSize = 12
        cancelBtn.Font = Enum.Font.GothamBold
        cancelBtn.ZIndex = 10
        cancelBtn.Parent = uploadModal
        Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 4)

        confirmBtn.MouseButton1Click:Connect(function()
            local sName = nameBox.Text
            local sContent = contentBox.Text
            if sName ~= "" and sContent ~= "" and writefile and makefolder then
                if not isfolder("BlackCatHub/" .. targetFolder) then makefolder("BlackCatHub/" .. targetFolder) end
                writefile("BlackCatHub/" .. targetFolder .. "/" .. sName:gsub("%.lua$", "") .. ".lua", sContent)
                uploadModal.Visible = false
                nameBox.Text = ""
                contentBox.Text = ""
                if refreshCallback then refreshCallback() end
            end
        end)

        cancelBtn.MouseButton1Click:Connect(function()
            uploadModal.Visible = false
        end)

        return uploadModal
    end

    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -75, 0, 30)
    searchBox.Position = UDim2.new(0, 5, 0, 5)
    searchBox.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    searchBox.BorderSizePixel = 0
    searchBox.PlaceholderText = "Search saved scripts..."
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    searchBox.TextSize = 12
    searchBox.Font = Enum.Font.Gotham
    searchBox.Parent = tabSaveCodes
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 4)

    local uploadSaveBtn = Instance.new("TextButton")
    uploadSaveBtn.Size = UDim2.new(0, 60, 0, 30)
    uploadSaveBtn.Position = UDim2.new(1, -65, 0, 5)
    uploadSaveBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
    uploadSaveBtn.BorderSizePixel = 0
    uploadSaveBtn.Text = "Upload"
    uploadSaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    uploadSaveBtn.TextSize = 12
    uploadSaveBtn.Font = Enum.Font.GothamBold
    uploadSaveBtn.Parent = tabSaveCodes
    Instance.new("UICorner", uploadSaveBtn).CornerRadius = UDim.new(0, 4)

    local saveListFrame = Instance.new("ScrollingFrame")
    saveListFrame.Size = UDim2.new(1, -10, 1, -45)
    saveListFrame.Position = UDim2.new(0, 5, 0, 40)
    saveListFrame.BackgroundTransparency = 1
    saveListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    saveListFrame.ScrollBarThickness = 3
    saveListFrame.Parent = tabSaveCodes

    local saveLayout = Instance.new("UIListLayout")
    saveLayout.SortOrder = Enum.SortOrder.LayoutOrder
    saveLayout.Padding = UDim.new(0, 6)
    saveLayout.Parent = saveListFrame

    local saveModal = createUploadPopup(tabSaveCodes, "Saved", function() end)
    uploadSaveBtn.MouseButton1Click:Connect(function() saveModal.Visible = true end)

    local function refreshSaveList(filter)
        for _, child in ipairs(saveListFrame:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        if listfiles then
            if not isfolder("BlackCatHub/Saved") then makefolder("BlackCatHub/Saved") end
            local files = listfiles("BlackCatHub/Saved")
            for _, filePath in ipairs(files) do
                local fileName = filePath:match("([^/]+)$"):gsub("%.lua$", "")
                if not filter or filter == "" or string.find(string.lower(fileName), string.lower(filter)) then
                    
                    local card = Instance.new("Frame")
                    card.Size = UDim2.new(1, 0, 0, 36)
                    card.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
                    card.BorderSizePixel = 0
                    card.Parent = saveListFrame
                    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 4)

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, -210, 1, 0)
                    nameLabel.Position = UDim2.new(0, 10, 0, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = fileName
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextSize = 12
                    nameLabel.Font = Enum.Font.GothamMedium
                    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                    nameLabel.Parent = card

                    local function createCardBtn(text, posX, color, callback)
                        local b = Instance.new("TextButton")
                        b.Size = UDim2.new(0, 45, 0, 26)
                        b.Position = UDim2.new(1, posX, 0.5, -13)
                        b.BackgroundColor3 = color
                        b.BorderSizePixel = 0
                        b.Text = text
                        b.TextColor3 = Color3.fromRGB(255, 255, 255)
                        b.TextSize = 10
                        b.Font = Enum.Font.GothamBold
                        b.Parent = card
                        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
                        b.MouseButton1Click:Connect(callback)
                    end

                    local codeContent = readfile(filePath)
                    createCardBtn("Exec", -200, Color3.fromRGB(40, 120, 60), function() pcall(function() loadstring(codeContent)() end) end)
                    createCardBtn("Copy", -150, Color3.fromRGB(60, 60, 65), function() if setclipboard then setclipboard(codeContent) end end)
                    createCardBtn("Edit", -100, Color3.fromRGB(120, 90, 30), function()
                        textBox.Text = codeContent
                        for _, p in pairs(pages) do p.Visible = false end
                        for _, b in ipairs(tabButtons) do b.TextColor3 = Color3.fromRGB(150, 150, 150) end
                        pages["Executor"].Visible = true
                        tabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
                    end)
                    createCardBtn("Del", -50, Color3.fromRGB(140, 40, 40), function()
                        if delfile then delfile(filePath) refreshSaveList(searchBox.Text) end
                    end)
                end
            end
            saveListFrame.CanvasSize = UDim2.new(0, 0, 0, #saveListFrame:GetChildren() * 42)
        end
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function() refreshSaveList(searchBox.Text) end)
    refreshSaveList()

    saveModal:GetPropertyChangedSignal("Visible"):Connect(function()
        if not saveModal.Visible then refreshSaveList(searchBox.Text) end
    end)

    local uploadAutoBtn = Instance.new("TextButton")
    uploadAutoBtn.Size = UDim2.new(0, 60, 0, 30)
    uploadAutoBtn.Position = UDim2.new(1, -65, 0, 5)
    uploadAutoBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
    uploadAutoBtn.BorderSizePixel = 0
    uploadAutoBtn.Text = "Upload"
    uploadAutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    uploadAutoBtn.TextSize = 12
    uploadAutoBtn.Font = Enum.Font.GothamBold
    uploadAutoBtn.Parent = tabAutoExec
    Instance.new("UICorner", uploadAutoBtn).CornerRadius = UDim.new(0, 4)

    local autoListFrame = Instance.new("ScrollingFrame")
    autoListFrame.Size = UDim2.new(1, -10, 1, -45)
    autoListFrame.Position = UDim2.new(0, 5, 0, 40)
    autoListFrame.BackgroundTransparency = 1
    autoListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    autoListFrame.ScrollBarThickness = 3
    autoListFrame.Parent = tabAutoExec

    local autoLayout = Instance.new("UIListLayout")
    autoLayout.SortOrder = Enum.SortOrder.LayoutOrder
    autoLayout.Padding = UDim.new(0, 6)
    autoLayout.Parent = autoListFrame

    local autoModal = createUploadPopup(tabAutoExec, "AutoExecFolder", function() refreshAutoList() end)
    uploadAutoBtn.MouseButton1Click:Connect(function() autoModal.Visible = true end)

    local function refreshAutoList()
        for _, child in ipairs(autoListFrame:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        if listfiles then
            if not isfolder("BlackCatHub/AutoExecFolder") then makefolder("BlackCatHub/AutoExecFolder") end
            local files = listfiles("BlackCatHub/AutoExecFolder")
            for _, filePath in ipairs(files) do
                local fileName = filePath:match("([^/]+)$"):gsub("%.lua$", "")
                
                local card = Instance.new("Frame")
                card.Size = UDim2.new(1, 0, 0, 36)
                card.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
                card.BorderSizePixel = 0
                card.Parent = autoListFrame
                Instance.new("UICorner", card).CornerRadius = UDim.new(0, 4)

                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, -210, 1, 0)
                nameLabel.Position = UDim2.new(0, 10, 0, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = fileName
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextSize = 12
                nameLabel.Font = Enum.Font.GothamMedium
                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                nameLabel.Parent = card

                local function createAutoCardBtn(text, posX, color, callback)
                    local b = Instance.new("TextButton")
                    b.Size = UDim2.new(0, 45, 0, 26)
                    b.Position = UDim2.new(1, posX, 0.5, -13)
                    b.BackgroundColor3 = color
                    b.BorderSizePixel = 0
                    b.Text = text
                    b.TextColor3 = Color3.fromRGB(255, 255, 255)
                    b.TextSize = 10
                    b.Font = Enum.Font.GothamBold
                    b.Parent = card
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
                    b.MouseButton1Click:Connect(callback)
                end

                local codeContent = readfile(filePath)
                createAutoCardBtn("Exec", -200, Color3.fromRGB(40, 120, 60), function() pcall(function() loadstring(codeContent)() end) end)
                createAutoCardBtn("Copy", -150, Color3.fromRGB(60, 60, 65), function() if setclipboard then setclipboard(codeContent) end end)
                createAutoCardBtn("Edit", -100, Color3.fromRGB(120, 90, 30), function()
                    textBox.Text = codeContent
                    for _, p in pairs(pages) do p.Visible = false end
                    for _, b in ipairs(tabButtons) do b.TextColor3 = Color3.fromRGB(150, 150, 150) end
                    pages["Executor"].Visible = true
                    tabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
                end)
                createAutoCardBtn("Del", -50, Color3.fromRGB(140, 40, 40), function()
                    if delfile then delfile(filePath) refreshAutoList() end
                end)
            end
            autoListFrame.CanvasSize = UDim2.new(0, 0, 0, #autoListFrame:GetChildren() * 42)
        end
    end

    autoModal:GetPropertyChangedSignal("Visible"):Connect(function()
        if not autoModal.Visible then refreshAutoList() end
    end)
    refreshAutoList()

    local obfBox = Instance.new("TextBox")
    obfBox.Size = UDim2.new(1, -135, 1, -25)
    obfBox.Position = UDim2.new(0, 5, 0, 5)
    obfBox.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    obfBox.BorderSizePixel = 0
    obfBox.MultiLine = true
    obfBox.ClearTextOnFocus = false
    obfBox.TextWrapped = true
    obfBox.Text = ''
    obfBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    obfBox.TextSize = 12
    obfBox.Font = Enum.Font.Code
    obfBox.TextXAlignment = Enum.TextXAlignment.Left
    obfBox.TextYAlignment = Enum.TextYAlignment.Top
    obfBox.Parent = tabObfuscate
    Instance.new("UICorner", obfBox).CornerRadius = UDim.new(0, 6)

    local linesLabel = Instance.new("TextLabel")
    linesLabel.Size = UDim2.new(1, -135, 0, 16)
    linesLabel.Position = UDim2.new(0, 5, 1, -18)
    linesLabel.BackgroundTransparency = 1
    linesLabel.Text = "Lines: 1"
    linesLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    linesLabel.TextSize = 11
    linesLabel.Font = Enum.Font.Gotham
    linesLabel.TextXAlignment = Enum.TextXAlignment.Left
    linesLabel.Parent = tabObfuscate

    local obfBuffer = {}
    obfBox:GetPropertyChangedSignal("Text"):Connect(function()
        local currentText = obfBox.Text
        if #currentText > 3500 then
            table.insert(obfBuffer, currentText)
            obfBox.Text = ""
        end
        local _, count = currentText:gsub("\n", "\n")
        linesLabel.Text = "Lines: " .. tostring(count + 1)
    end)

    local function createObfBtn(text, posY, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 115, 0, 32)
        btn.Position = UDim2.new(1, -120, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.Parent = tabObfuscate
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    createObfBtn("Obfuscate", 5, function()
        if obfBox.Text ~= "" then table.insert(obfBuffer, obfBox.Text) obfBox.Text = "" end
        local rawCode = table.concat(obfBuffer, "; ")
        obfBuffer = {}

        obfBox.Text = "Processing obfuscation in parts (Anti-Crash)..."

        task.spawn(function()
            local binaryEncoded = ""
            local chunkSize = 500
            for i = 1, #rawCode, chunkSize do
                local chunkPart = rawCode:sub(i, i + chunkSize - 1)
                for j = 1, #chunkPart do
                    local byte = chunkPart:byte(j)
                    local bin = ""
                    for b = 7, 0, -1 do
                        bin = bin .. ((bit32.band(byte, bit32.lshift(1, b)) > 0) and "1" or "0")
                    end
                    binaryEncoded = binaryEncoded .. " " .. bin
                end
                task.wait()
            end

            local obfuscatedResult = "local iI1i, I1iI = (2 + 2) * 5, function(s) return s end; " ..
                "local I_I_I = \"" .. binaryEncoded .. "\"; " ..
                "local function bExec(bData) " ..
                "    local res = {}; " ..
                "    for chunk in bData:gmatch(\"[^%s]+\") do " ..
                "        local val = 0; " ..
                "        for idx = 1, #chunk do " ..
                "            val = val * 2 + (chunk:sub(idx, idx) == \"1\" and 1 or 0); " ..
                "        end; " ..
                "        table.insert(res, string.char(val)); " ..
                "    end; " ..
                "    return table.concat(res, \"\"); " ..
                "end; " ..
                "loadstring(bExec(I_I_I))()"

            obfBox.Text = obfuscatedResult
        end)
    end)

    createObfBtn("Copy Result", 42, function()
        if setclipboard then setclipboard(obfBox.Text) end
    end)

    createObfBtn("Clear", 79, function()
        obfBox.Text = ""
        obfBuffer = {}
        linesLabel.Text = "Lines: 1"
    end)

    local settingsList = Instance.new("UIListLayout")
    settingsList.SortOrder = Enum.SortOrder.LayoutOrder
    settingsList.Padding = UDim.new(0, 8)
    settingsList.Parent = tabSettings
    tabSettings.CanvasSize = UDim2.new(0, 0, 0, 260)

    local function applyThemeChanges(bgRGB, charcoalRGB, accentRGB)
        pcall(function()
            local bgParts = {}
            for num in bgRGB:gmatch("%d+") do table.insert(bgParts, tonumber(num)) end
            local cBg = Color3.fromRGB(bgParts[1] or 0, bgParts[2] or 0, bgParts[3] or 0)

            local chParts = {}
            for num in charcoalRGB:gmatch("%d+") do table.insert(chParts, tonumber(num)) end
            local cCh = Color3.fromRGB(chParts[1] or 36, chParts[2] or 36, chParts[3] or 37)

            local acParts = {}
            for num in accentRGB:gmatch("%d+") do table.insert(acParts, tonumber(num)) end
            local cAc = Color3.fromRGB(acParts[1] or 255, acParts[2] or 255, acParts[3] or 255)

            MainFrame.BackgroundColor3 = cBg
            TopBar.BackgroundColor3 = cCh
            FixBar.BackgroundColor3 = cCh
            SideBar.BackgroundColor3 = cCh

            for _, btn in ipairs(SideBar:GetChildren()) do
                if btn:IsA("TextButton") then btn.BackgroundColor3 = cCh end
            end

            TitleMain.TextColor3 = cAc
        end)
    end

    applyThemeChanges(savedSettings.BGColor, savedSettings.CharcoalColor, savedSettings.AccentColor)
    if savedSettings.FPS then
        pcall(function()
            if setfpscap then
                setfpscap(9999)
                task.wait(0.1)
                setfpscap(savedSettings.FPS)
            end
        end)
    end

    local function createSettingRow(labelText, defaultVal, order, callback)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -5, 0, 36)
        row.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
        row.BorderSizePixel = 0
        row.LayoutOrder = order
        row.Parent = tabSettings
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.5, -10, 1, 0)
        lbl.Position = UDim2.new(0, 8, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = labelText
        lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row

        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0, 80, 0, 24)
        box.Position = UDim2.new(1, -90, 0.5, -12)
        box.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
        box.BorderSizePixel = 0
        box.Text = tostring(defaultVal)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.TextSize = 11
        box.Font = Enum.Font.Code
        box.Parent = row
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 3)

        box.FocusLost:Connect(function()
            if callback then callback(box.Text) end
        end)

        return box
    end

    createSettingRow("Target FPS", tostring(savedSettings.FPS), 1, function(val)
        local num = tonumber(val)
        if num then
            savedSettings.FPS = num
            saveCurrentSettings()
            pcall(function()
                if setfpscap then
                    setfpscap(9999)
                    task.wait(0.1)
                    setfpscap(num)
                end
            end)
        end
    end)

    createSettingRow("Background RGB", savedSettings.BGColor, 2, function(val)
        savedSettings.BGColor = val
        applyThemeChanges(val, savedSettings.CharcoalColor, savedSettings.AccentColor)
        saveCurrentSettings()
    end)

    createSettingRow("Charcoal RGB", savedSettings.CharcoalColor, 3, function(val)
        savedSettings.CharcoalColor = val
        applyThemeChanges(savedSettings.BGColor, val, savedSettings.AccentColor)
        saveCurrentSettings()
    end)

    createSettingRow("Accent RGB", savedSettings.AccentColor, 4, function(val)
        savedSettings.AccentColor = val
        applyThemeChanges(savedSettings.BGColor, savedSettings.CharcoalColor, val)
        saveCurrentSettings()
    end)

    local autoSaveRow = Instance.new("Frame")
    autoSaveRow.Size = UDim2.new(1, -5, 0, 36)
    autoSaveRow.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    autoSaveRow.BorderSizePixel = 0
    autoSaveRow.LayoutOrder = 5
    autoSaveRow.Parent = tabSettings
    Instance.new("UICorner", autoSaveRow).CornerRadius = UDim.new(0, 4)

    local autoSaveLbl = Instance.new("TextLabel")
    autoSaveLbl.Size = UDim2.new(0.7, 0, 1, 0)
    autoSaveLbl.Position = UDim2.new(0, 8, 0, 0)
    autoSaveLbl.BackgroundTransparency = 1
    autoSaveLbl.Text = "Auto Save Settings"
    autoSaveLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    autoSaveLbl.TextSize = 11
    autoSaveLbl.Font = Enum.Font.GothamMedium
    autoSaveLbl.TextXAlignment = Enum.TextXAlignment.Left
    autoSaveLbl.Parent = autoSaveRow

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 70, 0, 24)
    toggleBtn.Position = UDim2.new(1, -80, 0.5, -12)
    toggleBtn.BackgroundColor3 = savedSettings.AutoSave and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(120, 40, 40)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = savedSettings.AutoSave and "ON" or "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 11
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = autoSaveRow
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 3)

    toggleBtn.MouseButton1Click:Connect(function()
        savedSettings.AutoSave = not savedSettings.AutoSave
        toggleBtn.Text = savedSettings.AutoSave and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = savedSettings.AutoSave and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(120, 40, 40)
        saveCurrentSettings()
    end)
end)
