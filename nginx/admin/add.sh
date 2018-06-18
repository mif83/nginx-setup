#!/bin/bash

BASEDIR=$(dirname $0)'/'
cd $BASEDIR
ABSPATH="$PWD/"
cd ../conf.d
NGINXCONF="$PWD/"
cd ../ssl
SSLPATH="$PWD/"
read -p "Enter domain name: " domain
read -p "Enter port to proxy: " proxyport
cp $ABSPATH.cfg $ABSPATH$domain.conf
cp $ABSPATH.nginx $NGINXCONF$domain.conf
sed -i 's/mydomain/'$domain'/g' $ABSPATH$domain.conf
sed -i 's~%cert%~'$SSLPATH$domain'.crt~g; s~%certkey%~'$SSLPATH$domain'.key~g; s~%port%~'$proxyport'~g; s~%domain%~'$domain'~g' $NGINXCONF$domain.conf
mkdir /var/www/$domain
chmod +777 /var/www/$domain
cd $SSLPATH
openssl genrsa -out $domain.key 2048
openssl req -new -key $domain.key -out $domain.csr -config $ABSPATH$domain.conf -extensions v3_req
openssl x509 -req -in $domain.csr -CA root.crt -CAkey root.key -CAcreateserial -out $domain.crt -days 5000 -extfile $ABSPATH$domain.conf -extensions v3_req
openssl x509 -text -noout -in $domain.crt
rm $ABSPATH$domain.conf
echo -e "\n127.0.0.1\t"$domain"\n" >> /etc/hosts
service network-manager restart
service nginx restart
