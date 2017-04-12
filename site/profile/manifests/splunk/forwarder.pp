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
  ->
    splunkforwarder_input { 'autobahn-log4net-sourcetype':
    section => 'monitor:///C:\\logs\\Autobahn\\Eleanor.UI.Web',
    setting => 'sourcetype',
    value   => 'Log4Net:Autobahn',
  }
  ->
  splunkforwarder_input { 'autobahn-log4net-index':
    section => 'monitor:///C:\\logs\\Autobahn\\Eleanor.UI.Web',
    setting => 'index',
    value   => 'ab_log4',
  }
  ->
  splunkforwarder_input { 'autobahn-log4net-whitelist':
  section => 'monitor:///C:\\logs\\Autobahn\\Eleanor.UI.Web',
  setting => 'whitelist',
  value   => '\\.log\\.*',
  } ->
  splunkforwarder_input { 'autobahn-log4net-disabled':
    section => 'monitor:///C:\\logs\\Autobahn\\Eleanor.UI.Web',
    setting => 'disabled',
    value   => 0,
  }

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
  splunkforwarder_props { 'autobahn-log4net-extraction':
    section => 'Autobahn:Log4Net',
    setting => 'EXTRACT-level',
    value   => '^[^,\n]*,\d+\s+(?P<level>\w+)',
    require => Class['::splunk::forwarder'],
  }

  splunkforwarder_props { 'autobahn-log4net-logger':
    section => 'Autobahn:Log4Net',
    setting => 'EXTRACT-logger',
    value   => '^(?:[^ \n]* ){3}(?P<logger>[^ ]+)',
    require => Class['::splunk::forwarder'],
  }

  splunkforwarder_props { 'autobahn-log4net-message':
    section => 'Autobahn:Log4Net',
    setting => 'EXTRACT-message',
    value   => '^(?:[^ \n]* ){5}(?P<message>.+)',
    require => Class['::splunk::forwarder'],
  }

}
# [monitor://C:\logs\Autobahn\Eleanor.UI.Web]
# disabled = false
# index = ab_log4
# sourcetype = AB_log4
# whitelist = \.log\.*
