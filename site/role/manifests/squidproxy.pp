# Class: role::squidproxy
#
#
class role::squidproxy {
    include profile::base
    include profile::linux::squidproxy
}