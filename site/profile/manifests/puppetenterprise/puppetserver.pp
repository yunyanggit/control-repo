class profile::puppetenterprise::puppetserver(
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

}
