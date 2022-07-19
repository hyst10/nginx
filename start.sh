#!/usr/bin/env bash

APPDIR="/apps/nginx"
PKGNAME="nginx-1.20.0"
CPU_NUM=$(lscpu | awk -F: '/socket/{print $2}')
MAKE_OPT="./configure --prefix=${APPDIR} \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-pcre \
--with-stream \
--with-stream_ssl_module \
--with-stream_realip_module"

_nginx_make_install() {
    wget -c http://nginx.org/download/${PKGNAME}.tar.gz
    apt install bison bison-devel zlib-devel libcurl-devel libarchive-devel boost-devel gcc gcc-c++ cmake ncurses-devel gnutls-devel libxml2-devel openssl-devel libevent-devel libaio-devel -y
    apt install -y vim lrzsz tree screen psmisc lsof tcpdump wget ntpdategcc gcc-c++ glibc glibc-devel pcre pcre-devel openssl openssl-devel systemd-develnet-tools iotop bc zip unzip zlib-devel bash-completion nfs-utils automake libxml2libxml2-devel libxslt libxslt-devel perl perl-ExtUtils-Embed
    # getent passwd nginx | awk -F: '{print $3}' | grep 6000 -q || (userdel nginx && useradd -s /sbin/nologin -u 6000)
    tar xf ${PKGNAME}.tar.gz
    cd ${PKGNAME} && ${MAKE_OPT} && make -j${CPU_NUM} && make install
}

_nginx_make_install

gh release create ${PKGNAME}
gh release create ${PKGNAME} --title "${PKGNAME} (beta)" --notes "this is a beta release" --prerelease
