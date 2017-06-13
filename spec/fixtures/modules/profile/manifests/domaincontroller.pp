# Class: profile::domaincontroller
#
#
class profile::domaincontroller {

  dsc_windowsfeature { 'AD-Domain-Services':
    dsc_ensure => 'present',
    dsc_name   => 'AD-Domain-Services',
  }

  dsc_xaddomain { 'globalcustomcommerce.com':
    ensure                            => 'present',
    dsc_domainname                    => 'tragiccode.local',
    dsc_safemodeadministratorpassword => {
      'user'     => 'Administrator',
      'password' => 'Puppet!12345',
    },
    # Username & password to be assigned to our domain administrator account if this is our first domain in a forest.
    # else it's needed to join a new domain to an existing forest
    dsc_domainadministratorcredential => {
      'user'     => 'Administrator2',
      'password' => 'Puppet!12345',
    },
    dsc_domainnetbiosname             => 'TRAGICCODE', # 15 character limit...
    dsc_databasepath                  => 'C:\\Windows\\NTDS',
    dsc_logpath                       => 'C:\\Windows\\NTDS',
    dsc_sysvolpath                    => 'C:\\Windows\\SYSVOL',
    require                           => Dsc_windowsfeature['AD-Domain-Services'],
  }

  reboot { 'dsc_reboot':
    message => 'DSC has requested a reboot',
    when    => 'pending',
    require => Dsc_xaddomain['tragiccode.local'],
  }
}