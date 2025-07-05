#Requires AutoHotkey v2.0

#include "Gdip_All.ahk"
if !Gdip_Startup()
{
    MsgBox "[ERROR]: Cant initialize library GDI+ for healer..."
    ExitApp
}


; Crop window border
;new_x := 8
;new_y := 31
;new_width := 1296 - 16
;new_height := 1063 - 31 - 8


GetBitmap()
{
    pBitmap := Gdip_BitmapFromHWND(game_hwnd)
    ;pCroppedBitmap := Gdip_CloneBitmapArea(pBitmap, new_x, new_y, new_width, new_height)
    ;Gdip_DisposeImage(pBitmap)
    return pBitmap
}


; 4278255360 pixel bit color - 0 255 0 RGB - Green
; 4278190335 - 0  0 255 - Blue
; 4294967040 - 255 255 0 - Yellow
; 4294901760 - 255 0 0 - Red
; 4294902015 - 255 0 255 - Purple
; 4278255615 - 0 255 255 - Aqua
; 4294967295 - 255 255 255 white
; 4278190080 - 0 0 0 black
; 4294950860 - 1, 0.75, 0.8 pink
GetPixelColor(bitmap, x, y)
{
    argb := Gdip_GetPixel(bitmap, x, y)
    ;A := (argb >> 24) & 0xFF
    ;R := (argb >> 16) & 0xFF
    ;G := (argb >> 8)  & 0xFF
    ;B := (argb)       & 0xFF
    return argb
}
