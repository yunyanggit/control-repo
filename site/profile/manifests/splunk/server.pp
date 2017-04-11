# == Class: profile::splunk
#
class profile::splunk::server {



  class { '::splunk':
    src_root => "https://s3.amazonaws.com/gcc-webops-provisioning-scripts/binaries",
    version  => "6.5.3",
    build    => "36937ad027d4",
  }
}
