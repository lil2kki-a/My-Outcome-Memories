print("[FileBasedSoloThemes] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

-- Swaps default solo round music with your local .mp3 files from executor workspace. 
-- Auto-restores original audio if a file got removed, 
-- stops tracks on intermission (universal bugfix btw), 
-- and lets you set custom ending times.

local SoloThemes = game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.SoloTheme

_G.FileBasedSoloThemesGameTimeConn = _G.FileBasedSoloThemesGameTimeConn or nil
if _G.FileBasedSoloThemesGameTimeConn then
	_G.FileBasedSoloThemesGameTimeConn:Disconnect()
	_G.FileBasedSoloThemesGameTimeConn = nil
	print("[FileBasedSoloThemes] Previous FileBasedSoloThemesGameTimeConn was disconnected")
end
_G.FileBasedSoloThemesGameTimeConn = workspace:WaitForChild("GameProperties"):WaitForChild("Time").Changed:Connect(function(Property)
    -- print("Time", Property)
    for _, SoloTheme in ipairs(SoloThemes:GetDescendants()) do
        if not SoloTheme:IsA("Sound") then continue end
        if not isfile(SoloTheme.Name .. ".mp3") then
            if SoloTheme:GetAttribute("ReplacedSoundId") then 
                print(
                    "[FileBasedSoloThemes]", SoloTheme.Name, "was restored! (lost file)\n",
                    SoloTheme.SoundId, "->", SoloTheme:GetAttribute("ReplacedSoundId")
                )
                SoloTheme.SoundId = SoloTheme:GetAttribute("ReplacedSoundId")
                SoloTheme:SetAttribute("ReplacedSoundId", nil) -- forget org id
            end
            continue
        end
        local OldSoundId = SoloTheme.SoundId
        SoloTheme.SoundId = getcustomasset(SoloTheme.Name .. ".mp3")
        if OldSoundId ~= SoloTheme.SoundId then 
            SoloTheme:SetAttribute("ReplacedSoundId", OldSoundId)
            print(
                "[FileBasedSoloThemes]", SoloTheme.Name, "was replaced!\n", 
                SoloTheme:GetAttribute("ReplacedSoundId"), "->", SoloTheme.SoundId
            ) 
        end
	end
end)

_G.FileBasedSoloThemesGameStateConn = _G.FileBasedSoloThemesGameStateConn or nil
if _G.FileBasedSoloThemesGameStateConn then
	_G.FileBasedSoloThemesGameStateConn:Disconnect()
	_G.FileBasedSoloThemesGameStateConn = nil
	print("[FileBasedSoloThemes] Previous FileBasedSoloThemesGameStateConn was disconnected")
end
_G.FileBasedSoloThemesGameStateConn = workspace:WaitForChild("GameProperties"):WaitForChild("State").Changed:Connect(function(State)
    -- print("State", State)
    if State == "RE" then
        local PlayingSoloTheme = nil
        for _, SoloTheme in ipairs(SoloThemes:GetDescendants()) do
            if not SoloTheme:IsA("Sound") then continue end
            if not SoloTheme.IsPlaying then continue end
            PlayingSoloTheme = SoloTheme
            if not isfile(SoloTheme.Name .. ".txt") then continue end
            SoloTheme.TimePosition = tonumber(readfile(SoloTheme.Name .. ".txt"))
            print("[FileBasedSoloThemes] Setting TimePosition of", SoloTheme.Name, "by the .txt file... ("..SoloTheme.TimePosition..")")
            return
        end
        if PlayingSoloTheme then print("[FileBasedSoloThemes] No special ending time position found... ("..PlayingSoloTheme.Name..".txt with number in seconds)") end
    end
    if State == "SEC" or State == "INT" then -- stop all SoloThemes on interm or sel
        for _, SoloTheme in ipairs(SoloThemes:GetDescendants()) do
            if not SoloTheme:IsA("Sound") then continue end
            SoloTheme:Stop()
        end
    end
end)
