# Black Ops 1 Strat Tester 

This is a mod for creating, testing, and learning new strategies in Call of Duty Black Ops. 

This mod is meant to be an all-encompassing mod, with loads of features and options to give yourself the loadout and map setup you need to practice your strategies.

## Installing

For those who prefer a video guide, [click here](https://www.youtube.com/watch?v=rTJs7evNRXo&ab_channel=TTS4life)

1. Install the latest version of [Game_Mod](https://github.com/Nukem9/LinkerMod/releases) for BO1 and install by dragging the zip file's contents into your root folder of BO1 (where the executable is). **Note: This will place and `iw_43.iwd` into your `main` folder, potentially overwriting your custom camos. Rename your `iw_43.iwd` to `iw_99.iwd` to not overwrite your camos!**
1. Head to the [Releases](https://github.com/5and5/BO1-StratTester/releases) page and download the latest version's zip file
1. Create a `mods` folder in the root folder of your BO1 game if not already created
1. drag the `Strat Tester` folder into your `mods` folder. 
1. Launch Black Ops using the `BO_Mods.bat` file in the root folder of your BO1 (comes with installing Game_Mod)
    - If you see the `MODS` menu option on the TV, you successfully installed Game_Mod 4 steps ago, otherwise, review the installation process and that you booted the game using the `.bat` file. Launching through Steam does not give you the `MODS` option on the TV.
1. Select `MODS` on the TV, and click on `Strat Tester`
1. Enjoy! Everytime you want to strat tester you will need to start from Step 5. Installing new versions will have you start at step 2. 

## Download Common Zombie Patch Version
### _**Note this may not contain features on the latest version.**_

[Download Version 2.3](https://www.mediafire.com/file/dn8iuwts71l42c6/BO1-Strat_Tester_Patch.zip/file)

## Current Features:

*Note* Some settings require a "Restart Level" to take effect.

### General
- 500,000 points on spawn
- Remove Perk Limit
- Perks reserved on down
- Spawn in with some, all, or no perks
- Remove out of playable area death barriers 

### HUD
- Round Timer
- Zombies remaining
- Seconds Per Horde (measured every second)
- Health Bar
- Current Zone
- Sprint meter
    - Sprint meter colors can be customized using the following commands or through the config (if you use the console commands, they are automatically written to config)
        - `/cg_sprintMeterDisabledColor 0.8 0.1 0.1 0.2` - Color of the meter when you deplete your sprint and are recharging your sprint.
        - `/cg_sprintMeterEmptyColor 0.7 0.5 -.2 0.8` - Color the bar when you are nearly out of sprint  
        - `/cg_sprintMeterFullColor 0.8 0.8 0.8 0.8` - Color of the bar typically
        - `/hud_fade_sprint 1.7` - Time it takes for the sprint meter to fade.
    - Because the sprint meter is derived from the engine, and is the only way you can measure how much stamina you have within the confines of the game, some behavior may not work as desired (e.g. The bar will fade out when your sprint has grown more than what you would've had without Stamin-Up).

### Round Settings
- Set various starting rounds
    - If you want to start on a round that is not in the options, you can do so with `/st_round_number <number>` and restarting.
- Set a delay to navigate to where you need to start the round at game start
    - You can set a custom delay by typing `/st_round_start_delay <number>`
- Toggle whether round has insta-kill like behavior or not (useful if you want to practice on rounds lower than 163)
- Set the number of zombies per horde (useful for getting accurate SPH's on maps like COTD or Moon where there are only 23 normal zombies per horde due to a persistent boss holding the 24th slot).
- Select the frequency of special rounds between every round, every 4 rounds every 5 rounds, or every 4/5 rounds (vanilla)

### Box Settings
- Allow the box to roam from a particular location
- Set a specific box location to practice hitting from

### Perks & Drops
- Choose what perks you spawn in with between all, none, or a typical high-round game perk setup
    - If setup set of perks is not to your liking, simply go with 'none' and go buy your own
- Toggle whether powerups spawn or not
- Toggle whether Carpenters, Fire Sales, or Death Machines spawn at an individual level

### Game Settings
- Enable/disable graphic content on the fly
- Enable/disbale Mule Kick on a map
- Turn on/off the power at start
- Open doors on start (this tries to keep some common high-round doors closed, so you can leave this on unless you're testing a certain strategy that requires a more unique door setup)
- Destroy all barriers on spawn 
- Give weapons needed to perform a high-round game (typically the wonder-weapon, tactical grenade, and other weapons typically used in a high round game).
- Show average amount of zombies killed by each Wunderwaffe shot (Der Riese only)

### Map Options
- Set specific windows on Five
- Force activate a specific excavator
    - You can also type `/digger tunnel6|tunnel11|biodome` to activate a specific excavator.
- Disable Astro
- Disable George Romero
- Disable nova crawlers on Kino, Moon & Five
- Disable special zombies on Shang

Missing a crucial feature for you to get better at the game? We are open to requests!

# Cheats

### List of Useful Cheats

- `/god` godmode
- `/demigod` godmode but you still get hit
- `/noclip` flying
- `/give ammo` refills ammo
- `/timescale 10` changes the speed of the game (10 is max)
- `/ai_disableSpawn 1` stops zombies from spawning
- `/fast_restart` restart map
- `/where` print "x y z" coordinates
- `/setviewpos x y z` teleport to "x y z" coordinates

### List of Useful Binds
Add to the strat tester config (Call of Duty Black Ops\players\mods\Strat Tester\config.cfg)

- `bind F1 "god"` binds godmode to F1
- `bind F2 "noclip"` binds noclip to F2
- `bind F3 "give ammo"` binds max ammo to F3
- `bind F4 "toggle timescale 5 1"` binds 5x timescale toggle to F4
- `bind F8 "give m16_gl_upgraded_zm"` binds give upgraded m16 to F8

### List of Weapon Commands (host only)
Remove the "upgraded" for none papped version

- `/give explosive_bolt_upgraded_zm` Upgraded crossbow
- `/give ray_gun_upgraded_zm` Upgraded raygun
- `/give m1911_upgraded_zm` Upgraded m1911
- `/give m16_gl_upgraded_zm` Upgraded m16
- `/give ithaca_upgraded_zm` Upgraded steakout
- `/give m14_upgraded_zm` Upgraded m14

# Contributing

To contribute to the project, you need to first clone the repo. (If you are on Windows you need somme form of git client, such as GitHub Desktop)

First, you'll want to fork and then clone the project. 

```git clone https://github.com/<your-github-user>/BO1-Strat_Tester.git```

Then, you need to make sure you have game_mod installed on your BO1 client. Put the BO1-Strat_Tester folder into a folder called `mods` in the root of your BO1 directory.

You can edit the code to implement whatever featuers you desire using your favorite editor, then testing the changes by executing `/map_restart`. Every time that command is executed, all scripts get re-compiled. For UI changes to take effect, you will need to build the FastFile for the mod. To do so, download the BO1 Mod Tools in the Tools section of your Steam Library. In the mod builder tab. Make sure the drop down menu has Strat Tester selected. Then, in Build Mod, check `Link FastFile`, then click Build Mod. You will need to reload the mod using the `MODS` option on the TV for changes to appear in the menu (Note: if you are having issues building the mod, make sure `BO1-Strat_Tester` is the name of the folder for the mod.)

When you've made your changes, submit a pull request to the repo to be reviewed/tested.

# Credits
## Direct Contributors
- TTS4life 

- 5and5 

- lveez 

- Zi0MiX 

## Others
Porterico - Initial mod for Five Windows being set

JBleezy - Reimagined/Code references
