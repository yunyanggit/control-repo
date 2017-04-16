class puppetmaster {

  node_group { 'PuppetMaster':
    ensure               => present,
    rule                 => ['and', ['~', ['fact', 'fqdn'], $facts['fqdn']]],
    classes              => {
      'pe_r10k' => {
        'remote' => 'https://github.com/TraGicCode/control-repo.git',
      },
      'pe_repo::platform::windows_x86_64' => {

      },
    },
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    provider             => 'https',
  }
}

include puppetmaster
