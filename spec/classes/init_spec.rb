require 'spec_helper'

describe 'mackerel_agent' do
  let :facts do
    {
      osfamily: 'RedHat',
      operatingsystem: 'RedHat',
      operatingsystemrelease: '6',
      operatingsystemmajrelease: '6',
    }
  end
  describe 'compile' do
    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('mackerel_agent') }
  end

  describe 'supporting operating systems validation' do
    context 'on RedHat has been supported' do
      it { is_expected.to compile }
    end

    context 'on Debian has been supported' do
      let(:facts) do
        { osfamily: 'Debian' }
      end

      it { is_expected.to compile }
    end
  end
end
