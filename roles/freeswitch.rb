name 'adhearsion'
description 'Installs FreeSWITCH to run Adhearsion apps'
run_list "recipe[apt]",
  "recipe[freeswitch]"

override_attributes freeswitch: {
  tls_only: false,
  dialplan: {
    head_fragments: '<extension name="adhearsion">
  <condition>
    <action application="rayo"/>
  </condition>
</extension>'
  }
}
