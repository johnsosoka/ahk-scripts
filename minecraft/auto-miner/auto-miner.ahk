﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


z::
    if GetKeyState("LButton") {
        Send % "{Click Up}"
    } else {
        Send % "{Click Down}"
    }
return


f1::
{
MsgBox, Exiting Minecraft Auto-miner Script
ExitApp
}


