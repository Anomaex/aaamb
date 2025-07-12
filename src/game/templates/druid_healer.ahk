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
    t_m_c_fp_color := GetPixelColor(bitmap, 22, 45)

    is_trade := false
    if t_m_c_fp_color == 4278190335 ; blue
        is_trade := true

    is_mounted := false
    if t_m_c_fp_color == 4294967040 ; yellow
        is_mounted := true

    is_cast := false
    if t_m_c_fp_color == 4294901760 ; red
        is_cast := true

    if is_trade
        AcceptTrade(true)
    else if !is_mounted && !is_cast
        Handler(bitmap)
}


Handler(bitmap)
{
    tank_health_color := GetPixelColor(bitmap, 23, 190)
    if tank_health_color == 4278190335 ; blue
    {
        ControlSend("{y}",, game_pid)
    }
    else if tank_health_color == 4294902015 ; purple
    {
        PauseFollow()
        ControlSend("{Alt down}{y}{Alt up}",, game_pid)
    }
}
