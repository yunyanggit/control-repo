class profile::puppetenterprise::puppetserver(
    String $file_source_pe_license = 'puppet:///modules/profile/puppetenterprise/puppetserver/license.key'
) {

   file{ '/etc/puppetlabs/license.key':
    ensure => present,
    source => $file_source_pe_license,
    notify => Service['pe-console-services'],
  }

}
