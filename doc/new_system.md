
Amazon Linux AMI

1. install git

yum install git

2. install rvm

curl -sSL https://get.rvm.io | bash

rvm -v

vim ~/.bashrc
```
export RAILS_ENV=production

[[ -s "/home/www/.rvm/scripts/rvm" ]] && source "/home/www/.rvm/scripts/rvm"
```
source ~/.bashrc

3. install ruby

rvm install 1.9.3

rvm list

rvm --default use 1.9.3

4. create & download project dir 

mkdir -p /srv/rorapps/

cd /srv/rorapps/

git clone git@git.company.com.cn:menxu/fgcc.git

5. replace gem sources

gem source -l

gem sources --remove https://rubygems.org/

gem sources -a https://ruby.taobao.org/

gem source -l

6. bundle

gem install bundle

bundle

7.  bundle error

gem pg install error

```
Using config values from /usr/bin/pg_config
checking for libpq-fe.h... no
Can't find the 'libpq-fe.h header
```

安装其他gem插件的时候也会遇到类似这样的问题，找不到.h这样的文件，就是缺少你安装的这个gem包的依赖包，一般都是安装xxxx-devel就能解决问题

安装postgresql数据库的依赖包 

yum install postgresql-devel



install nginx & passenger

1. install passenger gem

gem install passenger

2. nginx download

http://nginx.org/en/download.html

wget http://nginx.org/download/nginx-1.8.0.tar.gz
wget -N ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.34.tar.bz2
tar jxvf pcre-8.34.tar.bz2
tar -zxvf nginx-1.8.0.tar.gz

3. nginx install

yum install ruby-devel gcc make pcre-devel zlib-devel openssl-devel pam-devel curl-devel rpm-buildyum install -y ruby-devel rubygems gcc

cd nginx-1.8.0

vim install_nginx_passenger.sh

```
#!/bin/tcsh
set cpwd = `pwd`;
echo $cpwd;
cd nginx-path;
make clean
./configure --prefix=${cpwd}/nginx \
  --user=www \
  --group=www \
  --with-http_realip_module \
  --with-http_gzip_static_module \
  --without-mail_pop3_module \
  --without-mail_imap_module \
  --without-mail_smtp_module \
  --without-http_ssi_module \
  --without-http_userid_module \
  --without-http_access_module \
  --without-http_auth_basic_module  \
  --without-http_geo_module \
  --without-http_map_module \
  --without-http_split_clients_module  \
  --without-http_fastcgi_module  \
  --without-http_uwsgi_module  \
  --without-http_scgi_module  \
  --without-http_memcached_module \
  --without-http_limit_zone_module \
  --without-http_limit_req_module  \
  --without-http_empty_gif_module  \
  --without-http_browser_module \
  --with-pcre=/srv/pcre-8.34 \
  --add-module=`passenger-config --root`/src/nginx_module
make && make install
```
passenger version > 4.0
--add-module=`passenger-config --root`/ext/nginx

passenger version 5.0 
--add-module=`passenger-config --root`/src/nginx_module

chmod +x install_nginx_passenger.sh

install_nginx_passenger.sh














