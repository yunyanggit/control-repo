require 'spec_helper'

describe 'profile::domaincontroller' do
  context 'with default values for all parameters' do
    sensitive_value_redacted_message = '#<Sensitive [value redacted]'
    let(:params) {{
      :domain_name                      => 'tragiccode.local',
      :domain_net_bios_name             => 'TRAGICCODE',
      :safe_mode_administrator_user     => 'billclinton',
      :safe_mode_administrator_password => 'TestPassword123!',
      :domain_administrator_user        => 'bobdole',
      :domain_administrator_password    => 'TestPassword321@',
    }}
    # Needed in order to get that 100% code coverage
    it { should contain_class('profile::domaincontroller') }

    it { should contain_dsc_windowsfeature('AD-Domain-Services').with({
        :dsc_ensure => 'present',
        :dsc_name   => 'AD-Domain-Services',
    }) }

    it { should contain_dsc_xaddomain('tragiccode.local').with({
        :ensure                            => 'present',
        :dsc_domainname                    => 'tragiccode.local',
        :dsc_domainnetbiosname             => 'TRAGICCODE',
        :dsc_databasepath                  => 'C:\\Windows\\NTDS',
        :dsc_logpath                       => 'C:\\Windows\\NTDS',
        :dsc_sysvolpath                    => 'C:\\Windows\\SYSVOL',
        :require                           => 'Dsc_windowsfeature[AD-Domain-Services]',
    }).with_dsc_domainadministratorcredential(/#{Regexp.escape(sensitive_value_redacted_message)}/)
      .with_dsc_safemodeadministratorpassword(/#{Regexp.escape(sensitive_value_redacted_message)}/) }

    it { should contain_reboot('dsc_reboot').with(
        :message => 'DSC has requested a reboot',
        :when    => 'pending',
        :require => 'Dsc_xaddomain[tragiccode.local]',
    ) }

  end
end