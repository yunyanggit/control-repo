# == Class: profile::activedirectory::domaincontroller
#
class profile::activedirectory::domaincontroller {
  class { 'windows_ad':
    install                => present,
    installmanagementtools => true,
    restart                => true,
    installflag            => true,
    configure              => present,
    configureflag          => true,
    domain                 => 'forest',
    domainname             => 'tragiccode.local',
    netbiosdomainname      => 'tragiccode',
    domainlevel            => '6',
    forestlevel            => '6',
    databasepath           => 'c:\\windows\\ntds',
    logpath                => 'c:\\windows\\ntds',
    sysvolpath             => 'c:\\windows\\sysvol',
    installtype            => 'domain',
    dsrmpassword           => 'PuppetRox123!',
    installdns             => 'yes',
    localadminpassword     => 'PuppetRox123!',
  }
}
