# Class: profile::linux::squidproxy
#
#
class profile::linux::squidproxy {
  include squid

  squid::http_port{'3128':
  }

  squid::acl{'localnet':
    type    => src,
    entries => ['10.43.192.0/18'],
  }

  squid::http_access{ 'localnet':
    action => allow,
  }

  squid::http_access{ 'all':
    action => deny,
  }

}