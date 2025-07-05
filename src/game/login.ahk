#Requires AutoHotkey v2.0


account_name := accounts[game_role][1]
password := accounts[game_role][2]


InitGameLogin()
{
    ControlSendText(account_name,, game_pid)
    Sleep(300)
    ControlSend("{Tab}",, game_pid)
    Sleep(300)
    ControlSendText(password,, game_pid)
    Sleep(300)
    ControlSend("{Enter}",, game_pid)
    Sleep(2500)
    ControlSend("{Enter}",, game_pid)
}
