cookbook_file "/etc/init/voxeo-smanager.conf" do
  source "voxeo-smanager.conf"
  mode "644"
  owner "root"
end

cookbook_file "/etc/init/voxeo-mediaserver.conf" do
  source "voxeo-mediaserver.conf"
  mode "644"
  owner "root"
end

cookbook_file "/etc/init/voxeo-appserver.conf" do
  source "voxeo-appserver.conf"
  mode "644"
  owner "root"
end

execute "kill as process if running" do
  command "killall vxlaunch"
  returns [0,1]
  not_if do
    File.exists?("/etc/init/voxeo-smanager.conf")
  end
end


