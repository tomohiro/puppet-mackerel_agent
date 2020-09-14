# == Defined type: mackerel_agent::mkr_plugin
#
define mackerel_agent::mkr_plugin {

  $install_location = '/opt/mackerel-agent/plugins'
  $name_array = split($name, '@')

  include ::mackerel_agent

  if !defined(Package['mkr']) {
    fail('Please install mkr')
  }

  exec { "mkr plugin install ${name}":
    command => "mkr plugin install --upgrade ${name}",
    user    => 'root',
    path    => ['/usr/bin'],
    unless  => "test '${name_array[1]}' = '`cat ${install_location}/meta/${name_array[0]}/release_tag`'",
    require => Package['mkr']
  }

}
