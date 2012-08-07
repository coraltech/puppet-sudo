
class sudo::params {

  include sudo::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $permissions = hiera_array('sudo_permissions', $sudo::default::permissions)
  }
  else {
    $permissions = $sudo::default::permissions
  }

  #-----------------------------------------------------------------------------
  # Operating system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_visudo_bin        = '/usr/sbin/visudo'
      $os_sudoers_file      = '/etc/sudoers'
      $os_sudoers_test_file = '/etc/sudoers.test'

      $os_sudoers_template  = 'sudo/sudoers.erb'

      $os_sudoers_dir       = '/etc/sudoers.d'
    }
    default: {
      fail("The sudo module is not currently supported on ${::operatingsystem}")
    }
  }
}
