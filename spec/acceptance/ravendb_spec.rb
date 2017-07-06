require 'spec_helper_acceptance'

describe 'profile::windows::ravendb' do

  context 'when installing with provided mandatory parameters' do

    let(:install_manifest) {
      <<-MANIFEST
          include profile::windows::ravendb
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(install_manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(install_manifest, :catch_changes => true)
    end
    

    describe package('RavenDB') do
      it { should be_installed }
    end

    describe service('RavenDB') do
      it { should be_running }
      it { should be_enabled }
    end

    describe port(8080) do
      it { should be_listening }
    end 

  end
end