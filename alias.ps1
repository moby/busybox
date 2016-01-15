$commands = busybox.exe --list

ForEach($command in $commands) {
    $commandexe = "C:\busybox\$command.exe"
    $nul = cmd /c mklink $commandexe busybox.exe
}
