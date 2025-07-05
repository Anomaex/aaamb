#Requires AutoHotkey v2.0

#include "handlers.ahk"


~F12::SetActivate()
~^F12::SetActivate(false) ; ONLY disable is_activate

~F11::ExitGame()

~F10::UseHeartstone()

~F9::ReloadUI()

~F8::AcceptTrade()

~F4::Follow()
~^F4::Follow(false) ; ONLY disable follow

~R::ClickToMove()

~NumLock::ToggleRun()

~Backspace::Mount()

~Space::Jump()

~RButton up::TargetAndInteract()

~F7::DrinkEat()
