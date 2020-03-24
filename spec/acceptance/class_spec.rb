require 'spec_helper_acceptance'

describe 'mackerel_agent class' do
  context 'default parameters with dummy api key' do
    let(:manifest) do
      <<-EOS
        class { 'mackerel_agent':
          apikey => 'dummy'
        }
      EOS
    end

    it 'works without errors' do
      result = apply_manifest(manifest, acceptable_exit_codes: [0, 6], catch_failures: true)
      expect(result.exit_code).not_to eq 1
      expect(result.exit_code).not_to eq 4
    end

    describe package('mackerel-agent') do
      it { is_expected.to be_installed }
    end

    describe service('mackerel-agent') do
      it { is_expected.to be_enabled }
      it { is_expected.not_to be_running } # Because install with the dummy api key
    end
  end
end
