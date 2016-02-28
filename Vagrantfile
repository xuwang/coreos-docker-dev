# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

Vagrant.require_version ">= 1.6.0"

MY_PATH = File.dirname(__FILE__)
CLOUD_INIT_PATH =  File.join(MY_PATH, "cloud-init")

# Define the vm nodes in json
NODES_CONF = File.join(MY_PATH, "nodes-conf", "standalone.json")
#NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster.json")
#NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster-large.json")
#NODES_CONF = File.join(MY_PATH, "nodes-conf", "flannel.json")
#NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster-flannel.json")
#NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster-secure-etcd.json")


TEST_ROOT_CA_PATH = File.join(MY_PATH, "apps", "certs", "rootCA.pem")
UPDATE_CHANNE = "beta"

Vagrant.configure("2") do |config|
	config.vm.box = "coreos-%s" % UPDATE_CHANNE
	config.vm.box_version = ">= 899.8.0"
	config.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % UPDATE_CHANNE

	# To enable ssh agent fowarding and
	# add vagrant insecure_private_key to ssh-agent for fleet ssh
	# if you are using a different private_keys vs the default vagrant's insecure_private_key,
	# add them to ssh-agent: 
	#			 ssh-add <your_cluster_private_key>
	config.ssh.forward_agent = true
	# Don't generate new ssh key for each box because it will be override by coreos' update-ssh-keys on reboot
	config.ssh.insert_key=false
	%x( if [[ `ssh-add -l` != *insecure_private_key* ]];then ssh-add ~/.vagrant.d/insecure_private_key; fi )

	config.vm.provider :vmware_fusion do |vb, override|
		override.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant_vmware_fusion.json" % UPDATE_CHANNE
	end

	config.vm.provider :virtualbox do |v|
		# On VirtualBox, we don't have guest additions or a functional vboxsf
		# in CoreOS, so tell Vagrant that so it can be smarter.
		v.check_guest_additions = false
		v.functional_vboxsf = false
	end

	# plugin conflict
	if Vagrant.has_plugin?("vagrant-vbguest") then
		config.vbguest.auto_update = false
	end
	
	
	# config vm with the data from node_conf
	def config_vm(config, node_name, node_conf)
		config.vm.define vm_name = node_name do |config|
			config.vm.network :private_network, ip: node_conf['ip']
			config.vm.hostname = node_name
		
			# configures all forwarding ports in JSON array
			ports = node_conf['ports']
			ports.each do |port|
				config.vm.network :forwarded_port,
					host:	port['host'],
					guest: 	port['guest'],
					id:		port['id']
			end

			config.vm.provider :virtualbox do |vb|
				if node_conf['memory']
					vb.memory = node_conf['memory']
				end
				if node_conf['cpu']
					vb.cpus = node_conf['cpu']
				end
			end

			# enable NFS for sharing the host machine into the coreos-vagrant VM
			config.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp,noatime']
			# note: many example application containers would require nfs volume to be "no_root_squash"
			#       e.g. chown on app dir is required.
			#       on mac os no_root_squash is not supported, instead using -maproot=0:0
			config.nfs.map_uid = 0
			config.nfs.map_gid = 0
			config.vm.provision :shell, \
				:inline => "ln -sf /home/core/share/apps /var/lib/ && ln -sf /home/core/share/apps-data /var/lib/", \
				:privileged => true

			# To make the self-signed certs truesed for clients in docker, update the system bundled certs with the test rootCA.
			# This should be done before docker.service starts so it can pick up the testing rootCA.
			config.vm.provision :file, :source => "~/.vagrant.d/insecure_private_key", :destination => "/home/core/.ssh/id_rsa_fleetui"
                        # Copy in vagrant private key so it can be used by fleetui container to check cluster status
			config.vm.provision :file, :source => "#{TEST_ROOT_CA_PATH}", :destination => "/tmp/XXX-Dockerage.pem"
			config.vm.provision :shell, \
				:inline => "cd /etc/ssl/certs && ([[ -f XXX-Dockerage.pem ]] || (mv /tmp/XXX-Dockerage.pem . && update-ca-certificates))", \
				:privileged => true

			# enable ssh-agent forwarding in coreos-vagrant VM.
			config.vm.provision :shell, \
				:inline => "echo -e 'Host #{node_conf['subnet']}.* *.#{node_conf['dns_domain']}\n  StrictHostKeyChecking no\n  ForwardAgent yes' > .ssh/config; chmod 600 .ssh/config", \
				:privileged => false

			cloud_init = node_conf['cloud_init']
			if cloud_init then
				cloud_init.each do | cnf |
					cnf_path =  File.join(CLOUD_INIT_PATH, "#{cnf}")
					if File.exist?(cnf_path) then
						config.vm.provision :file, :source => cnf_path, :destination => "/tmp/cloud-init/#{cnf}"
					end
				end
				config.vm.provision \
					:shell, 
					:inline => "cat /tmp/cloud-init/* > /tmp/vagrantfile-user-data; mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", \
					:privileged => true	
			end
		end
	end

	# read vm configurations from JSON files
	nodes_config = (JSON.parse(File.read(NODES_CONF)))['nodes']
	
	if nodes_config then
		nodes_config.each do |node|
			node_name = node[0]	# name of node
			node_conf = node[1]	# content of node
			config_vm(config, node_name, node_conf)
		end
	end
end
