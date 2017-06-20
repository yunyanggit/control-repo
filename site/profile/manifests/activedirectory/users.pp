# Class: profile::activedirectory::users
#
#
class profile::activedirectory::users(
  String $domain_administrator_password,
) {

  dsc_xaduser { 'ad_principal_manager':
    dsc_ensure      => 'present',
    dsc_domainname  => 'tragiccode.local',
    dsc_username    => 'ad_principal_manager',
    dsc_password    => {
    'user'     => 'this is ignored', # this is ignored...... its a PSCredential thing...
    'password' => $domain_administrator_password,
  },
    dsc_description => 'Managed by Puppet! Changes made manually may be lost.',
  }
}
