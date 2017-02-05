# -*- mode: ruby -*-
# vi: set ft=ruby :

numCassandraNodes = 3

Vagrant.configure("2") do |config|


  config.vm.box = "centos/7"


  # Define Cassandra Nodes
  (0..numCassandraNodes-1).each do |i|

        port_number = i + 4
        ip_address = "192.168.50.#{port_number}"
        seed_addresses = "192.168.50.4,192.168.50.5,192.168.50.6"
        config.vm.define "node#{i}" do |node|
            node.vm.network "private_network", ip: ip_address
            node.vm.provider "virtualbox" do |vb|
                   vb.memory = "2048"
                   vb.cpus = 4
            end


            node.vm.provision "shell", inline: <<-SHELL
                sudo /vagrant/scripts/000-vagrant-provision.sh

                sudo /opt/cassandra/bin/cassandra-cloud -cluster-name test \
                -client-address     #{ip_address} \
                -cluster-address    #{ip_address} \
                -cluster-seeds      #{seed_addresses}

                /opt/cassandra/start.sh
            SHELL
        end
  end


  # Define Bastion Node
  config.vm.define "bastion" do |node|
            node.vm.network "private_network", ip: "192.168.50.20"
            node.vm.provider "virtualbox" do |vb|
                   vb.memory = "256"
                   vb.cpus = 1
            end


            node.vm.provision "shell", inline: <<-SHELL
                yum install -y epel-release
                yum update -y
                yum install -y  ansible

                sudo mkdir ~/resources
                sudo cp -r /vagrant/resources/* ~/resources/
                sudo  /vagrant/scripts/002-hosts.sh

                ssh-keyscan node0 node1 node2  >> .ssh/known_hosts



                cp /vagrant/resources/server/certs/*  ~/.ssh/
                mkdir ~/playbooks
                cp -r /vagrant/playbooks/* ~/playbooks/
                sudo cp /vagrant/resources/home/inventory.ini /etc/ansible/hosts
                chown -R vagrant:vagrant /home/vagrant
            SHELL
  end



  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  config.push.define "atlas" do |push|
     push.app = "cloudurable/cassandra"
  end


end
