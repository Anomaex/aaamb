#Requires AutoHotkey v2.0
#SingleInstance Off

#include "../config.ahk"
#include "file_handler.ahk"


game_pid := ""
game_hwnd := ""


InitSwitchWindow()
{

    if game_role == 1
        return
        
    pid := GetPidFromFile(1, false)
    if pid != "" && ProcessExist(pid)
    {
        DetectHiddenWindows(true)
        raw_pid := StrReplace(game_pid, "ahk_pid ")
        SendMessage(0x5000, game_role, raw_pid,, "ahk_pid " . pid)
    }
}


InitWindow()
{
    old_ahk_pid := GetPidFromFile(game_role, false)
    if old_ahk_pid != "" && ProcessExist(old_ahk_pid)
        ProcessClose(old_ahk_pid)

    ahk_pid := WinGetPID(A_ScriptHwnd)
    WritePidToFile(game_role, ahk_pid)

    RunGame()
}


RunGame()
{
    global game_pid
    global game_hwnd

    old_game_pid := "ahk_pid " . GetPidFromFile(game_role, true)
    if WinExist(old_game_pid)
    {
        game_pid := old_game_pid
        game_hwnd := WinGetID(game_pid)
    }
    else
    {
        if game_role == 1
            Run(main_game_path_to_exe,,, &pid)
        else
            Run(multibox_game_path_to_exe,,, &pid)

        game_pid := "ahk_pid " . pid
        WinWait(game_pid)
        game_hwnd := WinGetID(game_pid)

        WritePidToFile(game_role, pid, true)

        SetTimer(InitGameLogin, -1750)
    }


    InitSwitchWindow()    

    SetTimer(CheckWindow, 2500)
}


CheckWindow()
{
    if !WinExist(game_pid)
        ExitApp()
}


; Initialize program
InitWindow()
