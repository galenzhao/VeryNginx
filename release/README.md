# APItools Traffic Monitor [![Build Status](https://travis-ci.org/APItools/monitor.svg?branch=master)](https://travis-ci.org/APItools/monitor)

APITools is a hosted proxy mainly for API calls, but can be used as a general programmable proxy.
It has analytics, lua middleware, storing passed calls and many other features.

# Building and Developing

You need Ruby 2.1.2 to build this project and Openresty to run it.
Then you can just run it like:

```bash
wget https://www.openssl.org/source/openssl-1.0.2l.tar.gz 
./config --prefix=/usr/local/openssl-1.0.2l --openssldir=/usr/local/openssl-1.0.2l shared zlib

#sudo apt-get install ruby-dev
RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/openssl-1.0.2l" rbenv install 2.1.2
gem sources --remove https://rubygems.org/
gem sources -a http://mirrors.aliyun.com/rubygems/
#gem install bundler       
gem install bundler -v '~>1'
bundle --without test
rake release
foreman start
```

If you want to know how exacly each component is started, check Procfile.

You will need a running redis server.

# Tests
We have several test suites for different components. First are the API tests that require `ruby`. You can run them by `rake test:api`. You need to have an instance running on ports 7071 and 10002. Then there is `rake test:integration` which runs cucumber tests with real browsers simulating user interactions. Next are `rake test:lua` which are lua tests. They require openresty version at least `1.7.4.1`. Last are Angular tests, that require `nodejs`. You can install all dependencies by `npm install` and then just `rake test:angular`.

## Docker

You can use [fig](http://www.fig.sh/index.html) to start the developer environment.
Or you can use our `make bash` to start similar environment without fig.


## Installing Openresty


### Installing Openresty on OSX

Install [homebrew](http://brew.sh/)

```bash
brew tap apitools/openresty
brew install openresty
brew install apitools/openresty/luarocks

bundle install
npm install
foreman start

# For tests:
luarocks intall busted-stable
/usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/release/config/nginx.conf -p /usr/local/openresty/release/
```

### Linux

```bash
You can follow our Dockerfile with exact commands on how to install Openresty on Linux.
You don't have to use all the flags or prefixes. The essense should be:

  514  wget https://openresty.org/download/openresty-1.15.8.2.tar.gz
  515  tar zxf openresty-1.15.8.2.tar.gz
  516  cd openresty-1.15.8.2/
  517  ./configure --with-pcre-jit --with-ipv6 --user=nginx --group=nginx --with-http_sub_module --with-http_auth_request_module --with-http_v2_module --with-stream --with-stream_ssl_module --with-stream_ssl_preread_module --with-http_ssl_module --with-luajit-xcflags=-DLUAJIT_ENABLE_LUA52COMPAT --with-http_gunzip_module --with-http_stub_status_module --with-luajit --prefix=/opt/verynginx/openresty
  518  make -j4
  
sudo yum install lua-devel
   
sudo luarocks install luajson
sudo luarocks install luaexpat
sudo luarocks install kong-redis-cluster

```

You can follow our Dockerfile with exact commands on how to install Openresty on Linux.
You don't have to use all the flags or prefixes. The essense should be:

```bash
wget http://openresty.org/download/ngx_openresty-1.7.2.1.tar.gz
tar xzf ngx_openresty-1.7.2.1.tar.gz
cd ngx_openresty-1.7.2.1

```

For SSL of HTTP client you need ngx_openresty-1.7.4.1rc2, apply our patch like:

```bash
curl https://gist.githubusercontent.com/mikz/4dae10a0ef94de7c8139/raw/
33d6d5f9baf68fc5a0748b072b4d94951e463eae/system-ssl.patch | patch -p0
```
and then configure and build like usual.

# Install Guide
You can find the full Install Guide in [our documentation](https://docs.apitools.com/docs/on-premise/).

## Debian/Ubuntu

Use our packages available from https://packagecloud.io/APItools/monitor.

## OSX

Follow [Installing Openresty on OSX](#installing-openresty-on-osx) to get Openresty running.
Then you can use a release or build it yourself.

# Running it

```bash
nginx -p /path/to/folder -c config/nginx.conf

while [ 0 -lt 1 ]; do curl 'http://127.0.0.1:7071/api/traces/all'   -X 'DELETE'   -H 'Connection: keep-alive'   -H 'Accept: application/json, text/plain, */*'   -H 'DNT: 1'   -H 'X-XSRF-TOKEN: eyJleHBpcmVzIjoxNjA3MzgxMDEyfQ==./s6PgCzwfr3+sffRTkyLy+MzvPE='   -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36'   -H 'Origin: http://127.0.0.1:7071'   -H 'Referer: http://127.0.0.1:7071/app/traces'   -H 'Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7,zh-TW;q=0.6'   -H 'Cookie: XSRF-TOKEN=eyJleHBpcmVzIjoxNjA3MzgxMDEyfQ==./s6PgCzwfr3+sffRTkyLy+MzvPE='   --compressed   --insecure -I; date; sleep 600; done
while [ 0 -lt 1 ]; do curl 'http://127.0.0.1:7071/api/events/all'   -X 'DELETE'   -H 'Connection: keep-alive'   -H 'Accept: application/json, text/plain, */*'   -H 'DNT: 1'   -H 'X-XSRF-TOKEN: eyJleHBpcmVzIjoxNjA3MzgxMDEyfQ==./s6PgCzwfr3+sffRTkyLy+MzvPE='   -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36'   -H 'Origin: http://127.0.0.1:7071'   -H 'Referer: http://127.0.0.1:7071/app/notifications'   -H 'Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7,zh-TW;q=0.6'   -H 'Cookie: XSRF-TOKEN=eyJleHBpcmVzIjoxNjA3MzgxMDEyfQ==./s6PgCzwfr3+sffRTkyLy+MzvPE='   --compressed   --insecure -I; date; sleep 600; done
```

## OSX

On OSX, instead of `nginx` use `openresty`.


# Contributing

We accept Pull Requests, but please check before doing so if it meets the target of this project.

For contributing guide check [CONTRIBUTING.md](CONTRIBUTING.md).
