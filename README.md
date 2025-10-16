# TMC Additions

Additional bits and bobs for TMC Framework

## Features

This resource provides a collection of modular features that can be individually enabled or disabled through the config file.

### 1. **Pause Menu Customization** (`Config.PauseMenu`)
- Customize the FiveM pause menu text
- Change menu categories and labels
- **File:** `client/pausemenu.lua`

### 2. **Barrier Removals** (`Config.BarrierRemovals`)
- Remove specific map barriers/objects
- Useful for removing unwanted props from the map
- **File:** `client/barriers.lua`

### 3. **Select Sit System** (`Config.SelectSit`)
- Allows players to place and sit with custom animations
- Command: `/selectsit [animation_id]`
- Interactive placement with rotation
- **File:** `client/selectsit.lua`

### 4. **Clear Stuck Props** (`Config.ClearProps`)
- Remove props that get stuck to the player
- Command: `/clearstuckprops`
- Built-in cooldown system
- **File:** `client/clearprops.lua`

### 5. **AFK System** (`Config.AFK`)
- Automatically kick players for being AFK
- Configurable warning and kick times
- Admin exemption support
- Admin command: `/afkcheck` (check all AFK players)
- **Files:** `client/afk.lua`, `server/afk.lua`

### 6. **Vehicle Settings** (`Config.Vehicle`)
- Vehicle-specific behavior tweaks
- Disable auto engine start/stop
- Control helmet behavior on bikes/aircraft
- Disable drive-by shooting
- Audio enhancements (helicopter/plane radio submix, disable flight music)
- **File:** `client/vehicle.lua`

**Features:**
- **Engine Control:** Disable automatic engine start/stop
- **Helmet Control:** Disable automatic helmet equipping and armor bonus
- **Drive-by Control:** Disable drive-by shooting from vehicles
- **Audio:** Realistic helicopter/plane radio effects, disable flight music

### 7. **Player/Ped Settings** (`Config.Player`)
- Player character behavior tweaks
- Control relaxed animations
- Weapon settings (auto-reload, headshots)
- **File:** `client/playerped.lua`

**Features:**
- **Animation Control:** Enable/disable relaxed animations
- **Weapon Tweaks:** Disable auto-reload and instant headshot kills
- **Combat Balance:** Make combat more balanced by disabling one-shot headshots

### 8. **World/Environment Settings** (`Config.World`)
- World audio and environment tweaks
- Disable unwanted ambient sounds
- Control static audio emitters
- **File:** `client/world.lua`

**Features:**
- **Audio Control:** Disable distant cop sirens
- **Static Emitters:** Disable annoying static audio sources (like Tequila-la music)

### 9. **Movement/Parkour System** (`Config.Movement`)
- Enhanced player movement features
- Jump fatigue and ragdoll system
- Sprint and movement speed customization
- Optional prone/crawl system
- **File:** `client/movement.lua`
- **Note:** Crouch and manual ragdoll are built into the framework and not included here

**Features:**
- **Jump System:** Configurable jump fatigue (ragdoll after X jumps)
- **Sprint Control:** Unlimited sprint or custom sprint speed
- **Movement Speeds:** Customize walk, run, swim, and climb speeds
- **Prone/Crawl:** Optional prone system (disabled by default)
- **Camera Control:** Disable idle and AFK camera movements
- **Vaulting Control:** Optionally disable vaulting

**No Key Bindings Required** - Jump fatigue is automatic, crouch/ragdoll are in the framework

## Configuration

All features can be configured in `config.lua`. Each module has its own config section:

```lua
Config.PauseMenu.Enabled = true/false
Config.BarrierRemovals.Enabled = true/false
Config.SelectSit.Enabled = true/false
Config.ClearProps.Enabled = true/false
Config.AFK.Enabled = true/false
Config.Vehicle.Enabled = true/false
Config.Player.Enabled = true/false
Config.World.Enabled = true/false
Config.Movement.Enabled = true/false
```

### Example Configuration

```lua
-- Pause Menu
Config.PauseMenu = {
    Enabled = true,
    Title = "Your Server Name",
    -- ... other settings
}

-- AFK System
Config.AFK = {
    Enabled = true,
    MaxIdleTime = 600, -- 10 minutes
    WarningTime = 540, -- 9 minutes (1 minute before kick)
    -- ... other settings
}

-- Vehicle Settings
Config.Vehicle = {
    Enabled = true,
    DisableAutoStart = true, -- Disable auto engine start
    EnableHeliSubmix = true, -- Enable realistic heli/plane radio effect
    DisableDriveBy = true, -- Disable drive-by shooting
    -- ... other settings
}

-- Player Settings
Config.Player = {
    Enabled = true,
    DisableHeadshots = true, -- Disable instant headshot kills
    DisableAutoReload = true, -- Disable automatic weapon reloading
    -- ... other settings
}

-- World Settings
Config.World = {
    Enabled = true,
    DisableDistantCopSirens = true, -- Disable cop sirens
    DisableStaticEmitters = true, -- Disable annoying ambient sounds
    -- ... other settings
}

-- Movement System
Config.Movement = {
    Enabled = true,
    DisableJumpFatigue = false, -- Enable jump fatigue
    MaxJumpsBeforeRagdoll = 15, -- Jump fatigue limit
    SprintUnlimited = false, -- Unlimited sprint
    ProneEnabled = false, -- Enable prone/crawl
    -- ... other settings
}
```

## Installation

1. Place the resource in your resources folder
2. Add `ensure tmc-additions` to your server.cfg
3. Configure the features you want in `config.lua`
4. Restart your server

## Commands

| Command | Description | Permission |
|---------|-------------|------------|
| `/selectsit [id]` | Place and sit with a custom animation | All Players |
| `/clearstuckprops` | Clear props stuck to your character | All Players |
| `/afkcheck` | View all AFK players and their idle times | Admin |

## Exports

### Client Exports

**Clear Props:**
```lua
exports['tmc-additions']:ClearStuckProps()
```

**AFK System:**
```lua
local idleTime = exports['tmc-additions']:GetIdleTime() -- Get idle time in seconds
```

**Movement System:**
```lua
local isProne = exports['tmc-additions']:IsProne() -- Check if player is prone
local jumpCount = exports['tmc-additions']:GetJumpCount() -- Get current jump count
```

### Server Exports

**AFK System:**
```lua
local idleTime = exports['tmc-additions']:GetPlayerIdleTime(source) -- Get player's idle time
exports['tmc-additions']:ResetPlayerAFK(source) -- Reset player's AFK status
```

## Dependencies

- `core` (TMC Framework)

## File Structure

```
tmc-additions/
├── client/
│   ├── main.lua          # Main file (now just a reference)
│   ├── pausemenu.lua     # Pause menu customization
│   ├── barriers.lua      # Barrier removals
│   ├── selectsit.lua     # Select sit system
│   ├── clearprops.lua    # Clear stuck props
│   ├── afk.lua           # AFK detection (client)
│   ├── vehicle.lua       # Vehicle-specific settings
│   ├── playerped.lua     # Player/ped settings
│   ├── world.lua         # World/environment settings
│   ├── movement.lua      # Movement/parkour system
│   └── player.lua        # (existing file)
├── server/
│   ├── main.lua          # Server main file
│   └── afk.lua           # AFK management (server)
├── config.lua            # All configuration settings
└── fxmanifest.lua        # Resource manifest
```

## Modular Design

Each feature is designed to be completely independent:
- Enable/disable any feature without affecting others
- Each feature has its own file for easy maintenance
- Clean separation of concerns
- No dependencies between features

## Support

For issues or questions, contact the me in my discord.
