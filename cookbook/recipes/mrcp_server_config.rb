cookbook_file "#{node['unimrcp']['install_dir']}/conf/unimrcpserver.xml" do
  owner 'root'
  group 'root'
  source 'unimrcpserver.xml'
  mode 0644
end

bash "install_unimrcp_server_init_script" do
  user "root"
  cwd File.join(node['unimrcp']['src_dir'], 'unimrcp', 'build', 'init.d')
  code 'cp unimrcp-server /etc/init.d'
  action :nothing
  subscribes :run, "bash[install_unimrcp]", :immediately
end

service 'unimrcp-server' do
  action [:enable, :start]
end
