#/bin/sh

# shellcheck enable=all


# {{ template "scripts-library" }}
true || source ../.chezmoitemplates/scripts-library

set -e
set -u

{{ if eq .chezmoi.os "linux" }}
{{   if (.chezmoi.kernel.osrelease | lower | contains "microsoft") }}

{{ joinPath .chezmoi.sourceDir "wsl/stealenv.sh" | quote }}



{{   end }}
{{ end }}
