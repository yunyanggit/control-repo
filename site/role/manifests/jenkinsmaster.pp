# Class: role::jenkinsmaster
#
#
class role::jenkinsmaster {
    # resources
    include profile::base
    include profile::jenkinsmaster
}