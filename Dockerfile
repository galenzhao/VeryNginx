FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    libpcre3-dev \
    libssl-dev \
    wget \
    perl \
    make \
    procps \
    libreadline-dev \
    libncurses5-dev \
    liblua5.1-0-dev \
    luarocks \
    redis-server \
    unzip \
    python3 \
    libexpat1-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN luarocks install luajson
RUN luarocks install luaexpat
RUN luarocks install kong-redis-cluster

RUN mkdir /code
COPY ./ /code/
WORKDIR /code
RUN groupadd -r nginx && useradd -r -g nginx nginx
RUN python3 install.py install
RUN chown nginx /opt/verynginx/verynginx/configs
#RUN unzip /code/release.2.zip -d /opt/verynginx
RUN cp -aR /code/release /opt/verynginx
RUN \cp /code/apitools/util.lua /usr/local/share/lua/5.1/json/decode/util.lua
RUN \cp /code/apitools/nginx.conf /opt/verynginx/release/config/nginx.conf

EXPOSE 80

CMD ["/code/init.sh", "-g", "daemon off; error_log /dev/stderr info;"]
