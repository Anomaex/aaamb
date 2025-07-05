#Requires AutoHotkey v2.0


switch_index := 1
windows_pids := []


MsgHandler(w_param, l_param, msg, hwnd)
{
    if w_param < 2
        return
    
    index := w_param - 1
    global windows_pids
    if windows_pids.Length != 4
        windows_pids := [0, 0, 0, 0]
    windows_pids[index] := l_param
}

OnMessage(0x5000, MsgHandler)


NextSwitchIndex()
{
    global switch_index := switch_index + 1
    if switch_index > 4
        switch_index := 1
}


SwitchWindow()
{
    global switch_index
    global windows_pids

    if windows_pids.Length != 4
    {
        windows_pids := [0, 0, 0, 0]
        Loop 4
        {
            pid := GetPidFromFile(A_Index + 1, true)
            if pid != ""
                windows_pids[A_Index] := pid
        }
    }

    if WinActive(game_pid)
        switch_index := 1 

    Loop 4
    {
        if windows_pids[switch_index] != 0
        {
            pid := "ahk_pid " . windows_pids[switch_index]
            if WinExist(pid)
            {
                WinActivate(pid)
                NextSwitchIndex()
                break
            }
            else
            {
                windows_pids[switch_index] := 0
            }
        }
        NextSwitchIndex()
    }
}


~F1::SwitchWindow()
