#!/bin/bash

cat > integration-config/test_config.json <<EOF
{
  "api_url": "${CREDHUB_API_URL}",
  "api_username": "${CREDHUB_USERNAME}",
  "api_password": "${CREDHUB_PASSWORD}",
  "credential_root": "${CREDHUB_CA_PATH}",
  "uaa_ca": "${UAA_CA_PEM_FILE}",
  "client_name": "${CREDHUB_CLIENT_NAME}",
  "client_secret": "${CREDHUB_CLIENT_SECRET}"
}
EOF
