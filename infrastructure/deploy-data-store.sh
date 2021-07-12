#!/bin/bash
sudo sysctl -w vm.max_map_count=262144

juju add-model data-store localhost

juju deploy -m  data-store ./bundles/data-store.yaml

juju wait -vw -m data-store
