name 'asterisk'
description 'Installs Asterisk to run Adhearsion apps'
run_list "recipe[asterisk]",
  "recipe[asterisk::unimrcp]"

override_attributes asterisk: {
  sip: {
    context: 'adhearsion'
  },
  manager: {
    permit: '0.0.0.0/0.0.0.0',
    read_perms: %w{all},
    write_perms: %w{all}
  }
}
