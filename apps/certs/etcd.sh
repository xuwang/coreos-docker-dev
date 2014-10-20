#!/bin/bash -e

echo "creating the etcd.key and etcd.csr...."
openssl req -new -out etcd.csr -config etcd.cnf

echo "creating the etcd-client.key and etcd-client.csr...."
openssl req -new -out etcd-client.csr -config etcd-client.cnf

echo "signing etcd.csr..."
openssl x509 -req -days 9999 -in etcd.csr -CA rootCA.pem -CAkey rootCA.key \
		-CAcreateserial -extensions v3_req -out etcd.crt -extfile etcd.cnf

echo "signing etcd-client.csr..."
openssl x509 -req -days 9999 -in etcd-client.csr -CA rootCA.pem -CAkey rootCA.key \
		-CAcreateserial -extensions v3_req -out etcd-client.crt -extfile etcd-client.cnf

echo "keep the secret to yourself."
chmod 600 *.key

echo "etcd.crt is generated:"
openssl x509 -text -noout -in etcd.crt

echo "etcd-client.crt is generated:"
openssl x509 -text -noout -in etcd-client.crt