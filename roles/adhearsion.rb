name 'adhearsion'
description 'Installs components necessary to run Adhearsion apps'
run_list "recipe[apt]",
  "recipe[java]",
  "recipe[mojolingo-misc::pcre]",
  "recipe[ruby_build]",
  "recipe[rbenv::user]"

override_attributes 'rbenv' => {
  'user_installs' => [
    { 'user'    => 'vagrant',
      'rubies'  => ['2.0.0-p247', 'jruby-1.7.4'],
      'global'  => '2.0.0-p247',
      'gems'    => {
        '2.0.0-p247' => [
          { 'name' => 'bundler' },
          { 'name' => 'adhearsion' }
        ],
        'jruby-1.7.4' => [
          { 'name' => 'bundler' },
          { 'name' => 'adhearsion' }
        ]
      }
    }
  ]
}
