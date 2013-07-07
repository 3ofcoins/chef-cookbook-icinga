require 'chefspec'

def prepare_chef_run
  Chef::Recipe.any_instance.stub(:search).and_return([])
  Chef::DataBag.stub(:list).and_return([])
  chef_run = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')

  # # ChefSpec seems to set languages.ruby to a string, which fails
  # # miserably. I don't feel safe assuming that it always does this.
  # case chef_run.node.automatic['languages']['ruby']
  # when nil then nil
  # when Hash then nil
  # else chef_run.node.automatic['languages'].delete('ruby')
  # end

  # chef_run.node.automatic_attrs['languages']['ruby']['bin_dir'] = '/usr/bin'
  chef_run.node.set['nagios']['server_auth_method'] = 'htauth'
  chef_run
end
