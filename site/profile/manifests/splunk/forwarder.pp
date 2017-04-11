# == Class: profile::splunk
#
class profile::splunk::forwarder {

  class { '::splunk::params':
    src_root => 'https://s3.amazonaws.com/gcc-webops-provisioning-scripts/binaries/splunk',
    version  => '6.5.3',
  }

  class { '::splunk::forwarder':
    server   => 'splunkserver',
    build    => '36937ad027d4',
  }
}
