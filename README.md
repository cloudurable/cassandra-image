Goal of this project is to create AMI, Vagrant Box and Docker base images that one could use to deploy Cassandra.

The docker image is hosted on docker hub (see [DockerHub](https://hub.docker.com/r/cloudurable/cassandra/)).
The vagrant box is hosted on Atlas see ([Atlas](https://atlas.hashicorp.com/cloudurable/boxes/cassandra)).
The source code is hosted on GitHub (see [GitHub](https://github.com/cloudurable/cassandra-image)).

Key features of image, AMI, Vagrant box

* Uses JBOD instead of RAID (not done)
* Uses ergonomics to configure Cassandra based on deployment environment (not done)
* Sets up security if requested (not done)
* Sets up TLS/SSL if requested (not done)
* Sets up HD encryption if requested (not done)
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


## About us
[Cloudurable](http://cloudurable.com/) provides AMIs, cloudformation templates and monitoring tools 
to support [Cassandra in production running in EC2](http://cloudurable.com/services/index.html). 
We also teach advanced [Cassandra courses which teaches how one could develop, support and deploy Cassandra to production in AWS EC2](http://cloudurable.com/services/index.html). 

## More details to follow

