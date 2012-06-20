
class sudo::params {

  #-----------------------------------------------------------------------------

  $permissions  = [ '%admin ALL=(ALL) ALL' ]

  $visudo_bin   = '/usr/sbin/visudo'
  $sudoers      = '/etc/sudoers'
  $sudoers_test = '/etc/sudoers.test'

  $sudoers_path = '/etc/sudoers.d'

  case $::operatingsystem {
    debian, ubuntu: {}
    centos, redhat: {}
  }
}
