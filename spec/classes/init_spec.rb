require 'spec_helper'

describe 'mackerel_agent' do
  describe 'compile' do
    it { should compile }
    it { should compile.with_all_deps }
    it { should contain_class('mackerel_agent') }
  end

  describe 'supporting operating systems validation' do
    context 'on RedHat has been supported' do
      it { should compile }
    end

    context 'on Debian has been supported' do
      let(:facts) do
        { :osfamily => 'Debian' }
      end

      it { should compile }
    end
  end

  describe 'unsupporting operating systems validation' do
    context 'on Darwin has not been supported' do
      let(:facts) do
        { :osfamily => 'Windows' }
      end

      it { should_not compile }
    end
  end
end
