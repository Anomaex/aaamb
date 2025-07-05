#Requires AutoHotkey v2.0


is_activate := false
is_drink_eat := false


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
    ControlSend("{s}",, game_pid)
    Sleep(3)
    ControlSend("{Left}{Right}",, game_pid)
    Sleep(3)
}


SetActivate(flag := true)
{
    if !CheckGameWindow()
        return
    
    global is_activate

    if !flag
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
Follow(flag := true, paused := false, stay_at_place := false, is_check := true)
{
    if is_check
        if !Check()
            return

    if stay_at_place
        ControlSend("{4}",, game_pid)
    else if paused
        ControlSend("{3}",, game_pid)
    else if flag
        ControlSend("{1}",, game_pid)
    else
        ControlSend("{2}",, game_pid)

    BreakFollow()
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


TargetAndInteract(is_check := true)
{
    if is_check
        if !Check()
            return
    ControlSend("{8}{Home}",, game_pid)
}


AcceptTrade(is_check := true)
{
    if is_check
        if !Check()
            return
        ControlSend("{7}",, game_pid) 
}


DrinkEat()
{
    if !Check()
        return
    global is_drink_eat := true
    Follow(, true,, false)
    Sleep(50)
    ControlSend("{End}",, game_pid)
}


ClickToMove()
{
    if Check()
        ControlSend("{5}",, game_pid)
}
