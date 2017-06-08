require 'spec_helper'

describe 'profile::base' do
  context 'with default values for all parameters' do

    it { should contain_class('profile::base') }

  end
end