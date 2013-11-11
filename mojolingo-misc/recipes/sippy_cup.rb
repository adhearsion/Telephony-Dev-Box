include_recipe 'sipp'
include_recipe 'wav2rtp'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby '1.9.3-p448'

rbenv_gem 'sippy_cup' do
  ruby_version '1.9.3-p448'
end
