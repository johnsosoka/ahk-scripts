F1::
    deleteRoutine()
    noSnipeRoutine()
    deleteRoutine()
    return

F2::
    MsgBox, Exiting Discord Deleter Script
    ExitApp


deleteRoutine() {
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
}

noSnipeRoutine() {
    Sleep 100
    SendInput {Enter}
    Sleep 100
    SendInput {Enter}
    Send, no snipe pls
    SendInput {Enter}
    Sleep 75
    SendInput {Enter}
    Sleep 175
}