#Requires AutoHotkey v2.0

#include "paladin.ahk"
#include "../gdip/gdip_helper.ahk"


Loop
{
    Sleep(400)

    if !is_activate
        continue

    bitmap := GetBitmap()

    t_m_c_fp_color := GetPixelColor(bitmap, 95, 45)

    is_trade := false
    if t_m_c_fp_color == 4278190335 ; blue
        is_trade := true

    is_mounted := false
    if t_m_c_fp_color == 4294967040 ; yellow
        is_mounted := true

    if is_trade
    {
        AcceptTrade(false)
    }
    else if !is_mounted
    {
        
        dispel_color := GetPixelColor(bitmap, 130, 135)
        party_dispel := GetPartyDispel(dispel_color)
        if party_dispel == 1
        {
            PartyDispel(party_dispel)
            Gdip_DisposeImage(bitmap)
            continue
        }
        else if party_dispel == 2
        {
            PartyDispel(party_dispel)
            Gdip_DisposeImage(bitmap)
            continue
        }

        seal_dispel_color := GetPixelColor(bitmap, 274, 45)
        seal_dispel := GetSealOrDispel(seal_dispel_color)
        if seal_dispel == 1
        {
            Dispel()
            Gdip_DisposeImage(bitmap)
            continue
        }

        damage_rotation_color := GetPixelColor(bitmap, 311, 45)
        if !DamageRotation(damage_rotation_color)
        {
            if party_dispel > 0
            {
                PartyDispel(party_dispel)
                Gdip_DisposeImage(bitmap)
                continue
            }
            
            if seal_dispel == 2
                Seal()
        }
    }

    Gdip_DisposeImage(bitmap)
}


DamageRotation(color)
{
    if color == 4294967040 ; yellow , JoL
        ControlSend("{r}",, game_pid)
    else if color == 4294967295 ; white , HoW
        ControlSend("{t}",, game_pid)
    else if color == 4294901760 ; red , Divine Storm
        ControlSend("{g}",, game_pid)
    else if color == 4278190335 ; blue , Crusader Strike
        ControlSend("{f}",, game_pid)
    else if color == 4294902015 ; purple , Exorcism
        ControlSend("{Shift down}{z}{Shift up}",, game_pid)
    else if color == 4278255615 ; aqua , FoL
        ControlSend("{z}",, game_pid)
    else if color == 4278190080 ; black , Consetration
        ControlSend("{x}",, game_pid)
    else if color == 4294950860 ; pink , HW
        ControlSend("{Shift down}{x}{Shift up}",, game_pid)
    else
        return false
    return true 
}
