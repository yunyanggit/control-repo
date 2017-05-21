class profile::splunk::ubuntu_forwarder {

    class { '::splunk::params':
        server   => 'splunkserver.local',
        src_root => 'https://s3.amazonaws.com/gcc-webops-provisioning-scripts/binaries/splunk',
        version  => '6.5.3',
        build    => '36937ad027d4',
    }

    class { '::splunk::forwarder':
      # splunk_user  => 'vagrant',
    }
    ->
      splunkforwarder_input { 'puppetserver-logs-index':
      section => 'monitor:///var/log/puppetlabs/puppetserver/puppetserver.log',
      setting => 'index',
      value   => 'puppetserver',
    }

  splunkforwarder_input { 'puppetserver-sourcetype':
    section => 'monitor:///var/log/puppetlabs/puppetserver/puppetserver.log',
    setting => 'sourcetype',
    value   => 'puppetserver',
  }

}
