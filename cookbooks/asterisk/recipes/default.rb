#
# Cookbook Name:: asterisk
# Recipe:: default
#
# Copyright 2011, Chris Peplin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform']
when "ubuntu","debian"
  apt_repository "asterisk" do
     uri "http://packages.asterisk.org/deb"
     components ["lucid","main"]
     action :add
  end
  
  package "asterisk" do
    options "--force-yes"
  end
  package "asterisk-dahdi" do
    options "--force-yes"
  end 
  #if you wanted to set up a service....
  # service "asterisk" do
  #     provider Chef::Provider::Service::Upstart
  #     supports :restart => true, :start => true, :stop => true
  #   end
  #   
  # 
  template "/etc/asterisk/manager.conf" do
        source "manager.conf.erb"
        owner "asterisk"
        group "asterisk"
        mode 0644
        #this only works if you define the service
        #notifies :reload, resources(:service => "asterisk")
  end
  

  template "/etc/asterisk/sip.conf" do
     source "sip.conf.erb"
     #can't do this unless you define the resource
     #notifies :reload, resources(:service => "asterisk")
     external_ip = node[:ec2] ? node[:ec2][:public_ipv4] : node[:ipaddress]
     owner "asterisk"
     group "asterisk"
     mode 0644
     variables :external_ip => external_ip
     
   end 
 
   
  template "/etc/asterisk/extensions.conf" do
       source "extensions.conf.erb"
       owner "asterisk"
       group "asterisk"
       mode 0644
    
   end 
   #stop the service because you dont want prism and asterisk running
   service "asterisk" do
     action :stop
   end
   
   
    template "asterisk.upstart.conf" do
     path "/etc/init/asterisk.conf"
     source "asterisk.upstart.conf.erb"
     owner "root"
     group "root"
     mode "0644"
   end
 
 #   
end
