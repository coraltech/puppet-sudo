# Class: sudo
#
#   This module configures sudoers permissions.
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <examples/params.json> for Hiera configurations)
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

  $permissions       = $sudo::params::permissions,
  $visudo_bin        = $sudo::params::visudo_bin,
  $sudoers_dir       = $sudo::params::sudoers_dir,
  $sudoers_file      = $sudo::params::sudoers_file,
  $sudoers_test_file = $sudo::params::sudoers_test_file,
  $sudoers_template  = $sudo::params::sudoers_template,

) inherits sudo::params {

  #-----------------------------------------------------------------------------
  # Configuration

  file { 'sudoers-test-file':
    path        => $sudoers_test_file,
    owner       => 'root',
    group       => 'root',
    mode        => 440,
    content     => template($sudoers_template),
    notify      => Exec['check-sudoers'],
  }

  exec { 'check-sudoers':
    command     => "${visudo_bin} -cf ${sudoers_test_file}",
    subscribe   => File['sudoers-test-file'],
    refreshonly => true,
  }

  file { 'sudoers':
    path      => $sudoers_file,
    owner     => 'root',
    group     => 'root',
    mode      => 440,
    source    => $sudoers_test_file,
    subscribe => Exec['check-sudoers'],
  }
}
