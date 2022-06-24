# DevOps box
* A vagrant project with an ubuntu box with the tools needed to do DevOps

# tools included
* Terraform
* AWS CLI
* Ansible

# SSH via VScode
* `vagrant ssh-config` to show ssh config.
* ``` 
  Host devops-box
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /Users/Someone/Documents/devops-box/.vagrant/machines/devops-box/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  ```
* Open VScode and `⌘⇧P` and selecting Remote-SSH: Open Configuration File.
* Paste the vagrant ssh config.
* `⌘⇧P` and selecting Remote-SSH: Connect to Host and select `devops-box`.
