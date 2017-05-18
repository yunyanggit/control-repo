# Introduction
The Goal of this repository is to provide the ability to quickly spin up a puppet enterprise environment for quickly testing changes without having to touch your actual puppet enterprise server.


# Requirements
1.) Install Vagrant

2.) Install Vagrant plugins
> vagrant plugin install vagrant-pe_build
> vagrant plugin install vagrant-hosts

3.) Download The version of puppet enterprise you would like to use
> vagrant pe-build copy file://C:/Users/tragiccode/Downloads/puppet-enterprise-2017.1.1-ubuntu-16.04-amd64.tar.g


# Using Code Manager
1.) Instal Pe-Client tools on your local workstation
2.) Update your hosts file to have the following entry
10.20.1.2     puppetmaster.local
3.) Obtain a RBAC token so you can deploy environments

> puppet-access login --username admin

4.) Initiate a deployment of all environments

> puppet-code deploy --all --wait --log-level info
