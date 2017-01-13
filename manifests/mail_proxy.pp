# TODO: This is only here for backwards compatibility - Use Hiera config of
#       HAProxy directly instead
class mailclient::mail_proxy(
  $proxy_listen_address = $mailclient::params::proxy_listen_address,
  $proxy_listen_port    = $mailclient::params::proxy_listen_port,
  $proxy_forward_address= $mailclient::params::proxy_forward_address,
  $proxy_forward_port   = $mailclient::params::proxy_forward_port,
  ) inherits mailclient::params{
    # TODO: Vars used below should be localised
    # TODO: This should allow for an array of hashes rather than only one set
    # of addresses/ports
    # TODO: Needs an absent/disable action
    if $proxy_listen_address != undef and
      $proxy_listen_port != undef and
      $proxy_forward_address != undef and
      $proxy_forward_port != undef {
        class { 'haproxy':
            template => $::haproxy_template,
            options  => {
                'listen_address'  => $proxy_listen_address,
                'listen_port'     => $proxy_listen_port,
                'forward_address' => $proxy_forward_address,
                'forward_port'    => $proxy_forward_port,
            }
        }
    } else {
        warning('not configuring haproxy due to undefs in input')
    }
}
