require 'spec_helper_acceptance'

describe 'mackerel_agent class' do
  context 'default parameters with dummy api key' do
    let(:manifest) {
      <<-EOS
        class { 'mackerel_agent':
          apikey => 'dummy'
        }
      EOS
    }

    it 'should work without errors' do
      result = apply_manifest(manifest, :acceptable_exit_codes => [0, 6], :catch_failures => true)
      expect(result.exit_code).not_to eq 2
      expect(result.exit_code).not_to eq 4
    end

    describe package('mackerel-agent') do
      it { should be_installed }
    end

    describe service('mackerel-agent') do
      it { should be_enabled }
      it { should_not be_running } # Because install with the dummy api key
    end
  end
end
