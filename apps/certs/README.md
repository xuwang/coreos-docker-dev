## Setup HTTPS testing certs for register.docker.local and index.docker.local

###Generate a self-signed multi-domain certs:

    cd generate && ./gen.sh

###To entrust this self-signed certs on a test vbox:
   
    sudo cp generate/rootCA.pem /etc/ssl/certs/XXX-Dockerage.pem
    cd /etc/ssl/certs && sudo update-ca-certificates [--fresh]

###To test ssl connection and the cert:

    openssl s_client -showcerts -connect registry.docker.local:443



