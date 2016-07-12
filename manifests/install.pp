# == Class: mackerel_agent::install
#
class mackerel_agent::install(
  $ensure              = present,
  $use_metrics_plugins = undef,
  $use_check_plugins   = undef
) {
  $gpgkey_url = 'https://mackerel.io/assets/files/GPG-KEY-mackerel'

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'Amazon': {
          $baseurl = 'http://yum.mackerel.io/amznlinux/$releasever/$basearch'
        }
        default: {
          $baseurl = 'http://yum.mackerel.io/centos/$basearch'
        }
      }

      yumrepo { 'mackerel':
        name     => 'mackerel',
        baseurl  => $baseurl,
        descr    => 'mackerel-agent',
        enabled  => 1,
        gpgkey   => $gpgkey_url,
        gpgcheck => 1,
      }

      $pkg_require = Yumrepo['mackerel']
    }
    'Debian': {
      apt::key { 'mackerel':
        id     => '2748FD61027D357542F8394DF92F673FC2B48821',
        source => $gpgkey_url
      }

      apt::source { 'mackerel':
        location => 'http://apt.mackerel.io/debian/',
        release  => 'mackerel',
        repos    => 'contrib',
        include  => {
          source => false
        },
        require  => Apt::Key['mackerel'],
      }

      $pkg_require = Class['apt::update']
    }
    default: {
      # Do nothing
      $pkg_require = undef
    }
  }

  package { 'mackerel-agent':
    ensure  => $ensure,
    require => $pkg_require,
  }

  case $use_metrics_plugins {
    true: {
      package { 'mackerel-agent-plugins':
        ensure  => present,
        require => $pkg_require,
      }
    }
    false: {
      package { 'mackerel-agent-plugins':
        ensure  => absent,
        require => $pkg_require,
      }
    }
    'latest': {
      package { 'mackerel-agent-plugins':
        ensure  => latest,
        require => $pkg_require,
      }
    }
    default: {
      # Do nothing
    }
  }

  case $use_check_plugins {
    true: {
      package { 'mackerel-check-plugins':
        ensure  => present,
        require => $pkg_require,
      }
    }
    false: {
      package { 'mackerel-check-plugins':
        ensure  => absent,
        require => $pkg_require,
      }
    }
    'latest': {
      package { 'mackerel-check-plugins':
        ensure  => latest,
        require => $pkg_require,
      }
    }
    default: {
      # Do nothing
    }
  }
}
