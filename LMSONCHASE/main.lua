print("[LMSONCHASE] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

local function tryReplaceThemes(Song)
    if not Song:IsA("Sound") then return end
    local path = Song:GetFullName()
    if path:find("Chases.LastLifeChase") or path:find("Chases.NormalChase") then
        local c = game.Players.LocalPlayer.Character:GetAttribute("Character")
        local solo = game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.SoloTheme:FindFirstChild(c.."Solo")
        if solo then
            Song.SoundId = solo.SoundId
            Song.PlaybackRegion = NumberRange.new(0, 0)
            Song.LoopRegion = NumberRange.new(0, 0)
        end
    end
end

_G.LMSONCHASE_SongAssetsConn = _G.LMSONCHASE_SongAssetsConn or nil
if _G.LMSONCHASE_SongAssetsConn then
    _G.LMSONCHASE_SongAssetsConn:Disconnect()
    _G.LMSONCHASE_SongAssetsConn = nil
    print("Previous LMSONCHASE_SongAssetsConn connection destroyed")
end
_G.LMSONCHASE_SongAssetsConn = workspace.Assets.Songs.DescendantAdded:Connect(function(Song) tryReplaceThemes(Song) end)

_G.LMSONCHASE_MyCharacterConn = _G.LMSONCHASE_MyCharacterConn or nil
if _G.LMSONCHASE_MyCharacterConn then
    _G.LMSONCHASE_MyCharacterConn:Disconnect()
    _G.LMSONCHASE_MyCharacterConn = nil
    print("Previous LMSONCHASE_MyCharacterConn connection destroyed")
end
_G.LMSONCHASE_MyCharacterConn = game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    for _, Song in ipairs(workspace.Assets.Songs:GetDescendants()) do tryReplaceThemes(Song) end
end)

for _, Song in ipairs(workspace.Assets.Songs:GetDescendants()) do tryReplaceThemes(Song) end
