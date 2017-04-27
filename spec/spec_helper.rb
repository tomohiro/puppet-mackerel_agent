require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
    :architecture => 'amd64',
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  }
end
