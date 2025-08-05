#Requires AutoHotkey v2.0

#include "handlers.ahk"


~F12::SetActivate()
~^F12::SetActivate(true) ; ONLY disable is_activate

~F11::ExitGame()

~F10::UseHeartstone()

~F9::ReloadUI()

~F4::Follow()
~^F4::Follow(true) ; ONLY disable follow

~F3::ClickToMove()

~NumLock::ToggleRun()

~Backspace::Mount()

~Space::Jump()

~RButton up::TargetAndInteract()

~F6::DrinkEat()

~WheelUp::MouseWheel()
~WheelDown::MouseWheel()
