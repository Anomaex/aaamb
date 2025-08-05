#Requires AutoHotkey v2.0


BuffTarget()
{
    if Check()
        ControlSend("{F8}",, game_pid)
}


~F5::BuffTarget()
