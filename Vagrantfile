Vagrant.configure(2) do |config|
	config.vm.define "devops-box" do |devbox|
		devbox.vm.box = "ubuntu/focal64"
    		#devbox.vm.network "private_network", ip: "192.168.199.9"
                devbox.vm.network :forwarded_port, guest: 9000, host: 9000, host_ip: "127.0.0.1"
    		#devbox.vm.hostname = "devops-box"
      		devbox.vm.provision "shell", path: "scripts/install.sh"
    		devbox.vm.provider "virtualbox" do |v|
    		  v.memory = 4096
    		  v.cpus = 2
    		end
	end
end
