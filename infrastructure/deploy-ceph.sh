#!/bin/bash

juju add-model ceph localhost

juju deploy -m  ceph ./bundles/ceph.yaml

juju wait -vw -m ceph
