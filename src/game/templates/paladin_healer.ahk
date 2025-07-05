#Requires AutoHotkey v2.0

#include "paladin.ahk"
#include "../gdip/gdip_helper.ahk"


Loop
{
    Sleep(300)

    if !is_activate 
        continue

    if is_drink_eat
    {
        global is_drink_eat := false
        Sleep(500)
    }

    bitmap := GetBitmap()

    t_m_c_fp_color := GetPixelColor(bitmap, 95, 45)

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
    {
        AcceptTrade(false)
    }
    else if !is_mounted && !is_cast
    {
        tank_color := GetPixelColor(bitmap, 23, 190)
        self_color := GetPixelColor(bitmap, 22, 45)
        damager_f_color := GetPixelColor(bitmap, 60, 190)
        damager_s_color := GetPixelColor(bitmap, 95, 190)
        damager_t_color := GetPixelColor(bitmap, 130, 190)

        jow_df_color := GetPixelColor(bitmap, 311, 45)
        jow_df := GetJoWOrDF(jow_df_color)
        df := (jow_df == 1 || jow_df == 2) ? true : false

        hs_iol_color := GetPixelColor(bitmap, 347, 45)
        hs_iol := GetHSIoL(hs_iol_color)
        hs := (hs_iol == 1 or hs_iol == 2) ? true : false
        iol := (hs_iol == 1 or hs_iol == 3) ? true : false

        mana_color := GetPixelColor(bitmap, 60, 45)
        mana := GetManaUse(mana_color)
        if mana == 1
        {
            ControlSend("{f}",, game_pid) ; use Divine Illumination
            Gdip_DisposeImage(bitmap)
            continue
        }
        else if mana == 2
        {
            ControlSend("{PgUp}",, game_pid) ; use mana pition
        } 

        bol_color := GetPixelColor(bitmap, 385, 45)
        bol := GetBoL(bol_color)
        if bol == 1
        {
            ControlSend("{g}",, game_pid) ; use beacon of light 
            Gdip_DisposeImage(bitmap)
            continue
        }

        HealHandler(tank_color, self_color, damager_f_color, damager_s_color, damager_t_color, df, hs, iol, bol == 2 ? true : false)

        dispel_color := GetPixelColor(bitmap, 130, 135)
        party_dispel := GetPartyDispel(dispel_color)
        if party_dispel == 1
        {
            PartyDispel(party_dispel)
            Gdip_DisposeImage(bitmap)
            continue
        }

        is_jow := (jow_df == 2 || jow_df == 3) ? true : false
        if is_jow
        {
            UseJoW()
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

        if party_dispel > 0
        {
            PartyDispel(party_dispel)
            Gdip_DisposeImage(bitmap)
            continue
        }

        if seal_dispel == 2
            Seal()
    }

    Gdip_DisposeImage(bitmap)
}


GetManaUse(color)
{
    if color == 4278190335 ; blue, Divine Illumination
        return 1
    else if color == 4294967040 ; yellow, potion
        return 2
    return 0
}


GetJoWOrDF(color)
{
    if color == 4278255360 ; green
        return 1
    else if color == 4278190335 ; blue
        return 2
    else if color == 4294967040 ; yellow
        return 3
    return 0
}


UseJoW()
{
    ControlSend("{r}",, game_pid)
}


GetHSIoL(color)
{
    if color == 4294967040 ; yellow
        return 1
    else if color == 4278255360 ; green
        return 2
    else if color == 4294901760 ; red
        return 3
    return 0
}


GetBoL(color)
{
    if color == 4294901760 ; red
        return 2
    else if color == 4294967040 ; yellow
        return 1
    return 0
}


~F2::Follow(,, true)


HealHandler(tank, healer, damager_f, damager_s, damager_t, df, hs, iol, bol)
{

    need_tank := false
    tank_params := []

    if tank == 4294902015 || tank == 4294901760 ; purple || red
    {
        if bol
        {
            need_tank := true
            tank_params := [true, df, hs, false]
        }
        else
        {
            Heal(1, true, df, hs, false)
            return
        }
    }

    if healer == 4294902015 || healer == 4294901760 ; purple || red
    {
        if need_tank
            Heal(2, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
        else
            Heal(2, true, df, hs, false)
        return
    }

    else if damager_f == 4294902015 ; purple
    {
        Heal(3, true, df, hs, false)
        return
    }
    else if damager_s == 4294902015 ; purple
    {
        Heal(4, true, df, hs, false)
        return
    }
    else if damager_t == 4294902015 ; purple
    {
        Heal(5, true, df, hs, false)
        return
    }

    if tank == 4294967040 ; yellow
    {
        if bol
        {
            need_tank := true
            tank_params := [true, df, hs, false]
        }
        else
        {
            Heal(1, true, false, hs, false)
            return
        }
    }
    
    if damager_f == 4294901760 ; red
    {
        if need_tank
            Heal(3, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
        else
            Heal(3, true, false, hs, false)
        return
    }
    else if damager_s == 4294901760 ; red
    {
        if need_tank
            Heal(4, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
        else
            Heal(4, true, false, hs, false)
        return
    }
    else if damager_t == 4294901760 ; red
    {
        if need_tank
            Heal(5, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
        else
            Heal(5, true, false, hs, false)
        return
    }

    else if healer == 4294967040 ; yellow
    {
        if need_tank
            Heal(2, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
        else
            Heal(2, true, false, hs, false)
        return
    }

    if bol
    {
        if damager_f == 4294967040 ; yellow
        {
            if need_tank
                Heal(3, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
            else
                Heal(3, true, false, hs, false)
            return
        }
        else if damager_s == 4294967040 ; yellow
        {
            if need_tank
                Heal(4, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
            else
                Heal(4, true, false, hs, false)
            return
        }
        else if damager_t == 4294967040 ; yellow
        {
            if need_tank
                Heal(5, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
            else
                Heal(5, true, false, hs, false)
            return 
        }
    }

    if tank == 4278190335 ; blue
    {
        if bol
        {
            need_tank := true
            tank_params := [false, false, hs, iol]
        }
        else
        {
            Heal(1, false, false, hs, iol)
            return
        }
    }

    if healer == 4278190335 ; blue
    {
        if need_tank
            Heal(2, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
        else
            Heal(2, false, false, hs, iol)
        return
    }

    else if need_tank
        Heal(2, tank_params[1], tank_params[2], tank_params[3], tank_params[4])
}


; index = 1 tank, 2 healer, 3 damager_f, 4 damager_s, 5 damager_t
Heal(index, hl, divine_favor, holy_shock, iol_fol)
{
    key := "u"
    if index == 1
        key := "y"
    else if index == 2
        key := "u"
    else if index == 3
        key := "i"
    else if index == 4
        key := "o"
    else if index == 5
        key := "p"

    if divine_favor
        ControlSend("{t}",, game_pid)

    if holy_shock
    {
        ControlSend("{Shift down}{" . key . "}{Shift up}",, game_pid)
        return
    }

    if iol_fol
    {
        ControlSend("{Ctrl down}{" . key . "}{Ctrl up}",, game_pid)
        return
    }

    if hl
    {
        Follow(, true,, false)
        ControlSend("{" . key . "}",, game_pid)
    }
}
