require 'spec_helper'

describe 'mackerel_agent::service' do
  context 'on a RedHat OS' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'RedHat',
        operatingsystemrelease: '6',
        operatingsystemmajrelease: '6',
      }
    end

    context 'with running (defaults)' do
      it { is_expected.to contain_service('mackerel-agent').with_ensure('running') }
    end

    context 'with stopped' do
      let(:params) do
        { ensure: 'stopped' }
      end

      it { is_expected.to contain_service('mackerel-agent').with_ensure('stopped') }
    end
  end
end
