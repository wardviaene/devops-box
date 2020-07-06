#Vagrant.configure(1) do |config|
#	config.vm.boot_mode = :gui
#end

Vagrant.configure(2) do |config|
	config.vm.boot_timeout = 600
	config.vm.define "devops-box" do |devbox|
		devbox.vm.box = "ubuntu/bionic64"
   		#devbox.vm.network "private_network", ip: "192.168.199.9"
   		#devbox.vm.hostname = "devops-box"
		devbox.vm.provision "shell", path: "scripts/install.sh"
		devbox.vm.provider "virtualbox" do |v|
		  #v.gui = true
		  v.memory = 4096
		  v.cpus = 2
   		end
	end
end
