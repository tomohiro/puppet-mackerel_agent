require 'beaker-rspec'

module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

# Install Puppet agent on all hosts
install_puppet_agent_on(hosts, {})

RSpec.configure do |c|
  c.formatter = :documentation

  c.before :suite do
    # Install mackerel_agent module to all hosts
    install_dev_puppet_module(:source => module_root)

    hosts.each do |host|
      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      on(host, puppet('module', 'install', 'puppetlabs-apt'))
    end
  end
end
