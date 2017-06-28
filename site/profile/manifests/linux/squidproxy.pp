# Class: profile::linux::squidproxy
#
#
class profile::linux::squidproxy {
  include squid

  squid::acl{'localnet':
    type    => src,
		entries => ['10.43.192.0/18'],
  }

  squid::http_access{ 'localnet':
    action => allow,
  }
}