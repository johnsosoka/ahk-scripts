/*
             _           __                  _
            | |         / /                 | |
  __ _ _   _| |_ ___   / /_      _____  _ __| | __
 / _` | | | | __/ _ \ / /\ \ /\ / / _ \| '__| |/ /
| (_| | |_| | || (_) / /  \ V  V / (_) | |  |   <
 \__,_|\__,_|\__\___/_/    \_/\_/ \___/|_|  |_|\_\

Version 1.0.2

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


CHANGELOG:

1.0.3:
    * Working Hours Introduced (bot will only execute work command during these hours)

1.0.2:
    * Gambling percent chance can be set in script config now.
    * updated readme
*/



global GamblingEnabled := true
global GamblingPercentChance := 5
global AccountForTimeDrift = := true

; Which Hour should Daily command be invoked (Default 8pm, 20)
global ExecuteDailyHour = 20

; Work Hours, Start
global startWorkHours = 10
global endWorkHours = 18

; Internally Used Vars Below
OneMinuteMilliseconds := 60000
global TotalHoursExecuted = 0
global DailyHoursCount = 0
global HasIssuedDailyToday = false


F1::
    loop {
	; Loop executes about every 60 to 65 minutes.
	; We will occasionally correct for the time drift by randomly waiting to execute on the hour.

	VariableSleepDuration := GenerateSleepDuration(OneMinuteMilliseconds*60, (OneMinuteMilliseconds*65))

	if (ShouldWork())
	{
	    DoWork()
	}
	
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
	} else if (DailyHoursCount >= 24) {
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

; Method to assist work hours
ShouldWork() {
    shouldWork := false

    if (A_Hour >= startWorkHours and A_Hour <= endWorkHours) {
        shouldWork := true
    }

    return shouldWork
}

; Determine if we should gamble. Utilizes GamblingPercentChance to determine chance of issuing command.
; Any value >= 100 = will determine that script should gamble.
ShouldGamble() {
    ShouldDo := false
    if (GamblingEnabled = false) {
        return ShouldDo
    }

    ; Gamble based on percent chance.
    Random, gambleRando, 1, 100
    if (gambleRando <= GamblingPercentChance) {
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

