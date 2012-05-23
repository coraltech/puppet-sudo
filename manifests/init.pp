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
#   $permissions = [ '%admin ALL=(ALL) ALL' ]
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
class sudo ( $permissions = [ '%admin ALL=(ALL) ALL' ] ) {

  include sudo::params

  #-----------------------------------------------------------------------------

  file { '/tmp/sudoers':
    owner  => 'root',
    group  => 'root',
    mode   => 440,
    source => template('sudo/sudoers.erb'),
    notify => Exec['check-sudoers'],
  }

  exec { 'check-sudoers':
    command     => "${sudo::params::visudo_bin} -cf /tmp/sudoers && cp /tmp/sudoers ${sudo::params::sudoers}; rm -f /tmp/sudoers",
    refreshonly => true,
    creates     => $sudo::params::sudoers,
  }
}
