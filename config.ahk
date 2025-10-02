#Requires AutoHotkey v2.0

#include "./secret.ahk"

;secret := {
;   ["login", "password", "paladin"], ;  1 index, Always must be tank/leader/main window
;   ["login", "password", "druid"], ; 2 index, Always must be healer
;   ["login", "password", "paladin"], ; DPS first
;   ["login", "password", "paladin"], ; DPS second
;   ["login", "password", "paladin"] ; DPS third
;}

accounts := secret

main_game_path_to_exe := "D:\Games\World_of_Warcraft_3_3_5a\Wow.exe"
multibox_game_path_to_exe := "D:\Games\World_of_Warcraft_3_3_5a_MultiBox\Wow.exe"
