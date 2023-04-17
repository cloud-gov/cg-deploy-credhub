#!/bin/bash

cat > integration-config/test_config.json <<EOF
{
  "api_url": "${CREDHUB_API_URL}",
  "api_username": "${CREDHUB_USERNAME}",
  "api_password": "${CREDHUB_PASSWORD}",
  "client_name": "${CREDHUB_CLIENT_NAME}",
  "client_secret": "${CREDHUB_CLIENT_SECRET}"
}
EOF
