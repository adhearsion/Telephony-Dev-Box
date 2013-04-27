#
# Cookbook Name:: rbenv
# Recipe:: system
#
# Copyright 2010, 2011 Fletcher Nichol
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

include_recipe "rbenv::system_install"

Array(node['rbenv']['rubies']).each do |rubie|
  rbenv_ruby rubie
end

if node['rbenv']['global']
  rbenv_global node['rbenv']['global']
end

node['rbenv']['gems'].each_pair do |rubie, gems|
  Array(gems).each do |gem|
    rbenv_gem gem['name'] do
      rbenv_version rubie

      %w{version action options source}.each do |attr|
        send(attr, gem[attr]) if gem[attr]
      end
    end
  end
end
