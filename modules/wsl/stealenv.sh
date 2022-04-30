#!/usr/bin/env bash

# shellcheck disable=SC2016

# This script records Windows environment variables to be used in the WSL2 Linux
# environment; the niche use of this is for being able to ssh into WSL2 VMs, but
# still have access to important Windows environment variables. This outputs
# into ~/.bashrc.win, and this file should be sourced from your ~/.bashrc; it
# will only substitute variables if they are not already part of your
# environment.

# The generated script also checks if the existing PATH already contains
# "/mnt/c", and only integrates the native PATH if the native paths are missing.

# Purposely ignore WSLENV
OLD_WSLENV="$WSLENV"
export WSLENV=""

# PATH is altered, and it forgets where chmod is
_chmod="$(which chmod)"

# Variables to borrow
vars=(APPDATA LOCALAPPDATA USERPROFILE PATH)

# Check if variables are set; if they aren't, don't record any of them, as we
# we're probably ssh'd into the WSL2 VM and can't see the native environment
for var in "${vars[@]}"; do
  varw=$(/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe -Command "\$env:$var" | sed 's,\r,,')

  if [ -z "${var+unset}" ]; then
    printf '%s missing, skipping environment theft...' "$var"
    exit 0
  fi
done

# Actually output them this time
{
  printf '#!/usr/bin/env bash\n'
  printf '\nOLD_PATH="$PATH"\n'

  for var in "${vars[@]}"; do
    varw=$(/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe -Command "\$env:$var" | sed 's,\r,,')

    printf '\nif [ -z "${%s+unset}" ]; then\n' "${var}W"
    printf '  export %s="%s"\n' "${var}W" "$varw"
    printf 'fi\n'

    varu=$(sed 's,\;,:,g;s,C:\\,/mnt/c/,g;s,\\,/,g' <<<"$varw")

    printf '\nif [ -z "${%s+unset}" ]; then\n' "$var"
    printf '  export %s="%s"\n' "$var" "$varu"
    printf 'fi\n'
  done

  printf '\nif [[ "$PATH" != *"/mnt/c/"* ]]; then\n'
  printf '  export PATH="$OLD_PATH:$PATH"\n'
  printf 'else\n'
  printf '  export PATH="$OLD_PATH"\n'
  printf 'fi\n'
} >~/.bashrc.win

"${_chmod}" +x ~/.bashrc.win

export WSLENV="$OLD_WSLENV"
