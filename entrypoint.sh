#!/bin/sh
set -eu

: "${HYDRA_PUBLIC_URL:?Missing HYDRA_PUBLIC_URL}"
: "${HYDRA_ADMIN_URL:?Missing HYDRA_ADMIN_URL}"
: "${HYDRA_CLIENT_ID:?Missing HYDRA_CLIENT_ID}"
: "${HYDRA_CLIENT_SECRET:?Missing HYDRA_CLIENT_SECRET}"
: "${KETO_READ_URL:?Missing KETO_READ_URL}"

envsubst < /etc/oathkeeper/oathkeeper.yml.tmpl > /etc/oathkeeper/oathkeeper.yml

exec oathkeeper -c /etc/oathkeeper/oathkeeper.yml serve
