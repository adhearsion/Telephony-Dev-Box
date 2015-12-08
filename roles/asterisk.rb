name 'asterisk'
description 'Installs Asterisk to run Adhearsion apps'
run_list "recipe[asterisk]"

override_attributes asterisk: {
  source: {
    version: '13.6.0',
    checksum: '8a01b53c946d092ac561c11b404f68cd328306d0e3b434a7485a11d4b175005a',
  },
  sip: {
    context: 'adhearsion'
  },
  manager: {
    ip_address: '0.0.0.0',
    permit: '0.0.0.0/0.0.0.0',
    read_perms: %w{all},
    write_perms: %w{all},
    event_filters: ['!Event: RTCP*', '!Variable: RTPAUDIOQOS*']
  },
  unimrcp: {
    server_ip: '127.0.0.1',
    server_port: '8060',
    rtp_port_min: '5000',
    rtp_port_max: '6000',
    client_ip: '127.0.0.1',
    rtp_ip: '127.0.0.1'
  }
},
unimrcp: {
  install_flite: true,
  install_pocketsphinx: true
}
