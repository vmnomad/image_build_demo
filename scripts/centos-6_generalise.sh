#!/bin/bash
sudo yum -y install WALinuxAgent
sudo service enable waagent
sudo rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
sudo yum -y install git vim tree
sudo yum -y install puppet-agent
sudo waagent -force -deprovision+user
export HISTSIZE=0
