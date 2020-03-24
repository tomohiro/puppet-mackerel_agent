# == Defined type: mackerel_agent::mkr_plugin
#
define mackerel_agent::mkr_plugin {

  include ::mackerel_agent

  if !defined(Package['mkr']) {
    fail('Please install mkr')
  }

  exec { "mkr plugin install ${name}":
    command => "mkr plugin install --upgrade ${name}",
    user    => 'root',
    path    => ['/usr/bin'],
    require => Package['mkr']
  }

}
