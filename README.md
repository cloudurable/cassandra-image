Goal of this project is to create AMI, Vagrant Box and Docker base images that one could use to deploy Cassandra.

The docker image is hosted on docker hub (see [DockerHub](https://hub.docker.com/r/cloudurable/cassandra/)).
The vagrant box is hosted on Atlas see ([Atlas](https://atlas.hashicorp.com/cloudurable/boxes/cassandra)).
The source code is hosted on GitHub (see [GitHub](https://github.com/cloudurable/cassandra-image)).

Key features of image, AMI, Vagrant box

* Uses JBOD instead of RAID
* Uses ergonomics to configure Cassandra based on deployment environment
* Sets up security if requested
* Sets up TLS/SSL if requested
* Sets up HD encryption if requested
* Sets up users
* Installs Cassandra as a systemd service 
* Allows cloud deploy 
* Monitoring (CloudWatch, InfluxDB)
* Log aggregation (CloudWatch, ELK)


## Create a vagrant box
```
git clone https://github.com/cloudurable/cassandra-image.git
cd cassandra-image 
vagrant up 
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
```

## Provisioning
We use packer and vagrant to create images. 


## About us
[Cloudurable](http://cloudurable.com/) provides AMIs, cloudformation templates and monitoring tools 
to support [Cassandra in production running in EC2](http://cloudurable.com/services/index.html). 
We also teach advanced [Cassandra courses which teaches how one could develop, support and deploy Cassandra to production in AWS EC2](http://cloudurable.com/services/index.html). 

## More details to follow

