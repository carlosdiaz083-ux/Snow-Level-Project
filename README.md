# Snow Level Project

A Godot 4 snow-themed platformer level — built as a parallel project to Hansel's castle level in Main-Project.

## Structure

```
Snow-Level-Project/
├── project.godot              # Godot project config (main scene: snow_level.tscn)
├── scenes/
│   ├── snow_level.tscn        # Main snow level scene (mirrors castle_level.tscn)
│   ├── platform_snow.tscn     # Moving/static snow platform (mirrors platform_castle.tscn)
│   ├── slime_snow.tscn        # Snow slime enemy (mirrors slime_green.tscn)
│   ├── kill_zone.tscn         # Instant-kill zone (bottomless pits, etc.)
│   ├── harm_zone.tscn         # Damage zone (spikes, ice hazards)
│   └── Items/
│       └── Checkpoint_flag.tscn
├── scripts/
│   ├── Global.gd              # Autoloaded global (checkpoints, save slots)
│   ├── game_manager.gd        # Health, lives, score, pause menu
│   ├── player.gd              # Player movement, jumping, combat
│   ├── harm_zone.gd           # Damage-on-contact logic
│   ├── kill_zone.gd           # Instant death logic
│   ├── coin.gd                # Coin pickup logic
│   ├── slime_snow.gd          # Snow slime AI (patrol back and forth)
│   └── checkpoint_flag.gd     # Checkpoint save logic
└── assets/
    └── sprites/
            ├── snow-tileset.png   # [ADD THIS] Snow/ice tileset for TileMapLayers
                    └── slime_snow.png     # [ADD THIS] Snow slime enemy sprite sheet
                    ```

                    ## Snow Theme Changes vs Castle Level

                    | Castle Level | Snow Level |
                    |---|---|
                    | Castle stone tileset | Snow/ice tileset |
                    | Warm amber background | Cool blue/white background |
                    | Slime green enemies | Snow slime enemies |
                    | Castle platforms | Snowy icy platforms |
                    | Princess NPC | (Add your snow NPC) |
                    | Necromancer boss | (Add your snow boss) |

                    ## Setup Instructions

                    1. Clone this repo and open `project.godot` in Godot 4.5+
                    2. Add your sprite assets to `assets/sprites/`:
                       - `snow-tileset.png` — your snow/ice tileset image
                          - `slime_snow.png` — snow slime sprite sheet
                          3. Paint your tilemap in the Godot editor (Background, Playground, Foreground layers)
                          4. Adjust platform and enemy positions in the snow_level scene as needed
                          5. The same player scene from Main-Project can be reused (copy `scenes/player.tscn` and all character sprites from Hansel's project)

                          ## Controls (same as castle level)

                          - **Move**: A/D or Arrow Keys
                          - **Jump**: Space
                          - **Stab**: Z
                          - **Swing**: X
                          - **Pause**: Escape
