include_recipe 'rbenv'
include_recipe 'rbenv::ruby_build'
include_recipe 'java'

package 'libpcre3'
package 'libpcre3-dev'
package 'default-jre-headless'

%w{2.0.0-p353 jruby-1.7.9}.each do |ruby|
  rbenv_ruby ruby

  rbenv_gem 'bundler' do
    ruby_version ruby
  end

  rbenv_gem 'adhearsion' do
    ruby_version ruby
  end
end
