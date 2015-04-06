# Preparing Your Mac for CoreOS-Vagrant

##Install [Homebrew][homebrew]

The missing package manager for OS X.

	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##Install [VirtualBox][virtualbox] 4.3.10 or greater

With Homebrew, it’s trivial to install Virtualbox which is a prerequisite to running vagrant on OSX.

	brew update
	brew install caskroom/cask/brew-cask
	brew cask install virtualbox

##Install [Vagrant][vagrant] 1.6 or greater

Don't know what Vagrant for? You must be kidding, get out of here!

##Install etcdctl and fleetctl
   
	brew install go etcdctl fleetctl
	etcdctl --version
	fleetctl version

Set fleet tunnel for vagrant coreos:

        export FLEETCTL_TUNNEL=localhost:$(vagrant ssh-config | grep Port | head -1 | awk '{print $2}')
	
You need to fresh fleetctl known_hosts after vagrant destroy and up:

	rm ~/.fleetctl/known_hosts

## Add SkyDNS as a nameserver to the host
 
You may like to adding the SkyDNS as a local dns server.  
Follow the instruction on [ Editing DNS and search domain settings on Mac OS X](http://support.apple.com/kb/ph6373)  

    add '172.17.8.101' to DNS Servers           # assuming skydns is running on 172.17.8.101
    add 'docker.local' to Search Domains        # assuming the skydns auth domain is docker.local

This would enable you to address services registered with SkyDNS by name/fqdn on the host,
without touching /etc/hosts.

[homebrew]: http://brew.sh/
[virtualbox]: https://www.virtualbox.org/
[vagrant]: https://www.vagrantup.com/downloads.html
