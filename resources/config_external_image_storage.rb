#
# Cookbook Name:: grafana
# Resource:: config_external_image_storage
#
# Copyright 2018, Sous Chefs
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
# Configures the installed grafana instance

property  :instance_name,           String,         name_property: true
property  :conf_directory,          String,         default: '/etc/grafana'
property  :config_file,             String,         default: lazy { ::File.join(conf_directory, 'grafana.ini') }
property  :storage_provider,        String,         required: true, default: 's3'
property  :region,                  String,         required: true, default: 'us-east-1'
property  :bucket,                  String,         required: true
property  :bucket_url,              String,         required: false
property  :path,                    String,         required: false
property  :access_key,              String,         required: false
property  :secret_key,              String,         required: false
property  :cookbook,                String,         default: 'grafana'
property  :source,                  String,         default: 'grafana.ini.erb'

action :install do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      node.run_state['grafana'] ||= { 'conf_template_source' => {}, 'conf_cookbook' => {} }
      source new_resource.source
      cookbook new_resource.cookbook

      variables['grafana']['external_image_storage'] ||= {}
      variables['grafana']['external_image_storage']['storage_provider'] ||= '' unless new_resource.storage_provider.nil?
      variables['grafana']['external_image_storage']['storage_provider'] << new_resource.storage_provider.to_s unless new_resource.storage_provider.nil?
      variables['grafana']['external_image_storage']['region'] ||= '' unless new_resource.region.nil?
      variables['grafana']['external_image_storage']['region'] << new_resource.region.to_s unless new_resource.region.nil?
      variables['grafana']['external_image_storage']['bucket'] ||= '' unless new_resource.bucket.nil?
      variables['grafana']['external_image_storage']['bucket'] << new_resource.bucket.to_s unless new_resource.bucket.nil?
      variables['grafana']['external_image_storage']['bucket_url'] ||= '' unless new_resource.bucket_url.nil?
      variables['grafana']['external_image_storage']['bucket_url'] << new_resource.bucket_url.to_s unless new_resource.bucket_url.nil?
      variables['grafana']['external_image_storage']['path'] ||= '' unless new_resource.path.nil?
      variables['grafana']['external_image_storage']['path'] << new_resource.path.to_s unless new_resource.path.nil?
      variables['grafana']['external_image_storage']['access_key'] ||= '' unless new_resource.access_key.nil?
      variables['grafana']['external_image_storage']['access_key'] << new_resource.access_key.to_s unless new_resource.access_key.nil?
      variables['grafana']['external_image_storage']['secret_key'] ||= '' unless new_resource.secret_key.nil?
      variables['grafana']['external_image_storage']['secret_key'] << new_resource.secret_key.to_s unless new_resource.secret_key.nil?

      action :nothing
      delayed_action :create
    end
  end
end
