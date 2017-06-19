# Class: profile::activedirectory::users
#
#
class profile::activedirectory::users(

) {

  dsc_xaduser { 'ad_principal_manager':
    dsc_ensure      => 'present',
    dsc_domainname  => 'tragiccode.local',
    dsc_username    => 'ad_principal_manager',
    dsc_password    => {
    'user'     => 'asdasdasd',
    'password' => "$(puppet node decrypt --env ${domain_administrator_password})",
  },
    dsc_description => 'Managed by Puppet! Changes made manually may be lost.',
  }
}
