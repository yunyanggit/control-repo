require 'spec_helper'

describe 'profile::puppetenterprise::puppetserver' do
  context 'with default values for all parameters' do
    file_source_pe_license = 'puppet:///modules/profile/puppetenterprise/puppetserver/license.key'
    let(:params) {{
      :file_source_pe_license => file_source_pe_license,
    }}
    it { should contain_file('/etc/puppetlabs/license.key').with({
        :ensure => 'present',
        :source => file_source_pe_license,
        :notify => 'Service[pe-console-services]',
    }) }
  end
end