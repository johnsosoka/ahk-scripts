# fp-hmm-bot

## Description

This is a particularly esoteric script which executes a few activities around saying "hmm".

**Features**
* Enter "hmm" in varying lengths
  * Ability to set maximum length.
* Enter a random thinking face, 
  * either the standard emoji `:thinking:` or a `:marine-thonk:`
  * Capability to set the percentage chance of keying this.
* Reply & React with thinking related terms at random.

You will note in the spaghetti code here that a fair bit of energy was put into making various aspects
of this random, the idea was for this script to appear to be a very persistent human.

## Usage
1. Adjust `MaximumHmmLength`, `RandomThinkingFace` and `ThinkingFacePercentChance` variables as needed.
2. Double click script to load
3. Open discord, navigate to the #hmm game channel
4. Click inside of the message box
5. Press F1 to execute the script (ESC to exit)

### Commands

| key | description |
|-----|-------------|
| `F1` | Start Execution |
| `ESC` | End Execution |

### Noteworthy Variables

| variable | description | Default Value |
|----------|-------------|---------------|
| `MaximumHmmLength` | Set the maximum length of hmm, a max of 3 would result in (at max) "hmmm" | 10 |
| `RandomThinkingFace` | If you do not want thinking faces, set to false | true |
| `ThinkingFacePercentChance` | The percent chance that the thinking face subroutine should be kicked off | 8 |
