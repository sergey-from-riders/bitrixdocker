#!/bin/sh
set -e

HOST_DOMAIN="nginx"

# Если в /etc/hosts не прописан host nginx то пропишем его
if ! grep $NGINX_HOST /etc/hosts; then
  if ping -q -c1 $HOST_DOMAIN > /dev/null 2>&1
  then
    HOST_IP=$(ping -c1 $HOST_DOMAIN | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
    echo "$HOST_IP  $NGINX_HOST" >> /etc/hosts
  fi
fi