require_relative 'spec_helper'

describe 'icinga::server' do
  let(:chef_run) { prepare_chef_run }

  it 'should override attributes, and then call the nagios cookbook, tricking it into installing Icinga' do
    chef_run.node.set['nagios']['server']['install_method'] = 'package'
    chef_run.converge 'icinga::server'

    expect(chef_run).to include_recipe "nagios::server"
    expect(chef_run).to include_recipe "nagios::server_package"
    expect(chef_run).not_to include_recipe "nagios::server_source"
    expect(chef_run).to install_package 'icinga'
    expect(chef_run).not_to install_package 'nagios3'
    expect(chef_run).to create_file '/etc/icinga/icinga.cfg'
    expect(chef_run).to create_file '/etc/icinga/objects/services.cfg'
  end

  it 'should do the trick with source install as well' do
    chef_run.node.set['nagios']['server']['install_method'] = 'source'
    chef_run.converge 'icinga::server'

    expect(chef_run).to include_recipe "nagios::server"
    expect(chef_run).not_to include_recipe "nagios::server_package"
    expect(chef_run).to include_recipe "nagios::server_source"
    expect(chef_run).to create_remote_file_if_missing(
      "#{Chef::Config[:file_cache_path]}/icinga-1.9.2.tar.gz"
      ).with(source: 'http://prdownloads.sourceforge.net/sourceforge/icinga/icinga-1.9.2.tar.gz')
    expect(chef_run).to create_file '/etc/icinga/icinga.cfg'
    expect(chef_run).to create_directory '/etc/icinga/objects'
    expect(chef_run).to create_file '/etc/icinga/objects/services.cfg'
  end
end
