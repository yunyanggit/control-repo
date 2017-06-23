require 'spec_helper'

describe 'profile::linux::puppetenterprise::puppetserver' do
  context 'with default values for all parameters' do
    file_source_pe_license     = 'puppet:///modules/profile/puppetenterprise/puppetserver/license.key'
    file_source_auto_sign_conf = 'puppet:///modules/profile/puppetenterprise/puppetserver/autosign.conf'
    let(:facts) {{
        :networking => { 'ip' => '10.0.2.15', },
    }}
    let(:params) {{
      :file_source_pe_license => file_source_pe_license,
    }}
    it { should contain_file('/etc/puppetlabs/license.key').with({
        :ensure => 'present',
        :source => file_source_pe_license,
        :notify => 'Service[pe-console-services]',
    }) }

    it { should contain_file('/etc/puppetlabs/puppet/autosign.conf').with({
        :ensure => 'present',
        :source => file_source_auto_sign_conf,
        :notify => 'Service[pe-console-services]',
    }) }
  end
end