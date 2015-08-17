# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

# Copied from https://github.com/mackerelio/cookbook-mackerel-agent
apikey = File.read('.mackerel-api-key').chomp!

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_check_update = false

  # Create `mackerel_agent` symlink to puppet modules
  agent_path = '/vagrant/modules/mackerel_agent'
  config.vm.provision :shell,
    inline: "[ -L #{agent_path} ] || ln -s /vagrant/ #{agent_path}"

  config.vm.define :centos do |centos|
    centos.vm.box    = 'puppetlabs/centos-6.6-64-puppet'
    centos.vm.host_name = 'centos'

    centos.vm.provision  :puppet do |puppet|
      puppet.manifests_path = 'tests'
      puppet.manifest_file  = 'init.pp'
      puppet.module_path    = 'modules'
      puppet.facter = {
        'apikey' => apikey
      }
    end
  end
  end
end
