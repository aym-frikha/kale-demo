# Environment Setup
To setup the environment we need to execute the following steps:

1- First of all, we need to create an AWS VM with those characteristics:

* `OS: Ubuntu 20.04`
* `AWS: t2.xlarge`
* `Disk: 100 GB`

2- After accessing this VM, we need to clone the demo repo under Aymen Frikha namespace:
```
$ git clone https://github.com/aym-frikha/kale-demo.git
```

3- install necessary packages for the environment like Juju and the libraries:
```
$ sudo ./install.sh
```
4- Access the infrastructure folder:
```
$ cd infrastructure
```
5- Bootstrap juju for lxd machines to create the juju environment:
```
$ ./bootstrap-juju-localhost.sh
```
6- Deploy the data-store model. In this step we will deploy the elasticsearch cluster using juju and the charms in a juju model called data-store:
```
$ ./deploy-data-store.sh
```
7- Deploy the ceph model. In this step we will deploy the ceph cluster using juju and the charms in a juju model called ceph. Basically, this environment will contain the object store system which is ceph-radosgw that will store the result model.
```
$ ./deploy-ceph.sh
```
8- Now we need to create the Ceph radosgw user , which is basically an S3 user to be able to store the result model:
```
$ ./create-rados-user.sh
```
9- The elasticsearch cluster will store the training data in this demo. So we need to upload this  data using this script:
```
$ ./upload-data.sh
```
10- In this step, we will create the k8s environment which is microk8s and we will deploy the docker registry and the kubeflow platform:
```
$ ./deploy-microk8s.sh
```
> Note: you may need to execute this command twice if you install microk8s for the first time in the machine and you need to execute these commands and logout login:
```
$ sudo usermod -a -G microk8s ubuntu
$ sudo chown -f -R ubuntu ~/.kube
```

# Setup Kale image

1- Download Kale image repository:
```
$ git clone https://github.com/kubeflow-kale/kale
```
2- Modify Dockerfile to download necessary libraries:
```
$ cd kale/docker/jupyterlab
```
3- Add additional packages to the install packages section in the Dockerfile:
```
.
.
pip3 install --upgrade  pandas==0.23.4 elasticsearch==7.7.0 boto3==1.13.16 &&\
.
.
.
```

3- Build and push the image to the local registry:
```
$ sudo docker build . -t localhost:32000/kale-demo
$ sudo docker push localhost:32000/kale-demo
```

