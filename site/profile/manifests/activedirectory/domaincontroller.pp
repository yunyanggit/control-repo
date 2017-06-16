# This class is used to install a new active directory domaincontroller.
#
# This class should not be called directly, but rather is used by our roles.
#
# @param domain_name [String] The new domain you're creating.
# @param domain_net_bios_name [String[1, 15]] The domain's net bios name.
# @param safe_mode_administrator_password [String] The password for booting the domaincontroller into recovery mode.
# @param domain_administrator_user [String] The user for the domain administrator account for the domain.
# @param domain_administrator_password [String] The password for the domain administrator account for the domain.
#
class profile::activedirectory::domaincontroller(
  String $domain_name,
  String[1, 15] $domain_net_bios_name,
  String $safe_mode_administrator_password,
  String $domain_administrator_user,
  String $domain_administrator_password,
) {

  redact('safe_mode_administrator_password')
  redact('domain_administrator_password')
  
  dsc_windowsfeature { 'RSAT-ADDS':
    dsc_ensure => 'present',
    dsc_name   => 'RSAT-ADDS',
  }

  dsc_windowsfeature { 'AD-Domain-Services':
    dsc_ensure => 'present',
    dsc_name   => 'AD-Domain-Services',
  }

  dsc_xaddomain { $domain_name:
    ensure                            => 'present',
    dsc_domainname                    => $domain_name,
    dsc_safemodeadministratorpassword => {
      'user'     => 'this is ignored', # this is ignored...... its a PSCredential thing...
      'password' => Sensitive($safe_mode_administrator_password),
    },
    # Username & password to be assigned to our domain administrator account if this is our first domain in a forest.
    # else it's needed to join a new domain to an existing forest
    dsc_domainadministratorcredential => {
      'user'     => $domain_administrator_user,
      'password' => Sensitive($domain_administrator_password),
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