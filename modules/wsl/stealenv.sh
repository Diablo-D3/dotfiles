#!/usr/bin/env bash

vars=(APPDATA LOCALAPPDATA USERPROFILE)

{
  printf "#!/usr/bin/env bash\n\n";

  for var in "${vars[@]}"; do
    varw=$(powershell.exe -Command "\$env:$var" | sed 's/\r//')
    export "${var}W=$varw"
    printf "%s=%s\n" "${var}W" "$varw"

    varu=$(wslpath "$varw")
    export "${var}=$varu"
    printf "%s=%s\n" "$var" "$varu";
  done
} > ~/.bashrc.local

chmod +x ~/.bashrc.local
