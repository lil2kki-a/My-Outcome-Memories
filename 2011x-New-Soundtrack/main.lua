print("[2011x-New-Soundtrack] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

local function loadCustomAsset(url, filename)
    if not isfile(filename) then
        print("[2011x-New-Soundtrack] Downloading", filename.."...")
        writefile(filename, game:HttpGet(url))
    end
    return getcustomasset(filename)
end

function prepare(sound)
    sound.PlaybackRegion = NumberRange.new(0, 0)
    sound.LoopRegion = NumberRange.new(0, 0)
    sound.PlaybackSpeed = 1 -- OM 0.1a special
    sound:SetAttribute("Eliminated", nil) -- no time pos jump on kill pls
    return sound
end

local themes = game:GetService("ReplicatedStorage"):FindFirstChild("ChaseThemes", true)
:FindFirstChild("2011x", true)

prepare(themes.miku.Rage).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."miku.Rage.mp3", "cache/lil2kki/2011x-New-Soundtrack/miku.Rage.mp3"
)

prepare(themes.Default.TerrorRadius).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."Default.TerrorRadius.mp3", "cache/lil2kki/2011x-New-Soundtrack/Default.TerrorRadius.mp3"
)

prepare(themes.Default.NormalChase).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."Default.NormalChase.mp3", "cache/lil2kki/2011x-New-Soundtrack/Default.NormalChase.mp3"
)

prepare(themes.Default.LastLifeChase).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."Default.LastLifeChase.mp3", "cache/lil2kki/2011x-New-Soundtrack/Default.LastLifeChase.mp3"
)

prepare(themes.RETRO.TerrorRadius).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."RETRO.TerrorRadius.mp3", "cache/lil2kki/2011x-New-Soundtrack/RETRO.TerrorRadius.mp3"
)
prepare(themes.RETRO.NormalChase).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."RETRO.NormalChase.mp3", "cache/lil2kki/2011x-New-Soundtrack/RETRO.NormalChase.mp3"
)
prepare(themes.RETRO.LastLifeChase).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."RETRO.LastLifeChase.mp3", "cache/lil2kki/2011x-New-Soundtrack/RETRO.LastLifeChase.mp3"
)
prepare(themes.RETRO.Rage).SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/2011x-New-Soundtrack/assets/"
    .."RETRO.Rage.mp3", "cache/lil2kki/2011x-New-Soundtrack/RETRO.Rage.mp3"
)

print("[2011x-New-Soundtrack] New sounds are ready for next round!")
