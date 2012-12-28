
class sudo::default {

  $exempt_group = 'admin'
  $permissions  = [ '%admin ALL=(ALL) NOPASSWD:ALL' ]

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $secure_path       = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

      $visudo_bin        = '/usr/sbin/visudo'
      $sudoers_file      = '/etc/sudoers'
      $sudoers_test_file = '/etc/sudoers.test'

      $sudoers_template  = 'sudo/sudoers.erb'

      $sudoers_dir       = '/etc/sudoers.d'
    }
    default: {
      fail("The sudo module is not currently supported on ${::operatingsystem}")
    }
  }
}
