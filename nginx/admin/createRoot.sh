#!/bin/bash
cd ../ssl
openssl genrsa -out root.key 2048
openssl req -x509 -new -key root.key -days 10000 -out root.crt