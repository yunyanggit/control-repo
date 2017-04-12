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

  splunk_indexes { 'autobahn-log4net-index-colddb':
    section => 'ab_log4',
    setting => 'coldPath',
    value   => '$SPLUNK_DB/ab_log4/colddb',
    require => Class['::splunk'],
  }

  splunk_indexes { 'autobahn-log4net-index-thawedpath':
    section => 'ab_log4',
    setting => 'thawedPath',
    value   => '$SPLUNK_DB/ab_log4/thaweddb',
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
  # [Autobahn:Log4Net]
  # DATETIME_CONFIG =
  # NO_BINARY_CHECK = true
  # category = Application
  # description = Autobahn Log4Net Conventions
  # pulldown_type = 1
  # disabled = false
  # EXTRACT-level = ^[^,\n]*,\d+\s+(?P<level>\w+)
  # EXTRACT-logger = ^(?:[^ \n]* ){3}(?P<logger>[^ ]+)
  # EXTRACT-message = ^(?:[^ \n]* ){5}(?P<message>.+)
  splunk_props { 'autobahn-log4net-extraction':
    section => 'Autobahn:Log4Net',
    setting => 'EXTRACT-level',
    value   => '^[^,\n]*,\d+\s+(?P<level>\w+)',
    require => Class['::splunk::forwarder'],
  }

  splunk_props { 'autobahn-log4net-logger':
    section => 'Autobahn:Log4Net',
    setting => 'EXTRACT-logger',
    value   => '^(?:[^ \n]* ){3}(?P<logger>[^ ]+)',
    require => Class['::splunk::forwarder'],
  }

  splunk_props { 'autobahn-log4net-message':
    section => 'Autobahn:Log4Net',
    setting => 'EXTRACT-message',
    value   => '^(?:[^ \n]* ){5}(?P<message>.+)',
    require => Class['::splunk::forwarder'],
  }

}
