#Requires AutoHotkey v2.0

#include "paladin.ahk"
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
    dispel_color := GetPixelColor(bitmap, 130, 135)
    if DispelHandler(dispel_color)
        return

    rotation_color := GetPixelColor(bitmap, 310, 45)
    if rotation_color == 4278255360 ; green / Judgement of ...
    {
        ControlSend("{q}",, game_pid)
        return
    }
    else if rotation_color == 4294967040 ; yellow Consecration
    {
        ControlSend("{e}",, game_pid)
        return
    }
    else if rotation_color == 4294901760 ; red / Exorcism
    {
        ControlSend("{r}",, game_pid)
        return
    }
    else
    {
        buffs_color := GetPixelColor(bitmap, 275, 45)
        BuffsHandler(buffs_color)
    }
}


DispelHandler(color)
{
    if color == 4278255360 ; green / tank dispel
    {
        ControlSend("{y}",, game_pid)
        return true
    }
    else if color == 4278190335 ; blue / healer dispel
    {
        ControlSend("{Shift down}{y}{Shift up}",, game_pid)
        return true
    }
    else if color == 4294967295 ; white / self dispel
    {
        ControlSend("{Ctrl down}{y}{Ctrl up}",, game_pid)
        return true
    }
    else if color == 4294967040 ; yellow / damager_f dispel
    {
        ControlSend("{u}",, game_pid)
        return true
    }
    else if color == 4294901760 ; red / damager_s dispel
    {
        ControlSend("{Shift down}{u}{Shift up}",, game_pid)
        return true
    }
    else if color == 4294902015 ; purple / damager_t dispel
    {
        ControlSend("{Ctrl down}{u}{Ctrl up}",, game_pid)
        return true
    }

    return false
}


BuffsHandler(color)
{
    if color == 4278255615 ; aqua / self seal
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
