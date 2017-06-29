require 'spec_helper_acceptance'

describe 'profile::windows::base' do


  context 'when installing with provided mandatory parameters' do

    let(:install_manifest) {
      <<-MANIFEST
          include profile::windows::base
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(install_manifest, :catch_failures => true)
    end
    
    it 'should have the timezone set to UTC' do
      apply_manifest(install_manifest, :catch_changes => true)
    end

    describe command('(Get-TimeZone).Id') do
       its(:stdout) { should match 'UTC' }
    end

  end

end