# == Class: mackerel_agent::install
#
class mackerel_agent::install(
  $ensure = present
) {
  $gpgkey_url = 'https://mackerel.io/assets/files/GPG-KEY-mackerel'

  case $::osfamily {
    'RedHat': {
      yumrepo { 'mackerel':
        name     => 'mackerel',
        baseurl  => "http://yum.mackerel.io/centos/${::architecture}",
        descr    => 'mackerel-agent',
        enabled  => 1,
        gpgkey   => $gpgkey_url,
        gpgcheck => 1
      }
    }
    default: {
      # Do nothing
    }
  }

  package { 'mackerel-agent':
    ensure        => $ensure,
    # [PUP-2650] 3.6.1 issues "warning" message for deprecation
    # https://tickets.puppetlabs.com/browse/PUP-2650
    allow_virtual => false,
  }
}
