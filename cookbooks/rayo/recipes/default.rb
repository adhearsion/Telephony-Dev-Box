execute "install rayo" do
  creates "/opt/voxeo/prism/apps/rayo"  
  command "sudo cp /vagrant/components_to_be_installed/rayo/rayo.war /opt/voxeo/prism/apps"
  only_if { File.exists?("/vagrant/components_to_be_installed/rayo/rayo.war") }
end

ruby_block "prompt_message_rayo_available" do
  block do
    unless File.exists?("/vagrant/components_to_be_installed/rayo/rayo.war")
      Chef::Log.error "*** Missing Rayo War file. Please copy latest build to components_to_be_installed/rayo as rayo.war and vagrant provision again. You may also run the scripts/install_rayo.rb script ***"
      abort "missing rayo file"
    end
  end
end
