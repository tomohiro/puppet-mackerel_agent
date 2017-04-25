require 'spec_helper'

describe 'mackerel_agent::config' do
  context 'with present (default)' do
    it { should contain_file('mackerel-agent.conf').with_ensure('present') }
    it { should contain_file('/etc/mackerel-agent/conf.d').with_ensure('directory') }
  end

  context 'with absent' do
    let(:params) do
      { :ensure => 'absent' }
    end

    it { should contain_file('mackerel-agent.conf').with_ensure('absent') }
  end

  context 'with roles' do
    let(:params) do
      { :roles => %w[service:web service:database] }
    end

    it { should contain_file('mackerel-agent.conf').with_ensure('present').with_content(%r{^roles = \["service:web", "service:database"\]$}) }
  end

  context 'with host_status' do
    let(:params) do
      { :host_status => {'on_start' => 'working', 'on_stop' => 'poweroff'} }
    end

    it { should contain_file('mackerel-agent.conf').with_ensure('present').with_content(%r{^\[host_status\]\non_start = "working"\non_stop  = "poweroff"$}) }
  end

  context 'with ignore_filesystems' do
    let(:params) do
      { :ignore_filesystems => '/dev/ram.*' }
    end

    it { should contain_file('mackerel-agent.conf').with_ensure('present').with_content(%r{^\[filesystems\]\nignore = "/dev/ram.*"$}) }
  end

  context 'with check_plugins' do
    let(:params) do
      { :check_plugins => { 'access_log' => '/usr/local/bin/check-log --file /var/log/access.log --pattern FATAL' } }
    end
    it { should contain_file('mackerel-agent.conf').with_ensure('present').with_content(%r{^\[plugin.checks.*\]\ncommand = \".*\"$}) }
  end

  context 'with check_plugins on some parameters' do
    let(:params) do
      { :check_plugins => { 'ssh' => { 'command' => 'ruby /path/to/check-ssh.rb', 'notification_interval' => '6', 'max_check_attempts' => '3', 'check_interval' => '5'} } }
    end
    it { should contain_file('mackerel-agent.conf').with_ensure('present').with_content(%r{^\[plugin.checks.*\]\ncommand = \".*\"\nnotification_interval = .*\nmax_check_attempts = .*\ncheck_interval = .*$}) }
  end

end
