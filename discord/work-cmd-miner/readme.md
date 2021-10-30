# work-cmd-miner

## Description

Script to execute `/work` and related commands on loop. Can kick off a subroutine to gamble earnings.

## Usage
1. Adjust GamblingEnabled variable as needed; Set GamblingPercentChance, default is 20% chance.
2. Double click script to load
3. Open discord, navigate to the #talk-to-the-bots channel.
4. Click inside the message box
5. Press `F1` to execute the script (`ESC` to exit)

### Commands

| key | description |
|-----|-------------|
| `F1` | Start Execution |
| `END` | End Execution |

### Noteworthy Variables

| variable | description | Default Value |
|----------|-------------|---------------|
| `GamblingEnabled` | Enable if you desire gambling subroutine to be called | true |
| `GamblingPercentChance` | Percent chance that the gambling subroutine will be invoked each hour | 20 |
| `ExecuteDailyHour` | Which hour of the day should the daily multiplier be issued? |