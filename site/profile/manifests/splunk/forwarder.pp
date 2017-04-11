# == Class: profile::splunk
#
class profile::splunk::forwarder {

  class { '::splunk::params':
    src_root => 'https://s3.amazonaws.com/mfyffe',
    version  => '6.5.3',
    build    => '36937ad027d4',
  }

  class { '::splunk::forwarder':
    server   => 'splunkserver',
  }
}
