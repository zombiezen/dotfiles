#shellcheck shell=bash
# Script to generate a new Nix store key and save it to 1Password.

set -euo pipefail

read -r -d '' TEMPLATE <<'EOF' || true
{
  "title": "",
  "category": "PASSWORD",
  "fields": [
    {
      "id": "password",
      "type": "CONCEALED",
      "purpose": "PASSWORD",
      "label": "password",
      "value": ""
    },
    {
      "id": "publicKey",
      "type": "STRING",
      "label": "public key",
      "value": ""
    },
    {
      "id": "notesPlain",
      "type": "STRING",
      "purpose": "NOTES",
      "label": "notesPlain",
      "value": ""
    }
  ]
}
EOF

if [[ $# -ne 1 || "$1" = '--help' ]]; then
  echo "usage: nix-op-key TITLE"
  exit 64
fi

# Generate
key_name="$1"
secret_key="$(nix \
  --extra-experimental-features 'nix-command' \
  key generate-secret \
  --key-name "$key_name")"
public_key="$(echo "$secret_key" |
  nix \
    --extra-experimental-features 'nix-command' \
    key convert-secret-to-public)"

# Fill out template.
item_file="$(mktemp -t nixop-XXXXXX.json)"
trap 'rm "$item_file"' EXIT
echo "$TEMPLATE" | jq \
  --arg title "$key_name" \
  --arg public_key "$public_key" \
  --rawfile password <(echo -n "$secret_key") \
  '.title = $title | .fields[0].value = $password | .fields[1].value = $public_key' \
  > "$item_file"

op item create \
  --template "$item_file" \
  --tags Nix
