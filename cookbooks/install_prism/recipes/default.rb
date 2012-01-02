#'openjdk-6-jre-headless' needed?
pkgs = ['libxerces-c28','libnspr4-0d', 'libidn11', "lynx", "psmisc"]
pkgs.each do |pkg|
  package pkg do
    action:nothing
  end.run_action(:install)
end

execute "set execute bit on installer" do
  cwd "/vagrant/components_to_be_installed/prism"
  command "sudo chmod +x prism.bin"
  only_if {File.exists?("/vagrant/components_to_be_installed/prism/prism.bin")}
end
  
execute "run prism installer" do
  cwd "/vagrant/components_to_be_installed/prism"
  creates "/opt/voxeo/prism"  
  command "sudo ./prism.bin -i silent"
  only_if {File.exists?("/vagrant/components_to_be_installed/prism/prism.bin")}
  
end

execute "start tropo app server" do
  creates "/opt/voxeo/prism/apps/tropo"  
  command "/opt/voxeo/prism/bin/prism service as"
  not_if {File.exists?("/opt/voxeo/prism/apps/tropo") || !File.exists?("/opt/voxeo/prism/bin/prism")}
  
end

execute "kill as process if running" do
  command "killall vxagent -w"
  returns [0,1]
  not_if do
    File.exists?("/etc/init/voxeo-smanager.conf")
  end
end




cookbook_file "/opt/voxeo/prism/conf/portappmapping.properties" do
  source "portappmapping.properties"
  mode "775"
  owner "root"
  only_if {File.exists?("/opt/voxeo/prism/conf")}
end
#TODO this needs to be copied from license_file dir

execute "copy license.xml" do
   command "sudo cp /vagrant/components_to_be_installed/prism/license_file/license.xml /opt/voxeo/prism/conf/license.xml; sudo chmod 775 /opt/voxeo/prism/conf/license.xml "
   only_if {File.exists?("/opt/voxeo/prism/conf") && File.exists?("/vagrant/components_to_be_installed/prism/license_file/license.xml")}
end

cookbook_file "/opt/voxeo/prism/apps/tropo/WEB-INF/classes/tropo.xml" do
  source "tropo.xml"
  mode "644"
  owner "root"
  only_if {File.exists?("/opt/voxeo/prism/apps/tropo")}
end

ruby_block "prompt_message_voxeo_installer" do
  block do
    unless File.exists?("/vagrant/components_to_be_installed/prism/prism.bin")
      Chef::Log.error "*** Missing Voxeo Installer. Please copy latest build to working directory/components_to_be_installed/prism as prism.bin  and vagrant provision  again ***"
      abort "missing voxeo installer"
    end
  end
end

ruby_block "prompt_message_voxeo_installed" do
  block do
    unless File.exists?("/opt/voxeo/prism/conf")
      Chef::Log.error "*** Missing Voxeo Install. No conf directory found.  Did you run the installer at /vagrant/components_to_be_installed/prism/prism.bin? ***"
      abort "voxeo install not extracted"
    end
  end
end

#


