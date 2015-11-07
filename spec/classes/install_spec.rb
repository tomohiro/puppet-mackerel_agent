require 'spec_helper'

describe 'mackerel_agent::install' do
  context 'with present (default)' do
    it { should contain_package('mackerel-agent').with_ensure('present') }
    it { should contain_file('/etc/mackerel-agent/conf.d').with_ensure('directory') }
  end

  context 'with absent' do
    let(:params) do
      { :ensure => 'absent' }
    end

    it { should contain_package('mackerel-agent').with_ensure('absent') }
  end

  context 'with mackerel agent plugins' do
    let(:params) do
      { :use_agent_plugins => true }
    end

    it { should contain_package('mackerel-agent-plugins').with_ensure('present') }
  end

  context 'without mackerel agent plugins' do
    let(:params) do
      { :use_agent_plugins => false }
    end

    it { should contain_package('mackerel-agent-plugins').with_ensure('absent') }
  end


  context 'with mackerel check plugins' do
    let(:params) do
      { :use_check_plugins => true }
    end

    it { should contain_package('mackerel-check-plugins').with_ensure('present') }
  end

  context 'without mackerel check plugins' do
    let(:params) do
      { :use_check_plugins => false }
    end

    it { should contain_package('mackerel-check-plugins').with_ensure('absent') }
  end
end
