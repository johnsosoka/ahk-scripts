; How many message deletion attempts before scrolling
attemptsBeforeScrolling := 5

; Automatically exit the script after this many attempts.
maximumAttempts := 1500 

; (Internal) Used for counting the deleted message attempts. Gets reset every X amount of attempts.
deleteAttempts := 0

; Total deletion attempts, should never reset. Helps us to automatically exit.
totalAttempts := 0
F1::
    loop {
        SendInput {Up}
        Sleep 100
        SendInput ^a
        Sleep 100
        SendInput {Backspace}
        Sleep 100
        SendInput {Enter}
        Sleep 100
        SendInput {Enter}
        Sleep 100
        SendInput {Backspace}
        Sleep 200
		; MouseClick, left

	deleteAttempts ++
	totalAttempts++

	if deleteAttempts = %attemptsBeforeScrolling%
	{
		SendInput {WheelUp}
		deleteAttempts := 0
	}

	if totalAttempts >= %maximumAttempts%
	{
	MsgBox, Maximum Attemps Reached or Exceeded. Exiting.
	ExitApp
	}
	
    }
    return

Escape::
{
MsgBox, Exiting Discord Deleter Script
ExitApp
}