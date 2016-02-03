require 'spec_helper'

describe 'mackerel_agent::config' do
  context 'with present (default)' do
    it { should contain_file('mackerel-agent.conf').with_ensure('present') }
    it { should contain_file('/etc/mackerel-agent/conf.d').with_ensure('directory') }
  end

  context 'with absent' do
    let(:params) do
      { :ensure => 'absent' }
    end

    it { should contain_file('mackerel-agent.conf').with_ensure('absent') }
  end
end
