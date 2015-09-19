require 'spec_helper'

describe 'mackerel_agent::install' do
  let(:facts) do
    { :osfamily => 'RedHat' }
  end

  it { should contain_package('mackerel-agent').with_ensure('present') }

  context 'with absent' do
    let(:params) do
      { :ensure => 'absent' }
    end

    it { should contain_package('mackerel-agent').with_ensure('absent') }
  end
end
