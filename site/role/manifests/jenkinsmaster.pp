# Class: role::jenkinsmaster
#
#
class role::jenkinsmaster {
    # resources
    include profile::base
    include profile::linux::git
    include profile::linux::continuousintegration::ruby
    include profile::linux::jenkinsmaster
}