require 'spec_helper'

describe 'profile::activedirectory::rbac' do
  context 'with default values for all parameters' do
    sensitive_value_redacted_message = '#<Sensitive [value redacted]'
    
    # Needed in order to get that 100% code coverage
    it { should contain_class('profile::activedirectory::rbac') }


    it { should contain_dsc_xaduser('ad_principal_manager').with({
        :dsc_ensure      => 'present',
        :dsc_domainname  => 'tragiccode.local',
        :dsc_username    => 'ad_principal_manager',
        :dsc_description => 'Managed by Puppet! Changes made manually may be lost.',
    }).with_dsc_password(/#{Regexp.escape(sensitive_value_redacted_message)}/) }

    it { should contain_dsc_xadgroup('Domain Admins').with({
        :dsc_ensure           => 'present',
        :dsc_groupname        => 'Domain Admins',
        :dsc_memberstoinclude => ['ad_principal_manager'],
        :dsc_category         => 'Security',
        :dsc_groupscope       => 'Global',
        :dsc_description      => 'Managed by Puppet! Changes made manually may be lost.',
    }) }

  end
end