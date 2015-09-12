require 'spec_helper'

describe 'mackerel_agent::config' do
  let(:facts) do
    { :osfamily => 'RedHat' }
  end

  it { should contain_file('mackerel-agent.conf').with_ensure('present') }

  context 'with absent' do
    let(:params) do
      { :ensure => 'absent' }
    end

    it { should contain_file('mackerel-agent.conf').with_ensure('absent') }
  end
end
