
# Run FleetUI on CoreOS

This example contains configurations that you can find in git repo https://github.com/xuwang/coreos-docker-dev.git. For a quick start, fireup the Vagrant cluster and start fleetui as documented in the repo's README.

# Reference details

* Generate ssh key for fleetui

        ssh-keygen -f /home/core/.ssh/id_rsa_fleetui -t rsa -C "fleetui@example.com"
        
* Add the public key to /home/core/.ssh/authorized_keys.d
 
        cp /home/core/.ssh/id_rsa_fleetui.pub /home/core/.ssh/authorized_keys.d
        sudo /usr/bin/update-ssh-keys

* Docker options
* 
        # env for fleet-ui
        BUILDER_IMAGE=xuwang/docker-fleetui-builder
        FLEETUI_IMAGE=fleet-ui
        OPTS="-p 3000:3000 \
        -v /home/core/.ssh/id_rsa_fleetui:/root/id_rsa"

* Unit file (fleet-ui.service)
        [Unit]
        Description=fleet-ui
        Requires=docker.service
        After=docker.service

        [Service]
        EnvironmentFile=/etc/environment
        EnvironmentFile=/var/lib/apps/fleet-ui/envvars
        TimeoutStartSec=0
        ExecStartPre=-/usr/bin/docker rm %n
        ExecStartPre=/usr/bin/bash -c "/var/lib/apps/bin/is_loaded ${FLEETUI_IMAGE} || \
                docker run --rm -v /var/run/docker.sock:/var/run/docker.sock ${BUILDER_IMAGE}"
        ExecStart=/usr/bin/bash -c "/usr/bin/docker run --rm --name %n ${OPTS} ${FLEETUI_IMAGE}"
        ExecStop=-/usr/bin/docker stop %n
        RestartSec=10
        Restart=always

* Start the fleetui:

        fleetctl start fleet-ui.service
        fleetctl list-units

This may takes somethime for fleet-ui docker to build. 

* Go to browser, for example: 172.17.8.102:3000

![fleet-ui machine list](images/fleetui.png "fleet-ui machine list")
