# == Class: profile::splunk
#
class profile::splunk::forwarder {

  class { '::splunk::params':
      server   => 'splunkserver',
      src_root => 'https://s3.amazonaws.com/gcc-webops-provisioning-scripts/binaries/splunk',
      version  => '6.5.3',
      build    => '36937ad027d4',
  }


  class { '::splunk::forwarder':
    pkg_provider => 'windows',
    splunk_user  => 'vagrant',
  }
}
