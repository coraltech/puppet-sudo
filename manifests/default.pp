
class sudo::default {

  $permissions  = [ '%admin ALL=(ALL) ALL' ]

  #---

  case $::operatingsystem {
    debian, ubuntu: {
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
