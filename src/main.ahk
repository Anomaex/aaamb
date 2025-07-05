#Requires AutoHotkey v2.0
#NoTrayIcon


RunTank()
{
    Run A_ScriptDir "/game/tank.ahk"
    Sleep(250)
}


RunDamager(index)
{
    Run A_ScriptDir "/game/damager.ahk " . index
    Sleep(250)
}


RunHealer()
{
    Run A_ScriptDir "/game/healer.ahk"
    Sleep(250)
}


RunAll()
{
    RunTank()
    Sleep(250)
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
