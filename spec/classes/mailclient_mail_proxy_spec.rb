require 'spec_helper'

haproxy_template = 'mailclient/haproxy/haproxy.cfg.erb'
proxy_listen_address = 'proxy.adaptavist.com'
proxy_listen_port    = '2345'
proxy_forward_address= 'fw.adaptavist.com'
proxy_forward_port   = '5432'

describe 'mailclient::mail_proxy', :type => 'class' do
    
  context "Should require proxy params" do
    it do
      should_not contain_class('haproxy')
    end
  end

  context "Should create haproxy with correct params" do
    let(:params) {{
        :proxy_listen_address  => proxy_listen_address,
        :proxy_listen_port     => proxy_listen_port,
        :proxy_forward_address => proxy_forward_address,
        :proxy_forward_port    => proxy_forward_port,
      }}
    let(:facts) {{
      :haproxy_template => haproxy_template
    }}
    it do
      should contain_class('haproxy').with(
        'template' => haproxy_template,
        'options' => {
            'listen_address' => proxy_listen_address,
            'listen_port' => proxy_listen_port,
            'forward_address' => proxy_forward_address,
            'forward_port' => proxy_forward_port,
          }
        )
    end
  end
end
