#!/bin/bash
sudo yum -y install WALinuxAgent
sudo systemctl enable waagent
sudo rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
sudo yum -y install git vim tree
sudo yum -y install puppet-agent
sudo waagent -force -deprovision+user
rm -f ~/.bash_history
export HISTSIZE=0
