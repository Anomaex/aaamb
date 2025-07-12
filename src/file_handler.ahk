#Requires AutoHotkey v2.0


cache_dir := "../../../cache"


GetPath(index, is_game)
{
    id := ""
    if index == 1
        id := "tank"
    else if index == 2
        id := "healer"
    else if index == 3
        id := "damager_f"
    else if index == 4
        id := "damager_s"
    else if index == 5
        id := "damager_t"

    if is_game
        id := "game_" . id
    else
        id := "ahk2_" . id

    if !FileExist(cache_dir)
        DirCreate(cache_dir)

    path := cache_dir . "/" . id . ".pid"
    return path
}


WritePidToFile(index, pid, is_game := false)
{
    path := GetPath(index, is_game)
    file := FileOpen(path, "w")
    file.Write(pid)
    file.Close()
}


GetPidFromFile(index, is_game)
{
    path := GetPath(index, is_game)
    if !FileExist(path)
        return ""

    raw_pid := FileRead(path) 
    pre_pid := StrReplace(raw_pid, "`r")
    pid := StrReplace(pre_pid, "`n")
    return pid
}
