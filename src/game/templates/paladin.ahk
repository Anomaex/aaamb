#Requires AutoHotkey v2.0


is_wheel := false


Attack()
{
    if is_wheel || !Check() 
        return

    global is_wheel
    is_wheel := true
    TargetAndInteract(false)
    Sleep(100)
    is_wheel := false
}


GetSealOrDispel(color)
{
    is_dispel := color == 4294901760 ? true : false ; red
    if is_dispel
    {
        return 1
    }
    else
    {
        is_seal := color == 4278190335 ? true : false ; blue
        if is_seal
            return 2
    }
    return 0
}


Seal()
{
    ControlSend("{q}",, game_pid)
}


Dispel()
{
    ControlSend("{v}",, game_pid)
}


GetPartyDispel(color)
{
    if color == 4294902015 ; purple, Tank
        return 1
    else if color == 4278190335 ; blue, Damager f / Healer
        return 2
    else if color == 4294967040 ; yellow, Damager s / f
        return 3
    else if color == 4294901760 ; red, Damager t / s
        return 4
    return 0
}


PartyDispel(index)
{
    if index == 1
        ControlSend("{h}",, game_pid)
    else if index == 2
        ControlSend("{Shift down}{h}{Shift up}",, game_pid)
    else if index == 3
        ControlSend("{Ctrl down}{h}{Ctrl up}",, game_pid)
    else if index == 4
        ControlSend("{Alt down}{h}{Alt up}",, game_pid)
}


BuffTarget(is_small_bless := false)
{
    if !Check()
        return

    if !is_small_bless
        ControlSend("{e}",, game_pid)
    else
        ControlSend("{Ctrl down}{e}{Ctrl up}",, game_pid)
}


ReleaseKey() {
    Sleep(3)
    ControlSend("{Shift up}",, game_pid)
    Sleep(3)
    ControlSend("{Ctrl up}",, game_pid)
    Sleep(3)
    ControlSend("{Alt up}",, game_pid)
    Sleep(3)
}

SetTimer(ReleaseKey, 10000) ; fix, some keys sometimes not UP command


~WheelUp::Attack()
~WheelDown::Attack()

~F5::BuffTarget()
~^F5::BuffTarget(true)
