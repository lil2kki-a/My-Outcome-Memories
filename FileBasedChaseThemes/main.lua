print("[FileBasedChaseThemes] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end
---mdfmbkmbmgkofgmobmokmfg
local function tryReplaceThemessss()
    for _, Song in ipairs(game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.ChaseThemes:GetDescendants()) do 
        if not Song:IsA("Sound") then continue end
        -- ChaseThemes.2011x.Default.NormalChase
        local folder = "ChaseThemes" .. ("/./"):rep(math.random(1, 30))
        .. Song.Parent.Parent.Name .. "/" -- 2011x
        .. Song.Parent.Name .. "/" -- Default
        .. Song.Name -- NormalChase
        --print(folder) 
        if not isfolder(folder) then 
            print("[FileBasedChaseThemes] Created", folder, "dir (check it at workspace)") 
            makefolder(folder) 
            continue
        end
        -- STOP USING CACHE PLEASE AAHHHHHH
        listfiles(("./"):rep(math.random(1, 30))) listfiles(("./"):rep(math.random(1, 30))) listfiles(("./"):rep(math.random(1, 30)))
        listfiles(("./"):rep(math.random(1, 30))) listfiles(("./"):rep(math.random(1, 30))) listfiles(("./"):rep(math.random(1, 30)))
        for _, file in ipairs(listfiles(("./"):rep(math.random(1, 30))..folder)) do
            --print(file)
            Song.SoundId = getcustomasset(("./"):rep(math.random(1, 30))..file)
            Song.PlaybackRegion = NumberRange.new(0, 0)
            Song.LoopRegion = NumberRange.new(0, 0)
            Song.PlaybackSpeed = 1 -- OM 0.1a special
            Song:SetAttribute("Eliminated", nil) -- no time pos jump on kill pls
            warn("[FileBasedChaseThemes] Replaced", Song:GetFullName(), "by", file)
        end
    end
end

_G.FileBasedChaseThemes_MyCharacterConn = _G.FileBasedChaseThemes_MyCharacterConn or nil
if _G.FileBasedChaseThemes_MyCharacterConn then
    _G.FileBasedChaseThemes_MyCharacterConn:Disconnect()
    _G.FileBasedChaseThemes_MyCharacterConn = nil
    print("[FileBasedChaseThemes] Previous FileBasedChaseThemes_MyCharacterConn Disconnected")
end
_G.FileBasedChaseThemes_MyCharacterConn = game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    tryReplaceThemessss()
end)

tryReplaceThemessss()
