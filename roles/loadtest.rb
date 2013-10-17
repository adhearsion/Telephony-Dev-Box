name 'adhearsion'
description 'Installs load testing tools'
run_list "recipe[apt]",
  "recipe[sipp]",
  "recipe[wav2rtp]",
  "recipe[ruby_build]",
  "recipe[rbenv::user]",
  "recipe[sudo]"

override_attributes 'rbenv' => {
  'user_installs' => [
    { 'user'    => 'vagrant',
      'rubies'  => ['1.9.3-p448'],
      'global'  => '1.9.3-p448',
      'gems'    => {
        '1.9.3-p448' => [
          { 'name' => 'sippy_cup' }
        ]
      }
    }
  ]
},
"authorization" => {
  "sudo" => {
    "users" => ["vagrant"],
    "passwordless" => "true"
  }
}
