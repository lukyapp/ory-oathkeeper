#!/bin/sh
set -eu

: "${HYDRA_PUBLIC_URL:?Missing HYDRA_PUBLIC_URL}"
: "${HYDRA_ADMIN_URL:?Missing HYDRA_ADMIN_URL}"
: "${HYDRA_CLIENT_ID:?Missing HYDRA_CLIENT_ID}"
: "${HYDRA_CLIENT_SECRET:?Missing HYDRA_CLIENT_SECRET}"
: "${KETO_READ_URL:?Missing KETO_READ_URL}"

envsubst < /etc/oathkeeper/oathkeeper.yml.tmpl > /etc/oathkeeper/oathkeeper.yml

JWKS_DIR="${RAILWAY_VOLUME_MOUNT_PATH:-/data}"
JWKS_FILE="$JWKS_DIR/jwks.json"
mkdir -p "$JWKS_DIR"
if [ ! -s "$JWKS_FILE" ]; then
  echo "Generating JWKS at $JWKS_FILE"
  oathkeeper credentials generate --alg RS256 > "$JWKS_FILE"
  chmod 0400 "$JWKS_FILE"
fi

exec oathkeeper -c /etc/oathkeeper/oathkeeper.yml serve
