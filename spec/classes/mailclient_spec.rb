require 'spec_helper'
 
def_relay                = true
def_relay_host           = 'mail.adaptavist.com'
def_relay_port           = 25
def_relay_tls            = true
def_relay_tls_cert       = '/etc/postfix/tls/smtp-client-cert.pem'
def_relay_tls_ca         = '/etc/postfix/tls/cacert.pem'
def_relay_auth           = true
def_relay_auth_user      = 'root@example.com'
def_relay_auth_passwd    = 'ExamplePass'
def_relay_auth_hosts     = []

relay_host           = 'mail1.adaptavist.com'
relay_port           = 2345
relay_tls            = false
relay_tls_cert       = '/etc/postfix/tls/smtp-client-cert.pem'
relay_tls_ca         = '/etc/postfix/tls/cacert.pem'
relay_auth           = false
relay_auth_user      = 'root@adaptavist.com'
relay_auth_passwd    = 'pass'
relay_auth_hosts     = ['google.com']

describe 'mailclient', :type => 'class' do
    
  context "Should setup mailsetver class and mail fwd with default params" do
  
    it do
      should contain_mailclient__root_mail_forwarding

      should contain_class('mailserver').with(
            'type' => 'relay',
            'relay_host' => def_relay_host,
            'relay_port' => def_relay_port,
            'relay_tls' => def_relay_tls,
            'relay_tls_cert' => def_relay_tls_cert,
            'relay_tls_ca' => def_relay_tls_ca,
            'relay_auth' => def_relay_auth,
            'relay_auth_user' => def_relay_auth_user,
            'relay_auth_passwd' => def_relay_auth_passwd,
            'relay_auth_hosts' => def_relay_auth_hosts,
        )
    end
  end

  context "Should setup fwd and not mailserver in case relay is false" do
    let(:params) { {:relay => false} }
  
    it do
      should contain_mailclient__root_mail_forwarding

      should_not contain_class('mailserver')
    end
  end

  context "Should setup mailsetver class and mail fwd with custom params" do
    let(:params) { {
      :relay_host => relay_host,
      :relay_port => relay_port,
      :relay_tls => relay_tls,
      :relay_tls_cert => relay_tls_cert,
      :relay_tls_ca => relay_tls_ca,
      :relay_auth => relay_auth,
      :relay_auth_user => relay_auth_user,
      :relay_auth_passwd => relay_auth_passwd,
      :relay_auth_hosts => relay_auth_hosts,
    } }
    it do
      should contain_mailclient__root_mail_forwarding

      should contain_class('mailserver').with(
            'type' => 'relay',
            'relay_host' => relay_host,
            'relay_port' => relay_port,
            'relay_tls' => relay_tls,
            'relay_tls_cert' => relay_tls_cert,
            'relay_tls_ca' => relay_tls_ca,
            'relay_auth' => relay_auth,
            'relay_auth_user' => relay_auth_user,
            'relay_auth_passwd' => relay_auth_passwd,
            'relay_auth_hosts' => relay_auth_hosts,
        )
    end
  end
end
