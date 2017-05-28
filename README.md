# Introduction
The Goal of this repository is to provide the ability to quickly spin up a puppet enterprise environment for quickly testing changes without having to touch your actual puppet enterprise server.


# Requirements
1.) Install Vagrant

2.) Install Vagrant plugins
> vagrant plugin install vagrant-pe_build
> vagrant plugin install vagrant-hosts

3.) Download The version of puppet enterprise you would like to use
> Invoke-RestMethod -Method Get -Uri https://s3.amazonaws.com/pe-builds/released/2017.2.1/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz -OutFile ~/Downloads/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz
> vagrant pe-build copy file://C:/Users/tragiccode/Downloads/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz
NOTE: file://~/Downloads/puppet-enterprise-2017.2.1-ubuntu-16.04-amd64.tar.gz might work


# Using Code Manager
1.) Install Pe-Client tools on your local workstation
2.) Run the following to quickly configure PE Client tools
> Configure-PEClientTools.ps1
2.) Update your hosts file to have the following entry
10.20.1.2     puppetmaster.local
3.) Obtain a RBAC token so you can deploy environments

> puppet-access login --username admin

4.) Initiate a deployment of all environments

> puppet-code print-config
> puppet-code status
> puppet-code deploy --all --wait --log-level info
