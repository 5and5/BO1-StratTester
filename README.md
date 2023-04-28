# Black Ops 1 Strat Tester 

This is a mod for creating, testing, and learning new strategies in Call of Duty Black Ops. 

This mod is meant to be an all-encompassing mod, with loads of features and options to give yourself the loadout and map setup you need to practice your strategies.

## Download Common Zombie Patch (No longer maintained)
[Download](https://www.mediafire.com/file/dn8iuwts71l42c6/BO1-Strat_Tester_Patch.zip/file)

## Current Features:

*Note* Some settings require a "Restart Level" to take effect.

### General
- 500,000 points on spawn
- Remove Perk Limit
- Perks reserved on down
- Spawn in with some, all, or no perks

### HUD
- Round Timer
- Zombies remaining
- Seconds Per Horde (measured every second)
- Health Bar
- Current Zone
- Sprint meter
    - Sprint meter colors can be customized using the following commands or through the config (if you use the console commands, they are automatically written to config)
        - `/cg_sprintMeterDisabledColor 0.8 0.1 0.1 0.2` - Color of the meter when you deplete your sprint and are recharing your sprint.
        - `/cg_sprintMeterEmptyColor 0.7 0.5 -.2 0.8` - Color the bar when you are nearly out of sprint  
        - `/cg_sprintMeterFullColor 0.8 0.8 0.8 0.8` - Color of the bar typically
        - `/hud_fade_sprint 1.7` - Time it takes for the sprint meter to fade.
    - Because the sprint meter is derived from the engine, and is the only way you can measure how much stamina you have within the confines of the game, some behavior may not work as desired (e.g. The bar will fade out when your sprint has grown more than what you would've had without Stamin-Up).

### Round Settings
- Set various starting rounds
    - If you want to start on a round that is not in the options, you can do so with `/round_number <number>` and restarting.
- Set a delay to navigate to where you need to start the round at game start
    - You can set a custom delay by typing `/round_start_delay <number>`
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

### Map Options
- Set specific windows on Five
- Force activate a specific excavator
    - You can also type `/digger tunnel6|tunnel11|biodome` to activate a specific excavator.
- Disable Astro
- Disable George Romero
- Disable nova crawlers on Kino, Moon & Five

Missing a crucial feature for you to get better at the game? We are open to requests!

# Contributing

To contribute to the project, you need to first clone the repo. (If you are on Windows you need somme form of git client, such as GitHub Desktop)

First, you'll want to fork and/or clone the project. 

```git clone https://github.com/5and5/BO1-Strat_Tester.git```

Then, you need to make sure you have game_mod installed on your BO1 client. Put the BO1-Strat_Tester folder into a folder called `mods` in the root of your BO1 directory.

You may also need to compile the mod in order to see some of the menu changes. To do so, download the BO1 Mod Tools in the Tools section of your Steam Library.

When you've made the changes, submit a pull request to the repo to be reviewed.

# Credits
## Coders
- TTS4life Programmer, maintainer
- 5and5 Programmer
- lveez Programmer

## Others
lveez - Initial mod made for practicing strats

Porterico - Initial mod for Five Windows being set

JBleezy - Reimagined/Code references
