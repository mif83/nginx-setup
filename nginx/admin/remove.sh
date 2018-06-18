#!/bin/bash

BASEDIR=$(dirname $0)'/'
cd $BASEDIR
ABSPATH="$PWD/"
cd ../conf.d
NGINXCONF="$PWD/"
cd ../ssl
SSLPATH="$PWD/"
read -p "Enter domain name: " domain

rm $NGINXCONF$domain.conf
rm $SSLPATH$domain.key
rm $SSLPATH$domain.csr
rm $SSLPATH$domain.crt

service nginx restart
