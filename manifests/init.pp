class mailclient (
  $absent               = $mailclient::params::absent,
  $disable              = $mailclient::params::disable,
  $haproxy_template     = $mailclient::params::haproxy_template,
  $relay                = $mailclient::params::relay,
  $relay_host           = $mailclient::params::relay_host,
  $relay_port           = $mailclient::params::relay_port,
  $relay_tls            = $mailclient::params::relay_tls,
  $relay_tls_cert       = $mailclient::params::relay_tls_cert,
  $relay_tls_key        = $mailclient::params::relay_tls_key,
  $relay_tls_ca         = $mailclient::params::relay_tls_ca,
  $relay_auth           = $mailclient::params::relay_auth,
  $relay_auth_user      = $mailclient::params::relay_auth_user,
  $relay_auth_passwd    = $mailclient::params::relay_auth_passwd,
  $relay_auth_hosts     = $mailclient::params::relay_auth_hosts,
  $relay_auth_pkgs      = $mailclient::params::relay_auth_pkgs,
  $root_mail_forwarding = $mailclient::params::root_mail_forwarding,
  $proxy_listen_address = $mailclient::params::proxy_listen_address,
  $proxy_listen_port    = $mailclient::params::proxy_listen_port,
  $proxy_forward_address= $mailclient::params::proxy_forward_address,
  $proxy_forward_port   = $mailclient::params::proxy_forward_port,
  ) inherits mailclient::params {
    validate_re($root_mail_forwarding, '^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$')
    validate_re($relay_host, '^([\w\-]+\.)+[\w\-]{2,}$')
    if !is_integer($relay_port) or $relay_port < 0 or $relay_port > 65535 {
        fail("mailclient::relay_port is set to \"${relay_port}\" which is not a valid port number")
    }
    validate_bool($relay_tls)
    validate_bool($relay_auth)
    validate_string($relay_auth_user)
    validate_string($relay_auth_passwd)
    validate_array($relay_auth_hosts)
    validate_array($relay_auth_pkgs)
    validate_absolute_path($relay_tls_cert)
    validate_absolute_path($relay_tls_key)
    validate_absolute_path($relay_tls_ca)

    class { 'mailclient::root_mail_forwarding': }
    if (str2bool($relay)) {
      class { 'mailserver':
            type              => 'relay',
            relay_host        => $relay_host,
            relay_port        => $relay_port,
            relay_tls         => $relay_tls,
            relay_tls_cert    => $relay_tls_cert,
            relay_tls_key     => $relay_tls_key,
            relay_tls_ca      => $relay_tls_ca,
            relay_auth        => $relay_auth,
            relay_auth_user   => $relay_auth_user,
            relay_auth_passwd => $relay_auth_passwd,
            relay_auth_hosts  => $relay_auth_hosts,
        }
    }
}
