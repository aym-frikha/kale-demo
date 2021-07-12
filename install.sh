#!/bin/bash -eu
snap install juju --classic --channel 2.9/stable
snap install juju-lint --classic
snap install juju-wait --classic
snap install juju-crashdump --classic
snap install kubectl --classic
snap install jq
sudo snap install --classic docker
apt update
apt install -y  python3-pip s3cmd
pip3 install elasticsearch
pip3 install kfp --upgrade
export PATH=$PATH:~/.local/bin

sudo cp patches/daemon.json /var/snap/docker/current/etc/docker/daemon.json
sudo systemctl restart snap.docker.dockerd.service
