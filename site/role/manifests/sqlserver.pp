# Class: role::sqlserver
#
#
class role::sqlserver {
    include profile::base
    include profile::windows::sqlserver
}