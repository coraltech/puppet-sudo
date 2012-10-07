
class sudo::params inherits sudo::default {

  $visudo_bin        = module_param('visudo_bin')

  $sudoers_dir       = module_param('sudoers_dir')
  $sudoers_file      = module_param('sudoers_file')
  $sudoers_test_file = module_param('sudoers_test_file')
  $sudoers_template  = module_param('sudoers_template')

  $permissions       = module_array('permissions')
}
