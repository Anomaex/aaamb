#Requires AutoHotkey v2.0

#include "druid.ahk"
#include "../gdip/gdip_helper.ahk"


Loop
{
    Sleep(300)

    if !is_activate 
        continue

    global is_drink_eat
    if is_drink_eat
    {
        is_drink_eat := false
        Sleep(500)
    }

    bitmap := GetBitmap()

    PreHandler(bitmap)

    Gdip_DisposeImage(bitmap)
}


PreHandler(bitmap)
{
    t_m_c_fp_lfgin_color := GetPixelColor(bitmap, 22, 45)

    is_lfg_in := false
    if t_m_c_fp_lfgin_color == 4294967295 ; white
        is_lfg_in := true

    is_trade := false
    if t_m_c_fp_lfgin_color == 4278255360 ; green
        is_trade := true

    is_mounted := false
    if t_m_c_fp_lfgin_color == 4278190335 ; blue
        is_mounted := true

    is_cast := false
    if t_m_c_fp_lfgin_color == 4294967040 ; yellow
        is_cast := true

    if is_lfg_in
        ControlSend("{6}",, game_pid)
    else if is_trade
        ControlSend("{7}",, game_pid)
    else if !is_mounted && !is_cast
        Handler(bitmap)
}


Handler(bitmap)
{
    mana_potion := GetPixelColor(bitmap, 275, 82)
    if mana_potion == 4294967040 ; yellow
        ControlSend("{PgUp}",, game_pid)

    tank_color := GetPixelColor(bitmap, 23, 190)
    healer_color := GetPixelColor(bitmap, 59, 190)
    damager_f_color := GetPixelColor(bitmap, 95, 190)
    damager_s_color := GetPixelColor(bitmap, 133, 190)
    damager_t_color := GetPixelColor(bitmap, 167, 190)

    flag := HealthHandler(tank_color, healer_color, damager_f_color, damager_s_color, damager_t_color)
    if !flag
    {
        curse_dispel_color := GetPixelColor(bitmap, 130, 136)
        if CurseDispelHandler(curse_dispel_color)
            return

        poison_dispel_color := GetPixelColor(bitmap, 166, 136)
        if PoisonDispelHandler(poison_dispel_color)
            return

        natures_grasp_color := GetPixelColor(bitmap, 312, 45)
        if natures_grasp_color == 4278255360 ; green
        {
            ControlSend("{q}",, game_pid)
            return
        }

        buffs_color := GetPixelColor(bitmap, 275, 45)
        BuffsHandler(buffs_color)
    }
}


BuffsHandler(color)
{
    if color == 4278255615 ; aqua / tank thorn
        ControlSend("{Shift down}{F7}{Shift up}",, game_pid)
    else if color == 4294967295 ; white / self buff
        ControlSend("{F7}",, game_pid)
    else if color == 4278255360 ; green / tank buff
        ControlSend("{F5}",, game_pid)
    else if color == 4278190335 ; blue / healer buff
        ControlSend("{Shift down}{F5}{Shift up}",, game_pid)
    else if color == 4294967040 ; yellow / damager_f buff
        ControlSend("{F6}",, game_pid)
    else if color == 4294901760 ; red / damager_s buff
        ControlSend("{Shift down}{F6}{Shift up}",, game_pid)
    else if color == 4294902015 ; purple / damager_t buff
        ControlSend("{Ctrl down}{F6}{Ctrl up}",, game_pid)
}


CurseDispelHandler(color)
{
    if color == 4278255360 ; green / tank dispel
    {
        ControlSend("{b}",, game_pid)
        return true
    }
    else if color == 4278190335 ; blue / healer dispel
    {
        ControlSend("{Shift down}{b}{Shift up}",, game_pid)
        return true
    }
    else if color == 4294967295 ; white / self dispel
    {
        ControlSend("{Ctrl down}{b}{Ctrl up}",, game_pid)
        return true
    }
    else if color == 4294967040 ; yellow / damager_f dispel
    {
        ControlSend("{n}",, game_pid)
        return true
    }
    else if color == 4294901760 ; red / damager_s dispel
    {
        ControlSend("{Shift down}{n}{Shift up}",, game_pid)
        return true
    }
    else if color == 4294902015 ; purple / damager_t dispel
    {
        ControlSend("{Ctrl down}{n}{Ctrl up}",, game_pid)
        return true
    }

    return false
}


PoisonDispelHandler(color)
{
    if color == 4278255360 ; green / tank dispel
    {
        ControlSend("{k}",, game_pid)
        return true
    }
    else if color == 4278190335 ; blue / healer dispel
    {
        ControlSend("{Shift down}{k}{Shift up}",, game_pid)
        return true
    }
    else if color == 4294967295 ; white / self dispel
    {
        ControlSend("{Ctrl down}{k}{Ctrl up}",, game_pid)
        return true
    }
    else if color == 4294967040 ; yellow / damager_f dispel
    {
        ControlSend("{l}",, game_pid)
        return true
    }
    else if color == 4294901760 ; red / damager_s dispel
    {
        ControlSend("{Shift down}{l}{Shift up}",, game_pid)
        return true
    }
    else if color == 4294902015 ; purple / damager_t dispel
    {
        ControlSend("{Ctrl down}{l}{Ctrl up}",, game_pid)
        return true
    }

    return false
}


HealthHandler(tank, healer, dmg_f, dmg_s, dmg_t)
{
    if tank == 4278255360 ; green / Rejuvenation
    {
        ControlSend("{y}",, game_pid)
        return true
    }
    if tank == 4294967040 ; yellow / Regrowth
    {
        PauseFollow()
        ControlSend("{i}",, game_pid)
        PauseFollow()
        return true
    }
    if tank == 4294967295 ; white / Healing Touch
    {
        PauseFollow()
        ControlSend("{u}",, game_pid)
        PauseFollow()
        return true
    }


    if healer == 4278255360 ; green / Rejuvenation
    {
        ControlSend("{Shift down}{y}{Shift up}",, game_pid)
        return true
    }
    if healer == 4294967040 ; yellow / Regrowth
    {
        PauseFollow()
        ControlSend("{Shift down}{i}{Shift up}",, game_pid)
        PauseFollow()
        return true
    }
    if healer == 4294967295 ; white / Healing Touch
    {
        PauseFollow()
        ControlSend("{Shift down}{u}{Shift up}",, game_pid)
        PauseFollow()
        return true   
    }


    if dmg_f == 4278255360 ; green / Rejuvenation
    {
        ControlSend("{Ctrl down}{y}{Ctrl up}",, game_pid)
        return true
    }
    if dmg_f == 4294967040 ; yellow / Regrowth
    {
        PauseFollow()
        ControlSend("{Ctrl down}{i}{Ctrl up}",, game_pid)
        PauseFollow()
        return true
    }
    if dmg_f == 4294967295 ; white / Healing Touch
    {
        PauseFollow()
        ControlSend("{Ctrl down}{u}{Ctrl up}",, game_pid)
        PauseFollow()
        return true   
    }


    if dmg_s == 4278255360 ; green / Rejuvenation
    {
        ControlSend("{Alt down}{y}{Alt up}",, game_pid)
        return true
    }
    if dmg_s == 4294967040 ; yellow / Regrowth
    {
        PauseFollow()
        ControlSend("{Alt down}{i}{Alt up}",, game_pid)
        PauseFollow()
        return true
    }
    if dmg_s == 4294967295 ; white / Healing Touch
    {
        PauseFollow()
        ControlSend("{Alt down}{i}{Alt up}",, game_pid)
        PauseFollow()
        return true   
    }


    if dmg_t == 4278255360 ; green / Rejuvenation
    {
        ControlSend("{Alt down}{Shift down}{y}{Shift up}{Alt up}",, game_pid)
        return true
    }
    if dmg_t == 4294967040 ; yellow / Regrowth
    {
        PauseFollow()
        ControlSend("{Alt down}{Shift down}{u}{Shift up}{Alt up}",, game_pid)
        PauseFollow()
        return true   
    }
    if dmg_t == 4294967295 ; white / Healing Touch
    {
        PauseFollow()
        ControlSend("{Alt down}{Shift down}{u}{Shift up}{Alt up}",, game_pid)
        PauseFollow()
        return true   
    }

    
    return false
}


~F2::Follow(,, true)
