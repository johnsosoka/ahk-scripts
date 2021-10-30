/*
DESCRIPTION:

The script has been tested for direct message discord conversations. It should scroll up
every 5 delete attempts--this enables it to continue deleting messages; Sometimes,
if it doesn't scroll up the script begins to fail.

Version 1.0.0

USAGE:

0. Adjust MaximumHmmLength and RandomThinkingFace variables as needed.
1. Double click script to load
2. Open discord, navigate to the hmm game channel.
3. Click inside of the message box
4. Press F1 to execute the script (ESC to exit)


*/

; This value determines the maximum length of the "hmm"
global MaximumHmmLength := 15

; If you do not want an occasional thinking face, set this value to false.
global RandomThinkingFace := true


; Track iterations of main loop.
global MainLoopCount = 0

OneMinuteMilliseconds := 60000


F1::
    loop {
	
	MainLoopCount ++
	if (MainLoopCount == 2)
	{
		HmmReply()
	}
	
	; Every 15 hmmms, Take a random break between 10 - 15 minutes before continuing.
	if ( MainLoopCount == 5) 
	{
		
		OnceInAwhilSleepDuration := GenerateSleepDuration((OneMinuteMilliseconds*10),(OneMinuteMilliseconds*15))
		Sleep OnceInAwhilSleepDuration
		LoopCount = 0
	}

	SleepCountDuration := GenerateSleepDuration(OneMinuteMilliseconds, (OneMinuteMilliseconds*2))

	if (ShouldThinkFace() && RandomThinkingFace)
		{
			Send, % GenerateThinkFace()
			SendInput {Enter}
			Sleep rand
		}
	else
	{
		Send, % GenerateHmm()
	}
	
	SendInput {Enter}
	Sleep SleepCountDuration

    }
    return
	
GenerateSleepDuration(minimum, maximum) {
	Random, rand, minimum, maximum
	return rand
}

HmmReply() { 
	SendInput {tab}
	Sleep 100
	SendInput {up}
	Sleep 100
	SendInput {r}
	Sleep 100
	Send, % GenerateHmm()
}

/*

Function to generate the hmm message. 

*/
GenerateHmm() {
	mVar := "m"
	Random, amountOfMs, 2, %MaximumHmmLength%
	counterVar := 0
	retVal = hm
	while (counterVar < amountOfMs)
	{
		retVal = %retVal%%mVar%
		counterVar++
	}
	
	return retVal
	
}

GenerateThinkFace() {
	ThinkingFace := ":marinethonk:"
	Random, thinkRando, 0, 10
	if (thinkRando > 7)
	{
		ThinkingFace := ":thinking:"
	}
	
	return ThinkingFace
}

; Boolean, function to determine if we should randomly generate a thinking face
ShouldThinkFace() {
	ShouldThink := false
	; 1 in 5 odds
	Random, thinkRando, 1, 5
	if (thinkRando == 3)
	{
		ShouldThink == true
	}
	
	return ShouldThink
}

Escape::
{
MsgBox, Exiting hmm Messaging Script
ExitApp
}
