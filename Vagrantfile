# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |vb|
       # Customize the amount of memory on the VM:
       vb.memory = "3096"
       vb.cpus = 4
  end

  config.vm.provision "shell", inline: <<-SHELL
        sudo /vagrant/scripts/000-vagrant-provision.sh
  SHELL


  config.vm.define "node0" do |node0|
    node0.vm.network "forwarded_port", guest: 7000, host: 17000
    node0.vm.network "forwarded_port", guest: 7199, host: 17199
    node0.vm.network "forwarded_port", guest: 9042, host: 19042
    node0.vm.network "private_network", ip: "192.168.50.4"

    node0.vm.provision "shell", inline: <<-SHELL
                sudo /opt/cassandra/bin/cassandra-cloud -cluster-name test \
                -client-address 192.168.50.4 \
                -cluster-address  192.168.50.4 \
                -cluster-seeds 192.168.50.4,192.168.50.5,192.168.50.6

                /opt/cassandra/bin/cassandra -R
    SHELL
  end

  config.vm.define "node1" do |node1|
    node1.vm.network "forwarded_port", guest: 7000, host: 27000
    node1.vm.network "forwarded_port", guest: 7199, host: 27199
    node1.vm.network "forwarded_port", guest: 9042, host: 29042
    node1.vm.network "private_network", ip: "192.168.50.5"

    node1.vm.provision "shell", inline: <<-SHELL
                sudo /opt/cassandra/bin/cassandra-cloud -cluster-name test \
                -client-address 192.168.50.5 \
                -cluster-address  192.168.50.5 \
                -cluster-seeds 192.168.50.4,192.168.50.5,192.168.50.6

                /opt/cassandra/bin/cassandra -R
    SHELL
  end

  config.vm.define "node2" do |node2|
    node2.vm.network "forwarded_port", guest: 7000, host: 37000
    node2.vm.network "forwarded_port", guest: 7199, host: 37199
    node2.vm.network "forwarded_port", guest: 9042, host: 39042
    node2.vm.network "private_network", ip: "192.168.50.6"

    node2.vm.provision "shell", inline: <<-SHELL
                sudo /opt/cassandra/bin/cassandra-cloud -cluster-name test  \
                -client-address 192.168.50.6 \
                -cluster-address  192.168.50.6 \
                -cluster-seeds 192.168.50.4,192.168.50.5,192.168.50.6


                /opt/cassandra/bin/cassandra -R
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
