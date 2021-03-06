require 'spec_helper_acceptance'

describe 'profile::linux::squidproxy' do

  context 'when installing with provided mandatory parameters' do

    let(:install_manifest) {
      <<-MANIFEST
          include profile::linux::squidproxy
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(install_manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(install_manifest, :catch_changes => true)
    end

    describe package('squid') do
      it { should be_installed }
    end

    describe service('squid') do
      it { should be_running }
      it { should be_enabled }
    end

    describe port(3128) do
      it { should be_listening }
    end

    describe file('/etc/squid/squid.conf') do
      its(:content) { should match /#{Regexp.escape('acl localnet src 10.43.192.0/18')}/ }
      its(:content) { should match /#{Regexp.escape('http_access allow localnet')}/ }
      its(:content) { should match /#{Regexp.escape('acl gcp_metadata dst 169.254.169.254')}/ }
      its(:content) { should match /#{Regexp.escape('http_access deny gcp_metadata')}/ }
      its(:content) { should match /#{Regexp.escape('http_access deny all')}/ }
      its(:content) { should match /cache deny all/ }
    end

  end

end