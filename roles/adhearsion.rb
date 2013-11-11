name 'adhearsion'
description 'Installs components necessary to run Adhearsion apps'
run_list "recipe[apt]",
  "recipe[mojolingo-misc::adhearsion]"

override_attributes 'rbenv' => {
  'group_users' => ['vagrant']
}
