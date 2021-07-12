#!/bin/bash

sudo snap install microk8s --classic --channel=1.21
#sudo usermod -a -G microk8s $USER
#sudo chown -f -R $USER ~/.kube
#sudo su - $USER


microk8s status --wait-ready


microk8s enable registry dns storage
microk8s enable kubeflow --bundle=./bundles/kubeflow.yaml --ignore-min-mem


