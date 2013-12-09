name 'adhearsion'
description 'Installs FreeSWITCH to run Adhearsion apps'
run_list "recipe[apt]",
  "recipe[freeswitch::rayo]"

