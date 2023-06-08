#!/usr/bin/env bash

# oidc-metadata-generator.sh
#   generates Apache2 libapache2-mod-auth-openidc module friendly OIDC matadata based on following
#   environment variables:
#   OIDC_METADATA_DIR   output directory
#   OIDC_FILE_PREFIX    file file prefix
#   OIDC_PROVIDER_URL   OIDC provider URL to be downloaded into $OIDC_METADATA_DIR
#   OIDC_SCOPES         OIDC scopes
#   OIDC_CLIENT_ID      OIDC client ID
#   OIDC_CLIENT_SECRET  OIDC client secret/password
#
# Execution example:
# OIDC_METADATA_DIR="/tmp/oidc_metadata"
#   OIDC_FILE_PREFIX="login.cesnet.cz%2Foidc"
#   OIDC_PROVIDER_URL="https://login.cesnet.cz/oidc/.well-known/openid-configuration"
#   OIDC_SCOPES="openid profile email offline_access eduperson_entitlement"
#   OIDC_CLIENT_ID="<ID>"
#   OIDC_CLIENT_SECRET="<secret>"
#   ./oidc-metadata-generator.sh

set -eo pipefail

set -x

mkdir -p "${OIDC_METADATA_DIR}"

# download provider json
curl -Ls "${OIDC_PROVIDER_URL}" > "${OIDC_METADATA_DIR}/${OIDC_FILE_PREFIX}.provider"

# construct client credentials
printf '{"client_id":"%s","client_secret":"%s"}' "${OIDC_CLIENT_ID}" "${OIDC_CLIENT_SECRET}" > "${OIDC_METADATA_DIR}/${OIDC_FILE_PREFIX}.client"

# pass scopes
printf '{"scope":"%s"}' "${OIDC_SCOPES}" > "${OIDC_METADATA_DIR}/${OIDC_FILE_PREFIX}.conf"

# summary
ls -la "${OIDC_METADATA_DIR}/"
