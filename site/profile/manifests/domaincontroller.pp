# Class: profile::domaincontroller
#
#
class profile::domaincontroller(
  String $domain_name,
  String[15] $domain_net_bios_name, 
  String $safe_mode_administrator_user,
  String $safe_mode_administrator_password,
  String $domain_administrator_user,
  String $domain_administrator_password,
) {

  dsc_windowsfeature { 'AD-Domain-Services':
    dsc_ensure => 'present',
    dsc_name   => 'AD-Domain-Services',
  }

  dsc_xaddomain { $domain_name:
    ensure                            => 'present',
    dsc_domainname                    => $domain_name,
    dsc_safemodeadministratorpassword => {
      'user'     => $safe_mode_administrator_user,
      'password' => $safe_mode_administrator_password,
    },
    # Username & password to be assigned to our domain administrator account if this is our first domain in a forest.
    # else it's needed to join a new domain to an existing forest
    dsc_domainadministratorcredential => {
      'user'     => $domain_administrator_user,
      'password' => $domain_administrator_password,
    },
    dsc_domainnetbiosname             => $domain_net_bios_name, # 15 character limit...
    dsc_databasepath                  => 'C:\\Windows\\NTDS',
    dsc_logpath                       => 'C:\\Windows\\NTDS',
    dsc_sysvolpath                    => 'C:\\Windows\\SYSVOL',
    require                           => Dsc_windowsfeature['AD-Domain-Services'],
  }

  reboot { 'dsc_reboot':
    message => 'DSC has requested a reboot',
    when    => 'pending',
    require => Dsc_xaddomain[$domain_name],
  }
}