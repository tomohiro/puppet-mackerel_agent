require 'spec_helper'

describe 'mackerel_agent::install' do
  context 'on a RedHat OS' do
    let :facts do
      {
        osfamily: 'RedHat',
	operatingsystem: 'RedHat',
	operatingsystemrelease: '6',
	operatingsystemmajrelease: '6',
      }
    end

    context 'with present (default)' do
      it { is_expected.to contain_package('mackerel-agent').with_ensure('present') }
    end

    context 'with absent' do
      let(:params) do
        { ensure: 'absent' }
      end

      it { is_expected.to contain_package('mackerel-agent').with_ensure('absent') }
    end

    context 'with mackerel agent plugins' do
      let(:params) do
        { use_metrics_plugins: true }
      end

      it { is_expected.to contain_package('mackerel-agent-plugins').with_ensure('present') }
    end

    context 'without mackerel agent plugins' do
      let(:params) do
        { use_metrics_plugins: false }
      end

      it { is_expected.to contain_package('mackerel-agent-plugins').with_ensure('absent') }
    end

    context 'with latest mackerel agent plugins' do
      let(:params) do
        { use_metrics_plugins: 'latest' }
      end

      it { is_expected.to contain_package('mackerel-agent-plugins').with_ensure('latest') }
    end

    context 'with mackerel check plugins' do
      let(:params) do
        { use_check_plugins: true }
      end

      it { is_expected.to contain_package('mackerel-check-plugins').with_ensure('present') }
    end

    context 'without mackerel check plugins' do
      let(:params) do
        { use_check_plugins: false }
      end

      it { is_expected.to contain_package('mackerel-check-plugins').with_ensure('absent') }
    end

    context 'with latest mackerel check plugins' do
      let(:params) do
        { use_check_plugins: 'latest' }
      end

      it { is_expected.to contain_package('mackerel-check-plugins').with_ensure('latest') }
    end

    context 'with mkr' do
      let(:params) do
        { use_mkr: true }
      end

      it { is_expected.to contain_package('mkr').with_ensure('present') }
    end

    context 'without mkr' do
      let(:params) do
        { use_mkr: false }
      end

      it { is_expected.to contain_package('mkr').with_ensure('absent') }
    end

    context 'with latest mackerel check plugins' do
      let(:params) do
        { use_mkr: 'latest' }
      end

      it { is_expected.to contain_package('mkr').with_ensure('latest') }
    end
  end
end
