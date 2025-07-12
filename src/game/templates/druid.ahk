#Requires AutoHotkey v2.0


BuffTarget(special := false)
{
    if !Check()
        return

    if !special
        ControlSend("{e}",, game_pid)
    else
        ControlSend("{Ctrl down}{e}{Ctrl up}",, game_pid)
}


~F5::BuffTarget()
~^F5::BuffTarget(true)
