require 'spec_helper'
describe 'mackerel_agent' do

  context 'with defaults for all parameters' do
    it { should contain_class('mackerel_agent') }
  end
end
