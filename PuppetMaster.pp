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

  class { '::splunk::params':
      server   => 'splunkserver',
      # src_root => 'https://s3.amazonaws.com/gcc-webops-provisioning-scripts/binaries/splunk',
      version  => '6.5.3',
      build    => '36937ad027d4',
  }

  class { '::splunk::forwarder':
    splunk_user  => 'vagrant',
  }
}

include puppetmaster
