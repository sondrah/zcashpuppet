require 'spec_helper'
describe 'zcashpuppet' do
  context 'with default values for all parameters' do
    it { should contain_class('zcashpuppet') }
  end
end
