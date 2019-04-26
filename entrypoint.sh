#!/bin/sh
set -e
mkdir -p config
/usr/bin/python3 update.py
mkdir data
touch data/vouch_bolt.db
mkdir -p /etc/nginx/
cp config/nginx.conf /etc/nginx/nginx.conf
cat config/nginx.conf
nginx
./vouch-proxy --config config/vouch_proxy_config.yml