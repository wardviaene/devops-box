Vagrant.configure(2) do |config|
	config.vm.define "devops-box" do |devbox|
		devbox.vm.box = "ubuntu/xenial64"
    		#devbox.vm.network "private_network", ip: "192.168.199.9"
    		#devbox.vm.hostname = "devops-box"
      		devbox.vm.provision "shell", path: "scripts/install.sh"
    		devbox.vm.provider "virtualbox" do |v|
                #config.vm.box_check_update = false
    		  v.memory = 4096
    		  v.cpus = 2
		 # Upload user's ssh key into box so it can be used for downloading stuff from stash
  		ssh_key_path = "./.ssh/"
  		config.vm.provision "shell", inline: "mkdir -p /home/vagrant/.ssh"
  		config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa3' }", destination: "/home/vagrant/.ssh/id_rsa"
  		config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa3.pub' }", destination: "/home/vagrant/.ssh/id_rsa.pub"
		end
	end
end
