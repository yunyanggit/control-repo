# == Class: profile::splunk
#
class profile::splunk::server {

  class { '::splunk::params':
      src_root => 'https://s3.amazonaws.com/gcc-webops-provisioning-scripts/binaries',
      version  => '6.5.3',
      build    => '36937ad027d4',
  }


  include ::splunk

  splunk_indexes { 'autobahn-log4net-index-homepath':
    section => 'ab_log4',
    setting => 'homePath',
    value   => '$SPLUNK_DB/ab_log4/db',
    require => Class['::splunk'],
  }
  splunk_indexes { 'autobahn-log4net-index-maxsize':
    section => 'ab_log4',
    setting => 'maxTotalDataSizeMB',
    value   => 10240,
    require => Class['::splunk'],
  }
  # [ab_log4]
  # coldPath = $SPLUNK_DB/ab_log4/colddb
  # enableDataIntegrityControl = 0
  # enableTsidxReduction = 1
  # homePath = $SPLUNK_DB/ab_log4/db
  # maxTotalDataSizeMB = 10240
  # thawedPath = $SPLUNK_DB/ab_log4/thaweddb
  # timePeriodInSecBeforeTsidxReduction = 1209600
  # tsidxReductionCheckPeriodInSec =

}
