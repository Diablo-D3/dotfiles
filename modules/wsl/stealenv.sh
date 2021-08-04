#!/usr/bin/env bash

vars=(APPDATA LOCALAPPDATA USERPROFILE)

{
  printf "#!/usr/bin/env bash\n\n";

  for var in "${vars[@]}"; do
    _wslenv "$var";
    printf "%s=%s\n" "$var" "${!var}";
  done
} > ~/.bashrc.local

chmod +x ~/.bashrc.local


