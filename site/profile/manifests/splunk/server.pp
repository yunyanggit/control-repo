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


  splunk_indexes { 'puppetserver-index-homepath':
    section => 'puppetserver',
    setting => 'homePath',
    value   => '$SPLUNK_DB/puppetserver/db',
    require => Class['::splunk'],
  }
  splunk_indexes { 'puppetserver-index-maxsize':
    section => 'puppetserver',
    setting => 'maxTotalDataSizeMB',
    value   => 10240,
    require => Class['::splunk'],
  }

  splunk_indexes { 'puppetserver-index-colddb':
    section => 'puppetserver',
    setting => 'coldPath',
    value   => '$SPLUNK_DB/puppetserver/colddb',
    require => Class['::splunk'],
  }

  splunk_indexes { 'puppetserver-index-thawedpath':
    section => 'puppetserver',
    setting => 'thawedPath',
    value   => '$SPLUNK_DB/puppetserver/thaweddb',
    require => Class['::splunk'],
  }


  ## PuppetServer logs
  # https://docs.puppet.com/pe/latest/install_what_and_where.html#log-files-installed
  splunk_props { 'puppetserver-logs-message':
    section => 'puppetserver',
    setting => 'EXTRACT-message',
    value   => '^(?:[^ \n]* ){6}(?P<message>.+)',
    require => Class['::splunk'],
  }

  splunk_props { 'puppetserver-logs-level':
    section => 'puppetserver',
    setting => 'EXTRACT-level',
    value   => '^[^,\n]*,\d+\s+(?P<level>\w+)',
    require => Class['::splunk'],
  }

  ## Autobahn log4net logs
  splunk_props { 'autobahn-log4net-extraction':
    section => 'Log4Net:Autobahn',
    setting => 'EXTRACT-level',
    value   => '^[^,\n]*,\d+\s+(?P<level>\w+)',
    require => Class['::splunk'],
  }

  splunk_props { 'autobahn-log4net-logger':
    section => 'Log4Net:Autobahn',
    setting => 'EXTRACT-logger',
    value   => '^(?:[^ \n]* ){3}(?P<logger>[^ ]+)',
    require => Class['::splunk'],
  }

  splunk_props { 'autobahn-log4net-message':
    section => 'Log4Net:Autobahn',
    setting => 'EXTRACT-message',
    value   => '^(?:[^ \n]* ){5}(?P<message>.+)',
    require => Class['::splunk'],
  }

  # splunk_uiprefs { 'default-search-earliest-time':
  #   section => 'search',
  #   setting => 'dispatch.earliest_time',
  #   value   => '@d',
  #   require => Class['::splunk'],
  # }
  #
  # splunk_uiprefs { 'default-search-latest-time':
  #   section => 'search',
  #   setting => 'dispatch.latest_time',
  #   value   => 'now',
  #   require => Class['::splunk'],
  # }

}
