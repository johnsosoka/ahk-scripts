# discord-message-deleter

## Description

The script works for direct message discord conversations. It should scroll up every `attemptsBeforeScrolling` number 
of delete attempts which allows the script to continue deleting messages.

⚠️Sometimes, if it doesn't scroll up properly, the script begins to fail.

## Usage

1. Adjust variables as needed.
2. Double click script to load
3. Open discord, navigate to the chatroom or dm history that you wish to delete.
4. Click inside the message box
5. Press `F1` to execute the script (`ESC` to exit)
6. After script is executing, without clicking scroll over message history (This allows the script to scroll up later)

### Commands

| key | description |
|-----|-------------|
| **F1** | Start Execution |
| **ESC** | End Execution |

### Noteworthy Variables

| variable | description | Default Value |
|----------|-------------|---------------|
| `attemptsBeforeScrolling` | How many message deletion attempts before scrolling | 5 |
| `maximumAttempts` | Automatically exit the script after this many attempts. | 1500 |