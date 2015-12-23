require 'spec_helper'
 
absent = true
def_root_mail_forwarding = 'root@example.com'
root_mail_forwarding = 'paul@adaptavist.com'

describe 'mailclient::root_mail_forwarding', :type => 'class' do
    
  context "Should setup .forward" do
    it do
      should contain_file('/root/.forward').with(
          'ensure'  => 'file',
          'content' => "#{def_root_mail_forwarding}\n",
          'mode'    => '0644',
          'owner'   => 'root',
          'group'   => 'root',
      )
    end
  end

  context "Should setup .forward with absent true and custom root mail" do
    let(:params) { {
      :absent => absent,
      :root_mail_forwarding => root_mail_forwarding,
      } }
  
    it do
      should contain_file('/root/.forward').with(
          'ensure'  => 'absent',
          'content' => "#{root_mail_forwarding}\n",
          'mode'    => '0644',
          'owner'   => 'root',
          'group'   => 'root',
      )
    end
  end
end
