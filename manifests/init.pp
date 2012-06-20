# Class: sudo
#
#   This module configures sudoers permissions.
#
#   Adrian Webb <adrian.webb@coraltg.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#   $permissions  = $sudo::params::permissions,
#   $visudo_bin   = $sudo::params::visudo_bin,
#   $sudoers      = $sudo::params::sudoers,
#   $sudoers_path = $sudo::params::sudoers_path
#
# Actions:
#
#   Configures a flexible array of given sudoers permissions
#
# Requires:
#
# Sample Usage:
#
#   class { 'sudo':
#     permissions => [ '%admin ALL=(ALL) ALL' ]
#   }
#
# [Remember: No empty lines between comments and class definition]
class sudo (

  $permissions  = $sudo::params::permissions,
  $visudo_bin   = $sudo::params::visudo_bin,
  $sudoers      = $sudo::params::sudoers,
  $sudoers_test = $sudo::params::sudoers_test,
  $sudoers_path = $sudo::params::sudoers_path

) inherits sudo::params {

  #-----------------------------------------------------------------------------

  file { $sudoers_test:
    owner       => 'root',
    group       => 'root',
    mode        => 440,
    content     => template('sudo/sudoers.erb'),
    notify      => Exec['check-sudoers'],
  }

  exec { 'check-sudoers':
    command     => "${visudo_bin} -cf ${sudoers_test}",
    subscribe   => File[$sudoers_test],
    refreshonly => true,
  }

  file { $sudoers:
    owner     => 'root',
    group     => 'root',
    mode      => 440,
    source    => $sudoers_test,
    subscribe => Exec['check-sudoers'],
  }
}
