include_recipe 'nagios::server'

chef_gem 'chef-rewind'
require 'chef/rewind'

begin
  rewind 'execute[preseed nagiosadmin password]' do
    action :nothing
  end
rescue Chef::Exceptions::ResourceNotFound
  # Seems we're trying to install from source
end

begin
  rewind 'package[nagios-nrpe-plugin]' do
    # Debian/Ubuntu nagios-nrpe-plugin package recommends nagios3
    # package, and at least some base systems follow recommendations
    # automatically. In effect, if we want to use Icinga, we end up with
    # both Icinga and an unconfigured Nagios. We want to prevent Apt
    # from doing that.
    options '--no-install-recommends' if node['platform_family'] == 'debian'
  end
rescue Chef::Exceptions::ResourceNotFound
  # Seems we're trying to install from source
end
