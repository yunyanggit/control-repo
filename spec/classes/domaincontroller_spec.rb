require 'spec_helper'

describe 'profile::domaincontroller' do
  context 'with default values for all parameters' do
    
    # Needed in order to get that 100% code coverage
    it { should contain_class('profile::domaincontroller') }

    it { should contain_dsc_windowsfeature('AD-Domain-Services').with({
        :dsc_ensure => 'present',
        :dsc_name   => 'AD-Domain-Services',
    }) }

    it { should contain_dsc_xaddomain('globalcustomcommerce.com').with({
        :ensure                            => 'present',
        :dsc_domainname                    => 'tragiccode.local',
        :dsc_safemodeadministratorpassword => {
          'user'     => 'Administrator',
          'password' => 'Puppet!12345',
        },
        :dsc_domainadministratorcredential => {
          'user'     => 'Administrator2',
          'password' => 'Puppet!12345',
        },
        :dsc_domainnetbiosname             => 'TRAGICCODE',
        :dsc_databasepath                  => 'C:\\Windows\\NTDS',
        :dsc_logpath                       => 'C:\\Windows\\NTDS',
        :dsc_sysvolpath                    => 'C:\\Windows\\SYSVOL',
        :require                           => 'Dsc_windowsfeature[AD-Domain-Services]',
    }) }

    it { should contain_reboot('dsc_reboot').with(
        :message => 'DSC has requested a reboot',
        :when    => 'pending',
        :require => 'Dsc_xaddomain[tragiccode.local]',
    ) }

  end
end