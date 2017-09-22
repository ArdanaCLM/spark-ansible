#!/bin/bash
#
# (c) Copyright 2016 Hewlett Packard Enterprise Development LP
# (c) Copyright 2017 SUSE LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
set -vxe
echo "Changing $1 in $2"
pushd ~/openstack/my_cloud/config
sed -e "$1" -i "$2" --follow-symlinks
git add -A
git commit --allow-empty -m "My Config Change"
pushd ~/openstack/ardana/ansible/
ansible-playbook -i hosts/localhost config-processor-run.yml -e encrypt="" \
                     -e rekey=""
ansible-playbook -i hosts/localhost ready-deployment.yml
popd
popd
