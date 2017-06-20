# Class: profile::firewall
#
#
class profile::firewall {
  class { 'windows_firewall':
    ensure => 'disabled',
  }
}