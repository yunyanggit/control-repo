require 'spec_helper'

describe 'profile::activedirectory::users' do
  context 'with default values for all parameters' do
    let(:params) {{
      :domain_administrator_password => 'Testing123!',
    }}
    # Needed in order to get that 100% code coverage
    it { should contain_class('profile::activedirectory::users') }

    it { should contain_dsc_xaduser('ad_principal_manager').with({
        :dsc_ensure      => 'present',
        :dsc_domainname  => 'tragiccode.local',
        :dsc_username    => 'ad_principal_manager',
        # TODO: Put in credential
        :dsc_description => 'Managed by Puppet! Changes made manually may be lost.',
    }) }

  end
end