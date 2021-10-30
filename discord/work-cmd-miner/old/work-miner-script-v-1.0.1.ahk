/*
             _           __                  _
            | |         / /                 | |
  __ _ _   _| |_ ___   / /_      _____  _ __| | __
 / _` | | | | __/ _ \ / /\ \ /\ / / _ \| '__| |/ /
| (_| | |_| | || (_) / /  \ V  V / (_) | |  |   <
 \__,_|\__,_|\__\___/_/    \_/\_/ \___/|_|  |_|\_\

Version 1.0.1

DESCRIPTION:
------------
This Script will work for you by issuing the /work command roughly every hour. It is fully customizable and executes
tasks with built-in variability--In other words, it attempts to behave like a very consistent human rather than a bot.

Options:
--------

Commands:

F1 - Execute Script (begin main loop, ensure cursor in discord)
ESC - Exit Script


USAGE:
-----------
0. Adjust ShouldGamble variable as needed. (True means it will gamble 20% of the time)
1. Double click script to load
2. Open discord, navigate to the #talk-to-the-bots channel.
3. Click inside of the message box
4. Press F1 to execute the script (ESC to exit)
*/


OneMinuteMilliseconds := 60000
global TotalHoursExecuted = 0
global GamblingEnabled := true
global AccountForTimeDrift = := true
global DailyHoursCount = 0
global HasIssuedDailyToday = false
; Which Hour should Daily command be invoked (Default 8pm, 20)
global ExecuteDailyHour = 20

F1::
    loop {
	; Loop executes about every 60 to 65 minutes.
	; We will occasionally correct for the time drift by randomly waiting to execute on the hour.

	VariableSleepDuration := GenerateSleepDuration(OneMinuteMilliseconds*60, (OneMinuteMilliseconds*65))
	DoWork()
	
	; Execute Daily command if we haven't and if it's the correct hour.
	if (ShouldDaily())
	{
		DoDaily()
	}
	
	if (ShouldGamble())
	{
		DoGamble()
	}
	


    ; FAILSAFE: Made it 24 iterations without Daily being issued somehow. Issue command and reset.
    if (DailyHoursCount = 24 and HasIssuedDailyToday = false) {

		DoDaily()
		; Reset since failsafe block issued daily.
		ResetDailyStats()
	} else {
		; Reset.
		ResetDailyStats()
	}

	TotalHoursExecuted ++
    DailyHoursCount++
	
	; Wait between 60-65 minutes
	Sleep VariableSleepDuration

    ; Wait a little longer on occasion if we should randomly account for time drift.
	if (ShouldAccountForTimeDrift()) {
	    DoAccountForTimeDrift()
	}

    }
    return

GenerateSleepDuration(minimum, maximum) {
	Random, rand, minimum, maximum
	return rand
}

; Method to determine if we should issue the daily command
ShouldDaily() {
    shouldDaily := false

    if (A_Hour = ExecuteDailyHour or A_Hour = ExecuteDailyHour + 1) {
        if (HasIssuedDailyToday = false) {
            shouldDaily := true
        }
    }

    return shouldDaily
}


; Determine if we should gamble. Currently 20% odds of bot gambling.
ShouldGamble() {
    ShouldDo := false
    if (GamblingEnabled = false) {
        return ShouldDo
    }

    ; 1 in 5 odds
    Random, gambleRando, 1, 5
    if (gambleRando = 3) {
        ShouldDo := true
    }

    return ShouldDo
}

/*
 Returns boolean. Determines if we should account for time drift.
 Conditions:
     * AccountForTimeDrift = true
     * 1 in 24 chance of executing
*/
ShouldAccountForTimeDrift() {
    ShouldAccount := false
    if (AccountForTimeDrift = false) {
        return ShouldAccount
    }

    Random, RandomExecutionHour, 1, 24
    if (A_Hour = RandomExecutionHour) {
        ShouldAccount := true
    }

    return ShouldAccount
}


; Function that occasionally delays execution so that we execute on top of the hour to account for time drift with
; variable execution (Every 60 to 65 minutes)
DoAccountForTimeDrift() {
    ; Duration required to wait in order for next execution to be on 00
    MinutesRequiredToWait := 60 - A_Min
    Sleep OneMinuteMilliseconds*MinutesRequiredToWait
}

; Function for Executing the Work Command
DoWork() {
	Send, % "/work"
	SendInput {Enter}
	Sleep 200
	SendInput {Enter}
	sleep 350
	; Final enter should be unnecessary, trying to understand the Gamble bug traffic jam
	SendInput {Enter} 
}

; Function for Executing the Daily Command.
DoDaily() {

	; Only execute if this hasn't run today.
	if (HasIssuedDailyToday = false) {
		Send, % "/daily"
		Sleep 150
		SendInput {Enter}
		Sleep 150
		SendInput {Enter}
		Sleep 150
		SendInput {Enter}
		
		; Prevent superfluous re-execution
		HasIssuedDailyToday := true
	}

}

ResetDailyStats() {
	DailyHoursCount := 0
	HasIssuedDailyToday := false
}

; Gambling Function.
DoGamble() {
    Send, % "/dice"
	sleep 350
	Send, % " 240"
	SendInput {Tab}
	sleep 75
	SendInput {Enter}
	sleep 75
	SendInput {Enter}
}

Escape::
{
MsgBox, Exiting work script I ran for %TotalHoursExecuted% hours
ExitApp
}

