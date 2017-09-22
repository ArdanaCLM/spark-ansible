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
ansible-playbook -i hosts/verb_hosts spark-stop.yml
SPARK_STATUS=$?
echo "Spark Service Stop"
if [ $SPARK_STATUS -eq 0 ]
then
  echo "Ok"
else
  echo "Fail"
  exit 1
fi

ansible-playbook -i hosts/verb_hosts spark-status.yml
SPARK_STATUS=$?
echo "Spark Service Status is $SPARK_STATUS"
if [ $SPARK_STATUS -eq 0 ]
then
  echo "Fail"
  exit 1
else
  echo "Ok"
fi

ansible-playbook -i hosts/verb_hosts spark-start.yml
SPARK_STATUS=$?
echo "Spark Service Start"
if [ $SPARK_STATUS -eq 0 ]
then
  echo "Ok"
else
  echo "Fail"
  exit 1
fi

ansible-playbook -i hosts/verb_hosts spark-status.yml
SPARK_STATUS=$?
echo "Spark Service Status is $SPARK_STATUS"
if [ $SPARK_STATUS -eq 0 ]
then
  echo "Ok"
else
  echo "Fail"
  exit 1
fi

ansible-playbook -i hosts/verb_hosts spark-submit.yml
SPARK_STATUS=$?
echo "Spark submit quick sum"
if [ $SPARK_STATUS -eq 0 ]
then
  echo "Ok"
else
  echo "Fail"
  exit 1
fi