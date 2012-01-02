require_recipe "apt"
require_recipe "rvm::system"
require_recipe "rvm::vagrant"
require_recipe "rvm::create_gemset"
require_recipe "install_prism"
require_recipe "install_rayo"
require_recipe "prism_upstart"
require_recipe "asterisk"
require_recipe "motd-tail"

%w{gems doc cache}.each do |dir|
  execute "chmod" do
    command "chmod g+w /usr/local/rvm/gems/ruby-1.9.2-p290/#{dir}"
    action :run
  end
end
