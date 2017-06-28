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

  end

end