require 'spec_helper'

describe 'profile::windows::base' do

  context 'with default values for all parameters' do

    it { should contain_class('profile::windows::base') }

    it { should contain_dsc_xtimezone('Server Timezone').with({
        :ensure               => 'present',
        :dsc_issingleinstance => 'yes',
        :dsc_timezone         => 'UTC',
    }) }

  end
end