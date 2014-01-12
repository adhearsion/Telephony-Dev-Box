cookbook_file "#{node['unimrcp']['install_dir']}/conf/unimrcpserver.xml" do
  owner 'root'
  group 'root'
  source 'unimrcpserver.xml'
  mode 0644
end
