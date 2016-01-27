require 'beaker-rspec'

# Install Puppet agent on all hosts
install_puppet_agent_on(hosts, {})

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    # Install module to all hosts
    hosts.each do |host|

      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      on(host, puppet('module', 'install', 'puppetlabs-apt'))
      on(host, puppet('module', 'install', 'tomohiro-mackerel_agent'))
    end
  end
end
