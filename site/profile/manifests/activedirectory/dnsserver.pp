# Class: profile::activedirectory::dnsserver
#
#
class profile::activedirectory::dnsserver {
    $network = regsubst( $facts['networking']['network'], '(\.0)+$', '')
    dsc_xdnsserveradzone { 'Ipv4 Reverse Lookup Zone':
      dsc_ensure           => 'present',
      dsc_name             => "${network}.in-addr.arpa",
      dsc_replicationscope => 'Forest',
      dsc_dynamicupdate    => 'None',
    }
}