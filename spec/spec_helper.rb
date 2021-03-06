require 'chefspec'

def prepare_chef_run(machine={})
  Chef::Recipe.any_instance.stub(:search).and_return([])
  Chef::DataBag.stub(:list).and_return([])

  machine = {
    platform: 'ubuntu',
    version: '12.04',
    step_into: [ 'apt_repository' ]
  }.merge(machine)
  chef_run = ChefSpec::ChefRunner.new(machine)

  chef_run.node.set['nagios']['server_auth_method'] = 'htauth'
  chef_run
end
