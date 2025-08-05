#Requires AutoHotkey v2.0
#NoTrayIcon

#include "../config.ahk"


RunTank()
{
    if accounts[1].Length > 0
    {
        Run A_ScriptDir "/game/templates/paladin_tank_start.ahk"
        Sleep(500)
    }
}


RunDamager(index)
{
    if accounts[index + 2].Length > 0
    {
        Run A_ScriptDir "/game/templates/paladin_damager_start.ahk " . index
        Sleep(500)
    }
}


RunHealer()
{
    if accounts[2].Length > 1
    {
        template := accounts[2][3]
        if template == "druid"
            Run A_ScriptDir "/game/templates/druid_healer_start.ahk"
        Sleep(500)
    }
}


RunAll()
{
    RunTank()
    Loop 3
        RunDamager(A_Index)
    RunHealer()
}


InitMain()
{
    run_gui := Gui("+AlwaysOnTop", "AAAMB - World of Warcraft 3.3.5a MultiBox")
    run_gui.Add("Text", "h7") ; vertical space
    run_gui.Add("Button", "w175", "Run ALL").OnEvent("Click", (*) => RunAll())
    run_gui.Add("Text", "h7")
    run_gui.Add("Button", "w175", "Run Tank ONLY").OnEvent("Click", (*) => RunTank())
    run_gui.Add("Text", "h7")
    run_gui.Add("Button", "w175", "Run Healer ONLY").OnEvent("Click", (*) => RunHealer())
    run_gui.Add("Text", "h7")
    run_gui.Add("Button", "w175", "Run Damager First ONLY").OnEvent("Click", (*) => RunDamager(1))
    run_gui.Add("Text", "h7")
    run_gui.Add("Button", "w175", "Run Damager Second ONLY").OnEvent("Click", (*) => RunDamager(2))
    run_gui.Add("Text", "h7")
    run_gui.Add("Button", "w175", "Run Damager Third ONLY").OnEvent("Click", (*) => RunDamager(3))
    run_gui.Add("Text", "h7")
    run_gui.Add("Button", "w175", "Close this window").OnEvent("Click", (*) => run_gui.Destroy())
    run_gui.Show("w350 Center")
}


; Initialize program
InitMain()
