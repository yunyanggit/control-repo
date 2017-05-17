node_group { 'PE Master - Customized':
  ensure               => 'present',
  rule                 => ['and', ['~', ['fact', 'fqdn'], $facts['fqdn']]],
  classes              => {
    'puppet_enterprise::profile::master' => {
      'r10k_remote'                 => 'https://github.com/TraGicCode/control-repo.git',
      'code_manager_auto_configure' => true,
    },
    'pe_repo::platform::windows_x86_64' => {

    },
  },
  environment          => 'production',
  override_environment => false,
  parent               => 'PE Master',
  provider             => 'https',
}
