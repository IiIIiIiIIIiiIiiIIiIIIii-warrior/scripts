_G.Version = {
    1.1,
    "Open sourced for bug fixing."
}

local Player = game:GetService'Players'.LocalPlayer
local Character = Player.Character
repeat wait()
until Character
local root = Character.HumanoidRootPart
local PlayerGui = Player:WaitForChild'PlayerGui'

local stuff = { nil, 0 }
local coords = {
    0,
    0,
    0
}

local ScreenGui = Instance.new('ScreenGui', PlayerGui)
    ScreenGui.DisplayOrder = 91
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = "Global"

local _Body = Instance.new('Frame', ScreenGui)
    _Body.BackgroundTransparency = 1
    _Body.Position = UDim2.new(.073,10,.38,-34)
    _Body.Size = UDim2.new(.187,-30,.408,-10)
    _Body.ZIndex = 3

local Border = Instance.new('ImageLabel', _Body)
    Border.BackgroundTransparency = 1
    Border.Position = UDim2.new(.099,0,.016,0)
    Border.Size = UDim2.new(.799,0,.253,0)
    Border.Image = "rbxassetid://3570695787"
    Border.ImageColor3 = Color3.fromRGB(100,100,100)
    Border.ScaleType = Enum.ScaleType.Slice
    Border.SliceCenter = Rect.new(100,100,100,100)
    Border.SliceScale = .05

local Body = Border:Clone()
    Body.Parent = Border
    Body.Position = UDim2.new(0,2,0,2)
    Body.Size = UDim2.new(1,-4,1,-4)
    Body.ImageColor3 = Color3.fromRGB(26,26,26)

local ButtonImg = Border:Clone()
    ButtonImg.AnchorPoint = Vector2.new(.5,.5)
    ButtonImg.Parent = Body
    ButtonImg.Position = UDim2.new(.497,0,.753,0)
    ButtonImg.Size = UDim2.new(.292,0,.246,0)
    ButtonImg.ImageColor3 = Color3.fromRGB(255,156,57)
    ButtonImg.SliceScale = .03

local Go = Instance.new('TextButton', ButtonImg)
    Go.BackgroundTransparency = 1
    Go.Position = UDim2.new(0,0,0,0)
    Go.Size = UDim2.new(1,0,1,0)
    Go.Font = Enum.Font.Gotham
    Go.Text = "Go"
    Go.TextColor3 = Color3.new(1,1,1)
    Go.TextSize = 16

local ButtonImg_2 = ButtonImg:Clone()
    ButtonImg_2.AnchorPoint = Vector2.new(.5,.5)
    ButtonImg_2:ClearAllChildren()
    ButtonImg_2.Parent = Body
    ButtonImg_2.Position = UDim2.new(.497,0,.322,0)
    ButtonImg_2.Size = UDim2.new(.908,0,.42,0)
    ButtonImg_2.ImageColor3 = Color3.new(0,0,0)

local Choose = Go:Clone()
    Choose.Parent = ButtonImg_2
    Choose.Text = "Select..."
    Choose.TextSize = 13
    Choose.TextColor3 = Color3.new(1,1,1)
    Choose.TextTruncate = "AtEnd"

local Border_2 = Border:Clone()
    Border_2:ClearAllChildren()
    Border_2.Parent = _Body
    Border_2.Position = UDim2.new(0,0,.29,0)
    Border_2.Size = UDim2.new(1,0,.71,0)

local Body_2 = Body:Clone()
    Body_2:ClearAllChildren()
    Body_2.Parent = Border_2

local List = Instance.new('ScrollingFrame', Body_2)
    List.BackgroundTransparency = 1
    List.Position = UDim2.new(0,0,0,0)
    List.Size = UDim2.new(1,0,1,0)
    List.CanvasSize = UDim2.new(0,0,7,0)
    List.ScrollBarImageTransparency = 1
    List.ScrollBarThickness = 0
    List.ScrollingDirection = "Y"

local Layout = Instance.new('UIGridLayout', List)
    Layout.CellPadding = UDim2.new(0,0,0,0)
    Layout.CellSize = UDim2.new(.5,0,0,30)
    Layout.FillDirection = "Horizontal"
    Layout.HorizontalAlignment = "Center"
    Layout.StartCorner = "TopLeft"
    Layout.VerticalAlignment = "Top"

local Version = Instance.new('TextLabel', ScreenGui)
    Version.Size = UDim2.new(.156,0,.061,0)
    Version.Position = UDim2.new(.252,0,.364,0)
    Version.BackgroundTransparency = 1
    Version.TextColor3 = Color3.new(1,1,1)
    Version.Font = "Gotham"
    Version.Text = string.format("%s - %s", _G.Version[1], _G.Version[2])

local Teleports = {
    ["Crim 1"] = {-229.36, 19.6377, 1593.47},
    ["Jewelry"] = {123.368, 19.6438, 1360.06},
}

function vehicle()
    wait(.033)
    for _, car in pairs(workspace.Vehicles:GetChildren()) do
        if car.Seat.PlayerName.Value == Player.Name then
            stuff[1] = car
            return
        end
    end
    local mtable = workspace.Vehicles:GetChildren()
    if #mtable == 0 then
        return
    end
    stuff[2] = stuff[2] + 1
    if stuff[2] >= #mtable then
        stuff[2] = 0
    end
    local vehc = mtable[stuff[2]]
    if vehc then
        if not vehc:FindFirstChild'TeamRestrict' then
            root.CFrame = vehc.BoundingBox.CFrame
            keypress(0x45)
            wait(.026)
            keyrelease(0x45)
            wait(.267)
            vehicle()
        end
    end
end

function teleport(x,y,z)
    stuff[1] = nil
    stuff[2] = 0
    vehicle()
    repeat wait()
    until stuff[1] ~= nil
    stuff[1]:MoveTo(Vector3.new(x,y,z))
end

Go.MouseButton1Down:Connect(function()
    teleport(coords[1], coords[2], coords[3])
end)

for k,v in pairs(Teleports) do
    local NewButton = Instance.new("TextButton", List)
        NewButton.BackgroundTransparency = 1
        NewButton.Font = Enum.Font.Gotham
        NewButton.Text = tostring(k)
        NewButton.TextColor3 = Color3.new(1,1,1)
        NewButton.TextTruncate = "AtEnd"
        NewButton.TextSize = 14
    NewButton.MouseButton1Down:Connect(function()
        Choose.Text = NewButton.Text
        coords[1] = v[1]
        coords[2] = v[2]
        coords[3] = v[3]
    end)
end

function ShowMessage(Message)
    local transparency = 1
    while (transparency > 0 and wait(.01)) do
        transparency = transparency - .01
        Message.TextTransparency = transparency
    end
    wait(3)
    while (transparency < 0 and wait(.01)) do
        transparency = transparency + .01
        Message.TextTransparency = transparency
    end
    wait(.25)
    Message:Destroy()
end

Version.TextTransparency = 1
spawn(function()
    wait(1)
    wait(ShowMessage(Version))
end)
