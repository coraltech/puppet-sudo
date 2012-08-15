
class sudo::params inherits sudo::default {

  $visudo_bin        = module_array('visudo_bin')

  $sudoers_dir       = module_array('sudoers_dir')
  $sudoers_file      = module_array('sudoers_file')
  $sudoers_test_file = module_array('sudoers_test_file')
  $sudoers_template  = module_array('sudoers_template')

  $permissions       = module_array('permissions')
}
