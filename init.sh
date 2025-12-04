#!/bin/bash

/opt/verynginx/openresty/nginx/sbin/nginx
redis-server --daemonize yes
/opt/verynginx/openresty/nginx/sbin/nginx -c /opt/verynginx/release/config/nginx.conf -p /opt/verynginx/release
