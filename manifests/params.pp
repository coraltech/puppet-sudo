
class sudo::params {

  #-----------------------------------------------------------------------------

  $visudo_bin   = '/usr/sbin/visudo'
  $sudoers      = '/etc/sudoers'

  $sudoers_path = '/etc/sudoers.d'

  case $::operatingsystem {
    debian, ubuntu: {}
    centos, redhat: {}
  }
}
