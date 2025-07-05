#Requires AutoHotkey v2.0


game_role := A_Args[1] + 2


#include "../window.ahk"
#include "login.ahk"
#include "hotkeys.ahk"


if template == "paladin"
{
    #include "templates\paladin_damager.ahk"
}
