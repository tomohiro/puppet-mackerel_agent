require 'spec_helper'

describe 'mackerel_agent::install' do
  context 'with present (default)' do
    it { should contain_package('mackerel-agent').with_ensure('present') }
  end

  context 'with absent' do
    let(:params) do
      { :ensure => 'absent' }
    end

    it { should contain_package('mackerel-agent').with_ensure('absent') }
  end
end
