# Class: profile::activedirectory::rbac
#
#
class profile::activedirectory::rbac(

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

    dsc_xadgroup { 'Domain Admins':
      dsc_ensure           => 'present',
      dsc_groupname        => 'Domain Admins',
      dsc_memberstoinclude => ['ad_principal_manager'],
      dsc_category         => 'Security',
      dsc_groupscope       => 'Global',
      dsc_description      => 'Managed by Puppet! Changes made manually may be lost.',
    }
}
