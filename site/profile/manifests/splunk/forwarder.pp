# == Class: profile::splunk
#
class profile::splunk::forwarder {

  class { '::splunk::forwarder':
    src_root => 'https://s3.amazonaws.com/gcc-webops-provisioning-scripts/binaries',
    version  => '6.5.3',
    server   => 'splunkserver',
  }
}
