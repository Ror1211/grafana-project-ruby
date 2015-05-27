#
# Cookbook Name:: grafana
# Recipe:: nginx
#
# Copyright 2014, Jonathan Tron
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

require 'base64'

include_recipe 'nginx'

graphite_basic_auth = if !node['grafana']['graphite_user'].empty? && !node['grafana']['graphite_password'].empty?
                        Base64.strict_encode64 "#{node['grafana']['graphite_user']}:#{node['grafana']['graphite_password']}"
                      end

template '/etc/nginx/sites-available/grafana' do
  source node['grafana']['nginx']['template']
  cookbook node['grafana']['nginx']['template_cookbook']
  notifies :reload, 'service[nginx]'
  mode '0644'
  owner 'root'
  group 'root'
  variables(
    graphite_scheme: node['grafana']['graphite_scheme'],
    graphite_server: node['grafana']['graphite_server'],
    graphite_port: node['grafana']['graphite_port'],
    server_name: node['grafana']['webserver_hostname'],
    server_aliases: node['grafana']['webserver_aliases'],
    listen_address: node['grafana']['webserver_listen'],
    listen_port: node['grafana']['webserver_port'],
    graphite_basic_auth: graphite_basic_auth.to_s
  )
end

nginx_site 'grafana' do
  template false
end
