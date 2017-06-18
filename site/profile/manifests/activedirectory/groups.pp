# Class: profile::activedirectory::groups
#
#
class profile::activedirectory::groups(

) {

  dsc_xadgroup { 'Domain Admins2':
    dsc_ensure           => 'present',
    dsc_groupname        => 'Domain Admins2',
    dsc_memberstoinclude => ['ad_principal_manager'],
    dsc_category         => 'Security',
    dsc_groupscope       => 'Global',
    dsc_description      => 'Managed by Puppet! Changes made manually may be lost.',
  }
}
