class profile::linux::puppetenterprise::puppetserver(
    String $file_source_pe_license     = 'puppet:///modules/profile/puppetenterprise/puppetserver/license.key',
    String $file_source_auto_sign_conf = 'puppet:///modules/profile/puppetenterprise/puppetserver/autosign.conf',
) {

  file { '/etc/puppetlabs/license.key':
    ensure => present,
    source => $file_source_pe_license,
    notify => Service['pe-console-services'],
  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure => present,
    source => $file_source_auto_sign_conf,
    notify => Service['pe-console-services'],
  }

  @@dsc_xdnsrecord { 'ARecord':
    dsc_ensure => 'present',
    dsc_name   => $facts['hostname'],
    dsc_target => $facts['networking']['ip'],
    dsc_type   => 'ARecord',
    dsc_zone   => 'tragiccode.local',
  }

  @@dsc_xdnsrecord { 'puppet':
    dsc_ensure => 'present',
    dsc_name   => 'puppet',
    dsc_target => "${facts['hostname']}.tragiccode.local",
    dsc_type   => 'CName',
    dsc_zone   => 'tragiccode.local',
    require    => Dsc_xdnsrecord['ARecord'],
  }

}
