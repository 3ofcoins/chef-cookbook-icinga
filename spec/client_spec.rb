require_relative 'spec_helper'

describe 'icinga::client' do
  let(:chef_run) { prepare_chef_run }

  it 'should just call out to nagios::client' do
    chef_run.node.set['nagios']['client']['install_method'] = 'package'
    chef_run.converge 'icinga::client'

    expect(chef_run).to include_recipe "nagios::client"
    expect(chef_run).to include_recipe "nagios::client_package"
    expect(chef_run).not_to include_recipe "nagios::client_source"
    expect(chef_run).to install_package 'nagios-nrpe-server'
    expect(chef_run).to create_file '/etc/nagios/nrpe.cfg'
  end

  it 'should do the trick with source install as well' do
    chef_run.node.set['nagios']['client']['install_method'] = 'source'
    chef_run.converge 'icinga::client'

    expect(chef_run).to include_recipe "nagios::client"
    expect(chef_run).not_to include_recipe "nagios::client_package"
    expect(chef_run).to include_recipe "nagios::client_source"
    expect(chef_run).to create_file '/etc/nagios/nrpe.cfg'
  end
end
