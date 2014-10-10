# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

Vagrant.require_version ">= 1.6.0"

MY_PATH = File.dirname(__FILE__)
NODES_CONF = File.join(MY_PATH, "nodes.json")
TEST_ROOT_CA_PATH = File.join(MY_PATH, "apps", "certs", "rootCA.pem")
ETCD_ENVVARS = File.join(MY_PATH, "nodes-conf", "etcd-envvars.sh")


UPDATE_CHANNE = "alpha"

Vagrant.configure("2") do |config|
  config.vm.box = "coreos-%s" % UPDATE_CHANNE
  config.vm.box_version = ">= 308.0.1"
  config.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % UPDATE_CHANNE

  # To enable ssh agent fowarding and
  # add vagrant insecure_private_key to ssh-agent for fleet ssh
  # if you are using a different private_keys vs the default vagrant's insecure_private_key,
  # add them to ssh-agent: 
  #      ssh-add <your_cluster_private_key>
  config.ssh.forward_agent = true
  %x( if [[ `ssh-add -l` != *insecure_private_key* ]];then ssh-add ~/.vagrant.d/insecure_private_key; fi )

  config.vm.provider :vmware_fusion do |vb, override|
    override.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant_vmware_fusion.json" % UPDATE_CHANNE
  end

  config.vm.provider :virtualbox do |v|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  # plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  # read vm and chef configurations from JSON files
  nodes_config = (JSON.parse(File.read(NODES_CONF)))['nodes']

  nodes_config.each do |node|
    node_name   = node[0] # name of node
    node_values = node[1] # content of node
    
    config.vm.define vm_name = node_name do |config|
      config.vm.hostname = node_name
      config.vm.network :private_network, ip: node_values['ip']

      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
          host:  port['host'],
          guest: port['guest'],
          id:    port['id']
      end

      config.vm.provider :virtualbox do |vb|
        if node_values['memory']
          vb.memory = node_values['memory']
        end
        if node_values['cpu']
          vb.cpus = node_values['cpu']
        end
      end

      # enable NFS for sharing the host machine into the coreos-vagrant VM.
      config.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']
      config.vm.provision :shell, :inline => "ln -sf /home/core/share/apps /var/lib/apps && ln -sf /home/core/share/data /var/lib/apps-data", :privileged => true
  
      # To make the self-signed certs truesed for clients in docker, update the system bundled certs with the test rootCA.
      # This should be done before docker.service starts so it can pick up the testing rootCA.
      config.vm.provision :file, :source => "#{TEST_ROOT_CA_PATH}", :destination => "/tmp/XXX-Dockerage.pem"
      config.vm.provision :shell, :inline => "cd /etc/ssl/certs && ([[ -f XXX-Dockerage.pem ]] || (mv /tmp/XXX-Dockerage.pem . && update-ca-certificates))", :privileged => true

      if node_values['etcd-envvars'] && File.exist?(node_values['etcd-envvars'])
        config.vm.provision :shell, :inline => "/bin/mkdir -p /etc/profile.d", :privileged => true
        config.vm.provision :file, :source => "#{node_values['etcd-envvars']}", :destination => "/tmp/etcd-envvars.sh"
        config.vm.provision :shell, :inline => "mv /tmp/etcd-envvars.sh /etc/profile.d/", :privileged => true
      end
  
      # enable ssh-agent forwarding in coreos-vagrant VM.
      config.vm.provision \
        :shell, \
        :inline => "echo -e 'Host #{node_values['ip_mask']}.* *.#{node_values['dns_domain']}\n  StrictHostKeyChecking no\n  ForwardAgent yes' > .ssh/config; chmod 600 .ssh/config", \
        :privileged => false

      if node_values['cloud_init'] && File.exist?(node_values['cloud_init'])
        config.vm.provision :file, :source => "#{node_values['cloud_init']}", :destination => "/tmp/vagrantfile-user-data"
        config.vm.provision :shell, :inline => "mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", :privileged => true
      end
    end
  end
end
