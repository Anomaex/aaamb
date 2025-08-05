#Requires AutoHotkey v2.0


is_activate := false
is_drink_eat := false
is_mouse_wheel := false


CheckGameWindow()
{
    try
    {
        title := WinGetTitle("A")
        if title == "World of Warcraft"
            return true
    }
    return false
}


Check()
{
    if is_activate && CheckGameWindow()
        return true
    return false
}


BreakFollow()
{
    Sleep(2)
    ControlSend("{Left}{Right}",, game_pid)
}


SetActivate(disable := false)
{
    if !CheckGameWindow()
        return
    
    global is_activate

    if disable
        is_activate := false
    else if is_activate
        is_activate := false
    else
        is_activate := true
}


ExitGame()
{
    if Check()
        ControlSend("{-}",, game_pid)
}


UseHeartstone()
{
    if Check()
        ControlSend("{0}",, game_pid)
}


ReloadUI()
{
    if Check()
        ControlSend("{=}",, game_pid)
}


; Variables paused and stay_at_place need in different situations
Follow(is_stop := false, is_pause := false, stay_at_place := false, no_check := false)
{
    if !no_check and !Check()
        return
    if is_stop
        ControlSend("{2}",, game_pid)
    else if is_pause
        ControlSend("{3}",, game_pid)
    else if stay_at_place
        ControlSend("{4}",, game_pid)
    else
        ControlSend("{1}",, game_pid)
    BreakFollow()
}


PauseFollow()
{
    Follow(, true,, true)
}


ToggleRun()
{
    if Check()
        ControlSend("{NumLock}",, game_pid)
}


Mount()
{
    if Check()
        ControlSend("{9}",, game_pid)
}


Jump()
{
    if Check()
        ControlSend("{Space}",, game_pid)
}


TargetAndInteract(no_check := false)
{
    if !no_check and !Check()
        return
    ControlSend("{8}{Home}",, game_pid)
}


DrinkEat()
{
    if !Check()
        return
    global is_drink_eat := true
    PauseFollow()
    Sleep(50)
    ControlSend("{End}",, game_pid)
}


ClickToMove()
{
    if Check()
        ControlSend("{5}",, game_pid)
}


MouseWheel()
{
    global is_mouse_wheel
    if is_mouse_wheel
        return
    if !Check()
        return
    is_mouse_wheel := true
    TargetAndInteract(true)
    Sleep(25)
    is_mouse_wheel := false
}


ReleaseKey() {
    ControlSend("{Shift up}",, game_pid)
    Sleep(2)
    ControlSend("{Ctrl up}",, game_pid)
    Sleep(2)
    ControlSend("{Alt up}",, game_pid)
    Sleep(2)
    ControlSend("{LWin up}",, game_pid)
    Sleep(2)
    ControlSend("{s up}",, game_pid)
}

SetTimer(ReleaseKey, 10000) ; fix, some keys sometimes not UP command
