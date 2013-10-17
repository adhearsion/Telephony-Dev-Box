name 'adhearsion'
description 'Installs Asterisk to run Adhearsion apps'
run_list "recipe[apt]",
  "recipe[chef-solo-search]",
  "recipe[asterisk]",
  "recipe[asterisk::package]",
  "recipe[asterisk::config]",
  "recipe[asterisk::unimrcp]"

override_attributes asterisk: {
  sip_conf_context: 'adhearsion',
  manager_permit: '0.0.0.0/0.0.0.0',
  manager_read_perms: %w{all},
  manager_write_perms: %w{all}
}
