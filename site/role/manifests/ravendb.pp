# Class: role::ravendb
#
#
class role::ravendb {
    include profile::base
    include role::windows::ravendb
}