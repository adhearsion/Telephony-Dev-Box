cookbook_file "#{node['freeswitch']['confpath']}/autoload_configs/unimrcp.conf.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source 'unimrcp.conf.xml'
  mode 0644
end

directory "#{node['freeswitch']['confpath']}/mrcp_profiles" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
end

cookbook_file "#{node['freeswitch']['confpath']}/mrcp_profiles/lumenvox.conf.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source 'lumenvox.conf.xml'
  mode 0644
end
