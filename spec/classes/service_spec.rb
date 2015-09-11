require 'spec_helper'

describe 'mackerel_agent::service' do
  let(:facts) do
    { :osfamily => 'RedHat' }
  end

  context 'with running (defaults)' do
    it { should contain_service('mackerel-agent').with_ensure('running') }
  end

  context 'with stopped' do
    let(:params) do
      { :ensure => 'stopped' }
    end

    it { should contain_service('mackerel-agent').with_ensure('stopped') }
  end
end
