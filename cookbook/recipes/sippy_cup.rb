include_recipe 'sipp'
include_recipe 'wav2rtp'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

ruby_v = '1.9.3-p484'

rbenv_ruby ruby_v do
  global true
end

rbenv_gem 'sippy_cup' do
  ruby_version ruby_v
end
