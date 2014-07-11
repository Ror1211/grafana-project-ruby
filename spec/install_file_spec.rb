require 'spec_helper'

module ChefSpecArkMatchers
  def put_ark(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new :ark, :put, resource_name
  end
end

describe 'grafana::_install_file' do

  include ChefSpecArkMatchers

  let(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end

  it 'install grafana from remote url using ark' do
    expect(chef_run).to put_ark('grafana').with(
      url: chef_run.node['grafana']['file']['url'],
      path: chef_run.node['grafana']['install_path'],
      checksum: chef_run.node['grafana']['file']['checksum'],
      owner: chef_run.node['nginx']['user'],
      strip_components: 1
    )
  end

  context 'with grafana version older than 1.5.1' do
    let(:chef_run) do
      ChefSpec::Runner.new do |runner|
        runner.node.set['grafana']['file']['version'] = '1.5.0'
      end.converge described_recipe
    end

    it 'install grafana from remote url using ark' do
      expect(chef_run).to put_ark('grafana').with(
        url: chef_run.node['grafana']['file']['url'],
        path: chef_run.node['grafana']['install_path'],
        checksum: chef_run.node['grafana']['file']['checksum'],
        owner: chef_run.node['nginx']['user'],
        strip_components: 0
      )
    end
  end

end
