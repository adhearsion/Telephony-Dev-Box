name 'loadtest'
description 'Installs load testing tools'
run_list "recipe[apt]",
  "recipe[sudo]",
  "recipe[telephony-dev-box::sippy_cup]"

override_attributes 'rbenv' => {
  'group_users' => ['vagrant']
},
"authorization" => {
  "sudo" => {
    "users" => ["vagrant"],
    "passwordless" => "true"
  }
}
