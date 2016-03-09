
Linux

查看系统配置
cat /proc/cpuinfo
查看硬盘分区情况
df -lh
查看服务器硬盘大小
fdish -l


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

2.1 passenger-install-nginx-module 安装

rvmsudo passenger-install-nginx-module

建议选择1.Yes: download  设置安装目录

2.2 编译安装

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
#!/bin/bash
cpwd=`pwd`;
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

查看nginx版本

nginx/sbin/nginx -v
nginx version: nginx/1.8.0

4. setting nginx config

conf/nginx.conf
```
user  www root;
worker_processes  2;

events {
  use epoll; #epoll事件模型
  multi_accept on; #使用multi_accept 告诉Nginx 收到一个新连接通知后接受尽可能多的连接
  worker_connections  10240;
}

http {
  passenger_root /usr/local/rvm/gems/ree-1.8.7-2012.02/gems/passenger-4.0.46;
  passenger_ruby /usr/local/rvm/gems/ree-1.8.7-2012.02/wrappers/ruby;

  include       mime.types;
  include       gzip.conf;
  default_type  application/octet-stream;
  charset utf-8;

  server_name_in_redirect on; #设置 server_name_in_redirect off; 让 nginx 在处理自己内部重定向时不默认使用  server_name 设置中的第一个域名
  port_in_redirect off; #禁止Nginx重定向至监听端口

  server_tokens off; #隐藏Nginx的版本号

  sendfile on;
  tcp_nopush on; #两个选项都对网络连接 在nginx中使用了send_file 并且配合TCP_CORK/TCP_NOPUSH进行操作
  tcp_nodelay on; #两个选项都对网络连接
  keepalive_timeout 60;

  passenger_show_version_in_header off;
  passenger_buffer_response on; #当这个参数被配置为on时，Passenger会对页面的输出进行缓存
  passenger_max_instances_per_app 15; #可以限制某个app instance占用了所有的pool和CPU时间片
  passenger_max_pool_size 15; #配置Passenger同一时刻可以并行的RoR/Rack应用实例的数量(注意是所有Rails应用)
  passenger_pool_idle_time 300; #指定了每个app instance最长的空闲时间

  server {
    listen 80;
    listen 3000;
    listen 3012; # callback 使用

    charset utf-8;
    root   /srv/rorapps/huafei2/public;
    rails_env production;
    passenger_enabled on;
    passenger_min_instances 2;

    proxy_redirect off;
    proxy_pass_request_headers  on;

    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header Host $host:$proxy_port;
    proxy_set_header Remote-addr $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

    proxy_connect_timeout 600;
    proxy_send_timeout 600;
    proxy_read_timeout 900;
    proxy_intercept_errors on;

    client_max_body_size 900m;
    client_body_buffer_size 128k;

    proxy_ignore_client_abort on;

    proxy_buffer_size 1024k;
    proxy_buffers 32 1024k;
    proxy_busy_buffers_size 2048k;
    proxy_temp_file_write_size 2048k;


    proxy_hide_header X-Powered-By;
    proxy_hide_header X-Runtime;
    proxy_hide_header X-UA-Compatible;
  }

}


```
关于passenger推荐(http://www.blogjava.net/pengpenglin/archive/2011/11/13/363643.html)


5. start/reload/stop nginx

/srv/nginx/sbin/nginx
/srv/nginx/sbin/nginx -s stop
/srv/nginx/sbin/nginx -s reload




install postgres


1. download

下载postgresql最新版：http://www.postgresql.org/ftp/source/

wget https://ftp.postgresql.org/pub/source/v9.4.5/postgresql-9.4.5.tar.bz2

bzip2 -d postgresql-9.4.5.tar.bz2

tar vxf postgresql-9.4.5.tar

2. postgresql install

yum install libxml2 libxml2-dev libxml2-libxslt  libxml2-dev libxslt1-dev libossp-uuid-dev gettext python-dev libperl-dev libreadline-dev libtool 

cd postgresql-9.4.5

vim install_postgresql.sh

```ruby
#!/bin/bash
cpwd=`pwd`;
echo $cpwd;
cd /srv/postgresql-9.4.5;
make clean;
./configure --prefix=${cpwd}/pgsql \
--enable-nls \
--enable-depend \
--with-perl \
--with-python \
--with-openssl \
--with-ossp-uuid \
--with-libxml \
--with-libxslt

#安装contrib目录下的一些工具，是第三方组织的一些工具代码，建议安装
cd /srv/postgresql-9.4.5/contrib;
make && make install;

cd /srv/postgresql-9.4.5;
make && make install;

groupadd pgsql;
useradd -g pgsql pgsql;
mkdir ${cpwd}/pgdata;
cd ${cpwd}/pgsql;
chown pgsql.pgsql -R ${cpwd}/pgsql/;
chown pgsql.pgsql -R ${cpwd}/pgdata/;

```

error

```
checking for Perl archlibexp... /usr/lib64/perl5
checking for Perl privlibexp... /usr/share/perl5
checking for Perl useshrplib... true
checking for flags to link embedded Perl... Can't locate ExtUtils/Embed.pm in @INC (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 .).
BEGIN failed--compilation aborted.
no
configure: error: could not determine flags for linking embedded Perl.
This probably means that ExtUtils::Embed or ExtUtils::MakeMaker is not
installed.
```
yum install perl-ExtUtils-Embed -y


```
checking for uuid_export in -lossp-uuid... no
checking for uuid_export in -luuid... no
configure: error: library 'ossp-uuid' or 'uuid' is required for OSSP UUID
```
yum install uuid-devel



3. init & start postgres
sudo su root

su - pgsql

数据库初始化
/srv/pgsql/bin/initdb -D /srv/pgdata

/srv/pgsql/bin/postgres -D /srv/pgdata
or
/srv/pgsql/bin/pg_ctl -D /srv/pgdata -l logfile start
/srv/pgsql/bin/pg_ctl -D /srv/pgdata start



4. 碰到一个问题就是 可以连接数据服务器的机器上的pg客户端和 数据库服务器的pg版本不一致 导致无法直接导入和导出数据

本方法解决

导出： pg_dump -U fgcc -h host  database -t users -f users.sql

处理数据： 在vim里面,用%s/“//g把所有的"符号替换掉 并把数据最上面的那行字段定义数据删除掉

执行
/srv/pgsql94/bin/psql -U main_user -h host -d database -c "COPY users from '/srv/pgdata94/data/users.csv' with delimiter ',' "













