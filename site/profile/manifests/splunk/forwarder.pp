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
  }


}
# [monitor://C:\logs\Autobahn\Eleanor.UI.Web]
# disabled = false
# index = ab_log4
# sourcetype = AB_log4
# whitelist = \.log\.*
