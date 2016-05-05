Vagrant.configure("2") do |config|
  VAGRANT_DEFAULT_PROVIDER = 'docker'
  config.vm.synced_folder "./", "/home/vagrant", disabled: true, type: "rsync", rsync__exclude: ".git/"
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.hostname = "test.local"

  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.name = "test.local"
    d.has_ssh = true
    d.ports = ["443:443","80:80","3306:3306","9000:9000"]
  end
  config.ssh.port = 22
#  config.vm.provision :shell, :path => "ansible/windows.sh", args: ["test"]
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbook.yml"
  end

end

