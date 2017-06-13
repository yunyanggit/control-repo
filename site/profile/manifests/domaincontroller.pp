# Class: profile::domaincontroller
#
#
class profile::domaincontroller(
  String $safe_mode_administrator_password,
) {

  dsc_windowsfeature { 'AD-Domain-Services':
    dsc_ensure => 'present',
    dsc_name   => 'AD-Domain-Services',
  }

  dsc_xaddomain { 'tragiccode.local':
    ensure                            => 'present',
    dsc_domainname                    => 'tragiccode.local',
    dsc_safemodeadministratorpassword => {
      'user'     => 'Administrator',
      'password' => $safe_mode_administrator_password,
    },
    # Username & password to be assigned to our domain administrator account if this is our first domain in a forest.
    # else it's needed to join a new domain to an existing forest
    dsc_domainadministratorcredential => {
      'user'     => 'Administrator2',
      'password' => $safe_mode_administrator_password,
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