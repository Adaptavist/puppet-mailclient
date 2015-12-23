# Class: mailclient::params
#
# This class defines default parameters used by the main module class
# mailclient Operating Systems differences in names and paths should be
# addressed here
#
# == Variables
#
# Refer to mailclient class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class mailclient::params {
  $relay_auth_pkgs = $::osfamily ? { # Default to RedHat/CentOS
    'Debian' => ['libsasl2-2', 'sasl2-bin', 'libsasl2-modules'],
    default  => ['cyrus-sasl-plain'],
  }

  $absent               = false
  $disable              = false
  $haproxy_template     = "${module_name}/haproxy/haproxy.cfg.erb"
  $relay                = true
  $relay_host           = 'mail.adaptavist.com'
  $relay_port           = 25
  $relay_tls            = true
  $relay_tls_cert       = '/etc/postfix/tls/smtp-client-cert.pem'
  $relay_tls_key        = '/etc/postfix/tls/smtp-client-key.key'
  $relay_tls_ca         = '/etc/postfix/tls/cacert.pem'
  $relay_auth           = true
  $relay_auth_user      = 'root@example.com'
  $relay_auth_passwd    = 'ExamplePass'
  $relay_auth_hosts     = []
  $root_mail_forwarding = 'root@example.com'
  $proxy_listen_address = undef
  $proxy_listen_port    = undef
  $proxy_forward_address= undef
  $proxy_forward_port   = undef
}
