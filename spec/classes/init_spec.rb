require 'spec_helper'

describe 'mackerel_agent' do
  describe 'supporting operationg systems validation' do
    context 'on RedHat' do
      let(:facts) do
        { :osfamily => 'RedHat' }
      end

      it { should contain_class('mackerel_agent') }
    end

    context 'on Debian' do
      let(:facts) do
        { :osfamily => 'Debian' }
      end

      it { should contain_class('mackerel_agent') }
    end
  end
end
