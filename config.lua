Config = Config or {}

Config.PauseMenu = { -- Pause Menu Customization
    Enabled = true, -- Enable/disable pause menu customization
    Title = "Your Server Name",
    MapCategory = "GPS",
    GameCategory = "Take a flight",
    DisconnectSubMenu = 'Go back to the homepage',
    CloseGameSubMenu = 'Exit and go to desktop',
    InfoCategory = "Logs",
    StatisticsCategory = "Statistics",
    GalleryCategory = "Gallery",
    RockstarEditorCategory = "Rockstar Editor",
    FiveMKeysConfigCategory = "FiveM Keybinds",
}

Config.BarrierRemovals = { -- Barrier Removals
    Enabled = true, -- Enable/disable barrier removals
    Barriers = {
        -- Remove legion barriers
        {coords = vector3(206.5139, -803.2482, 29.9843), radius = 1.535, model = 307771752},
        {coords = vector3(230.9401, -816.4125, 29.3043), radius = 1.535, model = 307771752},
        {coords = vector3(230.9218, -816.153, 30.163), radius = 1.535, model = -1184516519},
        {coords = vector3(206.5139, -803.2482, 29.9843), radius = 1.535, model = -1184516519},
        -- Remove occupation ave barriers
        {coords = vector3(266.09, -349.35, 44.74), radius = 1.535, model = 242636620},
        {coords = vector3(285.28, -355.78, 45.13), radius = 1.535, model = 406416082},
    },
}

Config.SelectSit = { -- Select Sit System
    Enabled = true, -- Enable/disable the /selectsit command
    Anims = { -- animations for /selectsit command
        {dict = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_phoneputdown_idle_nowork"},
        {dict = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_jimmy"},
    }
}

Config.ClearProps = { -- Clear Stuck Props System
    Enabled = true, -- Enable/disable the /clearstuckprops command
    Cooldown = 5000, -- Cooldown in milliseconds (5000 = 5 seconds)
}

Config.AFK = { -- AFK System
    Enabled = true, -- Enable/disable the AFK system
    MaxIdleTime = 600, -- Time in seconds before a player is kicked (600 = 10 minutes)
    CheckInterval = 30, -- How often to check for AFK players in seconds (30 = 30 seconds)
    WarningTime = 540, -- Time in seconds when to send a warning before kick (540 = 9 minutes)
    WarningMessage = "You will be kicked for being AFK in %s seconds!", -- Warning message (%s will be replaced with remaining time)
    KickMessage = "You have been kicked for being AFK.", -- Kick message
    ExemptPermission = "admin", -- Permission to exempt from AFK kick (set to nil to disable)
    CountPauseMenu = true, -- Count time spent in pause menu as AFK
}

Config.Vehicle = { -- Vehicle Settings
    Enabled = true, -- Enable/disable vehicle tweaks
    
    -- Engine Configuration
    DisableAutoStart = true, -- Disable automatic engine start when entering vehicle
    DisableAutoOff = true, -- Disable automatic engine shutdown when exiting vehicle
    
    -- Helmet Configuration
    DisableHelmetArmor = true, -- Disable helmet armor bonus
    DisableBikeAndAircraftHelmets = true, -- Disable automatic helmet equipping on bikes/aircraft
    
    -- Drive-by Configuration
    DisableDriveBy = true, -- Disable drive-by shooting from vehicles
    
    -- Audio Configuration
    DisableAircraftMusic = true, -- Disable flight music in aircraft
    EnableHeliSubmix = true, -- Enable helicopter/plane radio submix effect (realistic radio effect)
    SubmixCheckInterval = 500, -- How often to check for submix changes in milliseconds
    
    -- Update Intervals
    ConfigUpdateInterval = 5000, -- How often to reapply vehicle config flags in milliseconds (5000 = 5 seconds)
}

Config.Player = { -- Player/Ped Settings
    Enabled = true, -- Enable/disable player tweaks
    
    -- Animation Configuration
    DisableRelaxedMode = true, -- Disable relaxed animations (set to false to enable relaxed mode)
    
    -- Weapon Configuration
    DisableAutoReload = true, -- Disable automatic weapon reloading when on foot
    DisableHeadshots = true, -- Disable headshot damage (makes headshots not instantly kill)
    
    -- Update Intervals
    ConfigUpdateInterval = 5000, -- How often to reapply ped config flags in milliseconds (5000 = 5 seconds)
}

Config.World = { -- World/Environment Settings
    Enabled = true, -- Enable/disable world tweaks
    
    -- Audio Configuration
    DisableDistantCopSirens = true, -- Disable distant cop car sirens
    DisableStaticEmitters = true, -- Disable specific static audio emitters
    StaticEmitters = { -- List of static emitters to disable
        "SE_DLC_Biker_Tequilala_Exterior_Emitter", -- Tequila-la exterior
        "collision_9qv4ecm", -- Tequila-la interior
    },
}

Config.Movement = { -- Movement/Parkour System
    Enabled = true, -- Enable/disable movement system
    
    -- Jump Settings
    DisableJumpFatigue = false, -- Disable jump fatigue/ragdoll (false = ragdoll enabled after X jumps)
    MaxJumpsBeforeRagdoll = 15, -- Max jumps before player ragdolls (only if DisableJumpFatigue is false)
    RagdollDuration = 5000, -- Ragdoll duration in milliseconds (5000 = 5 seconds)
    JumpCooldownTime = 1400, -- Time to reset jump counter in milliseconds
    
    -- Sprint Settings
    SprintUnlimited = false, -- Unlimited sprint (no stamina drain)
    SprintSpeedMultiplier = 1.0, -- Sprint speed multiplier (1.0 = default, 1.5 = 50% faster)
    
    -- Crawl/Prone System
    ProneEnabled = false, -- Enable prone/crawl (disabled by default, not recommended for all servers)
    ProneKey = 'Z', -- Key to toggle prone
    
    -- Movement Modifiers
    WalkSpeed = 1.0, -- Walk speed multiplier (1.0 = default)
    RunSpeed = 1.0, -- Run speed multiplier (1.0 = default)
    SwimSpeed = 1.0, -- Swim speed multiplier (1.0 = default)
    
    -- Climbing/Vaulting
    ClimbingSpeedMultiplier = 1.0, -- Climbing speed multiplier (1.0 = default)
    DisableVaulting = false, -- Disable vaulting over objects
    
    -- Camera Settings
    DisableIdleCam = true, -- Disable idle camera movement
    DisableAFKCam = true, -- Disable AFK camera
}

Config.StealthKills = { -- Stealth Kill System
    Enabled = true, -- Enable/disable stealth kill system
    Hashes = {
        "ACT_stealth_kill_a",
        "ACT_stealth_kill_weapon",
        "ACT_stealth_kill_b",
        "ACT_stealth_kill_c",
        "ACT_stealth_kill_d",
        "ACT_stealth_kill_a_gardener"
    }
}