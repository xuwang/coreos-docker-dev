#!/bin/bash -e

echo "creating rootCA.key and rootCA.pem ..."
openssl req -x509 -new -nodes -days 9999 -config rootCA.cnf -out rootCA.pem

echo "creating the site.key and site.csr...."
openssl req -new -out site.csr -config site.cnf

echo "signing site.csr..."
openssl x509 -req -days 9999 -in site.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -extensions v3_req -out site.crt -extfile site.cnf

#see https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html
echo "generating dhparam.pem/2048 for strengthening the server security ..."

openssl dhparam -out dhparam.pem 2048
echo "keep the secret to yourself."
chmod 600 *.key *.pem

echo "site.crt is generated:"
openssl x509 -text -noout -in site.crt