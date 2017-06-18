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
    'password' => Sensitive('asda@#@$@123123asdas'),
  },
    dsc_description => 'Managed by Puppet! Changes made manually may be lost.',
  }
}
