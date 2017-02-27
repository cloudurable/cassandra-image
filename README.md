Goal of this project is to create AMI, Vagrant Box and Docker base images that one could use to deploy Cassandra.

The docker image is hosted on docker hub (see [DockerHub](https://hub.docker.com/r/cloudurable/cassandra/)).
The vagrant box is hosted on Atlas see ([Atlas](https://atlas.hashicorp.com/cloudurable/boxes/cassandra)).
The source code is hosted on GitHub (see [GitHub](https://github.com/cloudurable/cassandra-image)).

Key features of image, AMI, Vagrant box

* Uses JBOD instead of RAID (not done)
* Uses ergonomics to configure Cassandra based on deployment environment (preliminary work done)
* Sets up security if requested (not done)
* Sets up TLS/SSL if requested (not done)
* Sets up HD encryption if requested (not done, or use encrypted EBS instances)
* Sets up users (not done)
* Installs Cassandra as a systemd service (not done) 
* Allows cloud deploy (not done)
* Monitoring (CloudWatch, InfluxDB) (not done)
* Log aggregation (CloudWatch, ELK) (not done)
* Installs JEMalloc and configures Cassandra to use off heap no JVM (done)
* Install JNA (done)
* Configures OS (Linux) to be performant (done)


## Create a vagrant box
```
git clone https://github.com/cloudurable/cassandra-image.git
cd cassandra-image 
vagrant up 

# Connect to vagrant box
cqlsh localhost 19042
```

## Connect to vagrant image
```
vagrant ssh
```

## Create a docker image
```
git clone https://github.com/cloudurable/cassandra-image.git
cd cassandra-image 
bin/start-image.sh

# Connect to docker image
cqlsh localhost 29042
```

## Provisioning
We use packer and vagrant to create images. 

#### Running setup scripts
```
## cd ~; mkdir github; cd github; git clone https://github.com/cloudurable/cassandra-image
$ cd ~/github/cassandra-image
$ pwd
~/github/cassandra-image
## Setup keys
$ bin/setupkeys-cassandra-security.sh
## Download binaries
$ bin/prepare_binaries.sh
## Bring Vagrant cluster up
$ vagrant up
```


#### Working with ansible from bastion

```sh
$ vagrant ssh bastion
```



First setup ssh-agent and add keys to it.

#### Start ssh-agent and add keys
```
$ ssh-agent bash
$ ssh-add ~/.ssh/test_rsa
```

#### Ansible Ping server
```sh
$ ansible node0 -m ping
```

Output
```
node0 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}

```



#### Ansible Ping servers

```sh
$ ansible nodes  -m ping
```

Output
```
node0 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
node2 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
node1 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}

```

## Setting up my MacOSX to run Ansible against instances

Move to the where you checked out the [project](https://github.com/cloudurable/cassandra-image).

```sh
cd ~/github/cassandra-image
```

#### Add bastion, node0, etc. to /etc/hosts
```sh
$ cat /etc/hosts

### Used for ansible/ vagrant
192.168.50.20  bastion
192.168.50.4  node0
192.168.50.5  node1
192.168.50.6  node2
192.168.50.7  node3
192.168.50.8  node4
192.168.50.9  node5

```

#### Add keys to known_hosts to avoid prompts
```sh
$ ssh-keyscan node0 node1 node2  >> ~/.ssh/known_hosts

```


#### Start ssh-agent and add keys
```
$ ssh-agent bash
$ ssh-add ~/.ssh/test_rsa
```

#### Notice the ansible.cfg file and inventory.ini file in the project dir

```
$ cd ~/github/cassandra-image

$ cat ansible.cfg 
[defaults]
hostfile = inventory.ini

cat inventory.ini 
[nodes]
node0 ansible_user=vagrant
node1 ansible_user=vagrant
node2 ansible_user=vagrant


```

Ansible will use these. 



#### Ansible Ping server
```sh
$ ansible node0 -m ping
```

Output
```
node0 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}

```



#### Ansible Ping servers

```sh
$ ansible nodes  -m ping
```

Output
```
node0 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
node2 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
node1 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}

```






## More details to follow


## About us
[Cloudurable](http://cloudurable.com/) provides AMIs, cloudformation templates and monitoring tools 
to support [Cassandra in production running in EC2](http://cloudurable.com/services/index.html). 
We also teach advanced [Cassandra courses which teaches how one could develop, support and deploy Cassandra to production in AWS EC2](http://cloudurable.com/services/index.html). 


