# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'
require 'bundler'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

# Prepare: Create the Puppet modules directory to smoke testing
FileUtils.mkdir_p 'modules'

# Internal plugin
module VagrantPlugins
  module PuppetModule
    class Plugin < Vagrant.plugin(VAGRANTFILE_API_VERSION)
      name 'Puppet Module'
      description 'This plugin add install and cleanup hooks to provision'

      action_hook :manage_puppet_modules do |hook|
        hook.before Vagrant::Action::Builtin::Provision, Action
      end
    end

    class Action
      def initialize(app, _)
        @app = app
      end

      def call(env)
        puts 'Install dependency modules...'
        Bundler.clean_system 'bundle exec librarian-puppet install'

        # Call Puppet provisioner
        @app.call(env)

        # Cleanup process is very impotant for run acceptance tests
        puts 'Cleanup dependency modules...'
        FileUtils.rm_rf 'modules'
      end
    end
  end
end

# Read mackerel api key from environment variable to smoke testing.
apikey = ENV['MACKERERL_API_KEY']

SUPPORTING_PLATFORMS = {
  centos: 'puppetlabs/centos-6.6-64-puppet',
  ubuntu: 'puppetlabs/ubuntu-14.04-64-puppet'
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_check_update = false

  SUPPORTING_PLATFORMS.each do |osfamily, box|
    config.vm.define osfamily do |platform|
      platform.vm.box       = box
      platform.vm.host_name = osfamily
    end
  end

  # Create the `mackerel_agent` symlink to the Puppet modules directory
  config.vm.provision :shell do |shell|
    agent_path   = '/vagrant/modules/mackerel_agent'
    shell.inline = "[ -L #{agent_path} ] || ln -s /vagrant/ #{agent_path}"
  end

  # Define Puppet manifest
  config.vm.provision :puppet do |puppet|
    puppet.environment_path  = '.'
    puppet.environment       = 'test'
    puppet.module_path       = 'modules'
    puppet.hiera_config_path = 'test/hiera.yaml'
    puppet.facter            = { apikey: apikey }
  end
end
