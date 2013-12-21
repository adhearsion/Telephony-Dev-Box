cookbook_file "#{node['freeswitch']['confpath']}/autoload_configs/event_socket.conf.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source 'event_socket.conf.xml'
  mode 0644
end
