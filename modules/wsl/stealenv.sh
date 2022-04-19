#!/usr/bin/env bash

_chmod="$(which chmod)"

vars=(APPDATA LOCALAPPDATA USERPROFILE PATH)

{
  printf "#!/usr/bin/env bash\n"

  for var in "${vars[@]}"; do
    varw=$(/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe -Command "\$env:$var" | sed 's,\r,,')
    export "${var}W=$varw"
    printf "\n%s=\"%s\"\n" "${var}W" "$varw"

    varu=$(sed 's,\;,:,g;s,C:\\,/mnt/c/,g;s,\\,/,g' <<<"$varw")
    export "${var}=$varu"
    printf "%s=\"%s\"\n" "$var" "$varu"
  done
} >~/.bashrc.win

"${_chmod}" +x ~/.bashrc.win

unset vars
