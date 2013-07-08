require_relative 'spec_helper'

describe 'icinga::server' do
  it 'should override attributes, and then call the nagios cookbook, tricking it into installing Icinga' do
    chef_run = prepare_chef_run
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
    chef_run = prepare_chef_run
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

  it 'should add a PPA on Ubuntu' do
    chef_run = prepare_chef_run(
      platform: 'ubuntu',
      version: '12.04',
      evaluate_guards: true)
    chef_run.stub_command(/^apt-key list/, false)
    chef_run.stub_command(/^dpkg -l/, false)

    chef_run.converge 'icinga::server'

    expect(chef_run).to create_file_with_content(
      '/etc/apt/sources.list.d/icinga.list',
      /deb\s+http:\/\/ppa\.launchpad\.net\/formorer\/icinga\/ubuntu\s+precise\s+main/)
    expect(chef_run).not_to create_file '/etc/apt/sources.list.d/backports.list'
    expect(chef_run).not_to create_file '/etc/apt/sources.list.d/debmon.list'
  end

  it 'should add debmon and not backports on Debian Wheezy' do
    chef_run = prepare_chef_run(
      platform: 'debian',
      version: '7.0',
      evaluate_guards: true)
    chef_run.stub_command(/^apt-key list/, false)
    chef_run.stub_command(/^dpkg -l/, false)
    chef_run.node.automatic_attrs['lsb']['codename'] = 'wheezy'

    chef_run.converge 'icinga::server'

    expect(chef_run).not_to create_file '/etc/apt/sources.list.d/backports.list'
    expect(chef_run).to create_file_with_content(
      '/etc/apt/sources.list.d/debmon.list',
      /deb\s+http:\/\/debmon\.org\/debmon\s+debmon-wheezy\s+main/)
  end

  it 'should add debmon and backports on Debian Squeeze' do
    chef_run = prepare_chef_run(
      platform: 'debian',
      version: '6.0.5',
      evaluate_guards: true)
    chef_run.stub_command(/^apt-key list/, false)
    chef_run.stub_command(/^dpkg -l/, false)

    chef_run.converge 'icinga::server'

    expect(chef_run).to create_file_with_content(
      '/etc/apt/sources.list.d/backports.list',
      /deb\s+http:\/\/backports\.debian\.org\/debian-backports\s+squeeze-backports\s+main/)
    expect(chef_run).to create_file_with_content(
      '/etc/apt/sources.list.d/debmon.list',
      /deb\s+http:\/\/debmon\.org\/debmon\s+debmon-squeeze\s+main/)
  end
end
